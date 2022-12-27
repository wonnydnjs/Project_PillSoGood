package com.kh.pill.magazine.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Magazine {

	private int magazineNo; //MAGAZINE_NO	NUMBER
	private String magazineTitle; //MAGAZINE_TITLE	VARCHAR2(100 BYTE)
	private String magazineContent; //MAGAZINE_CONTENT	VARCHAR2(3000 BYTE)
	private int magazineCount; //MAGAZINE_COUNT	NUMBER
	private String magazineImgName; //MAGAZINE_IMG_NAME	VARCHAR2(1000 BYTE)
	private String magazineImgName2; //MAGAZINE_IMG_NAME2	VARCHAR2(1000 BYTE)
	private String categoryNo; //CATEGORY_NO	NUMBER
	private String magazineStatus; //MAGAZINE_STATUS	CHAR(1 BYTE)
	private String magazineHashtag; //MAGAZINE_HASHTAG	VARCHAR2(100 BYTE)

	private int magazineLikeCount; // 좋아요 수 카운트 -> 리스트/디테일뷰에서 보여지는 숫자
	
	private int preNo; //이전글의 글번호를 담을 필드
	private String preTitle; // 이전글 제목
	private String preImgName; // 이전글 썸네일
	private int nextNo; //다음글의 글번호를 담을 필드
	private String nextTitle; // 다음글 제목
	private String nextImgName; // 다음글 썸네일


}
