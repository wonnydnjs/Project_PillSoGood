package com.kh.pill.member.model.service;

import java.util.Map;

import com.kh.pill.member.model.vo.Member;

public interface MemberService {
	
	// 로그인 서비스 (select)
	Member loginMember(Member m);
	
	// 회원가입 서비스 (insert)
	int insertMember(Member m);

	// 회원정보수정 서비스 (update)
	int updateMember(Member m);
	
	// 회원탈퇴 서비스 (update)
	int deleteMember(String memberId);
	
	// 아이디중복체크 서비스 (select)
	int idCheck(String checkId);

	// 이메일 중복 체크
	//boolean emailCheck(String email);
	
	// 아이디 찾기
	String findId(Map<String, String> map);
	
	// 비밀번호 변경 (update)
	int changePwdMember(Member m);
	
	// 비밀번호 초기화
	int checkInitPwdMember(Member m);
}
