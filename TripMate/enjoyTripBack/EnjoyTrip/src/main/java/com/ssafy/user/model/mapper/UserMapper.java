package com.ssafy.user.model.mapper;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.user.model.userDto;

@Mapper
public interface UserMapper {
	void register(userDto userdto) throws Exception; // 회원가입
	
	int userUpdate(userDto userDto);
	void withdraw(String userId);
	userDto login(userDto userDto);
	void saveRefreshToken(Map<String, String> map) throws SQLException;
	Object getRefreshToken(String userid) throws SQLException;
	void deleteRefreshToken(Map<String, String> map) throws SQLException;
	userDto userInfo(String userId) throws SQLException;
}
