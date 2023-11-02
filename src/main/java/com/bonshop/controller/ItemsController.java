package com.bonshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/items/*")
public class ItemsController {

	//
	@RequestMapping(value="/outer")
	public void outer() {
	}
	
	//상의 (타임리프 테스트)
	@RequestMapping(value="/top")
	public void top() {
	}
	
	//하의
	@RequestMapping(value="/pants")
	public void pants() {
	}
	
	//액세서리
	@RequestMapping(value="/acc")
	public void acc() {
	}
	
	//가방,신발
	@RequestMapping(value="/bag_shoes")
	public void bag_shoes() {
	}
	
	//랭킹
	@RequestMapping(value="/ranking")
	public void ranking() {
	}
	
}
