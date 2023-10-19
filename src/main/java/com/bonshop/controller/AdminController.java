package com.bonshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	@RequestMapping(value="/")
	public ModelAndView home() {
		ModelAndView model = new ModelAndView();
		
		model.setViewName("/admin/home");
		return model;
	}
	
}
