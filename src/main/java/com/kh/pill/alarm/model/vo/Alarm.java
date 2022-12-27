package com.kh.pill.alarm.model.vo;

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
public class Alarm {
	
	private int alarmNo;
	private String alarmContent;
	private String alarmDate;
	private String fromId;
	private int alarmRead;
	private String alarmStatus;
	private int memberNo;
	private String alarmUrl;

}
