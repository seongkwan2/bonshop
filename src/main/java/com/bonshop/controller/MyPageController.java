package com.bonshop.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bonshop.service.MemberService;
import com.bonshop.vo.MemberVO;

@Controller
@RequestMapping(value="/myPage/*")
public class MyPageController {

	@Autowired
	private MemberService memberService;

	@Autowired //비밀번호 암호화 의존성 추가
	private PasswordEncoder passwordEncoder;


	//마이페이지 홈
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public ModelAndView home(Principal principal, HttpSession session) {
		System.out.println("myPage/home 메서드 동작 (get)");
		ModelAndView mv = new ModelAndView();

		//Principal을 이용해서 현재 계정 정보를 가져옴
		String loginId = principal.getName();
		MemberVO memberInfo = memberService.findById(loginId);

		// 추출한 MemberVO 객체를 ModelAndView 객체에 추가
		mv.addObject("memberInfo", memberInfo);
		return mv;
	}

	//회원 수정 본인 인증 폼
	@RequestMapping(value="/checkPw", method = RequestMethod.GET)
	public ModelAndView checkPw(HttpSession session, HttpServletRequest request) throws Exception {
		System.out.println("checkPw (GET)메서드 동작");

		ModelAndView model = new ModelAndView();

		return model;
	}

	//회원 수정 본인 인증 폼의 기능 동작
	@RequestMapping(value="/checkPw", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkPw(HttpSession session, HttpServletRequest request, Principal principal) throws Exception {
		Map<String, Object> map = new HashMap<>();
		System.out.println("checkPw (POST)메서드 동작");

		//Principal을 이용해서 현재 계정 정보를 가져옴
		String loginId = principal.getName();
		MemberVO memberInfo = memberService.findById(loginId);

		if(memberInfo == null) {
			map.put("status", "error");
			map.put("message", "로그인 이후 이용 가능합니다!");
			return map;
		}

		String mPwd = request.getParameter("mPwd");
		System.out.println("암호화 전: "+mPwd);

		if(mPwd != null) {//사용자에게 값을 입력 받은 뒤
			String encodedPwd = passwordEncoder.encode(mPwd);
			System.out.println("암호화 후: "+encodedPwd);
			if(passwordEncoder.matches(mPwd, memberInfo.getM_pwd())) {//matches메서드로 원래의 비밀번호와 암호화된 비밀번호를 비교해줌
				System.out.println("인증 완료");
				map.put("authSuccess", true);
			} else {
				System.out.println("인증 실패");
				map.put("authSuccess", false);
			}
			return map;
		}//if
		return map;
	}//home()

	//수정 폼
	@RequestMapping(value="/fixInfo", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView fixInfo(Principal principal) {
		System.out.println("fixInfo(get) 메서드 동작");
		ModelAndView mv = new ModelAndView();

		//Principal을 이용해서 현재 계정 정보를 가져옴
		String loginId = principal.getName();
		MemberVO memberInfo = memberService.findById(loginId);

		// 추출한 MemberVO 객체를 ModelAndView 객체에 추가
		mv.addObject("memberInfo", memberInfo);

		return mv;
	}

	//수정 폼의 기능
	@RequestMapping(value="/fixInfo", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> fixInfo(@RequestBody MemberVO memberInfo, Principal principal) {
		Map<String, Object> map = new HashMap<>();

		//ID값은 직접 지정함
		String loginId = principal.getName();
		memberInfo.setM_id(loginId);
		this.memberService.updateMember(memberInfo); //클라이언트에게 입력받은 정보로 업데이트
		

		map.put("memberInfo", memberInfo);
		map.put("status", "success");

		return map;
	}
	
	//비밀번호 변경
	@RequestMapping(value="/pwChange")
	public void pwChange() {}

	//회원탈퇴 메서드
	@RequestMapping(value="/deleteMember", method = RequestMethod.POST)
	public ModelAndView deleteMember(Principal principal) {
		System.out.println("deleteMember(POST)메서드 동작");
		ModelAndView mv = new ModelAndView();
		String loginId = principal.getName();
		this.memberService.deleteById(loginId);

		mv.setViewName("redirect:/myPage/delMember"); // 로그아웃 처리 후 메인 페이지로 리다이렉트
		return mv;
	}//delete_id()
	
	//회원탈퇴완료 페이지
	@RequestMapping(value="/delMember")
	public void delMember() {}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

















