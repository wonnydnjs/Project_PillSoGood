package com.kh.pill.member.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.member.model.service.adminMypageService;
import com.kh.pill.member.model.vo.Member;

@Controller
public class adminMypageController {
	
	

	@Autowired
	private adminMypageService adMypageService; 
	
	
	/**
	 * 관리자 회원 리스트 조회
	 */
	@RequestMapping("adminMypage.me")
	public String selectMemberAdMypage(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model) {
		
		// 회원 정보 수 구하기
		int listCount = adMypageService.selectListCount();
		
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		// 회원 정보 조회
		ArrayList<Member> list = adMypageService.selectList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		
		
		return "member/adminMyPage_memList";
		
	}
	
	/**
	 * 관리자 회원 상세 조회
	 */
	@RequestMapping("adMyPageDetail.me")
	public String selectDetailMemberAdMypage(int mno, Model model) {
		
		Member m = adMypageService.selectMember(mno);

		if( m == null) {
			
			model.addAttribute("errorMsg", "게시글 상세조회 실패");
			return "common/errorPage";
			
		} else {
			
			model.addAttribute("m", m);
			return "member/adminMyPage_memDetail";
			
		}
		

		
	}
	
	/**
	 * 관리자 회원 정보 수정하는 페이지로 이동 
	 */
	@RequestMapping("adMyPageUpdateForm.me")
	public String updateMemberFormAdMyPage(int mno, Model model) {
		
		Member m = adMypageService.selectMember(mno);
		
		model.addAttribute("m", m);
		
		return "member/adminMyPage_memUpdateForm";
		
	}
	
	
	/**
	 * 회원 정보 업데이트 요청
	 */
	@RequestMapping("adMyPageUpdate.me")
	public String updateMemberAdMyPage(Member m, Model model) {
		
		System.out.println(m);
		
		int result = adMypageService.updateMember(m);
		
		if(result > 0) { 
			
			model.addAttribute("alertMsg", "성공적으로 회원정보가 수정되었습니다.");
			
			// 회원 상세보기 페이지로 url 재요청
			return "redirect:/adMyPageDetail.me?mno=" + m.getMemberNo();
		}
		else { 
			
			model.addAttribute("errorMsg", "회원정보 수정 실패");
			
			return "common/errorPage";
		}
		
		
		
	}
	
	/**
	 * 회원 탈퇴 처리 
	 */
	@RequestMapping("adMyPageDelete.me")
	public String deleteMemberAdMyPage(int memberNo, Model model) {
		
		System.out.println(memberNo);
		
		int result = adMypageService.deleteMember(memberNo);
		
		if(result > 0) {
			
			model.addAttribute("alertMsg", "성공적으로 탈퇴처리 되었습니다.");
			
			// 회원 리스트 조회 페이지로 url 재요청
			return "member/adminMyPage_memList";
			
		} else {
			
			model.addAttribute("errorMsg", "회원탈퇴 실패");
			
			return "common/errorPage";
		}
		
	}
	
	/**
	 * 관리자 회원 검색
	 */
	@RequestMapping("adMyPageSearch.me")
	public String searchMemberAdMyPage(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model, String keyword) {
		
		// 검색되는 회원 수 구하기
		int listCount = adMypageService.selectSearchListCount(keyword);
		
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		// 회원 정보 조회
		ArrayList<Member> searchList = adMypageService.selectSearchList(pi, keyword);
		
		model.addAttribute("pi", pi);
		model.addAttribute("searchList", searchList);
		
		// System.out.println(searchList);
		
		return "member/adminMyPage_memList";
	}
	

}
