package com.kh.pill.order.model.service;

import java.util.ArrayList;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.order.model.vo.Order;
import com.kh.pill.order.model.vo.OrderCart;

public interface OrderService {
	
	// order
	
	// 구독회차 조회
	int selectCountByCustomerUid(String customerUid);
	
	// 구독 여부 확인
	int checkSubscribing(int memberNo);
	
	// 주문 완료 (저장)
	// Order insert -> Cart select -> OrderCart insert -> Cart update
	int insertOrder(Order o);
	ArrayList<Cart> selectCart(int memberNo);
	int insertOrderCart(OrderCart oc);
	int deleteCart(int memberNo);
	
	// 주문 취소 (삭제)
	int deleteOrder(Order o);
	// 구독 해지 (다른 회차는 결제완료로 두고 마지막 회차만 삭제)
	int deleteSubs(Order o);
	
	// 기존 결제의 장바구니 번호 조회
	ArrayList<OrderCart> selectCartNoForSubs(int memberNo);
	
	// ---------------------------------------------------------------
	// cart
	// 장바구니
	
	// 장바구니 담기
	int insertCart(Cart c);
	
	// 장바구니 리스트 조회
	int selectIsCart(Cart c);
	
	// 장바구니 상품 추가되었을 때 update
	int updateCart(Cart c);
	
	// 장바구니 상품 삭제
	int removeCart(Cart c);
	
	// 장바구니 상품 수정
	int modifyCart(Cart c);
	
	// ---------------------------------------------------------------
	// 관리자
	
	// 전체 주문 조회
	int selectAllListCount();
	ArrayList<Order> selectOrderAllList(PageInfo pi);

	// 주문 수정 (관리자만)
	int updateOrder(Order o);

	// 당해 당월 매출 구하기 
	ArrayList<Order> selectSalesPerMonth();

	// 연간 매출 구하기 
	ArrayList<Order> selectSalesPerYear();

	// 제품 누적매출 통계 구하기
	ArrayList<Cart> productSalesStatistics();
	
}
