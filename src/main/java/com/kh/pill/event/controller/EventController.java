package com.kh.pill.event.controller;

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

import com.google.gson.Gson;
import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.event.model.service.EventService;
import com.kh.pill.event.model.vo.Event;
import com.kh.pill.event.model.vo.EventLike;
import com.kh.pill.event.model.vo.EventReply;
import com.kh.pill.member.model.vo.Member;

@Controller
public class EventController { 
	
	@Autowired
	private EventService eventService;
	
	
	
	/**
	 * 이벤트 게시판 전체 리스트 조회 페이지
	 */
	@RequestMapping("list.ev")
	public String SelectEventList(@RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) { 
		
		
		int listCount = eventService.selectListCount(); // 이벤트 총 게시글수 조회 
		
		int pageLimit = 10; // 페이징바 갯수 
		int boardLimit = 5; // 페이지에 보여질 게시글 수 
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Event> list = eventService.SelectEventList(pi);
		

		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		
		return "event/eventListView";
		
	}
	
	
	/**
	 * 이벤트 게시글 상세조회 
	 */
	@RequestMapping("detail.ev")
	public String selectEvent(int eno, HttpSession session ,Model model) {
		
		
		Member loginUser= (Member)session.getAttribute("loginUser");
		
		if(loginUser != null) { // 로그인 유저가 있다면 좋아요 누를수 있는 상세 페이지 
		
			int memberNo = loginUser.getMemberNo();
			
			// System.out.println(memberNo);
			
			EventLike elList = new EventLike(eno, memberNo);
			
			EventLike el = eventService.selectEventLike(elList);
			
			// System.out.println(el);
			
			Event e = eventService.selectEvent(eno);
			
			
			
			if( e == null) {
				
				model.addAttribute("errorMsg", "게시글 상세조회 실패");
				return "common/errorPage";
				
			} else {
				
				model.addAttribute("e", e);
				model.addAttribute("el", el);
				return "event/eventDetailView";
				
				
			}
			
		
			
		} else { // 로그인 유저가 없다면 그냥 게시글만 조회만 하는 상세 페이지
			
			
			Event e = eventService.selectEvent(eno);
			
			if( e == null) {
				
				model.addAttribute("errorMsg", "게시글 상세조회 실패");
				return "common/errorPage";
				
			} else {
				
				model.addAttribute("e", e);
				return "event/eventDetailView";
				
			}
			
			
			
		}
		
		
		
		
		
	}
	
	/**
	 * 댓글 리스트 조회
	 */
	@ResponseBody
	@RequestMapping(value="rlist.ev", produces="application/json; charset=UTF-8")
	public String selectReplyList(int eno) {
		
		
		ArrayList<EventReply> list = eventService.selectReplyList(eno);
	
		
		return new Gson().toJson(list);
		
		

		
	}
	
	
	/**
	 * 이벤트 작성폼으로 이동하는 메소드
	 */
	@RequestMapping("enrollForm.ev")
	public String enrollForm() {
		return "event/eventEnrollForm";
	}
	
	
	/**
	 * 이벤트 게시글 추가하는 메소드
	 */
	@RequestMapping("insert.ev")
	public ModelAndView insertEvent(Event e, MultipartFile upfile, HttpSession session, ModelAndView mv) {
		
		// 새로 넘어온 첨부파일이 있는 경우 
		if(!upfile.getOriginalFilename().contentEquals("")) {
			
			// 넘어온 첨부파일을 수정명으로 바꾸고 서버에 업로드 
			String ChangeName = saveFile(upfile, session);
			
			// e에 새로넘어온 첨부파일에 대한 수정파일명 필드에 담기 
			e.setEvtImgName("resources/eventUploadFiles/" + ChangeName);
			
			
			// System.out.println(ChangeName);
		}
		
		
		
		int result = eventService.insertEvent(e);
		
		
		
		if (result > 0) { // 성공, 게시글 리스트 페이지로 이동 (list.ev)
			
			session.setAttribute("alertMsg", "성공적으로 이벤트가 등록되었습니다.");
			mv.setViewName("redirect:/list.ev");
			
		} else { // 실패, 에러페이지로 이동 
			
			mv.addObject("errorMsg", "게시글 작성 실패").setViewName("common/errorPage");
			
		}
		
		return mv;
		
	}
	
