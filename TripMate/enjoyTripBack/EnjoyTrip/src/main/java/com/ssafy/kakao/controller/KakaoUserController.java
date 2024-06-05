package com.ssafy.kakao.controller;

import java.util.NoSuchElementException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.ssafy.kakao.model.LoginResponse;
import com.ssafy.kakao.model.service.KakaoService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/kakao")
public class KakaoUserController {

    private final KakaoService kakaoService;

	//web 버전
    @ResponseBody
    @GetMapping("/login/oauth/kakao")
//    @PostMapping("/login/oauth/kakao")
    public ResponseEntity<LoginResponse> kakaoLogin(@RequestParam String code, HttpServletRequest request){
        try{
			// 현재 도메인 확인
			String currentDomain = request.getServerName();
            return ResponseEntity.ok(kakaoService.kakaoLogin(code, currentDomain));
        } catch (NoSuchElementException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,"Item Not Found");
        }
    }
}
