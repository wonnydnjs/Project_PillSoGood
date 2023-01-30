package com.kh.pill.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.kh.pill.member.model.vo.Member;
import com.kh.pill.product.model.service.ProductService;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.review.model.service.ReviewService;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;
import com.kh.pill.review.model.vo.ReviewReply;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ProductService productService;
	
	// 메뉴바 클릭시 => list.re (기본적으로 1번 페이지 요청)
	// 페이징바 클릭 시 => list.re?cpage=요청하는페이지수&order=~~
	@RequestMapping("list.re")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, @RequestParam(value="order", defaultValue="default")String order, Model model) {
		
		// 베스트 리뷰 조회
		ArrayList<Review> bestListAll = reviewService.selectBestList(); // 일반 리뷰 전체를 베스트 기준으로 조회 후 ArrayList bestListAll 에 담음
		ArrayList<Review> bestList = new ArrayList<>(); // 베스트 기준에 맞는 상위 3개 리뷰를 담을 ArrayList bestList 생성 
		
		if(bestListAll.size() >= 3 ) {
			
			for(int i = 0; i < 3; i++) { // 상위 3개를 위해 3번만 반복
				
				Review bestReview = bestListAll.get(i); // bestListAll 에서 상위 3개 리뷰를 추출
				
				int rno = 0; // 일치 조건인 외래키 reviewNo 변수 설정 및 초기화
				rno = bestReview.getReviewNo(); // rno 에 상위 3개 리뷰의 reviewNo 를 담음
					
				ArrayList<ReviewFile> bflist = reviewService.selectBestReviewFile(rno); 
				// REVIEW_FILE 테이블에서 rno 가 일치하는 썸네일 파일만 추출해서  ArrayList bflist 에 담음
				
				bestReview.setFlist(bflist); // bflist 를 Review 객체 bestReview 에 담음
				bestList.add(bestReview); // bestReview 를 ArrayList bestList 에 담음
				
			}
			
			model.addAttribute("bestList", bestList);
		} else {
		
			model.addAttribute("bestList", bestList);
		
		}
		
		// 일반 리뷰 전체 조회는 베스트 리뷰 전체 조회와 비슷함
		
		// 일반 리뷰 전체 조회용 페이징
		int listCount = reviewService.selectListCount();
		
		int pageLimit = 5;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		model.addAttribute("pi", pi);

		// 일반 리뷰 전체 조회
		ArrayList<Review> list = reviewService.selectList(pi, order);
				
		for(int i = 0; i < list.size(); i++) {
			
			Review review = list.get(i);
			
			int rno = 0;
			rno = review.getReviewNo();
				
			ArrayList<ReviewFile> flist = reviewService.selectReviewFile(rno);
			int replyCount = reviewService.selectReplyCount(rno);
			
			review.setFlist(flist);
			review.setReplyCount(replyCount);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("order", order);

		// 리턴
		return "review/reviewListView";
	}
	
	@RequestMapping("enrollForm.re")
	public String enrollForm(int memberNo, Model model, HttpSession session) {
		
		// memberNo 회원의 GROUP 화 된 ORDER_NO(int OrderNo) 들을 배열로 받아옴 
		ArrayList<Review> rOrderList = reviewService.selectROrderList(memberNo);
		
		if(rOrderList.size() != 0) {
			for( int i = 0; i < rOrderList.size(); i++ ) {
				
				// rOrderList 의 <Review> 타입 reviewOrder 들 추출
				Review reviewOrder = rOrderList.get(i);
				// 그 안에 있는 OrderNo 추출해서 rOrderNo 로 지정
				long orderNo = reviewOrder.getOrderNo();
				
				// rOrderNo에 해당하는 productName 들 추출해서 배열로 담음
				ArrayList<Review> rOrderProductNameList = reviewService.selectROrderProductNameList(orderNo);
				
				// 배열 -> 문자열 가공
				String rOrderProductNames = "";
				
				if ( rOrderProductNameList.size() == 1 ) { // 상품 한 개
					
					rOrderProductNames += rOrderProductNameList.get(0).getProductName();
				}
				else if ( rOrderProductNameList.size() > 1 ){ // 상품 두 개 이상
					
					rOrderProductNames += rOrderProductNameList.get(0).getProductName();
					for( int j = 1; j < rOrderProductNameList.size(); j++) {
						
						rOrderProductNames += ", ";
						rOrderProductNames += rOrderProductNameList.get(j).getProductName();
					
					}
				}
				
				// reviewOrder 안에 문자열 담음
				reviewOrder.setProductName(rOrderProductNames);
				reviewOrder.setMemberNo(memberNo);
				
			}
			
			model.addAttribute("rOrderList", rOrderList);
			return "review/reviewEnrollForm";
		} else {
			session.setAttribute("alertMsg", "후기를 작성할 구매 목록이 없습니다.");
			return "redirect:/list.re";
		}
	}
	
	@RequestMapping("insert.re")
	public ModelAndView insertReview(long orderNo, Review r, List<MultipartFile> upfile, HttpSession session, ModelAndView mv) {
		
		// rOrderNo에 해당하는 productName 들 추출해서 배열로 담음
		ArrayList<Review> rOrderProductNameList = reviewService.selectROrderProductNameList(orderNo);
		
		// 배열 -> 문자열 가공
		String rOrderProductNames = "";
		
		if( rOrderProductNameList.size() == 1 ) { // 상품 한 개
			
			rOrderProductNames += rOrderProductNameList.get(0).getProductName();
		}
		else if ( rOrderProductNameList.size() > 1 ){ // 상품 두 개 이상
			
			rOrderProductNames += rOrderProductNameList.get(0).getProductName();
			for( int j = 1; j < rOrderProductNameList.size(); j++) {
				
				rOrderProductNames += ", ";
				rOrderProductNames += rOrderProductNameList.get(j).getProductName();
			}
		}

		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		r.setMemberNo(memberNo);

		// 먼저 파일 여부와 무관하게 rawReview 를 insert
		int rawResult = reviewService.insertRawReview(r);
		r.setProductName(rOrderProductNames);

		if(rawResult > 0) { // 만들어졌으면 진행
			
			// r에 들어있는 memberNo로 만들어진 review 중에서 rawReview 를 select 해서 reviewNo, 
			Review rawReview = reviewService.selectRawReview(memberNo);
			rawReview.setProductName(rOrderProductNames);
			// productName 이 담기기는 하는데, 컬럼이 없어서 조회 때 보여줄 길이 없음. 인증 조건 정도로 해야하거나, 선생님한테 여쭤보기

			int rawReviewNo = rawReview.getReviewNo();
			// upfile 에 비었든 안 비었든 MultipartFIle 객체는 하나 이상 만들어짐(사용자가 파일첨부를 시도하고 취소하더라도 빈 MultipartFIle 객체가 만들어지기 때문)
			
			// 1. 0번 인덱스(썸네일 사진) 첨부파일 있는지 검사
			String fileExist1 = upfile.get(0).getOriginalFilename();
			if(!fileExist1.equals("")) { // 썸네일 사진 있음 => fileLevel = 1 로 REVIEW_FILE 테이블에 insert
				
				String currentTime =  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
				
				int ranNum = (int)(Math.random() * 90000) + 10000; // 5자리 랜덤값
				
				String ext = fileExist1.substring(fileExist1.lastIndexOf(".")); //
				
				String changeName = currentTime + ranNum + ext;
				
				String filePath = session.getServletContext().getRealPath("resources/reviewUploadFiles/");
				// String filePath = "resources/reviewUploadFiles/";
				
				try {
					upfile.get(0).transferTo(new File(filePath + changeName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				ReviewFile reviewFile = new ReviewFile();
				
				reviewFile.setChangeName(changeName);
				reviewFile.setFilePath("resources/reviewUploadFiles/");
				reviewFile.setFileLevel(1);
				reviewFile.setReviewNo(rawReviewNo);
				
				reviewService.insertReviewFile(reviewFile);
			}
			else {} // 썸네일 사진 없음 => 세부 사진 insert로 진행
					
			// 2. 이외 인덱스(세부 사진) 첨부파일 있는지 검사
			for(int i = 1; i < upfile.size(); i++) {
				String fileExist2 = upfile.get(i).getOriginalFilename();
				if(!fileExist2.equals("")) { // 세부 사진 있음 => fileLevel = 2 로 REVIEW_FILE 테이블에 insert
					
					String currentTime =  new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
					
					int ranNum = (int)(Math.random() * 90000) + 10000; // 5자리 랜덤값
					
					String ext = fileExist2.substring(fileExist2.lastIndexOf(".")); //
					
					String changeName = currentTime + ranNum + ext;
					
					String filePath = session.getServletContext().getRealPath("resources/reviewUploadFiles/");
					// String filePath = "resources/reviewUploadFiles/";
					
					try {
						upfile.get(i).transferTo(new File(filePath + changeName));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					
					ReviewFile reviewFile = new ReviewFile();
					
					reviewFile.setChangeName(changeName);
					reviewFile.setFilePath("resources/reviewUploadFiles/");
					reviewFile.setFileLevel(2);
					reviewFile.setReviewNo(rawReviewNo);
					
					reviewService.insertReviewFile(reviewFile);
				}
				else {} // 세부 사진 없음 => REVIEW_FILE 테이블에 insert 종료
				
				// REVIEW_FILE 테이블에 insert 끝났으면 rawReviewNo 인 ReviewFile 들 select
				ArrayList<ReviewFile> flist = reviewService.selectNewReviewFile(rawReviewNo); 
				
				rawReview.setFlist(flist);
				// flist 를 Review 객체에 담음
				session.setAttribute("alertMsg", "리뷰가 성공적으로 등록되었습니다.");
			}
			
		}
		else {
			// 실패했으면 그냥 alert 하고 list.re 로 리다이렉트
			session.setAttribute("alertMsg", "리뷰 등록에 실패했습니다.");
		}
		mv.setViewName("redirect:/list.re");
		return mv;
	}
	
	@RequestMapping("detail.re")
	public ModelAndView selectReview(int rno, ModelAndView mv) {
	    
		// rno 에는 상세조회하고자 하는 해당 게시글 번호가 담겨있음 
		// 1. 해당 게시글 조회수 증가용 서비스 먼저 호출 결과 받기 (update 하고 오기)
		int result = reviewService.increaseCount(rno);
		  
		if(result > 0) { // 성공적으로 조회수 증가가 일어났다면
		 
			// 2. 상세조회 요청
			// => reviewDetailView.jsp 상에 필요한 데이터 조회
			Review r = reviewService.selectReview(rno);
			
			// 해당 리뷰에 첨부되어 있는 파일 리스트 조회 후 담기
			ArrayList<ReviewFile> flist = reviewService.selectReviewFile(rno);
			r.setFlist(flist);
			
			// 해당 리뷰에 첨부되어 있는 상품 번호 리스트 조회 후 담기
			ArrayList<Integer> pNoList = reviewService.selectProductNoList(rno); 
			
			ArrayList<Product> pList = new ArrayList<>();

			for( int pno : pNoList) {
				
				Product p = productService.selectProduct(pno);
				pList.add(p);
			}
			
			r.setPList(pList);
			
			// 조회된 데이터를 담아서 review/reviewDetailView.jsp 로 포워딩
			mv.addObject("pList", pList);
			mv.addObject("r", r).setViewName("review/reviewDetailView");
			
		}
		else { // 실패 
			
			mv.addObject("errorMsg", "리뷰 조회 실패").setViewName("common/errorPage");
			
		}
		
		return mv;
	}
	

	@ResponseBody
	@RequestMapping(value="rlist.re", produces="application/json; charset=UTF-8")
	public String ajaxSelectReviewReplyList(int rno) {
		
		ArrayList<ReviewReply> list = reviewService.selectReviewReplyList(rno);
		
		return new Gson().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value="rinsert.re", produces="text/html; charset=UTF-8")
	public String ajaxInsertReviewReply(ReviewReply r) {
		
		int result = reviewService.insertReviewReply(r);
		
		return (result > 0) ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="rdelete.re", produces="text/html; charset=UTF-8")
	public String ajaxDeleteReviewReply(int replyNo) {
	 		
			int result = reviewService.deleteReviewReply(replyNo);
	 
	 		return (result > 0 ) ? "success" : "fail";
	}
	
	@RequestMapping("delete.re")
	public String deleteReview(String rno, HttpSession session, Model model) {
				
		int rno2 = Integer.parseInt(rno);
		
		// 리뷰에 첨부되어 있는 파일들 삭제
		int result1 = reviewService.deleteReviewFile(rno2);

		// 리뷰 삭제
		int result2 = reviewService.deleteReview(rno2);
		
		if(result1 * result2 > 0) {
			// 리뷰 리스트 페이지 url 재요청
			session.setAttribute("alertMsg", "성공적으로 리뷰가 삭제되었습니다.");
			return "redirect:/list.re";
		}
		else { // 리뷰 삭제 실패
			
			model.addAttribute("alertMsg", "리뷰 삭제 실패");
			return "redirect:/list.re";
		}
		
	}
		
	@RequestMapping("myDelete.re")
	public String deleteMyReview(String rno, HttpSession session, Model model) {
				
		int rno2 = Integer.parseInt(rno);
		
		// 리뷰에 첨부되어 있는 파일들 삭제
		int result1 = reviewService.deleteReviewFile(rno2);

		// 리뷰 삭제
		int result2 = reviewService.deleteReview(rno2);
		
		if(result1 * result2 > 0) {
			// 리뷰 리스트 페이지 url 재요청
			session.setAttribute("alertMsg", "성공적으로 리뷰가 삭제되었습니다.");
			return "redirect:/myPage.re";
		}
		else { // 리뷰 삭제 실패
			
			model.addAttribute("alertMsg", "리뷰 삭제 실패");
			return "redirect:/myPage.re";
		}
		
	}
	
  	/*
	@RequestMapping("updateForm.re")
	public String updateForm(int rno, Model model) {
		
		// 리뷰 수정 페이지를 포워딩 하기 전에 우선적으로 해당 리뷰 정보 조회
		Review r = reviewService.selectReview(rno); // 기존의 상세보기 서비스 재활용
		
		model.addAttribute("r", r);
		
		return "review/reviewUpdateForm";
	}
	*/
	/*
	@RequestMapping("update.re")
	public String updateReview(Review r, MultipartFile reupfile, HttpSession session, Model model) {
		
		// 새로 넘어온 첨부파일이 있는 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			
			// r 의 reviewNo : 내가 수정하고자 하는 리뷰의 번호
			// r 의 reviewTitle : 수정할 제목 (SET 절)
			// r 의 reviewContent : 수정할 내용 (SET 절)
			// r 의 originName : 기존 첨부파일의 원본명
			// r 의 changeName : 기존 첨부파일의 수정명
			
			// 1. 기존 첨부파일이 있었을 경우 => 기존 첨부파일을 찾아서 삭제
			
			if(r.getOriginName() != null) {
				String realPath = session.getServletContext().getRealPath(r.getChangeName());
				new File(realPath).delete();
			}
			
			// 2. 새로 넘어온 첨부파일을 수정명으로 바꾸고 서버에 업로드 시키기
			String changeName = saveFile(reupfile, session);
			
			// 3. r 객체에 새로 넘어온 첨부파일에 대한 원본명, 수정파일명 필드에 담기
			r.setOriginName(reupfile.getOriginalFilename());
			r.setChangeName("resources/uploadFiles/" + changeName);
			
		}
		*/
		/*
		 * r 에 무조건 담겨있는 내용
		 * reviewNo, reviewTitle, reviewContent
		 * 
		 * 추가적으로 고려해야할 경우의 수
		 * 1. 새로 첨부된 파일 X, 기존 첨부파일 X
		 * => originName : null, changeName : null
		 * 
		 * 2. 새로 첨부된 파일X, 기존 첨부파일 O
		 * => originName : 새로 첨부된 파일의 원본명
		 *    changeName : 새로 첨부된 파일의 수정명 + 파일경로
		 *    
		 * 4. 새로 첨부된 파일O, 기존 첨부파일 O
		 * => 기존 파일 삭제
		 * => 새로 전달된 파일을 서버에 업로드
		 * => originName : 새로 첨부된 파일의 원본명
		 *    changeName : 새로 첨부된 파일의 수정명 + 파일경로
		 */
		/*
		// Service 단으로 r 보내기
		int result = reviewService.updateReview(r);
		
		if(result > 0) { // 리뷰 수정 성공
			
			session.setAttribute("alertMsg", "성공적으로 리뷰가 수정되었습니다.");
			
			// 리뷰 상세보기 페이지로 url 재요청
			return "redirect:/detail.re?rno=" + r.getReviewNo();
		}
		else { // 리뷰 수정 실패
			
			model.addAttribute("errorMsg", "리뷰 수정 실패");
			
			return "common/errorPage";
		}
		
	}
	*/
	
}
