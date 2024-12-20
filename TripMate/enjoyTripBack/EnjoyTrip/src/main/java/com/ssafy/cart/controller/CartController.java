package com.ssafy.cart.controller;

import java.util.ArrayList;
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
	
	
	@Operation(summary = "장바구니", description = "장바구니 최단거리를 가져온다")
	@PostMapping("/short")
	public ResponseEntity<Map<String, Object>> getShort(
			@RequestBody ArrayList<Map<String, Object>> cartList,
			HttpServletRequest request) {
		System.out.println(cartList);
		
		int N = cartList.size();
		if (N == 0) return null ;
		int MASK = (1 << N) - 1;
		double dp[][] = new double[N][MASK + 1];
		double graph[][] = getDistance(cartList, N);
		int path[][] = new int[N][MASK + 1]; 
		
		for (int row = 0; row < N; row++) {
			for (int col = 0; col < MASK + 1; col++) {
				dp[row][col] = Double.MAX_VALUE;
			}
		}
		
		double sum = recursion(0,0, dp, graph, MASK, path);
		ArrayList<Map<String, Object>> newList = reconstructPath(MASK, path, cartList);
		Map<String, Object> response = new HashMap<>();
		response.put("shortPath", newList);
		
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	public double[][] getDistance(ArrayList<Map<String, Object>> cartList, int N) {
        double[][] graph = new double[N][N];

        for (int start = 0; start < N; start++) {
            double startMapY = (double) cartList.get(start).get("mapy");
            double startMapX = (double) cartList.get(start).get("mapx");
            for (int end = 0; end < N; end++) {
                if (start == end) continue;
                double endMapY = (double) cartList.get(end).get("mapy");
                double endMapX = (double) cartList.get(end).get("mapx");

                // Compute Euclidean distance
                double distance = Math.sqrt(Math.pow(startMapY - endMapY, 2) + Math.pow(startMapX - endMapX, 2));
                graph[start][end] = distance;
            }
        }

        return graph;
    }
	
	private double recursion(int cur_node, int bitmask, double[][] dp, double[][] graph, int MASK, int[][] path) {
		if (dp[cur_node][bitmask] != Double.MAX_VALUE) {
			return dp[cur_node][bitmask];
		}
		double MAX_NUM = 100_000_000;
		if (bitmask == MASK - 1) {
			if (graph[cur_node][0] == 0) return MAX_NUM;
			return graph[cur_node][0];
		}
		
		for (int new_node = 1; new_node < graph.length; new_node++) {	
			if (graph[cur_node][new_node] == 0) continue;
			if ( (bitmask & (1 << new_node)) > 0 ) continue;
			int new_bit = (bitmask | (1 << new_node));
			double cost = recursion(new_node, new_bit, dp, graph, MASK, path) + graph[cur_node][new_node];
			
			if (MAX_NUM > cost) {
				MAX_NUM = cost;
				path[cur_node][bitmask] = new_node;
			}
			MAX_NUM = Math.min(MAX_NUM, recursion(new_node, new_bit, dp, graph, MASK, path) + graph[cur_node][new_node]);
		}
		
		dp[cur_node][bitmask] = MAX_NUM;
		return MAX_NUM;
	}
	
	private ArrayList<Map<String, Object>> reconstructPath(int MASK, int[][] path, ArrayList<Map<String, Object>> cartList) {
        int bitmask = 0;
        int cur_node = 0;
        ArrayList<Map<String, Object>> newCartList = new ArrayList<Map<String, Object>>();
        newCartList.add(cartList.get(cur_node));
        
        while (bitmask != MASK - 1) {
            int next_node = path[cur_node][bitmask];
            bitmask |= (1 << next_node);
            cur_node = next_node;
            newCartList.add(cartList.get(cur_node));
        }

        return newCartList;
    }

}
