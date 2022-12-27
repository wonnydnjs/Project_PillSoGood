package com.kh.pill.event.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor // 기본생성자
@Setter
@Getter
@ToString
public class Event {
	private int evtNo; // EVENT_NO	NUMBER
	private String evtTitle; // EVENT_TITLE	VARCHAR2(100 BYTE)
	private String evtContent; // EVENT_CONTENT	VARCHAR2(3000 BYTE)
	private int evtCount; // EVENT_COUNT	NUMBER
	private String evtImgName; // EVENT_IMG_NAME	VARCHAR2(1000 BYTE)
	private String evtStatus; // EVENT_STATUS	CHAR(1 BYTE)
	private Date evtStart; // EVENT_START	DATE
	private Date evtDew; // EVENT_DEW	DATE
	private int evtLikeCount; // EVENT_LIKE_COUNT	NUMBER
	

}
