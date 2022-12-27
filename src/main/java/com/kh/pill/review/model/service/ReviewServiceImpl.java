package com.kh.pill.review.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.review.model.dao.ReviewDao;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;
import com.kh.pill.review.model.vo.ReviewReply;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private ReviewDao reviewDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 베스트 리뷰 조회
	@Override
	public ArrayList<Review> selectBestList() {
		
		return reviewDao.selectBestList(sqlSession);
	}
	@Override
	public ArrayList<ReviewFile> selectBestReviewFile(int rno) {

		return reviewDao.selectBestReviewFile(sqlSession, rno);
	}
	
	// 일반 리뷰 조회
	@Override
	public int selectListCount() {
		
		return reviewDao.selectListCount(sqlSession);
	}
	@Override
	public ArrayList<Review> selectList(PageInfo pi, String order) {
		
		return reviewDao.selectList(sqlSession, pi, order);
	}
	@Override
	public ArrayList<ReviewFile> selectReviewFile(int rno) {

		return reviewDao.selectReviewFile(sqlSession, rno);
	}
	@Override
	public int selectReplyCount(int rno) {
		return reviewDao.selectReplyCount(sqlSession, rno);
	}

	@Override
	public int increaseCount(int reviewNo) {
		
		return reviewDao.increaseCount(sqlSession, reviewNo);
	}

	@Override
	public Review selectReview(int reviewNo) {
		
		return reviewDao.selectReview(sqlSession, reviewNo);
	}
	
	@Override
	public ArrayList<Integer> selectProductNoList(int rno) {
		return reviewDao.selectProductNoList(sqlSession, rno);
	}

	@Override
	public int deleteReview(int rno2) {
		return reviewDao.deleteReview(sqlSession, rno2);
	}

	@Override
	public int deleteReviewFile(int rno2) {
		return reviewDao.deleteReviewFile(sqlSession, rno2);
	}
	
	@Override
	public ArrayList<ReviewReply> selectReviewReplyList(int reviewNo) {
		return reviewDao.selectReviewReplyList(sqlSession, reviewNo);
	}

	@Override
	public int insertReviewReply(ReviewReply r) {
		return reviewDao.insertReviewReply(sqlSession, r);
	}
	
	@Override
	public int deleteReviewReply(int replyNo) {
		return reviewDao.deleteReviewReply(sqlSession, replyNo);
	}

	@Override
	public int insertRawReview(Review r) {
		return reviewDao.insertRawReview(sqlSession, r);
	}
	
	@Override
	public Review selectRawReview(int memberNo) {
		return reviewDao.selectRawReview(sqlSession, memberNo);
	}
	
	@Override
	public int insertReviewFile(ReviewFile reviewFile) {
		return reviewDao.insertReviewFile(sqlSession, reviewFile);
	}
	
	@Override
	public ArrayList<ReviewFile> selectNewReviewFile(int rawReviewNo) {
		return reviewDao.selectNewReviewFile(sqlSession, rawReviewNo);
	}
	
	@Override
	public ArrayList<Review> selectROrderList(int memberNo) {
		return reviewDao.selectROrderList(sqlSession, memberNo);
	}
	@Override
	public ArrayList<Review> selectROrderProductNameList(long orderNo) {
		return reviewDao.selectROrderProductNameList(sqlSession, orderNo);
	}
	
	

	
	

	

	

	
}
