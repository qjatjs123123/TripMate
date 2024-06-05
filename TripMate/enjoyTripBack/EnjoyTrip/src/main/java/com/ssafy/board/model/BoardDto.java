package com.ssafy.board.model;

import java.util.List;

public class BoardDto {

	private int board_id;
	private String title;
	private String content;
	private String tripdate;
	private String img;
	private String user_id;
	private String registerdate;
	private String address;
	private int hit;
	private List<FileInfoDto> fileInfos;
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTripdate() {
		return tripdate;
	}
	public void setTripdate(String tripdate) {
		this.tripdate = tripdate;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getRegisterdate() {
		return registerdate;
	}
	public void setRegisterdate(String registerdate) {
		this.registerdate = registerdate;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}

	public List<FileInfoDto> getFileInfos() {
		return fileInfos;
	}
	public void setFileInfos(List<FileInfoDto> fileInfos) {
		this.fileInfos = fileInfos;
	}
	
	@Override
	public String toString() {
		return "BoardDto [board_id=" + board_id + ", title=" + title + ", content=" + content + ", tripdate=" + tripdate
				+ ", img=" + img + ", user_id=" + user_id + ", registerdate=" + registerdate + ", address=" + address
				+ ", hit=" + hit + "]";
	}
	
}
