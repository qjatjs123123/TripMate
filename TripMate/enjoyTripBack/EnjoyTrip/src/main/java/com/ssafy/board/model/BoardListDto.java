package com.ssafy.board.model;

import java.util.List;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
@Schema(title = "BoardListDto : 게시글 목록 & 페이지 정보", description = "게시글 목록과 현재 페이지와 전체 페이지 정보를 나타낸다.")
public class BoardListDto {

	@Schema(description = "글목록")
	private List<BoardDto> articles;
	@Schema(description = "현재까지불러온 데이터의 총 개수")
	private int totalCount;
	@Schema(description = "다음 데이터의 시작 위치")
	private int nextStart;

}
