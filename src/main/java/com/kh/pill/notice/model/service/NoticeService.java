package com.kh.pill.notice.model.service;

import java.util.ArrayList;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.notice.model.vo.Notice;
import com.kh.pill.notice.model.vo.NoticeDetail;

public interface NoticeService {
	
	int selectListCount();
	

	ArrayList<Notice> selectList(PageInfo pi);
	
	int insertNotice(Notice n);

	int increaseCount(int noticeNo);
	
	NoticeDetail selectNotice(int noticeNo);
	

	int deleteNotice(int noticeNo);
	

	int updateNotice(Notice n);
	
	Notice selectUpdateNotice(int noticeNo);
	
}
