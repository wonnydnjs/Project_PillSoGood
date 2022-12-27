package com.kh.pill.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.notice.model.service.NoticeService;
import com.kh.pill.notice.model.vo.Notice;
import com.kh.pill.notice.model.vo.NoticeDetail;

@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("list.no")
	public String selectList(@RequestParam(value="cpage", defaultValue="1")int currentPage, Model model) {
		
		int listCount= noticeService.selectListCount();
		
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Notice> list = noticeService.selectList(pi);
		
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "notice/noticeListView";
		
	}
	
	@RequestMapping("enrollForm.no")
	public String enrollForm() {
		
		return "notice/noticeEnrollForm";
		
	}
	
	@RequestMapping("insert.no")
	public String insertNotice(Notice n, HttpSession session) {
		
		int result = noticeService.insertNotice(n);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "게시글 등록에 성공했습니다.");
			return "redirect:/list.no";
			
		} else {
			
			return null;
		}
		
		
	}
	
	@RequestMapping("detail.no")
	public String selectNotice(int nno, Model m) {
		
		int result = noticeService.increaseCount(nno);
		
		if(result > 0) {
			
			NoticeDetail n = noticeService.selectNotice(nno);
			
			m.addAttribute("n" , n);
			
			
			
			return "notice/noticeDetailView";
			
		} else {
			
			return null;
		}
		
	}
	
	@RequestMapping("updateForm.no")
	public String updateNoticeForm(String nno, Model m) {
		
		int noticeNo = Integer.parseInt(nno);
		
		Notice newNotice = noticeService.selectUpdateNotice(noticeNo);
		
		m.addAttribute("n", newNotice);
		return "notice/noticeUpdateForm";
	}
	
	
	@RequestMapping("update.no")
	public String updateNotice(Notice n, HttpSession session) {
		
		int result = noticeService.updateNotice(n);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			return "redirect:/detail.no?nno=" + n.getNoticeNo();
			
		}else {
			return null;
		}
	}
	
	@RequestMapping("delete.no")
	public String deleteNotice(String nno, HttpSession session) {
		
		int noticeNo = Integer.parseInt(nno);
		
		int result = noticeService.deleteNotice(noticeNo);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			return "redirect:/list.no";
			
		} else {
			
			return null;
		}
		
	}

}
