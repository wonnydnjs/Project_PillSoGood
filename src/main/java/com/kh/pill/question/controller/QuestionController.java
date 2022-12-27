package com.kh.pill.question.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pill.common.model.vo.PageInfo;
import com.kh.pill.common.template.Pagination;
import com.kh.pill.member.model.vo.Member;
import com.kh.pill.question.model.service.QuestionService;
import com.kh.pill.question.model.vo.Question;

@Controller
public class QuestionController {
	
	@Autowired
	private QuestionService questionService;
	
	// 사용자
	
	@RequestMapping("list.qu")
	public String selectQuestionList(@RequestParam(value="cpage", defaultValue="1")int currentPage, HttpSession session, Model model) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		if(loginUser != null) {
			
			int memberNo = loginUser.getMemberNo();
			int listCount = questionService.selectListCount(memberNo);
			
			int pageLimit = 5;
			int boardLimit = 10;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			ArrayList<Question> list = questionService.selectQuestionList(memberNo, pi);
			
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
		}
			
		return "question/questionListView";
	}
	
	@RequestMapping("detail.qu")
	public String selectQuestion(int qno, Model model) {
		
		Question q = questionService.selectQuestion(qno);
		
		model.addAttribute("q", q);
		
		return "question/questionDetailView";
	}
	
	@RequestMapping("enrollForm.qu")
	public String enrollForm() {
		
		return "question/questionEnrollForm";
	}
	
	@RequestMapping("insert.qu")
	public ModelAndView insertQuestion(Question q, MultipartFile upfile, HttpSession session, ModelAndView mv) {
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			String questionImage = saveFile(upfile, session);
			
			q.setQuestionImage("resources/questionUploadFiles/" + questionImage);
		}
		
		int result = questionService.insertQuestion(q);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "1:1 문의가 등록되었습니다");
			mv.setViewName("redirect:/list.qu");
			
		} else {
			
			mv.addObject("errorMsg", "1:1 문의 작성 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	@RequestMapping("updateForm.qu")
	public String updateForm(int qno, Model model) {
		
		Question q = questionService.selectQuestion(qno);
		model.addAttribute("q", q);
		
		return "question/questionUpdateForm";
	}
	
	@RequestMapping("update.qu")
	public ModelAndView updateQuestion(Question q, MultipartFile reupfile, String imageCheck, HttpSession session, ModelAndView mv) {
		
		
		if(!reupfile.getOriginalFilename().equals("")) {
			
			if(q.getQuestionImage() != null && !q.getQuestionImage().equals("")) {
				new File(session.getServletContext().getRealPath(q.getQuestionImage())).delete();
			}
			
			String questionImage = saveFile(reupfile, session);
			
			q.setQuestionImage("resources/questionUploadFiles/" + questionImage);
		}
		
		if(imageCheck != null && imageCheck.equals("check")) {
			
			new File(session.getServletContext().getRealPath(q.getQuestionImage())).delete();
			q.setQuestionImage("");
		}
		
		int result = questionService.updateQuestion(q);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "1:1 문의가 수정되었습니다");
			mv.setViewName("redirect:/detail.qu?qno=" + q.getQuestionNo());
			
		} else {
			
			mv.addObject("errorMsg", "1:1 문의 수정 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	@RequestMapping("delete.qu")
	public ModelAndView deleteQuestion(int qno, String filePath, HttpSession session, ModelAndView mv) {
		
		int result = questionService.deleteQuestion(qno);
		
		if(result > 0) {
			
			if(!filePath.equals("")) {
				new File(session.getServletContext().getRealPath(filePath)).delete();
			}
			
			session.setAttribute("alertMsg", "1:1 문의가 삭제되었습니다.");
			mv.setViewName("redirect:/list.qu");
		} else {
			
			mv.addObject("errorMsg", "1:1 문의 삭제 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	// --------------------------------------------------------------------------
	
	// 관리자
	@RequestMapping("qlist.ad")
	public String selectQuestionAllList(@RequestParam(value="cpage", defaultValue="1")int currentPage, HttpSession session, Model model) {
		
		int listCount = questionService.selectAllListCount();
		
		int pageLimit = 5;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Question> list = questionService.selectQuestionAllList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "question/adminQuestionListView";
	}
	
	@ResponseBody
	@RequestMapping(value="aninsert.ad", produces="text/html; charset=UTF-8")
	public String insertAnswer(Question q) {
		
		int result = questionService.insertAnswer(q);
		
		return (result > 0) ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="anupdate.ad", produces="text/html; charset=UTF-8")
	public String updateAnswer(Question q) {
		
		int result = questionService.updateAnswer(q);
		
		return (result > 0) ? "success" : "fail";
	}
	
	@ResponseBody
	@RequestMapping(value="andelete.ad", produces="text/html; charset=UTF-8")
	public String deleteAnswer(int qno) {
		
		int result = questionService.deleteAnswer(qno);
		
		return (result > 0) ? "success" : "fail";
	}
	
	// --------------------------------------------------------------------------
	
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		int random = (int)(Math.random() * 90000) + 10000;
		
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + random + ext;
		
		String savePath = session.getServletContext().getRealPath("/resources/questionUploadFiles/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return changeName;
	}
}
