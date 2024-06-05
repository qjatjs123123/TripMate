package com.ssafy.kakao.model;

import com.ssafy.auth.model.AuthTokens;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class LoginResponse {
    private Long id;
    private String nickname;
    private String email;
    private AuthTokens token;

    public LoginResponse(Long id, String nickname, String email, AuthTokens token) {
        this.id = id;
        this.nickname = nickname;
        this.email = email;
        this.token = token;
    }
    
    public LoginResponse(Long id, String nickname, String email) {
        this.id = id;
        this.nickname = nickname;
        this.email = email;
    }
}