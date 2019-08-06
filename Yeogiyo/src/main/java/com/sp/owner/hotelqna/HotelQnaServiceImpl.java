package com.sp.owner.hotelqna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;


@Service("owner.hotelqna.hotelQnaServiceImpl")
public class HotelQnaServiceImpl implements HotelQnaService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertHotelQna(HotelQna dto) throws Exception {
		try {
			int seq = dao.selectOne("owner.hotelqna.seq");
			dto.setQnaNum(seq);
			
			dao.insertData("owner.hotelqna.insertHotelQna", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<HotelQna> listHotelQna(Map<String, Object> map) {
		List<HotelQna> list = null;
		
		try {
			list = dao.selectList("owner.hotelqna.selectHotelQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("owner.hotelqna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteHotelQna(int qnaNum) throws Exception {
		try {
			dao.deleteData("owner.hotelqna.deleteHotelQna", qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateHotelQna(HotelQna dto) throws Exception {
		try {
			dao.updateData("owner.hotelqna.updateHotelQna",dto);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<HotelQna> listHotelQna(int qnaNum) {
		List<HotelQna> list = null;
		
		try {
			list = dao.selectList("owner.hotelqna.selectHotelQnas", qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	

}
