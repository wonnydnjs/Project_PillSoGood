package com.kh.pill.order.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Order {
	
	private String orderNo;
	private String orderDate;
	private int orderPrice;
	private String memberNo;
	private int subsCount;
	private String customerUid;
	private String orderReceipt;
	private String orderStatus;
	private String subsStatus;
	private int delivery;
	private String address;
	
	private String productNames;
	
	public Order(String orderNo, String orderDate, int orderPrice, String memberNo, int subsCount,
			String orderReceipt, String orderStatus, String subsStatus, String address) {
		super();
		this.orderNo = orderNo;
		this.orderDate = orderDate;
		this.orderPrice = orderPrice;
		this.memberNo = memberNo;
		this.subsCount = subsCount;
		this.orderReceipt = orderReceipt;
		this.orderStatus = orderStatus;
		this.subsStatus = subsStatus;
		this.address = address;
	}
	
}