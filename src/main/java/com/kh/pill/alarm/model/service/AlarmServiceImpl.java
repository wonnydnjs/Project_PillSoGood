package com.kh.pill.alarm.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.alarm.model.dao.AlarmDao;
import com.kh.pill.alarm.model.vo.Alarm;

@Service
public class AlarmServiceImpl implements AlarmService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private AlarmDao alarmDao;

	@Override
	public int selectMaxQuestionNo() {

		return alarmDao.selectMaxQuestionNo(sqlSession);
	}

	@Override
	public int selectMemberNo(String toId) {
		
		return alarmDao.selectMemberNo(sqlSession, toId);
	}

	@Override
	public int insertQuestionAlarm(Alarm a) {
		
		return alarmDao.insertQuestionAlarm(sqlSession, a);
	}

	@Override
	public ArrayList<Alarm> selectAlarmList(int memberNo) {

		return alarmDao.selectAlarmList(sqlSession, memberNo);
	}

	@Override
	public int alarmReadUpdate(int alarmNo) {
		
		return alarmDao.alarmReadUpdate(sqlSession, alarmNo);
	}

	@Override
	public int deleteAlarm(int alarmNo) {
		
		return alarmDao.deleteAlarm(sqlSession, alarmNo);
	}

	@Override
	public int readAllAlarm(int memberNo) {
		
		return alarmDao.readAllAlarm(sqlSession, memberNo);
	}

	@Override
	public int deleteReadAlarm(int memberNo) {

		return alarmDao.deleteReadAlarm(sqlSession, memberNo);
	}

	@Override
	public int selectMaxReviewNo() {
		
		return alarmDao.selectMaxReviewNo(sqlSession);
	}
	
	

}
