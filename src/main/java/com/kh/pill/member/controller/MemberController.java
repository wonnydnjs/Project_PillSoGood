package com.kh.pill.member.controller;

import java.text.ParseException;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.pill.member.model.service.MemberService;
import com.kh.pill.member.model.vo.Member;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("loginForm.me")
	public String loginMemberForm() {
		
		return "member/loginForm";
	}
	
	@RequestMapping("changePwdForm.me")
	public String changePwd() {
		
		return "member/myPage_ChangePwd";
	}
	
	@RequestMapping("deleteForm.me")
	public String deleteForm() {
		
		return "member/myPage_DeleteForm";
	}
	
	
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m, ModelAndView mv, HttpSession session, HttpServletResponse response) {
		
		Member loginUser = memberService.loginMember(m);
		
		if(loginUser != null &&
			bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {
			
			session.setAttribute("loginUser", loginUser);
			
			session.setAttribute("alertMsg", "로그인에 성공했습니다.");
			
			mv.setViewName("redirect:/");
		}
		else {
			
			// 로그인 실패
			session.setAttribute("alertMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
			
			mv.setViewName("redirect:loginForm.me");
		}
		
		return mv;
	}
	

	
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		// 세션을 무효화하는 메소드 : session.invalidate();
		session.invalidate();
		
		// 메인페이지로 url 요청
		return "redirect:/";
	}
	
	
	@RequestMapping("enrollForm.me")
	public String enrollForm() {
		
		// 회원가입 페이지를 포워딩
		// 포워딩 하고자하는 경로 : /WEB-INF/views/member/memberEnrollForm.jsp
		// 접두어와 접미어를 제외한 경로 : member/memberEnrollForm
		return "member/memberEnrollForm";
	}
	
	@RequestMapping("insert.me")
	public String insertMember(Member m, Model model, HttpSession session) {

		String encPwd = bcryptPasswordEncoder.encode(m.getMemberPwd());
	
		m.setMemberPwd(encPwd);
		
		int result = memberService.insertMember(m);
		
		if(result > 0) { // 성공
			
			// 일회성 알람 문구
			session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다.");

			return "member/memberEnrollFormCongrats";
		}
		else { 
			
			model.addAttribute("errorMsg", "회원가입 실패");
			
			return "common/errorPage";
		}
	}
	
	@RequestMapping("myPage.me")
	public String myPage() {
		
		return "member/myPage.me";
	}
	
	@RequestMapping("update.me")
	public String updateMember(Member m, Model model, HttpSession session) throws ParseException {
		
		int result = memberService.updateMember(m);
		
		if(result > 0) { // 성공
			
			Member updateMem = memberService.loginMember(m);
			session.setAttribute("loginUser", updateMem);
			
			// session 에 일회성 알람 문구도 담기
			session.setAttribute("alertMsg", "성공적으로 회원정보가 변경되었습니다.");
			
			// 마이페이지 url 재요청
			return "redirect:/myPage.info";
		}
		else { // 실패 
			
			model.addAttribute("errorMsg", "회원정보 변경에 실패했습니다.");
			
			return "common/errorPage";
		}
	}
	

	@RequestMapping("delete.me")
	public String deleteMember(String memberPwd, String memberId, HttpSession session, Model model) {
		
		String encPwd = ((Member)session.getAttribute("loginUser")).getMemberPwd();
		
		// 비밀번호 대조작업
		if(bcryptPasswordEncoder.matches(memberPwd, encPwd)) {
			
			// 비밀번호가 맞을 경우 => 탈퇴처리
			int result = memberService.deleteMember(memberId);
			
			if(result > 0) { // 탈퇴처리 성공
				
				session.removeAttribute("loginUser"); // 로그인한 회원의 정보만 지움
				session.setAttribute("alertMsg", "성공적으로 탈퇴되었습니다. 그동안 이용해주셔서 감사합니다.");
				
				return "redirect:/";
				
			} else { 
				
				model.addAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
				
				return "common/errorPage";
			}
		}
		else {
			
			session.setAttribute("alertMsg", "비밀번호를 잘못 입력하였습니다. 확인해주세요.");
			
			return "redirect:/myPage.info";
		}
		
	}
	
	@RequestMapping("changePwd.me")
	public String changePwdMember(String memberPwd, String changePwd, HttpSession session, Model model) {
		
		String encPwd = ((Member)session.getAttribute("loginUser")).getMemberPwd();
		
		// 비밀번호 대조작업
		if(bcryptPasswordEncoder.matches(memberPwd, encPwd)) {
			// 비밀번호가 맞을 경우
			
			// changePwd 암호화
			String changeEnc = bcryptPasswordEncoder.encode(changePwd);
			
			// 수정할 멤버의 회원아이디랑 암호화된 비밀번호를 담은 member 객체 생성
			Member m = new Member();
			
			// 회원 아이디랑 새 비밀번호
			m.setMemberPwd(changeEnc);
			m.setMemberId(((Member)session.getAttribute("loginUser")).getMemberId());
			
			int result = memberService.changePwdMember(m);
			
			if(result > 0) { // 비밀번호 변경 성공
				// memberId 를 넘겨주면서 회원정보 다 가져오기
				Member loginUser = memberService.loginMember(m);
				
				// session 에 loginUser 덮어쓰기
				session.setAttribute("loginUser", loginUser);
				session.setAttribute("alertMsg", "성공적으로 비밀번호가 변경되었습니다.");
				
				return "redirect:/myPage.info";
				
			} else { 
				
				model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다.");
				
				return "common/errorPage";
			}
		}
		else {
			
			session.setAttribute("alertMsg", "비밀번호를 잘못 입력하였습니다. 확인해주세요.");
			
			return "redirect:/changePwdForm.me";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="idCheck.me", produces="text/html; charset=UTF-8")
	public String idCheck(String checkId) {
				
		int count = memberService.idCheck(checkId);

		return (count > 0) ? "NNNNN" : "NNNNY";
	}

	@RequestMapping("idFindForm.me")
	public String idFindForm() {
		
		return "member/idFindForm";
	}


	@RequestMapping(value="idFind.me")
	public String idFind(String memberName, String email, HttpSession session, Model model) {
		
		//System.out.println(memberName);
		//System.out.println(email);
		HashMap <String, String> map = new HashMap<>();
		map.put("memberName", memberName);
		map.put("email", email);
		
		
		//System.out.println(map);
		String findId = memberService.findId(map);
		//System.out.println(findId);
			
		if (findId == null) {
			
			session.setAttribute("alertMsg", "입력하신 정보의 해당 아이디가 없습니다. 다시 입력해주세용.");
			
			return "member/idFindForm";
			
		} else {
			
			model.addAttribute("findId", findId);
			
			return "member/idFindFormCongrats";
			
		}

	}

}



