package com.bonshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

	@GetMapping("/login") //사용자 로그인 페이지
	public void login() {
		
	}
	
	@RequestMapping("/accessDenied") //403 접근금지 에러가 났을때
	public void accessDenied() {
		
	}
	
	@GetMapping("/logout") //로그아웃 페이지
	public void logout() {
        
	}
}
