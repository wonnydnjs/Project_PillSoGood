package com.kh.pill.event.model.service;

import java.util.ArrayList;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.event.model.vo.Event;
import com.kh.pill.event.model.vo.EventLike;
import com.kh.pill.event.model.vo.EventReply;

public interface EventService {
	
	// 이벤트 게시판 리스트 조회 서비스 + 페이징처리
	// 게시글의 총 갯수
	int selectListCount();
	
	// 이벤트 게시글 리스트 조회
	ArrayList<Event> SelectEventList(PageInfo pi);
	
	// 이벤트 게시글 상세 조회 요청
	Event selectEvent(int eno);
	
	// 이벤트 작성 서비스
	int insertEvent(Event b);
	
	// 이벤트 삭제 서비스
	int deleteEvent(int evtNo);
	
	// 이벤트 수정 서비스
	int updateEvent(Event b);
	
	// 이벤트 댓글 리스트 조회용 서비스 (Ajax)
	ArrayList<EventReply> selectReplyList(int evtNo);
	
	// 이벤트 댓글 작성 서비스 (Ajax)
	int insertReply(EventReply er);

	// 이벤트 좋아요 누른사람 추가 
	int insertEvtLike(EventLike el);

	// 이벤트 좋아요 조회
	EventLike selectEventLike(EventLike elList);

	// 이벤트 좋아요 카운트 세는 메소드 
	int selectEvtLikeCount(int eno);

	// 이벤트 좋아요 카운트 업데이트 
	int updateEventEvtLikeCount(int eno);

	// 이벤트 좋아요 삭제 
	int deleteEvtLike(EventLike el);

	// 이벤트 댓글 삭제
	int deleteReply(int replyNo);

	// 이벤트 대댓글 작성
	int insertNestedReply(EventReply er);


	// 이벤트 대댓글 삭제
	int deleteNrReply(int replyNo);

	

	
		
}
