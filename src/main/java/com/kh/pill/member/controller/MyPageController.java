package com.kh.pill.member.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.event.model.vo.Event;
import com.kh.pill.member.model.service.MyPageService;
import com.kh.pill.member.model.vo.Member;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.order.model.vo.Order;
import com.kh.pill.poll.model.vo.Poll;
import com.kh.pill.poll.model.vo.PollResult;
import com.kh.pill.product.model.vo.Product;
import com.kh.pill.review.model.vo.Review;
import com.kh.pill.review.model.vo.ReviewFile;

@Controller
public class MyPageController {
	
	@Autowired
	private MyPageService myPageService;
	
	/**
	 * 주문조회 페이지
	 * @return
	 */
	@RequestMapping("myPage.or")
	public String myPageOrderList(@RequestParam(value="cpage", defaultValue="1")int currentPage, HttpSession session, Model model) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		int listCount = myPageService.selectMyOrderListCount(memberNo);
		int pageLimit = 5;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Order> olist = myPageService.selectMyOrderList(pi, memberNo);
		
		for(Order o : olist) {
			
			ArrayList<Product> plist = myPageService.selectMyOrderProducts(o.getOrderNo());
			String[] str = new String[plist.size()];
			
			for(int i = 0; i < plist.size(); i++) {
				 str[i] = plist.get(i).getProductName();
			}
			o.setProductNames(String.join(" & ", str));
			
		}
		
		model.addAttribute("pi", pi);
		model.addAttribute("olist", olist);
		
