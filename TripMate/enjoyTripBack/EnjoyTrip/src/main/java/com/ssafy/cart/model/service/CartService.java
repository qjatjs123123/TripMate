package com.ssafy.cart.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.cart.model.CartDto;

public interface CartService {
	List<CartDto> getList(String userId) throws SQLException;
	
	void insertCartItem (String userId, int content_id)  throws SQLException;
	void deleteCartItem (String userId, int content_id)  throws SQLException;

}
