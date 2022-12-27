package com.kh.pill.common.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.magazine.model.service.MagazineService;
import com.kh.pill.magazine.model.vo.Magazine;
import com.kh.pill.review.model.service.ReviewService;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;

@Controller
public class CommonController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MagazineService magazineService;
	
	
	@RequestMapping("aboutUs.pill")
	public String fowardAboutUs() {
		
		return "common/aboutUs";
	}
	
	@RequestMapping("faq.pill")
	public String fowardFAQ() {
		
		return "common/faq";
	}
	
	@ResponseBody
	@RequestMapping(value="bestReview.main", produces="application/json; charset=UTF-8")
	public String mainPageBesReview() {
		
		// 베스트 리뷰 조회
		ArrayList<Review> bestListAll = reviewService.selectBestList(); // 일반 리뷰 전체를 베스트 기준으로 조회 후 ArrayList bestListAll 에 담음
		ArrayList<Review> bestList = new ArrayList<>(); // 베스트 기준에 맞는 상위 3개 리뷰를 담을 ArrayList bestList 생성 
		// System.out.println(bestList);
		if(bestListAll.size() != 0 ) {
			
			for(int i = 0; i < 4; i++) { // 상위 3개를 위해 3번만 반복
				
				Review bestReview = bestListAll.get(i); // bestListAll 에서 상위 3개 리뷰를 추출
				
				int rno = 0; // 일치 조건인 외래키 reviewNo 변수 설정 및 초기화
				rno = bestReview.getReviewNo(); // rno 에 상위 3개 리뷰의 reviewNo 를 담음
				// System.out.println(rno);
					
				ArrayList<ReviewFile> bflist = reviewService.selectBestReviewFile(rno); 
				// REVIEW_FILE 테이블에서 rno 가 일치하는 썸네일 파일만 추출해서  ArrayList bflist 에 담음
				// System.out.println("bflist : " + bflist);
				
				bestReview.setFlist(bflist); // bflist 를 Review 객체 bestReview 에 담음
				bestList.add(bestReview); // bestReview 를 ArrayList bestList 에 담음
				
			}
		}
		
		
		return new Gson().toJson(bestList);
		
	}
	
	@ResponseBody
	@RequestMapping(value="latestMagazine.main", produces="application/json; charset=UTF-8")
	public String latestMagazine() {
		
		
		int pageLimit = 5; 
		int boardLimit = 6;
		int currentPage = 1;
		
		int listCount = magazineService.selectListCount();

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		
		ArrayList<Magazine> list = magazineService.selectMagazineList(pi);
		
		ArrayList<Magazine> mainList = new ArrayList<>();
		
		
		for(int i =0; i <3 ; i++) {
			
			Magazine m = new Magazine();
			
			m = list.get(i);
			
			
			mainList.add(m);
			
		}
		
		return new Gson().toJson(mainList);
	}
	

}
