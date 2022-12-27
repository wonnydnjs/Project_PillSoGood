package com.kh.pill.member.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.event.model.vo.Event;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.order.model.vo.Order;
import com.kh.pill.poll.model.vo.Poll;
import com.kh.pill.poll.model.vo.PollResult;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;

public interface MyPageService {
	
	// 주문조회
	int selectMyOrderListCount(int memberNo);
	ArrayList<Order> selectMyOrderList(PageInfo pi, int memberNo);
	// 주문내역의 상품정보들 조회
	ArrayList<Product> selectMyOrderProducts(String orderNo);
	
	// 주문조회 기간별 검색
	int searchOrderListByDateCount(HashMap<String, String> map);
	ArrayList<Order> searchOrderListByDate(PageInfo pi, HashMap<String, String> map);
	
	// 주문 상세조회
	Order selectMyOrder(String orderNo);
	// 주문한 상품의 수량 조회
	ArrayList<Cart> selectMyOrderCarts(String orderNo);
	
	// 구독 리스트 조회
	ArrayList<Order> selectMySubsList(int memberNo);
	// 중복 제외 customerUid 수
	int selectMyCustomerUidCount(int memberNo);
	// 구독 상세조회
	Order selectMySubs(String customerUid);
	// 현재 구독의 첫 결제일
	String selectMyFirstSubs(String customerUid);
	
	
	// 설문 결과 조회용
	ArrayList<Poll> selectPollList(int memberNo);
	ArrayList<PollResult> selectPollResult(int memberNo);

	// 제품 조회 리스트 카운트
	int selecMyProducttListCount(int memberNo);
	// 제품 조회
	ArrayList<Product> selectMyProductList(PageInfo pi, int memberNo);

	// 후기 조회 리스트 카운트
	int selectMyReviewListCount(int memberNo);
	// 후기 조회
	ArrayList<Review> selectMyReviewList(PageInfo pi, int memberNo);
	// 후기 첨부파일 조회
	ArrayList<ReviewFile> selectReviewFile(int rno);
	// 후기 조회수
	int selectReplyCount(int rno);
	
	// 이벤트 조회 리스트 카운트
	int selectMyEventListCount(int memberNo);
	// 이벤트 조회
	ArrayList<Event> selectMyEventList(PageInfo pi, int memberNo);
	

}
