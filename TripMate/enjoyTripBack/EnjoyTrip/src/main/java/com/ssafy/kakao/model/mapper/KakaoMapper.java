package com.ssafy.kakao.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.ssafy.kakao.model.LoginResponse;

@Mapper
public interface KakaoMapper {

	public LoginResponse findByEmail(String kakaoEmail);
	public void save(LoginResponse kakaoUser);

}
