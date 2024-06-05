package com.ssafy.trip.model.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ssafy.trip.model.tripDto;

public interface tripService {
	List<tripDto> getList(int sido_code, int content_type_id, String title, int pageNo, String userId) throws SQLException;

	List<tripDto> getListbyLoc(Map<String, Double> map) throws SQLException;

	List<tripDto> getLatestAttraction() throws SQLException;
}
