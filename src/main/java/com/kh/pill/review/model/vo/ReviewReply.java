package com.kh.pill.review.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor //기본생성자
@Setter // setter메소드들
@Getter // getter메소드들
@ToString //toString메소드
public class ReviewReply {

	private int replyNo; // REPLY_NO	NUMBER
	private String replyContent; // REPLY_CONTENT	VARCHAR2(3000 BYTE)
	private String replyDate; // REPLY_DATE	DATE
	private String replyStatus; // REPLY_STATUS	CHAR(1 BYTE)
	
	private int memberNo;
	private int reviewNo;
	private String memberName;
	private String memberId;
	
	
}
