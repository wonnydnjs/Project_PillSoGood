package com.kh.pill.order.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kh.pill.order.model.service.OrderService;
import com.kh.pill.order.model.vo.Cart;
import com.kh.pill.order.model.vo.Order;
import com.kh.pill.order.model.vo.OrderCart;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.request.CancelData;
import com.siot.IamportRestClient.request.OnetimePaymentData;
import com.siot.IamportRestClient.request.ScheduleData;
import com.siot.IamportRestClient.request.ScheduleEntry;
import com.siot.IamportRestClient.request.UnscheduleData;
import com.siot.IamportRestClient.response.AccessToken;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;
import com.siot.IamportRestClient.response.Schedule;

@Controller
public class APIController {
	
	public static final String IMP_KEY = "1727133848405455";
	public static final String IMP_SECRET = "OCjfwc1lxL1LMNxWqq38WJceT8I24xn8k1e6UGT23s9nxtmFtMouX70Sk09YOR2S3OXI578aeko6jxIB";
	
	private IamportClient client = new IamportClient(IMP_KEY, IMP_SECRET);
	
	@Autowired
	private OrderService orderService;
	
	@ResponseBody
	@RequestMapping(value="/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> verifyIamport(@PathVariable(value = "imp_uid")String impUid) throws IamportResponseException, IOException {
	    return client.paymentByImpUid(impUid);
	}
	
	@ResponseBody
	@RequestMapping(value="/users/getToken")
	public IamportResponse<AccessToken> getToken() throws IamportResponseException, IOException {
	    return client.getAuth();
	}
	
	@ResponseBody
	@RequestMapping(value="/subscribe/payments/onetime")
	public IamportResponse<Payment> onetime(OnetimePaymentData onetimeData) throws IamportResponseException, Exception {
		return client.onetimePayment(onetimeData);
	}
	
	@ResponseBody
	@RequestMapping(value="/subscribe/payments/schedule")
	public void subscribeSchedule(String merchant_uid, String response) throws Exception {
		
		JsonObject payment = JsonParser.parseString(response).getAsJsonObject();
		
		Date schedule_at = new Date(payment.get("paidAt").getAsLong() + 300000);
		
		ScheduleEntry entry = new ScheduleEntry(merchant_uid, schedule_at, payment.get("amount").getAsBigDecimal());
		entry.setName(payment.get("name").getAsString());
		entry.setBuyerName(payment.get("buyerName").getAsString());
		entry.setBuyerEmail(payment.get("buyerEmail").getAsString());
		entry.setCustomData(payment.get("customData").getAsString());
		
		ScheduleData scheduleData = new ScheduleData(payment.get("customerUid").getAsString());
		scheduleData.addSchedule(entry);
		
		client.subscribeSchedule(scheduleData);
	}
	
	/*
	@GetMapping(value="/subscribe/customers/{customer_uid}")
	public IamportResponse<BillingCustomer> getCustomerUid(@PathVariable(value = "customer_uid")String customerUid) throws IamportResponseException, IOException {
	    return client.getBillingCustomer(customerUid);
	}
	*/
	
	@GetMapping(value="/payments/{imp_uid}")
	public IamportResponse<Payment> getPayments(@PathVariable(value="imp_uid")String impUid) throws IamportResponseException, IOException {
		return client.paymentByImpUid(impUid);
	}
	
	@ResponseBody
	@RequestMapping(value="/payments/cancel")
	public IamportResponse<Payment> cancel(String merchant_uid) throws IamportResponseException, IOException {
		
		CancelData cancelData = new CancelData(merchant_uid, false);
		
		return client.cancelPaymentByImpUid(cancelData);
	}
	
	@ResponseBody
	@RequestMapping(value="/subscribe/payments/unschedule")
	public IamportResponse<List<Schedule>> unsubscribeSchedule(String customer_uid) throws IamportResponseException, IOException {
		
		UnscheduleData unscheduleData = new UnscheduleData(customer_uid);
		return client.unsubscribeSchedule(unscheduleData);
	}
	
	@RequestMapping(value="/iamport/webhook")
	public void webhook(@RequestBody HashMap<String,Object> webhook) throws Exception {
		
		if(webhook.get("status").toString().equals("paid")) {
			
			String impUid = webhook.get("imp_uid").toString();
			
			Payment p = getPayments(impUid).getResponse();
			
			ObjectMapper mapper = new ObjectMapper();
			String response = mapper.writeValueAsString(p);
			
			JSONObject customData = (JSONObject)(new JSONParser().parse(p.getCustomData()));
			
			int memberNo = Integer.parseInt(String.valueOf(customData.get("memberNo")));
			
			Order o = new Order(p.getMerchantUid(), p.getMerchantUid().substring(0, 14), 
					p.getAmount().intValue(), String.valueOf(customData.get("memberNo")), 1, 
					p.getReceiptUrl(), "Y", "N", "(" + p.getBuyerPostcode() + ") " + p.getBuyerAddr());
			
			// 구독일 경우
			// p.getCustomerUid() 로 select 검사
			// customerUid 가 일치하는 subs_count 컬럼값 조회
			if(p.getCustomerUid() != null) {
				
				o.setCustomerUid(p.getCustomerUid());
				o.setSubsStatus("Y");
				
				int count = orderService.selectCountByCustomerUid(p.getCustomerUid());
			
				if(count != 0) {
					// subs_count 컬럼 +1
					o.setSubsCount(count + 1);
				}
			}
			
			int oresult = orderService.insertOrder(o);
			
			// 첫 결제때만 장바구니에 상품이 들어있을 것
			if(o.getSubsCount() == 1) {
				
				// Cart 현재 갯수와 번호들
				ArrayList<Cart> list = orderService.selectCart(memberNo);
				
				int ocresult = 1;
				
				if(oresult > 0) {
					
					for(int i = 0; i < list.size(); i++) {
						
						// OrderCart 에 insert
						OrderCart oc = new OrderCart(list.get(i).getCartNo(), o.getOrderNo());
						ocresult *= orderService.insertOrderCart(oc);
					}
					
					// CART 테이블에 loginUser 상품들 STATUS = 'N'
					if(ocresult > 0) {
						orderService.deleteCart(memberNo);
					}
				}
			} else {
				
				// 구독 자동 재결제일 경우
				// ORDERS 테이블에서 구독여부가 Y 인 memberNo 의 orderNo 으로 OrderCart 에 있는 cartNo 을 가져옴
				ArrayList<OrderCart> list = orderService.selectCartNoForSubs(memberNo);
				
				if(oresult > 0) {
					
					for(int i = 0; i < list.size(); i++) {
						
						// OrderCart 에 insert
						OrderCart oc = new OrderCart(list.get(i).getCartNo(), o.getOrderNo());
						orderService.insertOrderCart(oc);
					}
				}
			}
			
			if(o.getSubsStatus().equals("Y")) {
				String merchantUid = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + ((int)(Math.random() * 90000) + 10000);
				subscribeSchedule(merchantUid, response);
			}
		}
	}
	
	
	
}