	/**
	 * 이벤트 게시물 업로드할때 파일명 수정해주는 메소드
	 */
	private String saveFile(MultipartFile upfile, HttpSession session) {
		// 파일명 수정 먼저하기 
		String originName = upfile.getOriginalFilename(); // 원본 파일명 
		
		// 시간 형식을 문자열로 뽑아내기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		// 뒤에 붙을 5자리 랜덤값 
		int ranNum = (int)(Math.random()*90000) + 10000; // 5자리 랜덤값 
		
		// 원본파일로부터 확장자만 뽑기 (.png)
		String ext = originName.substring(originName.lastIndexOf(".")); 
		
		// 이어 붙이기 
		String ChangeName = currentTime + ranNum + ext;
		
		
		
		// 업로드 하고자 하는 서버의 물리적인 실제 경로 알아내기 
		String savePath = session.getServletContext().getRealPath("/resources/eventUploadFiles/");
		
		try {
			upfile.transferTo((new File(savePath + ChangeName)));
		
		} catch (IllegalStateException | IOException e1) {
			
			e1.printStackTrace();
		}
		
		return ChangeName;
	}
	
	/**
	 * 이벤트 게시물 삭제
	 */
	@RequestMapping("delete.ev")
	public String deleteEvent(int eno, String evtImgName, HttpSession session, Model model) {
		
		int result = eventService.deleteEvent(eno);
		
		if(result > 0) { // 게시글 삭제 성공 
			
			// 파일 경로
			// String realPath = session.getServletContext().getRealPath("/resources/eventUploadFiles/");
			
			// 현재 삭제 성공된 게시글에 존재하는 파일 객체의 변수 지정 
			// new File("/"+evtImgName);
			// File file = new File("/"+evtImgName);
			
			// if(file.exists()) { // 파일이 존재하면
			/*
			if(!evtImgName.equals("")) {
				System.out.println(evtImgName);
				
				file.delete(); // 파일 삭제	
			}
			*/
			
			// 게시글 삭제를 위해 실제 경로를 다시 불러와줘야함! 
			// evtImgName에는 수정파일명만 들어있는 상태
			// realPath로 실제경로와 함께 수정명을 담아줘야함 
			String realPath = session.getServletContext().getRealPath(evtImgName); // "/resources/eventUploadFiles/수정명.jpg"
			new File(realPath).delete();
			
			
			
			// 게시판 리스트 페이지로 이동 
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			
			return "redirect:/list.ev";
			
		} else { // 게시글 삭제 실패 
			
			model.addAttribute("errorMsg", "게시글 삭제 실패");
			
			return "common/errorPage";
		}
		
	}
	
	
	/**
	 * 이벤트 게시물 수정하는 페이지로 이동 
	 */
	@RequestMapping("updateForm.ev")
	public String updateForm(int eno, Model model) {
			
		Event e = eventService.selectEvent(eno);
		
		model.addAttribute("e", e);
		
		// System.out.println(e);
		
		return "event/eventUpdateForm";
		
		
	}
	
