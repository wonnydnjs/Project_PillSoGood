package com.kh.pill.magazine.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class MagazinePage {

	private int MagazineNo; // 현재글번호
	private int preNo; //이전글의 글번호를 담을 필드
	private String preTitle; // 이전글 제목
	private String preImgName; // 이전글 썸네일
	private int nextNo; //다음글의 글번호를 담을 필드
	private String nextTitle; // 다음글 제목
	private String nextImgName; // 다음글 썸네일
		

}
