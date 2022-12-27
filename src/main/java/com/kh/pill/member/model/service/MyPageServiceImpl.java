package com.kh.pill.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.event.model.vo.Event;
import com.kh.pill.member.model.dao.MyPageDao;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.order.model.vo.Order;
import com.kh.pill.poll.model.vo.Poll;
import com.kh.pill.poll.model.vo.PollResult;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;

@Service
public class MyPageServiceImpl implements MyPageService {
	
	@Autowired
	private MyPageDao myPageDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	/**
	 * 전체 주문내역 수
	 */
	@Override
	public int selectMyOrderListCount(int memberNo) {
		return myPageDao.selectMyOrderListCount(sqlSession, memberNo);
	}
	
	/**
	 * 주문내역 전체 조회
	 */
	@Override
	public ArrayList<Order> selectMyOrderList(PageInfo pi, int memberNo) {
		return myPageDao.selectMyOrderList(sqlSession, pi, memberNo);
	}

	/**
	 * 주문내역의 제품명 조회
	 */
	@Override
	public ArrayList<Product> selectMyOrderProducts(String orderNo) {
		return myPageDao.selectMyOrderProducts(sqlSession, orderNo);
	}
	
	/**
	 * 주문내역 기간별 조회
	 */
	@Override
	public int searchOrderListByDateCount(HashMap<String, String> map) {
		return myPageDao.searchOrderListByDateCount(sqlSession, map);
	}
	@Override
	public ArrayList<Order> searchOrderListByDate(PageInfo pi, HashMap<String, String> map) {
		return myPageDao.searchOrderListByDate(sqlSession, pi, map);
	}
	
	/**
	 * 주문 상세조회
	 */
	@Override
	public Order selectMyOrder(String orderNo) {
		return myPageDao.selectMyOrder(sqlSession, orderNo);
	}
	
	/**
	 * 주문 상품의 수량 조회
	 */
	@Override
	public ArrayList<Cart> selectMyOrderCarts(String orderNo) {
		return myPageDao.selectMyOrderCarts(sqlSession, orderNo);
	}
	
	/**
	 * 구독 리스트 조회
	 */
	@Override
	public ArrayList<Order> selectMySubsList(int memberNo) {
		return myPageDao.selectMySubsList(sqlSession, memberNo);
	}
	
	/**
	 * 중복 제외 customerUid 수
	 */
	@Override
	public int selectMyCustomerUidCount(int memberNo) {
		return myPageDao.selectMyCustomerUidCount(sqlSession, memberNo);
	}
	
	/**
	 * 구독 상세조회
	 */
	@Override
	public Order selectMySubs(String customerUid) {
		return myPageDao.selectMySubs(sqlSession, customerUid);
	}
	
	/**
	 * 구독 첫결제일 조회
	 */
	@Override
	public String selectMyFirstSubs(String customerUid) {
		return myPageDao.selectMyFirstSubs(sqlSession, customerUid);
	}
	
	
	
	
	
	/**
	 * 설문조사 결과 조회용 서비스
	 */
	@Override
	public ArrayList<PollResult> selectPollResult(int memberNo) {
		
		return myPageDao.selectPollResult(sqlSession, memberNo);
	}



	/**
	 * 설문조사 결과 조회용 서비스
	 */
	@Override
	public ArrayList<Poll> selectPollList(int memberNo) {
		
		return myPageDao.selectPollList(sqlSession, memberNo);
	}

	
	/**
	 * 제품 조회용 서비스
	 */
	@Override
	public int selecMyProducttListCount(int memberNo) {
		return myPageDao.selectMyProductListCount(sqlSession, memberNo);
	}
	
	@Override
	public ArrayList<Product> selectMyProductList(PageInfo pi, int memberNo) {
		return myPageDao.selectMyProductList(sqlSession, pi, memberNo);
	}
	
	
	/**
	 * 후기 조회용 서비스
	 */
	@Override
	public int selectMyReviewListCount(int memberNo) {
		return myPageDao.selectMyReviewListCount(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Review> selectMyReviewList(PageInfo pi, int memberNo) {
		return myPageDao.selectMyReviewList(sqlSession, pi, memberNo);
	}
	
	@Override
	public ArrayList<ReviewFile> selectReviewFile(int rno) {
		return myPageDao.selectReviewFile(sqlSession, rno);
	}

	@Override
	public int selectReplyCount(int rno) {
		return myPageDao.selectReplyCount(sqlSession, rno);
	}

	/**
	 * 이벤트 조회용 서비스
	 */
	@Override
	public int selectMyEventListCount(int memberNo) {
		return myPageDao.selectMyEventListCount(sqlSession, memberNo);
	}

	@Override
	public ArrayList<Event> selectMyEventList(PageInfo pi, int memberNo) {
		return myPageDao.selectMyEventList(sqlSession, pi, memberNo);
	}



	


}
