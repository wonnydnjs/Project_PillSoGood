package com.kh.pill.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.notice.model.dao.NoticeDao;
import com.kh.pill.notice.model.vo.Notice;
import com.kh.pill.notice.model.vo.NoticeDetail;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		
		return noticeDao.selectListCount(sqlSession);
		
		
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		
		return noticeDao.selectList(sqlSession, pi);
	}
	

	@Override
	public NoticeDetail selectNotice(int noticeNo) {
		
		
		return noticeDao.selectNotice(sqlSession, noticeNo);
	}

	@Override
	public int increaseCount(int noticeNo) {

		return noticeDao.increaseCount(sqlSession, noticeNo);
	}

	@Override
	public int insertNotice(Notice n) {

		return noticeDao.insertNotice(sqlSession, n);
	}

	


	@Override
	public int deleteNotice(int noticeNo) {
		
		return noticeDao.deleteNotice(sqlSession, noticeNo);
	}

	@Override
	public int updateNotice(Notice n) {

		return noticeDao.updateNotice(sqlSession, n);
	}

	@Override
	public Notice selectUpdateNotice(int noticeNo) {
		
		return noticeDao.selectUpdateNotice(sqlSession,noticeNo);
	}



}
