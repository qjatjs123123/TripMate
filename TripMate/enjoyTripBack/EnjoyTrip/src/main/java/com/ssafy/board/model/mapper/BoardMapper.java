package com.ssafy.board.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.board.model.BoardDto;
import com.ssafy.board.model.FileInfoDto;

@Mapper
public interface BoardMapper {

	void writeArticle(BoardDto boardDto) throws SQLException;
	void registerImg(BoardDto boardDto) throws Exception;
	List<BoardDto> listArticle(Map<String, Object> param) throws SQLException;
	int getTotalArticleCount(Map<String, Object> param) throws SQLException;
	BoardDto getArticle(int boardId) throws SQLException;
	void updateHit(int boardId) throws SQLException;
	void modifyArticle(BoardDto boardDto) throws SQLException;
	void deleteArticle(int boardId) throws SQLException;

	List<FileInfoDto> fileInfoList(int articleNo) throws Exception;
	void deleteFile(int articleNo) throws Exception;
	List<BoardDto> getPopularArticle() throws Exception;

}
