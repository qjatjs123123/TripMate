package com.ssafy.trip.model.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ssafy.trip.model.tripDto;
import com.ssafy.trip.model.mapper.TripMapper;

@Service
public class tripServiceImpl implements tripService{
	
	private TripMapper tripMapper;
	
	private tripServiceImpl(TripMapper tripMapper) {
		this.tripMapper = tripMapper;
	}
	
	@Override
	public List<tripDto> getList(int sido_code, int content_type_id, String title, int pageNo, String userId) throws SQLException {
		return tripMapper.getList(sido_code, content_type_id, title, pageNo,userId);
	}
	
	@Override
	public List<tripDto> getListbyLoc(Map<String, Double> map) throws SQLException {
		return tripMapper.getListByLoc(map);	
	}

	@Override
	public List<tripDto> getLatestAttraction() throws SQLException {
		List<tripDto> list = tripMapper.getLatestAttraction();
		return list;
	}

}
