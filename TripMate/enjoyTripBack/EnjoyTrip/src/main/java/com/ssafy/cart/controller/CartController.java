package com.ssafy.cart.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.cart.model.CartDto;
import com.ssafy.cart.model.service.CartService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/cart")
@CrossOrigin("*")
public class CartController {
	private static final long serialVersionUID = 1L;
	
	private CartService cartService;
	
	public CartController(CartService cartService) {
		this.cartService = cartService;
	}
	
	@Operation(summary = "장바구니", description = "회원 별 장바구니 여행지 목록을 가져온다")
	@GetMapping("/{userId}")
	public ResponseEntity<Map<String, Object>> getInfo(
			@PathVariable("userId") @Parameter(description = "인증할 회원의 아이디.", required = true) String userId,
			HttpServletRequest request) {
//		logger.debug("userId : {} ", userId);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		try {
//			로그인 사용자 정보.
			List<CartDto> list = this.cartService.getList(userId);
			resultMap.put("cartList", list);
			status = HttpStatus.OK;
		} catch (Exception e) {
//			log.error("정보조회 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		} 
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@Operation(summary = "장바구니", description = "회원 별 장바구니 여행지 목록을 가져온다")
	@PostMapping("/")
	public ResponseEntity<Map<String, Object>> cartInsert(
			@RequestBody Map<String, String> map,
			HttpServletRequest request) {
		System.out.println(map);
		String userId = map.get("userId");
		int content_id = Integer.valueOf( map.get("content_id"));
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		try {
//			로그인 사용자 정보.
			this.cartService.insertCartItem(userId, content_id);
			List<CartDto> list = this.cartService.getList(userId);
			resultMap.put("cartList", list);
			status = HttpStatus.OK;
		} catch (Exception e) {
//			log.error("정보조회 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		} 
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@Operation(summary = "장바구니", description = "회원 별 장바구니 여행지 목록을 가져온다")
	@DeleteMapping("/")
	public ResponseEntity<Map<String, Object>> cartDelete(
			@RequestBody Map<String, String> map,
			HttpServletRequest request) {
		System.out.println(map);
		String userId = map.get("userId");
		int content_id = Integer.valueOf( map.get("content_id"));
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		try {
//			로그인 사용자 정보.
			this.cartService.deleteCartItem(userId, content_id);
			List<CartDto> list = this.cartService.getList(userId);
			resultMap.put("cartList", list);
			status = HttpStatus.OK;
		} catch (Exception e) {
//			log.error("정보조회 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		} 
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}

}
