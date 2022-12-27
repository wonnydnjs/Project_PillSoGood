package com.kh.pill.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor // 기본생성자
@AllArgsConstructor // 모든 필드를 매개변수로 갖는 생성자
@Setter // setter 메소드들
@Getter // getter 메소드들
@ToString // toString 메소드
public class Member {

	private int memberNo; //MEMBER_NO	NUMBER
	private String memberId; //MEMBER_ID	VARCHAR2(20 BYTE)
	private String memberPwd; //MEMBER_PWD	VARCHAR2(20 BYTE)
	private String memberName; //MEMBER_NAME	VARCHAR2(18 BYTE)
	private String email; //EMAIL	VARCHAR2(40 BYTE)
	private String phone; //PHONE	VARCHAR2(11 BYTE)
	private String addressZip; //ADDRESS_ZIP	VARCHAR2(10 BYTE)
	private String address1; //ADDRESS_1	VARCHAR2(300 BYTE)
	private String address2; //ADDRESS_2	VARCHAR2(200 BYTE)
	private String gender; //GENDER	CHAR(1 BYTE)
	private Date memberBirthYear; //MEMBER_BIRTH_YEAR	DATE
	private int height; //HEIGHT	NUMBER
	private int weight; //WEIGHT	NUMBER
	private Date memberEnrollDate; //MEMBER_ENROLL_DATE	DATE
	private String memberStatus; //MEMBER_STATUS	CHAR(1 BYTE)

	
}
