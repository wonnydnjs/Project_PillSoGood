package com.kh.pill.event.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor // 기본생성자 
@Setter
@Getter
@ToString
public class EventReply {
	private int replyNo; // REPLY_NO	NUMBER
	private String replyContent; // REPLY_CONTENT	VARCHAR2(3000 BYTE)
	private String replyDate; // REPLY_DATE	DATE
	private int parentReply; // PARENT_REPLY	NUMBER
	private String replyStatus; //REPLY_STATUS	CHAR(1 BYTE)
	private int memberNo; // MEMBER_NO	NUMBER
	private int evtNo; // EVENT_NO	NUMBER
	private String memberName; // MEMBER_NAME 
}