		return "member/myPage_OrderList";
	}
	
	/**
	 * 주문조회 기간별 검색
	 * @return
	 */
	@RequestMapping("search.or")
	public String searchOrderListByDate(@RequestParam(value="cpage", defaultValue="1")int currentPage, String s, String e, HttpSession session, Model model) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		// s == 시작날짜 (3, 6, 12 / 지정한 날짜)
		// e == 종료날짜 (0 오늘 / 지정한 날짜)
		LocalDate today = LocalDate.now();
		LocalDate startDate = null;
		LocalDate endDate = today;
		
		if(s.equals("3") || s.equals("6") || s.equals("12")) {
			startDate = today.minusMonths(Integer.parseInt(s));
		} else {
			startDate = LocalDate.parse(s);
			endDate = LocalDate.parse(e);
		}
		
		HashMap<String, String> map = new HashMap<>();
		map.put("startDate", startDate.toString() + " 00:00:00");
		map.put("endDate", endDate.toString() + " 23:59:59");
		map.put("memberNo", String.valueOf(memberNo));
		
		int listCount = myPageService.searchOrderListByDateCount(map);
		int pageLimit = 5;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Order> olist = myPageService.searchOrderListByDate(pi, map);
		
		for(Order od : olist) {
			
			ArrayList<Product> plist = myPageService.selectMyOrderProducts(od.getOrderNo());
			String[] str = new String[plist.size()];
			
			for(int i = 0; i < plist.size(); i++) {
				 str[i] = plist.get(i).getProductName();
			}
			
			od.setProductNames(String.join(" & ", str));
		}
		
		model.addAttribute("pi", pi);
		model.addAttribute("olist", olist);
		
		model.addAttribute("s", s);
		model.addAttribute("e", e);
		
		return "member/myPage_OrderList";
	}
	
	/**
	 * 주문 상세조회
	 * @return
	 */
	@RequestMapping("detail.or")
	public String selectMyOrder(String ono, Model model) {
		
		Order o = myPageService.selectMyOrder(ono);
		
		ArrayList<Cart> clist = myPageService.selectMyOrderCarts(ono);
		
		ArrayList<Product> plist = myPageService.selectMyOrderProducts(ono);
		
		model.addAttribute("o", o);
		model.addAttribute("clist", clist);
		model.addAttribute("plist", plist);
		
		return "member/myPage_OrderDetail";
	}
	
	/**
	 * 구독관리 페이지
	 * @return
	 */
	@RequestMapping("myPage.subs")
	public String myPageSubsList(HttpSession session, Model model) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		ArrayList<Order> all = myPageService.selectMySubsList(memberNo);
		
		// 중복값을 제외한 cusmoterUid 의 갯수 세기
		int count = myPageService.selectMyCustomerUidCount(memberNo);
		
		// customerUid 들을 담을 배열
		String[] uidArr = new String[count];
		int num = 0;
		
		for(int i = 0; i < all.size(); i++) {
			if(!Arrays.asList(uidArr).contains(all.get(i).getCustomerUid())) {
				uidArr[num] = all.get(i).getCustomerUid();
				num++;
			}
		}
		
		// 동일한 customerUid 값 중 subsCount 가 max 인 order 정보 가져오기
		ArrayList<Order> list = new ArrayList<>();
		
		for(int i = 0; i < uidArr.length; i++) {
			
			Order o = myPageService.selectMySubs(uidArr[i]);
			
			ArrayList<Product> plist = myPageService.selectMyOrderProducts(o.getOrderNo());
			
			if(plist.size() != 0) {
				String str = plist.get(0).getProductName();
				
				if(plist.size() > 1) {
					str += " 외 " + (plist.size() - 1);
				}
				
				o.setProductNames(str);
			}
			
			list.add(o);
			
			if(o.getSubsStatus().equals("Y")) {
				
				// 다음 결제 예정일
				LocalDate next = LocalDate.parse(o.getOrderDate());
				next = next.plusMonths(1);
				
				model.addAttribute("next", next.toString());
			}
		}
		
		model.addAttribute("list", list);
		
		return "member/myPage_SubsList";
	}
	
	/**
	 * 구독 상세조회
	 * @return
	 */
	@RequestMapping("detail.subs")
	public String selectMySubs(String ono, Model model) {
		
		// orderNo 로 customerUid 조회 후 해당 customerUid 중
		// subsCount 가 max 인 경우와 1 인 경우 조회
		Order order = myPageService.selectMyOrder(ono);
		
		Order o = myPageService.selectMySubs(order.getCustomerUid());
		
		ArrayList<Product> plist = myPageService.selectMyOrderProducts(o.getOrderNo());
		
		if(plist.size() != 0) {
			String str = plist.get(0).getProductName();
			
			if(plist.size() > 1) {
				str += " 외 " + (plist.size() - 1);
			}
			
			o.setProductNames(str);
		}
		
		// 현재 진행중인 구독의 첫 결제일
		String date = myPageService.selectMyFirstSubs(order.getCustomerUid());
		
		if(o.getSubsStatus().equals("Y")) {
			
			// 다음 결제 예정일
			LocalDate next = LocalDate.parse(o.getOrderDate());
			next = next.plusMonths(1);
			
			model.addAttribute("next", next.toString());
		}
		
		model.addAttribute("o", o);
		model.addAttribute("plist", plist);
		model.addAttribute("date", date);
		
		return "member/myPage_SubsDetail";
	}
	
	/**
	 * 주문 취소폼
	 * @return
	 */
	@RequestMapping("cancel.or")
	public String cancelOrderForm(String ono, String st, Model model) {
		
		Order o = myPageService.selectMyOrder(ono);
		
		ArrayList<Cart> clist = myPageService.selectMyOrderCarts(ono);
		
		ArrayList<Product> plist = myPageService.selectMyOrderProducts(ono);
		
		model.addAttribute("st", st);
		model.addAttribute("o", o);
		model.addAttribute("clist", clist);
		model.addAttribute("plist", plist);
		
		model.addAttribute("delivery", o.getDelivery());
		
		return "member/myPage_OrderCancelForm";
	}
	
	
	
	/**
	 * 내 정보 관리 페이지
	 * @return
	 */
	@RequestMapping("myPage.info")
	public String myPageInfoList() {
		
		
		return "member/myPage_InfoList";
	}
	
	
	
	
	/**
	 * 설문조사 페이지
	 * @return
	 */
	@RequestMapping("myPage.poll")
	public String myPagePollList(HttpSession session, Model m) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		int memberNo = loginUser.getMemberNo();
		
		ArrayList<Poll> pollList = myPageService.selectPollList(memberNo);
		ArrayList<PollResult> pollResult = myPageService.selectPollResult(memberNo);
		
		m.addAttribute("pollList", pollList);
		m.addAttribute("pollResult", pollResult);
				
		return "member/myPage_PollList";
	}
	
	
	
	/**
	 * 내 관심 제품 페이지
	 * @return
	 */
	@RequestMapping("myPage.prod")
	public String myPageProductList(@RequestParam(value="cpage", defaultValue="1")int currentPage, HttpSession session, Model model) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		int memberNo = loginUser.getMemberNo();
		
		int listCount = myPageService.selecMyProducttListCount(memberNo);
		// System.out.println("listCount : " + listCount);
		int pageLimit = 5;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		model.addAttribute("pi", pi);
		
		ArrayList<Product> myList = myPageService.selectMyProductList(pi, memberNo);
		// System.out.println("myList : " + myList);
		
		model.addAttribute("myList", myList);
		
		return "member/myPage_ProductList";
	}
	
	
	
	/**
	 * 내 후기 페이지
	 * @return
	 */
	@RequestMapping("myPage.re")
	public String myPageReviewList(@RequestParam(value="cpage", defaultValue="1")int currentPage, HttpSession session, Model model) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
				
				// 조회용 페이징
				int listCount = myPageService.selectMyReviewListCount(memberNo);
				// System.out.println("listCount : " + listCount);
				int pageLimit = 5;
				int boardLimit = 5;
				
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
				model.addAttribute("pi", pi);
				// System.out.println("pi : " + pi);
				
				// 내 리뷰 조회
				ArrayList<Review> myList = myPageService.selectMyReviewList(pi, memberNo);
				// System.out.println("myList : " + myList);
				
				for(int i = 0; i < myList.size(); i++) {
					
					Review review = myList.get(i);
					
					int rno = 0;
					rno = review.getReviewNo();
						
					ArrayList<ReviewFile> flist = myPageService.selectReviewFile(rno);
					int replyCount = myPageService.selectReplyCount(rno);
					// System.out.println("flist : " + flist);
					review.setFlist(flist);
					review.setReplyCount(replyCount);
				}
				model.addAttribute("myList", myList);
				// System.out.println("myList : " + myList);
		return "member/myPage_ReviewList";
	}
	
	/**
	 * 찜한 이벤트 페이지 
	 * @return
	 */
	@RequestMapping("myPage.ev")
	public String myPageEventList(@RequestParam(value="cpage", defaultValue="1")int currentPage, HttpSession session, Model model) {
		
		int memberNo = ((Member)session.getAttribute("loginUser")).getMemberNo();
		
		// 조회용 페이징
		int listCount = myPageService.selectMyEventListCount(memberNo);
		// System.out.println("listCount : " + listCount);
		int pageLimit = 5;
		int boardLimit = 4;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		model.addAttribute("pi", pi);
		// System.out.println("pi : " + pi);
		
		// 찜한 이벤트 전체 조회

		ArrayList<Event> myList = myPageService.selectMyEventList(pi, memberNo);
		// System.out.println("myList : " + myList);
		
		model.addAttribute("pi", pi);
		model.addAttribute("myList", myList);
		
		return "member/myPage_EventList";
	}
	
}
