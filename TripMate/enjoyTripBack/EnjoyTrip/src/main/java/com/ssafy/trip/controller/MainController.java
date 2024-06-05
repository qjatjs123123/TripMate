package com.ssafy.trip.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
	
	@GetMapping("/")
	public String index() {
		log.debug("main controller index call!!!");
		return "index";
	}
	
}
