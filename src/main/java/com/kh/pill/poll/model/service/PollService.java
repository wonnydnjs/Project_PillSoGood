package com.kh.pill.poll.model.service;

import java.util.ArrayList;

import com.kh.pill.member.model.vo.Member;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.poll.model.vo.Poll;
import com.kh.pill.poll.model.vo.PollResult;

public interface PollService {
	
	int insertPoll(int memberNo);
	
	Poll selectPoll(int memberNo);
	
	int updateMember(Member m);
	
	int insertResultType(PollResult pr);
	
	ArrayList<PollResult> selectResult(int memberNo);
	
	int insertCart(Cart c);
	
	ArrayList<PollResult> pollResult(Poll p);
	
	int deletePoll(int pollNo);
	
	int deleteCart(int memberNo);

}
