package com.kh.pill.alarm.model.service;

import java.util.ArrayList;

import com.kh.pill.alarm.model.vo.Alarm;

public interface AlarmService {
	
	int selectMaxQuestionNo();
	
	int selectMaxReviewNo();
	
	int selectMemberNo(String toId);
	
	int insertQuestionAlarm(Alarm a);
	
	ArrayList<Alarm> selectAlarmList(int memberNo);
	
	int alarmReadUpdate(int alarmNo);
	
	int deleteAlarm(int alarmNo);
	
	int readAllAlarm(int memberNo);
	
	int deleteReadAlarm(int memberNo);

}
