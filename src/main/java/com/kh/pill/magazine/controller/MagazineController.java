package com.kh.pill.magazine.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.magazine.model.service.MagazineService;
import com.kh.pill.magazine.model.vo.Magazine;
import com.kh.pill.magazine.model.vo.MagazineLike;
import com.kh.pill.member.model.vo.Member;


@Controller
public class MagazineController {

	@Autowired
	private MagazineService magazineService;
	
	@RequestMapping("list.mag")
	public String SelectMagazineList(@RequestParam(value="cpage", defaultValue="1") int currentPage, Model model,
												  @RequestParam(value="life", defaultValue="") String life,
												  @RequestParam(value="season", defaultValue="") String season, 
												  @RequestParam(value="issue", defaultValue="") String issue) { 

		int listCount = 0; // 카테고리별로 게시글의 갯수가 다 다르니까 => 라이프 갯수 + 시즌 갯수 + 이슈 갯수 = 전체 게시글 갯수
		int pageLimit = 5; 
		int boardLimit = 6; 
		
		PageInfo pi = null;
		
		// PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		// 카테고리
		ArrayList<Magazine> list = new ArrayList<>();
		
		// System.out.println("life : " + life);
		// System.out.println("season : " + season);
		// System.out.println("issue : " + issue);
		
		if(life.equals("1")) { 
			
			// 기본적으로 최신순 조회
			listCount = magazineService.selectListCount1();

			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			list = magazineService.selectLifeList(pi);
		
		} else if(season.equals("2")) { 

			// 기본적으로 최신순 조회
			listCount = magazineService.selectListCount2();

			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			list = magazineService.selectSeasonList(pi);
		
		} else if(issue.equals("3")) {

			// 기본적으로 최신순 조회
			listCount = magazineService.selectListCount3();

			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			list = magazineService.selectIssueList(pi);
			
		} else { // 전체조

			// 기본적으로 최신순 조회
			listCount = magazineService.selectListCount();

			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			list = magazineService.selectMagazineList(pi);
		}
		
		// System.out.println(list);
		// System.out.println(life);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("life", life);
		model.addAttribute("season", season);
		model.addAttribute("issue", issue);

		return "magazine/magazineListView";
	}
	

	@RequestMapping("enrollForm.mag")
	public String enrollForm() {
		
		return "magazine/magazineEnrollForm";
	
	}
	
	@RequestMapping("enroll.mag")
	public ModelAndView insertMagazine(Magazine mag, MultipartFile upfile, HttpSession session, ModelAndView mv) throws IllegalStateException, IOException {
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			String ChangeName = saveFile(upfile, session);
			
			mag.setMagazineImgName("resources/magazineUploadFiles/" + ChangeName);

		}

		int result = magazineService.insertMagazine(mag);
	
		if (result > 0) { 
			
			session.setAttribute("alertMsg", "게시글이 등록되었습니다.");
			mv.setViewName("redirect:/list.mag");
			
		} else {
			
			mv.addObject("errorMsg", "게시글 작성에 실패했습니다.").setViewName("common/errorPage");
			
		}
		
