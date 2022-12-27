package com.kh.pill.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Notice {
	
	private int noticeNo; // NOTICE_NO NUMBER PRIMARY KEY,
    private String noticeTitle; // NOTICE_TITLE VARCHAR2(100) NOT NULL,
    private String noticeContent; // NOTICE_CONTENT VARCHAR2(3000) NOT NULL,
    private String noticeDate; // NOTICE_DATE DATE,
    private int noticeCount; // NOTICE_COUNT NUMBER,
    private String noticeStatus; // NOTICE_STATUS CHAR(1) DEFAULT 'Y');
	

}
