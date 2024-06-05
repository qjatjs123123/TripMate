package com.ssafy.user.model.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ssafy.user.model.userDto;
import com.ssafy.user.model.mapper.UserMapper;

@Service
public class userServiceImpl implements userService {
    
	private UserMapper userMapper;
	
	public userServiceImpl(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	
	@Override
	public userDto login(userDto userDto) throws Exception{
		// TODO Auto-generated method stub
		return userMapper.login(userDto);
	}
	
	@Override
	public int register(userDto userDto) throws Exception {
		userMapper.register(userDto);
		return 0;
	}

	@Override
	public int withdraw(String userId) throws Exception{
		userMapper.withdraw(userId);
		return 0;
	}


	@Override
	public void saveRefreshToken(String userId, String refreshToken) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("token", refreshToken);
		userMapper.saveRefreshToken(map);
	}

	@Override
	public Object getRefreshToken(String userId) throws Exception {
		return userMapper.getRefreshToken(userId);
	}

	@Override
	public void deleRefreshToken(String userId) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("token", null);
		userMapper.deleteRefreshToken(map);
	}


	@Override
	public userDto userInfo(String userId) throws Exception {
		return userMapper.userInfo(userId);
	}


	@Override
	public int userUpdate(userDto userDto) throws Exception{
		return userMapper.userUpdate(userDto);
	}


}