package com.kh.pill.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class NoticeDetail {
	
	private int noticeNo;
	private int nextNo;
	private int prevNo;
	private String noticeTitle;
	private String nextTitle;
	private String prevTitle;
	private String noticeContent;
	private String noticeDate;
	private String nextDate;
	private String prevDate;

}
