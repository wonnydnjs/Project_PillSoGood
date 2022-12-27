package com.kh.pill.event.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.event.model.dao.EventDao;
import com.kh.pill.event.model.vo.Event;
import com.kh.pill.event.model.vo.EventLike;
import com.kh.pill.event.model.vo.EventReply;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	private EventDao eventDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	/**
	 * 이벤트 총 게시글수 조회 
	 */
	@Override
	public int selectListCount() {
		
		return eventDao.selectListCount(sqlSession);
	}

	/**
	 * 이벤트 게시글 리스트 전체 조회
	 */
	@Override
	public ArrayList<Event> SelectEventList(PageInfo pi) {
		
		return eventDao.SelectEventList(sqlSession, pi);
		
	}

	/**
	 * 이벤트 게시글 상세조회
	 */
	@Override
	public Event selectEvent(int eno) {
		
		return eventDao.selectEvent(sqlSession, eno);
	}

	/**
	 * 이벤트 게시글 추가
	 */
	@Override
	public int insertEvent(Event e) {
		
		return eventDao.insertEvent(sqlSession, e);
	}

	/**
	 * 이벤트 게시물 삭제
	 */
	@Override
	public int deleteEvent(int eno) {
		
		return eventDao.deleteEvent(sqlSession, eno);
	}

	/**
	 * 이벤트 게시물 수정 
	 */
	@Override
	public int updateEvent(Event e) {
		
		return eventDao.updateEvent(sqlSession, e);
	}

	/**
	 * 댓글 리스트 조회
	 */
	@Override
	public ArrayList<EventReply> selectReplyList(int evtNo) {
		
		return eventDao.selectReplyList(sqlSession, evtNo);
	}

	/**
	 * 이벤트 댓글 작성 
	 */
	@Override
	public int insertReply(EventReply er) {
		
		return eventDao.insertReply(sqlSession, er);
	}
	
	

	/**
	 * 이벤트 게시물 좋아요 누름 
	 */
	@Override
	public int insertEvtLike(EventLike el) {
		
		return eventDao.insertEvtLike(sqlSession, el);
	}

	
	/**
	 * 이벤트 좋아요 조회
	 */
	@Override
	public EventLike selectEventLike(EventLike elList) {
		
		return eventDao.selectEventLike(sqlSession, elList);
	}

	/**
	 * 이벤트 좋아요 카운트 컬럼 업데이트 
	 */
	@Override
	public int updateEventEvtLikeCount(int eno) {
	
		return eventDao.updateEventEvtLikeCount(sqlSession ,eno);
	}

	/**
	 * 이벤트 좋아요 삭제 
	 */
	@Override
	public int deleteEvtLike(EventLike el) {
	
		return eventDao.deleteEvtLike(sqlSession, el);
	}

	/**
	 * 이벤트 좋아요 카운트 세는 메소드 
	 */
	@Override
	public int selectEvtLikeCount(int eno) {
	
		return eventDao.selectEvtLikeCount(sqlSession, eno);
	}

	/**
	 * 이벤트 댓글 삭제
	 */
	@Override
	public int deleteReply(int replyNo) {
		
		return eventDao.deleteReply(sqlSession, replyNo);
	}

	
	/**
	 * 이벤트 대댓글 작성 
	 */
	@Override
	public int insertNestedReply(EventReply er) {
		
		return eventDao.insertNestedReply(sqlSession, er);
	}

	/**
	 * 이벤트 대댓글 삭제 
	 */
	@Override
	public int deleteNrReply(int replyNo) {
		
		return eventDao.deleteNrReply(sqlSession, replyNo);
	}

	
	

}
