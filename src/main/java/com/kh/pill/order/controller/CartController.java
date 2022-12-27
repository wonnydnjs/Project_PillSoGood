package com.kh.pill.order.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.pill.member.model.vo.Member;
import com.kh.pill.order.model.service.OrderService;
import com.kh.pill.order.model.vo.Cart;

@Controller
public class CartController {
	
	@Autowired
	private OrderService orderService;
	
	/**
	 * @param 장바구니 담기
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="insert.cart", produces="text/html; charset=UTF-8")
	public String insertCart(Cart c, HttpSession session) {
		
		int result = 0;
		
		Member member = (Member)session.getAttribute("loginUser");
		
		c.setMemberNo(member.getMemberNo());
		
		// 조회 : memberNo 로 cart 에 담긴 productNo 이 있는지
		// 있으면 cartAmount 컬럼값을 가져와야 함 (number) == 장바구니에 해당 상품이 있음 (UPDATE)
		// 없으면 0 == 장바구니에 해당 상품이 없음 (INSERT)
		int count = orderService.selectIsCart(c);
		
		if(count != 0) {
			c.setCartAmount(count + c.getCartAmount());
			// UPDATE
			result = orderService.updateCart(c);
		} else {
			result = orderService.insertCart(c);
		}
		
		return (result > 0) ? "success" : "fail";
	}
	
	/**
	 * @param 장바구니 리스트 조회
	 * @return
	 */
	@RequestMapping("list.cart")
	public String selectCart(HttpSession session, Model model) {
		
		Member member = (Member)session.getAttribute("loginUser");
		int memberNo = member.getMemberNo();
		
		ArrayList<Cart> list = orderService.selectCart(memberNo);
		
		model.addAttribute("list", list);
		
		return "order/cart";
	}
	
	/**
	 * @param 장바구니 상품 삭제
	 * @return
	 */
	@RequestMapping("remove.cart")
	public String removeCart(int[] valueArr, int memberNo) {
		
		// String[] ajaxMsg = request.getParameterValues("valueArr");
		
		int size = valueArr.length;
		
		for(int i = 0; i < size; i++) {
			
			Cart c = new Cart();
			c.setProductNo(valueArr[i]);
			c.setMemberNo(memberNo);
			orderService.removeCart(c);
		}
		
		return "redirect:list.cart";
	}
	
	/**
	 * @param 장바구니 상품 수정
	 */
	@ResponseBody
	@RequestMapping("update.cart")
	public String updateCart(Cart c) {
		
		int result = orderService.updateCart(c);
		
		return (result > 0) ? "success" : "fail";
	}
	
	
	//----------------------------------------- 관리자 -----------------------------------------//
	
	
	/**
	 * 관리자 페이지 제품별 매출 통계 
	 */
	@RequestMapping("productSalesStatistics.ad")
	public String productSalesStatistics(HttpServletRequest request) {
		
		ArrayList<Cart> productList = orderService.productSalesStatistics();
		
		ArrayList<Cart> list = new ArrayList<>();
		
		for(int i = 0; i < 5; i++) {
			Cart c = new Cart();
			c = productList.get(i);
			list.add(c);
			
		}
		
		// System.out.println(list);
		
		request.setAttribute("list", list);
		
		return "order/adminProductSalesStatistics";
	}
	
	
	
	

}
