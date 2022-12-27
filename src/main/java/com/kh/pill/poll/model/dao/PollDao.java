package com.kh.pill.poll.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.member.model.vo.Member;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.poll.model.vo.Poll;
import com.kh.pill.poll.model.vo.PollResult;

@Repository
public class PollDao {
	
	public int insertPoll(SqlSessionTemplate sqlSession, int memberNo) {
			
		return sqlSession.insert("pollMapper.insertPoll", memberNo);
	}
	
	public Poll selectPoll(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.selectOne("pollMapper.selectPoll", memberNo);
	}
	
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("pollMapper.updateMember", m);
		
	}
	
	public int insertResultType(SqlSessionTemplate sqlSession, PollResult pr) {
		
		return sqlSession.insert("pollMapper.insertResultType", pr);
	}
	
	
	public ArrayList<PollResult> selectResult(SqlSessionTemplate sqlSession, int memberNo) {
	
		return (ArrayList)sqlSession.selectList("pollMapper.selectResult", memberNo);
	}
	
	public int insertCart(SqlSessionTemplate sqlSession, Cart c) {
		
		return sqlSession.insert("pollMapper.insertCart", c);
	}
	
	public ArrayList<PollResult> pollResult(SqlSessionTemplate sqlSession, Poll p) {
		
		return (ArrayList)sqlSession.selectList("pollMapper.pollResult", p);
	}
	
	public int deletePoll(SqlSessionTemplate sqlSession, int pollNo) {
		
		return sqlSession.update("pollMapper.deletePoll", pollNo);
	}
	
	public int deleteCart(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.delete("pollMapper.deleteCart", memberNo);
	}
}
