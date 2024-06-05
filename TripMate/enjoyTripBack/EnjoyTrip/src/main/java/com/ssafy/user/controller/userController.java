package com.ssafy.user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.jwt.JWTUtil;
import com.ssafy.user.model.userDto;
import com.ssafy.user.model.service.userService;

import ch.qos.logback.core.model.Model;
import io.swagger.v3.oas.annotations.Hidden;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/user")
@CrossOrigin("*")
public class userController {
	private static final long serialVersionUID = 1L;
       
	private final JWTUtil jwtUtil;
	private final userService userService;
	
	public userController(userService userService, JWTUtil jwtUtil) {
		super();
		this.userService = userService;
		this.jwtUtil = jwtUtil;
	}

	@Operation(summary = "로그인", description = "아이디와 비밀번호를 이용하여 로그인 처리.")
	@PostMapping("/login")
	public ResponseEntity<Map<String, Object>> login(
			@RequestBody @Parameter(description = "로그인 시 필요한 회원정보(아이디, 비밀번호).", required = true) userDto userDto) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HttpStatus status = HttpStatus.ACCEPTED;
		try {
			userDto loginUser = this.userService.login(userDto);
			if(loginUser != null) {
				String accessToken = jwtUtil.createAccessToken(loginUser.getUserId());
				String refreshToken = jwtUtil.createRefreshToken(loginUser.getUserId());

				
//				발급받은 refresh token 을 DB에 저장.
				this.userService.saveRefreshToken(loginUser.getUserId(), refreshToken);
				
//				JSON 으로 token 전달.
				resultMap.put("access-token", accessToken);
				resultMap.put("refresh-token", refreshToken);
				
				status = HttpStatus.CREATED;
			} else {
				resultMap.put("message", "아이디 또는 패스워드를 확인해 주세요.");
				status = HttpStatus.UNAUTHORIZED;
			} 
			
		} catch (Exception e) {
//			log.debug("로그인 에러 발생 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	
	
	@Operation(summary = "회원인증", description = "회원 정보를 담은 Token 을 반환한다.")
	@GetMapping("/{userId}")
	public ResponseEntity<Map<String, Object>> getInfo(
			@PathVariable("userId") @Parameter(description = "인증할 회원의 아이디.", required = true) String userId,
			HttpServletRequest request) {
//		logger.debug("userId : {} ", userId);
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		if (jwtUtil.checkToken(request.getHeader("Authorization"))) {
//			log.info("사용 가능한 토큰!!!");
			try {
//				로그인 사용자 정보.
				userDto userDto = this.userService.userInfo(userId);
				resultMap.put("userInfo", userDto);
				status = HttpStatus.OK;
			} catch (Exception e) {
//				log.error("정보조회 실패 : {}", e);
				System.out.println(e);
				resultMap.put("message", e.getMessage());
				status = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		} else {
//			log.error("사용 불가능 토큰!!!");
			status = HttpStatus.UNAUTHORIZED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	
	@Operation(summary = "로그아웃", description = "회원 정보를 담은 Token 을 제거한다.")
	@GetMapping("/logout/{userId}")
	@Hidden
	public ResponseEntity<?> removeToken(@PathVariable ("userId") @Parameter(description = "로그아웃 할 회원의 아이디.", required = true) String userId) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		try {
			this.userService.deleRefreshToken(userId);
			status = HttpStatus.OK;
		} catch (Exception e) {
//			log.error("로그아웃 실패 : {}", e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	
	@Operation(summary = "Access Token 재발급", description = "만료된 access token 을 재발급 받는다.")
	@PostMapping("/refresh")
	public ResponseEntity<?> refreshToken(@RequestBody userDto userDto, HttpServletRequest request)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		String token = request.getHeader("refreshToken");
//		log.debug("token : {}, memberDto : {}", token, memberDto);
		if (jwtUtil.checkToken(token)) {
			
			if (token.equals(this.userService.getRefreshToken(userDto.getUserId()))) {
				String accessToken = jwtUtil.createAccessToken(userDto.getUserId());
				resultMap.put("access-token", accessToken);
				status = HttpStatus.CREATED;
			}
		} else {

			status = HttpStatus.UNAUTHORIZED;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@Operation(summary = "회원수정", description = "회원 정보를 수정한다.")
	@PostMapping("/modify")
	public ResponseEntity<?> updateUser(@RequestBody userDto userDto, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		
		try {
			this.userService.userUpdate(userDto);
			userDto new_userDto = this.userService.userInfo(userDto.getUserId());
			resultMap.put("userInfo", new_userDto);
			status = HttpStatus.OK;
		} catch (Exception e) {
//			log.error("로그아웃 실패 : {}", e);
			System.out.println(e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	@Operation(summary = "회원가입", description = "회원 가입")
	@PostMapping("/register")
	public ResponseEntity<?> registerUser(@RequestBody userDto userDto, HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		
		try {
			this.userService.register(userDto);
			status = HttpStatus.OK;
		} catch (Exception e) {
//			log.error("로그아웃 실패 : {}", e);
			System.out.println(e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
	
	
	@Operation(summary = "회원삭제", description = "회원 정보를 삭제한다.")
	@DeleteMapping("/{userId}")
	public ResponseEntity<?> deleteUser(@PathVariable ("userId") @Parameter(description = "삭제 할 회원의 아이디.", required = true) String userId) {
		Map<String, Object> resultMap = new HashMap<>();
		HttpStatus status = HttpStatus.ACCEPTED;
		
		try {
			this.userService.withdraw(userId);
			status = HttpStatus.OK;
		} catch (Exception e) {
			System.out.println(e);
			resultMap.put("message", e.getMessage());
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		return new ResponseEntity<Map<String, Object>>(resultMap, status);
	}
}
