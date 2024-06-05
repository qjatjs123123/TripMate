package com.ssafy.cart.model.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.cart.model.CartDto;

@Mapper
public interface CartMapper {
	List<CartDto> getList(String userId) throws SQLException;
	void insertCartItem (String userId, int content_id)  throws SQLException;
	void deleteCartItem (String userId, int content_id)  throws SQLException;
}

