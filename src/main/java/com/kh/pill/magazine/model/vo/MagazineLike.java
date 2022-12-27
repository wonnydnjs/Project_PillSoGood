package com.kh.pill.magazine.model.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class MagazineLike {

	private int magazineLikeNo; //MAGAZINE_LIKE_NO	NUMBER pk값
	private int memberNo; //MEMBER_NO	NUMBER 회원번호
	private int magazineNo; //MAGAZINE_NO	NUMBER 게시글 번호
	private int magazineLike; //LIKE_NUM	NUMBER	Yes 좋아요

	public MagazineLike(int magazineNo, int memberNo) {
		this.magazineNo = magazineNo;
		this.memberNo = memberNo;
	}
}