package com.bonshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/member/*")
public class LoginController {

	@GetMapping("/login") //사용자 로그인 페이지
	public void login() {
	}
	
	@GetMapping("/logout") //로그아웃 페이지
	public void logout() {
	}
}
