package com.ssafy.auth;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.ssafy.auth.model.AuthTokens;
import com.ssafy.jwt.JwtTokenProvider;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class AuthTokensGenerator {
    private static final String BEARER_TYPE = "Bearer";
    private static final long ACCESS_TOKEN_EXPIRE_TIME = 1000 * 60 * 60; 	//1시간
    private static final long REFRESH_TOKEN_EXPIRE_TIME = 1000 * 60 * 60 * 24 * 14;  // 14일
    
    private final JwtTokenProvider jwtTokenProvider;

    //id 받아 Access Token 생성
    public AuthTokens generate(String uid) {
        long now = (new Date()).getTime();
        Date accessTokenExpiredAt = new Date(now + ACCESS_TOKEN_EXPIRE_TIME);
        Date refreshTokenExpiredAt = new Date(now + REFRESH_TOKEN_EXPIRE_TIME);

        //String subject = email.toString();
        String accessToken = jwtTokenProvider.accessTokenGenerate(uid, accessTokenExpiredAt);
        String refreshToken = jwtTokenProvider.refreshTokenGenerate(refreshTokenExpiredAt);

        return AuthTokens.of(accessToken, refreshToken, BEARER_TYPE, ACCESS_TOKEN_EXPIRE_TIME / 1000L);
    }
}