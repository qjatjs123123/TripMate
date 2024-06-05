package com.ssafy.openai.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.ssafy.openai.model.ChatGPTRequest;
import com.ssafy.openai.model.ChatGPTResponse;


@RestController
@RequestMapping("/bot")
public class CustomBotController {
	@Value("${openai.model}")
	private String model;
    @Value("${openai.api.url}")
    private String apiURL;
    @Autowired
    private RestTemplate template;
    
    @PostMapping("/chat")
    public String chat(@RequestBody Map<String, String> request) {
    	String prompt = request.get("prompt");
    	System.out.println("prompt : " + prompt);
    	ChatGPTRequest chatGPTRequest = new ChatGPTRequest(model, prompt);
    	ChatGPTResponse chatGPTResponse = template.postForObject(apiURL, chatGPTRequest, ChatGPTResponse.class);
    	return chatGPTResponse.getChoices().get(0).getMessage().getContent();
    }
}

