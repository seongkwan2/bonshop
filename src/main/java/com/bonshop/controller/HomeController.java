package com.bonshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	//메인 페이지
	@RequestMapping(value="/")
	public ModelAndView home() {
		ModelAndView model = new ModelAndView();

		model.setViewName("/main/home");
		return model;
	}

}
