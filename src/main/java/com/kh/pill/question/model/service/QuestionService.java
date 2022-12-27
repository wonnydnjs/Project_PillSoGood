package com.kh.pill.question.model.service;

import java.util.ArrayList;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.question.model.vo.Question;

public interface QuestionService {
	
	// 리스트조회
	int selectListCount(int memberNo);
	ArrayList<Question> selectQuestionList(int memberNo, PageInfo pi);
	
	// 상세조회
	Question selectQuestion(int questionNo);
	
	// 작성
	int insertQuestion(Question q);
	
	// 수정
	int updateQuestion(Question q);
	
	// 삭제
	int deleteQuestion(int questionNo);
	
	// 관리자 전체 리스트조회
	int selectAllListCount();
	ArrayList<Question> selectQuestionAllList(PageInfo pi);
	
	// 답변 작성
	int insertAnswer(Question q);
	
	// 답변 수정
	int updateAnswer(Question q);
	
	// 답변 삭제
	int deleteAnswer(int questionNo);
}
