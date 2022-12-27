package com.kh.pill.question.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.question.model.vo.Question;

@Repository
public class QuestionDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession, int memberNo) {
		return sqlSession.selectOne("questionMapper.selectListCount", memberNo);
	}

	public ArrayList<Question> selectQuestionList(SqlSessionTemplate sqlSession, int memberNo, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("questionMapper.selectQuestionList", memberNo, rowBounds);
	}

	public Question selectQuestion(SqlSessionTemplate sqlSession, int questionNo) {
		return sqlSession.selectOne("questionMapper.selectQuestion", questionNo);
	}

	public int insertQuestion(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.insert("questionMapper.insertQuestion", q);
	}

	public int updateQuestion(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.update("questionMapper.updateQuestion", q);
	}

	public int deleteQuestion(SqlSessionTemplate sqlSession, int questionNo) {
		return sqlSession.update("questionMapper.deleteQuestion", questionNo);
	}
	
	public int selectAllListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("questionMapper.selectAllListCount");
	}
	
	public ArrayList<Question> selectQuestionAllList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("questionMapper.selectQuestionAllList", null, rowBounds);
	}
	
	public int insertAnswer(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.update("questionMapper.insertAnswer", q);
	}

	public int updateAnswer(SqlSessionTemplate sqlSession, Question q) {
		return sqlSession.update("questionMapper.updateAnswer", q);
	}

	public int deleteAnswer(SqlSessionTemplate sqlSession, int questionNo) {
		return sqlSession.update("questionMapper.deleteAnswer", questionNo);
	}
}
