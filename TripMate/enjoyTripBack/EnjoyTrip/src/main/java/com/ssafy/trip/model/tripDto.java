package com.ssafy.trip.model;

public class tripDto {
	private int content_id;
	private int content_type_id;
	private String title;
	private String addr1;
	private String addr2;
	private String first_image;
	private String first_image2;
	private double mapy;
	private double mapx;
	private String overview;
	private int isExist;
	
	
	
	public int getContent_type_id() {
		return content_type_id;
	}
	public void setContent_type_id(int content_type_id) {
		this.content_type_id = content_type_id;
	}
	public int getContent_id() {
		return content_id;
	}
	public void setContent_id(int content_id) {
		this.content_id = content_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getFirst_image() {
		return first_image;
	}
	public void setFirst_image(String first_image) {
		this.first_image = first_image;
	}
	public String getFirst_image2() {
		return first_image2;
	}
	public void setFirst_image2(String first_image2) {
		this.first_image2 = first_image2;
	}
	public double getMapy() {
		return mapy;
	}
	public void setMapy(double mapy) {
		this.mapy = mapy;
	}
	public double getMapx() {
		return mapx;
	}
	public void setMapx(double mapx) {
		this.mapx = mapx;
	}
	public String getOverview() {
		return overview;
	}
	public void setOverview(String overview) {
		this.overview = overview;
	}
	public int getIsExist() {
		return isExist;
	}
	public void setIsExist(int isExist) {
		this.isExist = isExist;
	}
	
	
}
