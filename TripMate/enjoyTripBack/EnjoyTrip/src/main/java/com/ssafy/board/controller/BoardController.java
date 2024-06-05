package com.ssafy.board.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ssafy.board.model.BoardDto;
import com.ssafy.board.model.BoardListDto;
import com.ssafy.board.model.FileInfoDto;
import com.ssafy.board.model.service.BoardService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/hotplace")
public class BoardController {

	private BoardService boardService;
	public BoardController(BoardService boardService) {
		super();
		this.boardService = boardService;
	}
	
    @Value("${file.path.upload-files}")
    private String uploadDir;
    
	@Operation(summary = "핫플 게시판 글목록", description = "모든 게시글의 정보를 반환한다.")
	@ApiResponses(value = { @ApiResponse(responseCode = "200", description = "게시글목록 OK!!"),
			@ApiResponse(responseCode = "404", description = "페이지없어!!"),
			@ApiResponse(responseCode = "500", description = "서버에러!!") })
	@GetMapping
    public ResponseEntity<?> listArticles(@RequestParam @Parameter(description = "게시글을 얻기위한 부가정보.", required = true) Map<String, String> map, HttpSession session) {
		try {
			BoardListDto boardListDto = boardService.listArticle(map);
			System.out.println(boardListDto);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
			return ResponseEntity.ok().headers(header).body(boardListDto);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
                    .body("서버에서 문제가 발생했습니다.");
		}
	}
	
	
	@Operation(summary = "게시판 글보기", description = "글번호에 해당하는 게시글의 정보를 반환한다.")
	@GetMapping("/{boardId}")
	public ResponseEntity<?> viewArticle(@PathVariable("boardId") @Parameter(name = "boardId", description = "얻어올 글의 글번호.", required = true) int boardId, HttpSession session) {
		System.out.println("view");
		System.out.println("No: " + boardId);
		try {
			boardService.updateHit(boardId);
			BoardDto boardDto = boardService.getArticle(boardId);
			return ResponseEntity.ok(boardDto);
		}catch(Exception e){
			e.printStackTrace();

			 return ResponseEntity
	                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
	                    .body("서버에서 문제가 발생했습니다.");
		}
	}
	
