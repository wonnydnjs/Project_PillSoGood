package com.kh.pill.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.member.model.dao.adminMyPageDao;
import com.kh.pill.member.model.vo.Member;

@Service
public class adminMypageServiceImpl implements adminMypageService {

	@Autowired
	private adminMyPageDao adMyPageDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	
	
	/**
	 * 회원정보 수 구하기
	 */
	@Override
	public int selectListCount() {
		
		return adMyPageDao.selectListCount(sqlSession);
	}

	/**
	 * 회원 정보 리스트 조회
	 */
	@Override
	public ArrayList<Member> selectList(PageInfo pi) {
		
		return adMyPageDao.selectList(sqlSession, pi);
	}

	/**
	 * 회원 정보 상세 조회
	 */
	@Override
	public Member selectMember(int mno) {
		
		return adMyPageDao.selectMember(sqlSession, mno);
	}

	/**
	 * 회원 정보 수정
	 */
	@Override
	public int updateMember(Member m) {
		
		return adMyPageDao.updateMember(sqlSession, m);
	}

	/**
	 * 회원 탈퇴 처리
	 */
	@Override
	public int deleteMember(int memberNo) {
		
		return adMyPageDao.deleteMember(sqlSession, memberNo);
	}
	
	/**
	 * 회원 검색 리스트 카운트 처리
	 */
	@Override
	public int selectSearchListCount(String keyword) {
		return adMyPageDao.selectSearchListCount(sqlSession, keyword);
	}

	/**
	 * 회원 검색 처리
	 */
	@Override
	public ArrayList<Member> selectSearchList(PageInfo pi, String keyword) {
		return adMyPageDao.selectSearchList(sqlSession, pi, keyword);
	}

}
