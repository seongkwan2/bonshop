package com.bonshop.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

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
		String loginId = principal.getName();

		System.out.println("loginId의 내용 :" +loginId);
		MemberVO memberInfo = memberService.findById(loginId);
		
		// 추출한 MemberVO 객체를 ModelAndView 객체에 추가
	    mv.addObject("memberInfo", memberInfo);
		return mv;
	}

	//마이페이지 회원정보 수정
		@RequestMapping(value="/home", method=RequestMethod.POST)
		@ResponseBody //JSON타입으로 다시 ajax에 접근하기 위한 방법
		public Map<String, Object> home(@RequestBody MemberVO m, HttpSession session) {
		    Map<String, Object> map = new HashMap<>();
		    System.out.println("myPage/home 메서드 동작 (post)");

		    try {
		    	String id=(String)session.getAttribute("id");
		    	m.setM_id(id);	//아이디를 이용해서 해당 회원 정보들을 수정
		        this.memberService.updateMember(m); //DB에 저장

		        map.put("status", "success");
		        map.put("message", "수정 성공");
		        
		    } catch (Exception e) {
		    	e.printStackTrace();
		    	map.put("status", "error");
		    	map.put("message", "수정 실패: " + e.getMessage());
		    }
			return map;
		}
	
	//우편주소 검색 공지창 (이거 쓰지말고 member/zip_find 를 사용할수 있게 수정 해야함)
		@RequestMapping("/zip_find")
		public ModelAndView zip_find() {
			ModelAndView zm=new ModelAndView();
			zm.setViewName("member/zip_find");
			return zm;
		}//zip_find()
		

	
	//회원 정보 수정
	@RequestMapping(value="/infoEdit")
	public void infoEdit() {}
}
