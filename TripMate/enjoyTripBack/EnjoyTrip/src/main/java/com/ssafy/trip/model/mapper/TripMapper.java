package com.ssafy.trip.model.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.trip.model.tripDto;

@Mapper
public interface TripMapper {
	List<tripDto> getList(int sido_code, int content_type_id, String title, int pageNo, String userId) throws SQLException;

	List<tripDto> getListByLoc(Map<String, Double> map);

	List<tripDto> getLatestAttraction() throws SQLException;
}
