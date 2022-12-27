package com.kh.pill.question.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.question.model.dao.QuestionDao;
import com.kh.pill.question.model.vo.Question;

@Service
public class QuestionServiceImpl implements QuestionService {
	
	@Autowired
	private QuestionDao questionDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public int selectListCount(int memberNo) {
		return questionDao.selectListCount(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Question> selectQuestionList(int memberNo, PageInfo pi) {
		return questionDao.selectQuestionList(sqlSession, memberNo, pi);
	}

	@Override
	public Question selectQuestion(int questionNo) {
		return questionDao.selectQuestion(sqlSession, questionNo);
	}

	@Override
	public int insertQuestion(Question q) {
		return questionDao.insertQuestion(sqlSession, q);
	}

	@Override
	public int updateQuestion(Question q) {
		return questionDao.updateQuestion(sqlSession, q);
	}

	@Override
	public int deleteQuestion(int questionNo) {
		return questionDao.deleteQuestion(sqlSession, questionNo);
	}

	@Override
	public int selectAllListCount() {
		return questionDao.selectAllListCount(sqlSession);
	}

	@Override
	public ArrayList<Question> selectQuestionAllList(PageInfo pi) {
		return questionDao.selectQuestionAllList(sqlSession, pi);
	}

	@Override
	public int insertAnswer(Question q) {
		return questionDao.insertAnswer(sqlSession, q);
	}

	@Override
	public int updateAnswer(Question q) {
		return questionDao.updateAnswer(sqlSession, q);
	}

	@Override
	public int deleteAnswer(int questionNo) {
		return questionDao.deleteAnswer(sqlSession, questionNo);
	}
}