	/**
	 * 이벤트 게시물 수정 요청 
	 */
	@RequestMapping("update.ev")
	public String updateEvent(Event e, MultipartFile reupfile, HttpSession session, Model model) {
		
		
		// System.out.println(e);
		
		// 첨부파일 있는 경우 
		if(!reupfile.getOriginalFilename().contentEquals("")) {
			
			// 기존 첨부파일이 있었을 경우 => 첨부파일 삭제 
			if(e.getEvtImgName() != null) {
				
				String realPath = session.getServletContext().getRealPath(e.getEvtImgName());
				new File(realPath).delete();
				
			} 
			
			// 새로 넘어온 첨부파일을 수정명으로 바꾸고 서버에 업로드 
			String ChangeName = saveFile(reupfile, session);
			
			// 새로 넘어온 첨부파일에 대한 원본명, 수정파일명 필드에 담기 
			e.setEvtImgName(reupfile.getOriginalFilename());
			e.setEvtImgName("resources/eventUploadFiles/" + ChangeName);
			
			// System.out.println(e.getEvtImgName());
			
		}
		
		int result = eventService.updateEvent(e);
		
		// System.out.println(result);


		if(result > 0) { // 게시글 수정 성공 
			
			// System.out.println(result);
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			
			// 게시글 상세보기 페이지 url 재요청 
			return "redirect:/detail.ev?eno=" + e.getEvtNo();
			
			
		} else { // 게시글 수정 실패
			
			model.addAttribute("errorMsg", "게시글 수정 실패");
			
			return "common/errorPage";
			
		}
		
		
		
		
	}
	
	
	/**
	 * 이벤트 게시물 좋아요 누름 요청 
	 */
	@ResponseBody
	@RequestMapping(value="insert.el", produces="text/html; charset=UTF-8")
	public String ajaxInsertEvtLike(EventLike el) {
		
		int result = eventService.insertEvtLike(el);
		int evtLikeCount = 0;
		
		if (result > 0) { // 좋아요가 추가 되면 event_like_count 컬럼 업데이트 
			
			int eno = el.getEvtNo();
			
			result *= eventService.updateEventEvtLikeCount(eno); // 업데이트 
			
			evtLikeCount = eventService.selectEvtLikeCount(eno);// 업데이트한거 다시 조회함
			
		}
		
		return String.valueOf(evtLikeCount);
	}
	
	/**
	 * 이벤트 좋아요 삭제하는 구문
	 */
	@ResponseBody
	@RequestMapping(value="delete.el", produces="text/html; charset=UTF-8")
	public String ajaxDeleteEvtLike(EventLike el) {
	
		int result = eventService.deleteEvtLike(el);
		int evtLikeCount = 0;
		
		if (result > 0) { // 좋아요가 삭제 되면 event_like_count 컬럼 업데이트 
					
			int eno = el.getEvtNo();
			
			result *= eventService.updateEventEvtLikeCount(eno);
		
			evtLikeCount = eventService.selectEvtLikeCount(eno);// 업데이트한거 다시 조회함
			
		}
		
		return String.valueOf(evtLikeCount);
	}
	
	/**
	 * 이벤트 댓글 작성
	 */
	@ResponseBody
	@RequestMapping(value="rinsert.ev", produces="text/html; charset=UTF-8")
	public String ajaxInsertReply(EventReply er) {
		
		int result = eventService.insertReply(er);
		
		return (result > 0 ) ? "success" : "fail";
		
	}
	
	/**
	 * 이벤트 댓글 삭제 
	 */
	@ResponseBody
	@RequestMapping(value="rdelete.ev", produces="text/html; charset=UTF-8")
	public String ajaxDeleteReply(int replyNo) {
		
		// System.out.println(replyNo);
		
		int result = eventService.deleteReply(replyNo);
		
		// System.out.println(result);
		
		return (result > 0) ? "success" : "fail";
		
		
	}
	
	
	/**
	 * 이벤트 대댓글 작성 
	 */
	@ResponseBody
	@RequestMapping(value="nrinsert.ev", produces="text/html; charset=UTF-8")
	public String ajaxInsertNestedReply(EventReply er) {
		
		// System.out.println(er);

		int result = eventService.insertNestedReply(er);
		
		// System.out.println(er);
		
	
		return (result > 0) ? "success" : "fail";
		
	}
	
	/**
	 * 이벤트 대댓글 삭제
	 */
	@ResponseBody
	@RequestMapping(value="nrdelete.ev", produces="text/html; charset=UTF-8")
	public String ajaxDeleteNestedReply(int replyNo) {
		
		
		
		int result = eventService.deleteNrReply(replyNo);
		
		return (result > 0) ? "success" : "fail";
		
	}

}