	@Operation(summary = "이미지 불러오기")
	@GetMapping("/img/{img}")
	public ResponseEntity<?> getImg(@PathVariable("img") @Parameter(name = "img") String img, HttpSession session) {
		System.out.println(uploadDir + img);
		try {
			InputStream imageStream = new FileInputStream(uploadDir + img);
			System.out.println("imageStream " + imageStream);
			byte[] imageByteArray = IOUtils.toByteArray(imageStream);
			imageStream.close();
			String base64Image = Base64.getEncoder().encodeToString(imageByteArray);
			HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_JPEG); // 이미지 타입에 따라 변경
			return new ResponseEntity<>(base64Image, headers, HttpStatus.OK);
		}catch(Exception e){
			e.printStackTrace();
			 return ResponseEntity
	                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
	                    .body("서버에서 문제가 발생했습니다.");
		}
	}

	/**
	 * 
	 @RequestParam("subject") String subject, @RequestParam("content") String content
	 */
	@Operation(summary = "게시판 글작성", description = "새로운 게시글 정보를 입력한다.")
	@PostMapping
	public ResponseEntity<?> write(@RequestPart @Parameter(description = "작성글 정보.", required = true) BoardDto boardDto,
			 @RequestPart(value = "files", required = false) MultipartFile[] files, HttpSession session){

		try {
			
			System.out.println("boardDto : " + boardDto + ", files : " + files);
			String today = new SimpleDateFormat("yyMMdd").format(new Date());
			String img = "";
			File folder = new File(uploadDir);
			System.out.println(folder);
			if(!folder.exists()) folder.mkdirs();
			List<FileInfoDto> fileInfos = new ArrayList<FileInfoDto>();
			for (MultipartFile mfile : files) {
				FileInfoDto fileInfo = new FileInfoDto();
				String originalFileName = mfile.getOriginalFilename();
				if(!originalFileName.isEmpty()) {
					String saveFileName = UUID.randomUUID().toString()  // UUID는 이미지 이름 중복 방지 위해 랜덤하게 생성된 고유값
							+ originalFileName.substring(originalFileName.lastIndexOf('.'));
					fileInfo.setSaveFolder(today);
					fileInfo.setOriginalFile(originalFileName);
					fileInfo.setSaveFile(saveFileName);
					mfile.transferTo(new File(folder, saveFileName));
					img = saveFileName;
				}
				fileInfos.add(fileInfo);
			}
			boardDto.setFileInfos(fileInfos);
			boardDto.setImg(img);
			
			boardService.writeArticle(boardDto);
			return ResponseEntity.ok(boardDto);
		}catch(Exception e){
			e.printStackTrace();
			return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
                    .body("게시판 글 등록 실패 !"); 
		}
	}

	
	@Operation(summary = "게시판 글수정", description = "수정할 게시글 정보를 입력한다. 그리고 DB수정 성공여부에 따라 'success' 또는 'fail' 문자열을 반환한다.")
	@PutMapping
	public ResponseEntity<?> modify(HttpSession session, @RequestPart @Parameter(description = "작성글 정보.", required = true) BoardDto boardDto,
			 @RequestPart(value = "files", required = false) MultipartFile[] files){
		try {
			System.out.println("boardDto : " + boardDto + ", files : " + files);
			String today = new SimpleDateFormat("yyMMdd").format(new Date());
			File folder = new File(uploadDir);
			if(!folder.exists()) folder.mkdirs();
			List<FileInfoDto> fileInfos = new ArrayList<FileInfoDto>();
			for (MultipartFile mfile : files) {
				FileInfoDto fileInfo = new FileInfoDto();
				String originalFileName = mfile.getOriginalFilename();
				if(!originalFileName.isEmpty()) {
					String saveFileName = UUID.randomUUID().toString()  // UUID는 이미지 이름 중복 방지 위해 랜덤하게 생성된 고유값
							+ originalFileName.substring(originalFileName.lastIndexOf('.'));
					fileInfo.setSaveFolder(today);
					fileInfo.setOriginalFile(originalFileName);
					fileInfo.setSaveFile(saveFileName);
					mfile.transferTo(new File(folder, saveFileName));
				}
				fileInfos.add(fileInfo);
			}
			boardDto.setFileInfos(fileInfos);
			boardService.modifyArticle(boardDto);
			return ResponseEntity.status(HttpStatus.ACCEPTED).body("게시판 수정 성공"); 
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
                    .body("게시판 수정 실패!"); 
		}
	}

	@DeleteMapping("/{boardId}")
	public ResponseEntity<?> delete(@PathVariable("boardId") @Parameter(name = "boardId", description = "살제할 글의 글번호.", required = true) int boardId) throws Exception{
		try {
			boardService.deleteArticle(boardId, uploadDir);
			return ResponseEntity.status(HttpStatus.OK).body("성공적으로 게시판을 삭제하였습니다.");
		}catch(Exception e){
			e.printStackTrace();
			return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
                    .body("게시판 글 삭제 실패 !"); 
		}
	}
	
    @GetMapping("/popular")
    public ResponseEntity<?> getPopularArticle(HttpSession session) {
		try {
			System.out.println("인기여행지 가져오기!!!");
			BoardListDto boardListDto = boardService.getPopularArticle();
			System.out.println(boardListDto);
			HttpHeaders header = new HttpHeaders();
			header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
			return ResponseEntity.ok().headers(header).body(boardListDto);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return ResponseEntity
                    .status(HttpStatus.INTERNAL_SERVER_ERROR) // 500 Internal Server Error 상태 코드 설정
                    .body("서버에서 문제가 발생했습니다.");
		}
    }

}
