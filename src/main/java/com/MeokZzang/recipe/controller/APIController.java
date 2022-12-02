package com.MeokZzang.recipe.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class APIController {
	
	@RequestMapping("/usr/data/apiTest")
	String showTestPage() {
		return "usr/data/API";
	}
	
}
