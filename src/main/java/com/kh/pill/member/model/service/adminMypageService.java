package com.kh.pill.member.model.service;

import java.util.ArrayList;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.member.model.vo.Member;

public interface adminMypageService {

	// 페이지 카운트 세기
	int selectListCount();

	// 회원 정보 리스트 조회 
	ArrayList<Member> selectList(PageInfo pi);

	// 회원 정보 상세 조회
	Member selectMember(int mno);

	// 회원 정보 수정
	int updateMember(Member m);

	// 회원 탈퇴 처리
	int deleteMember(int memberNo);

	// 회원 검색 리스트 카운트
	int selectSearchListCount(String keyword);

	// 회원 검색 조회
	ArrayList<Member> selectSearchList(PageInfo pi, String keyword);

}
