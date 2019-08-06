package com.sp.user.hotel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.hotel.HotelService")
public class HotelServiceImpl implements HotelService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public int HotelCount(Map<String, Object> map) {
		int count = 0;
		
		try {
			count=dao.selectOne("user.hotel.hotelCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	
	@Override
	public Hotel detailHotel(Map<String, Object> map) {
		Hotel dto = null;
		try {
			dto = dao.selectOne("user.hotel.hotelDetail", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<Hotel> listHotel(Map<String, Object> map) {
		List<Hotel> list = null;
		try {
			list=dao.selectList("user.hotel.hotelList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Hotel> listPhoto(Map<String, Object> map) {
		List<Hotel> plist = null;
		try {
			plist=dao.selectList("user.hotel.hotelPhoto",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return plist;
	}

	@Override
	public List<Hotel> listHotelRoom(Map<String, Object> map) {
		List<Hotel> rlist = null;
		try {
			rlist=dao.selectList("user.hotel.hotelRoomList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rlist;
	}

	@Override
	public String getHotelId(String hotelName) {
		String hotelId = null;
		
		try {
			hotelId=dao.selectOne("user.hotel.hotelId",hotelName);
		} catch (Exception e) {	
			e.printStackTrace();
		}
		
		
		return hotelId;
	}

	@Override
	public List<Hotel> listaddopt(Map<String, Object> map) {
		List<Hotel> optlist = null;
			try {
				optlist=dao.selectList("user.hotel.addoptList", map);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return optlist;
	}


	@Override
	public List<Hotel> listReview(Map<String, Object> map) {
		List<Hotel> reviewlist= null;
		try {
			reviewlist=dao.selectList("user.hotel.showReview", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reviewlist;
	}


	@Override
	public List<Hotel> listHotPlace(Map<String, Object> map) {
		List<Hotel> hotplacelist= null;
		try {
			hotplacelist=dao.selectList("user.hotel.showHotPlace", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return hotplacelist;
	}


	@Override
	public void insertHotelQnA(Map<String, Object> map) throws Exception{
		try {
			dao.insertData("user.hotel.hotelqna",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}



}
