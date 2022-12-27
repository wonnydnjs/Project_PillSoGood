package com.kh.pill.alarm.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.alarm.model.vo.Alarm;

@Repository
public class AlarmDao {
	
	
	public int selectMaxQuestionNo(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("alarmMapper.selectMaxQuestionNo");
	}
	
	public int selectMaxReviewNo(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("alarmMapper.selectMaxReviewNo");
	}
	
	public int selectMemberNo(SqlSessionTemplate sqlSession, String toId) {
		
		return sqlSession.selectOne("alarmMapper.selectMemberNo", toId);
	}

	public int insertQuestionAlarm(SqlSessionTemplate sqlSession, Alarm a) {
		
		return sqlSession.insert("alarmMapper.insertQuestionAlarm", a);
	}
	
	public ArrayList<Alarm> selectAlarmList(SqlSessionTemplate sqlSession, int memberNo) {
		
		return (ArrayList)sqlSession.selectList("alarmMapper.selectAlarmList", memberNo);
	}
	
	public int alarmReadUpdate(SqlSessionTemplate sqlSession, int alarmNo) {
		
		return sqlSession.update("alarmMapper.alarmReadUpdate", alarmNo);
	}
	
	public int deleteAlarm(SqlSessionTemplate sqlSession, int alarmNo) {
		
		return sqlSession.update("alarmMapper.deleteAlarm", alarmNo);
	}
	
	public int readAllAlarm(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.update("alarmMapper.readAllAlarm", memberNo);
	}
	
	public int deleteReadAlarm(SqlSessionTemplate sqlSession, int memberNo) {
		
		return sqlSession.update("alarmMapper.deleteReadAlarm", memberNo);
	}
	
}
