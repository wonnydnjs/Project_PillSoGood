package com.kh.pill.poll.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.member.model.vo.Member;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.poll.model.dao.PollDao;
import com.kh.pill.poll.model.vo.Poll;
import com.kh.pill.poll.model.vo.PollResult;

@Service
public class PollServiceImpl implements PollService {

	@Autowired
	private PollDao pollDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int insertPoll(int memberNo) {
		
		return pollDao.insertPoll(sqlSession, memberNo);
	}


	@Override
	public int updateMember(Member m) {
		
		return pollDao.updateMember(sqlSession, m);
	}


	@Override
	public Poll selectPoll(int memberNo) {
		
		return pollDao.selectPoll(sqlSession, memberNo);
	}


	@Override
	public int insertResultType(PollResult pr) {
		
		return pollDao.insertResultType(sqlSession, pr);
	}


	@Override
	public ArrayList<PollResult> selectResult(int memberNo) {
		
		return pollDao.selectResult(sqlSession, memberNo);
	}


	@Override
	public int insertCart(Cart c) {

		return pollDao.insertCart(sqlSession, c);
	}


	@Override
	public ArrayList<PollResult> pollResult(Poll p) {
		
		return pollDao.pollResult(sqlSession, p); 
	}


	@Override
	public int deletePoll(int pollNo) {

		return pollDao.deletePoll(sqlSession, pollNo);
	}


	@Override
	public int deleteCart(int memberNo) {
		
		return pollDao.deleteCart(sqlSession, memberNo);
	}

}
