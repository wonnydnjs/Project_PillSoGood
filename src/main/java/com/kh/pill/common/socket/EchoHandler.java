package com.kh.pill.common.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.pill.member.model.vo.Member;

public class EchoHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//클라이언트와 서버가 연결
		// TODO Auto-generated method stub
		// logger.info("Socket 연결");
		sessions.add(session);
		//logger.info(currentUserName(session));//현재 접속한 사람
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId,session);
		
		//logger.info(String.valueOf(userSessionsMap.size()));
		
	}
	
	@SuppressWarnings("deprecation")
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지

		
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		
		
		if (!StringUtils.isEmpty(msg)) {
			
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 5) {
				
				String cmd = strs[0];
				String fromId = strs[1];
				String toId = strs[2];
				String bno = strs[3];
				String title = strs[4];
				
				WebSocketSession toIdSession = userSessionsMap.get(toId);
				
				 if("question".equals(cmd)) {
					toId = "admin";
					toIdSession = userSessionsMap.get(toId);
					if(!fromId.equals(toId)) {
						TextMessage tmpMsg = new TextMessage("<br>"+fromId + "님이 "
								+ "문의를 작성하셨습니다. <br>" + title );
						toIdSession.sendMessage(tmpMsg);
					}
					
				} else if("answer".equals(cmd)) {
					
					TextMessage tmpMsg = new TextMessage("<br> 관리자님이 "
							+ "문의에 대한 답변을 작성 하셨습니다. <br>" + title );
					toIdSession.sendMessage(tmpMsg);
					
				} else if("review".equals(cmd)) {
					
					TextMessage tmpMsg = new TextMessage("<br>"+ fromId + "님이 "
							+ "리뷰를 작성 하셨습니다. <br>" + title);
					toIdSession.sendMessage(tmpMsg);
				} else if("reply".equals(cmd)) {
					
					TextMessage tmpMsg = new TextMessage("<br>" + fromId + "님이 "
							+ "리뷰에 댓글을 다셨습니다. <br>"+ title);
					toIdSession.sendMessage(tmpMsg);
							
				} else if("order".equals(cmd)) {
					
					TextMessage tmpMsg = new TextMessage("<br>" + fromId + "님이 "
							+ "상품을 구매하셨습니다.<br>주문번호 : " + title);
					toIdSession.sendMessage(tmpMsg);
				}
				
			}
			
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		
		sessions.remove(session);
		userSessionsMap.remove(currentUserName(session),session);
		
	}

	
	private String currentUserName(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		Member loginUser = (Member)httpSession.get("loginUser");
		
		if(loginUser == null) {
			
			return null;
		}

		return loginUser.getMemberId();
		
	}
}