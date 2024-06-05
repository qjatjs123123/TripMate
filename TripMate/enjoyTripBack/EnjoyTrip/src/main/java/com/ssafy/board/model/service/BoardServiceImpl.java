package com.ssafy.board.model.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.board.model.BoardDto;
import com.ssafy.board.model.BoardListDto;
import com.ssafy.board.model.FileInfoDto;
import com.ssafy.board.model.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	private final BoardMapper boardMapper;
	public BoardServiceImpl(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}

	@Override
	@Transactional
	public void writeArticle(BoardDto boardDto) throws Exception {
		boardMapper.writeArticle(boardDto);
		List<FileInfoDto> fileInfos = boardDto.getFileInfos();
		if (fileInfos != null && !fileInfos.isEmpty()) {
			boardMapper.registerImg(boardDto);
		}
	}

	@Override
	public BoardListDto listArticle(Map<String, String> map) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("word", map.get("word") == null ? "" : map.get("word"));
		
	    // 무한 스크롤을 위한 시작 위치와 데이터 크기 설정
	    int start = Integer.parseInt(map.get("start") == null ? "0" : map.get("start"));
	    int limit = Integer.parseInt(map.get("limit") == null ? "20" : map.get("limit"));
	    if(start>0)
	    	param.put("start", start-1);
	    else
	    	param.put("start", start);
	    param.put("limit", limit);

		String key = map.get("key");
		param.put("key", key == null ? "" : key);
		if ("user_id".equals(key))
			param.put("key", key == null ? "" : "user_id");
		
		List<BoardDto> list = boardMapper.listArticle(param);
		
		if ("user_id".equals(key))
			param.put("key", key == null ? "" : "user_id");
		
		int totalArticleCount = boardMapper.getTotalArticleCount(param);
		int nextStart = start + list.size();
		
		BoardListDto boardListDto = new BoardListDto();
		
		boardListDto.setArticles(list);
		boardListDto.setTotalCount(totalArticleCount);
		boardListDto.setNextStart(nextStart);

		return boardListDto;
	}

	@Override
	public BoardDto getArticle(int boardId) throws Exception {
		return boardMapper.getArticle(boardId);
	}

	@Override
	public void updateHit(int boardId) throws Exception {
		boardMapper.updateHit(boardId);
	}

	@Override
	public void modifyArticle(BoardDto boardDto) throws Exception {
		boardMapper.modifyArticle(boardDto);
	}

//	@Override
//	public void deleteArticle(int boardId) throws Exception {
//		boardMapper.deleteArticle(boardId);
//	}
//	
	@Override
	@Transactional
	public void deleteArticle(int boardId, String path) throws Exception {
		List<FileInfoDto> fileList = boardMapper.fileInfoList(boardId);
		boardMapper.deleteFile(boardId);
		boardMapper.deleteArticle(boardId);
		for(FileInfoDto fileInfoDto : fileList) {
			File file = new File(path + File.separator + fileInfoDto.getSaveFolder() + File.separator + fileInfoDto.getSaveFile());
			file.delete();
		}
	}

	@Override
	public BoardListDto getPopularArticle() throws Exception {
		List<BoardDto> list = boardMapper.getPopularArticle();
		BoardListDto boardListDto = new BoardListDto();
		boardListDto.setArticles(list);
		return boardListDto;
	}

}
