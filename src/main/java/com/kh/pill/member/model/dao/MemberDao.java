package com.kh.pill.member.model.dao;


import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.member.model.vo.Member;

@Repository
public class MemberDao {
	
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {

		// 로그인 
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.insertMember", m);
	}
	
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updateMember", m);
	}
	
	public int deleteMember(SqlSessionTemplate sqlSession, String memberId) {
		
		return sqlSession.update("memberMapper.deleteMember", memberId);
	}
	
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {

		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}

	public String findId(SqlSessionTemplate sqlSession, Map<String, String> map) {

		return sqlSession.selectOne("memberMapper.idFind", map);
	}
	
	// 비밀번호 변경
	public int changePwdMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.changePwdMember", m);
	}
	
	// 비밀번호 초기화
	public int checkInitPwdMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.checkInitPwdMember", m);
	}

}








