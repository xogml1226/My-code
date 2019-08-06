package com.sp.admin.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("admin.granted.grantedService")
public class GrantedServiceImpl implements GrantedService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount() {
		int result=0;
		try {
			result=dao.selectOne("admin.granted.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Granted> listHotel(Map<String, Object> map) {
		List<Granted> list=null;
		try {
			list=dao.selectList("admin.granted.listHotel", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Granted readHotel(String hotelId) {
		Granted dto=null;
		try {
			dto = dao.selectOne("admin.granted.readHotel", hotelId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateGranted(Granted dto) throws Exception {
		try {
			dao.updateData("admin.granted.updateGranted", dto.getHotelId());
			dao.updateData("admin.granted.updateEnabled", dto.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
}