		return mv;
		
	}
	

	private String saveFile(MultipartFile upfile, HttpSession session) throws IllegalStateException, IOException {

		String originName = upfile.getOriginalFilename(); 
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		int ranNum = (int)(Math.random() * 90000) + 10000;
		
		String ext = originName.substring(originName.lastIndexOf(".")); 

		String ChangeName = currentTime + ranNum + ext;

		String savePath = session.getServletContext().getRealPath("/resources/magazineUploadFiles/");
		
		upfile.transferTo((new File(savePath + ChangeName)));

		return ChangeName;
	}

	@RequestMapping("detail.mag")
	public String selectMagazine(int magazineNo, HttpSession session ,Model model) {
		
		Member loginUser= (Member)session.getAttribute("loginUser");
		
		if(loginUser != null) { //로그인 o => 좋아요 보이기
		
			int memberNo = loginUser.getMemberNo();
			
			Magazine prev = magazineService.selectMagazine(magazineNo - 1);
			Magazine next = magazineService.selectMagazine(magazineNo + 1);

			MagazineLike magLselect = new MagazineLike(magazineNo, memberNo);
			MagazineLike magL = magazineService.selectMagazineLike(magLselect);

			Magazine mag = magazineService.selectMagazine(magazineNo);
			
			int result = magazineService.updateViewCount(magazineNo);
			
			if(result > 0) { // 조회수 0 이상 => 다 넘기기
				
				model.addAttribute("prev", prev);
				model.addAttribute("next", next);
				model.addAttribute("mag" , mag);
				
				model.addAttribute("magL", magL);
				
				return "magazine/magazineDetailView";
			
			} else {
				
				model.addAttribute("errorMsg", "게시글 상세 조회에 실패했습니다.");
				
				return "common/errorPage";
				
			}
				
		} else { // 로그인 x => 이전글/다음글, 글번호만 넘기기

			int result = magazineService.updateViewCount(magazineNo);
			
			Magazine mag = magazineService.selectMagazine(magazineNo);
			Magazine prev = magazineService.selectMagazine(magazineNo - 1);
			Magazine next = magazineService.selectMagazine(magazineNo + 1);

			if(result > 0) {
				model.addAttribute("mag" , mag);
				model.addAttribute("prev", prev);
				model.addAttribute("next", next);
				
				return "magazine/magazineDetailView";
				
			} else { // 다 조회 안 될 경우
				
				model.addAttribute("errorMsg", "게시글 상세 조회에 실패했습니다.");
				
				return "common/errorPage";
				
			}
	
		}
	
	}
	
	// 좋아요 갯수 조회
	@ResponseBody
	@RequestMapping("likeCount.mag")
	public int selectLikeCount(int magazineNo) {
		
		// System.out.println(magazineNo);
		
		int magazineLikeCount = magazineService.selectMagazineLikeCount(magazineNo);
		
		// System.out.println(magazineLikeCount);
		
		return magazineLikeCount;
	}

	
	// 좋아요 insert
	@ResponseBody
	@RequestMapping(value="insert.magL", produces="text/html; charset=UTF-8")
	public String insertMagazineLike(MagazineLike magL) {

		int result = magazineService.insertMagazineLike(magL);
		
		int magazineLikeCount = 0;
		
		if (result > 0) { 
			
			int magazineNo = magL.getMagazineNo();
			
			result *= magazineService.updateMagazineLikeCount(magazineNo); // 1*0 혹은 1*1
			
			magazineLikeCount = magazineService.selectMagazineLikeCount(magazineNo);
			
		}
			
			return String.valueOf(magazineLikeCount);

	}

	
	// 좋아요 delete
	@ResponseBody
	@RequestMapping(value="delete.magL", produces="text/html; charset=UTF-8")
	public String deleteMagazineLike(MagazineLike magL) {
	
		int result = magazineService.deleteMagazineLike(magL);
		int count = 0;
		int magazineLikeCount = 0;
	
		if (result > 0) {
					
			int magazineNo = magL.getMagazineNo();
			
			count = magazineService.updateMagazineLikeCount(magazineNo);
		
			magazineLikeCount = magazineService.selectMagazineLikeCount(magazineNo);
			
		}
	
			return String.valueOf(magazineLikeCount);
	
	}

	
	@RequestMapping("delete.mag")
	public String deleteMagazine(int magazineNo, String filePath, HttpSession session, Model model) {

		int result = magazineService.deleteMagazine(magazineNo);
		
		if(result > 0) {

			if(!filePath.equals("")) {
				
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
				
			}
			
			session.setAttribute("alertMsg", "게시글이 삭제되었습니다.");
			
			return "redirect:/list.mag";
			
		} else { 
			
			model.addAttribute("errorMsg", "게시글 삭제에 실패했습니다.");
			
			return "common/errorPage";
		}
				
	}
	
	
	@RequestMapping("updateForm.mag")
	public String updateForm(int magazineNo, Model model) {
		
		Magazine mag = magazineService.selectMagazine(magazineNo);
		
		// System.out.println(mag);
		
		model.addAttribute("mag", mag);

		return "magazine/magazineUpdateForm";

	}
	
	
	@RequestMapping("update.mag")
	public String updateMagazine(Magazine mag, MultipartFile reupfile, HttpSession session, Model model) throws IllegalStateException, IOException {

		if(!reupfile.getOriginalFilename().equals("")) { // 새로운 첨부파일이 있을경우
 
			if(mag.getMagazineImgName() != null) { // 기존 첨부파일이 있을경우 => 덮어씌우기
				
				String realPath = session.getServletContext().getRealPath(mag.getMagazineImgName());
				
				new File(realPath).delete(); // 삭제
				

				String ChangeName = saveFile(reupfile, session);

				mag.setMagazineImgName("resources/magazineUploadFiles/" + ChangeName); // 덮어씌운부분
				
			} 
		}
		
		// 이 시점 기준으로
		// 새로운 첨부파일이 있었다면 => magazineImgName 필드값은 새로운 첨부파일의 수정명으로 덮어씌워졌을거임
		// 새로운 첨부파일이 없었다면 => magazineImgName 필드값은 기존 첨부파일의 수정명이 그대로 들어가 있었을거임
		
		int result = magazineService.updateMagazine(mag);
		
		// System.out.println(result);


		if(result > 0) {
			
			// System.out.println(result);
			
			session.setAttribute("alertMsg", "게시글이 수정되었습니다.");
			
			return "redirect:/detail.mag?magazineNo=" + mag.getMagazineNo();
			
			
		} else { 
			
			model.addAttribute("errorMsg", "게시글 수정에 실패했습니다.");
			
			return "common/errorPage";
			
		}
	
		
	}


}

