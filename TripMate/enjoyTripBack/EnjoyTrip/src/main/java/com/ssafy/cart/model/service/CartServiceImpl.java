package com.ssafy.cart.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.cart.model.CartDto;
import com.ssafy.cart.model.mapper.CartMapper;

@Service
public class CartServiceImpl implements CartService{
	
	private CartMapper cartMapper;
	
	private CartServiceImpl(CartMapper cartMapper) {
		this.cartMapper = cartMapper;
	}

	
	@Override
	public List<CartDto> getList(String userId) throws SQLException {
		// TODO Auto-generated method stub
		return this.cartMapper.getList(userId);
	}


	@Override
	public void insertCartItem(String userId, int content_id) throws SQLException {
		this.cartMapper.insertCartItem(userId, content_id);
		
	}


	@Override
	public void deleteCartItem(String userId, int content_id) throws SQLException {
		this.cartMapper.deleteCartItem(userId, content_id);
		
	}

}
