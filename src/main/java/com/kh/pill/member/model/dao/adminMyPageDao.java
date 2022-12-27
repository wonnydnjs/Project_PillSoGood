package com.kh.pill.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.member.model.vo.Member;

@Repository
public class adminMyPageDao {

	/**
	 * 회원정보 수 구하기
	 */
	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("memberMapper.adminSelectListCount");
	}

	/**
	 * 회원 정보 리스트 조회 
	 */
	public ArrayList<Member> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.adminSelectList", null, rowBounds);
	}

	/**
	 * 회원 상세 조회
	 */
	public Member selectMember(SqlSessionTemplate sqlSession, int mno) {
		
		return sqlSession.selectOne("memberMapper.adminSelectMember", mno);
	}

	/**
	 * 회원 정보 수정
	 */
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.adminUpdateMember", m);
	}

	/**
	 * 회원 탈퇴 처리
	 */
	public int deleteMember(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.update("memberMapper.adminDeleteMember", memberNo);
	}

	/**
	 * 회원 검색 리스트 처리
	 */
	public int selectSearchListCount(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("memberMapper.adminSelectSearchListCount");
	}

	/**
	 * 회원 검색 처리
	 */
	public ArrayList<Member> selectSearchList(SqlSessionTemplate sqlSession, PageInfo pi, String keyword) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("memberMapper.adminSelectSearchList", keyword, rowBounds);
	}

}
