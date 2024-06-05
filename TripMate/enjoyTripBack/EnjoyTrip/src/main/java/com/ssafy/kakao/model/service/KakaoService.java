package com.ssafy.kakao.model.service;

import com.ssafy.kakao.model.LoginResponse;

public interface KakaoService {

	LoginResponse kakaoLogin(String code, String currentDomain);

}
