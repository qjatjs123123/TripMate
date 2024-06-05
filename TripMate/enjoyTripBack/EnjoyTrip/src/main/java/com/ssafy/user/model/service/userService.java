package com.ssafy.user.model.service;

import com.ssafy.user.model.userDto;

public interface userService {
	
	int register(userDto userDto) throws Exception; // 회원가입
	int userUpdate(userDto userDto) throws Exception;
	int withdraw(String userId) throws Exception;
	userDto login(userDto userDto) throws Exception;
	void saveRefreshToken(String userId, String refreshToken) throws Exception;
	Object getRefreshToken(String userId) throws Exception;
	void deleRefreshToken(String userId) throws Exception;
	userDto userInfo(String userId) throws Exception;
}
