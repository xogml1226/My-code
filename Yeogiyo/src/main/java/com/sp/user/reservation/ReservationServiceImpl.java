package com.sp.user.reservation;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.reservation.reservationService")
public class ReservationServiceImpl implements ReservationService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public Reservation reservationdetail(int roomnum) {
		Reservation dto=null;
		
		try {
			
			dto = dao.selectOne("user.reservation.showresdetail",roomnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int roomnum(Map<String, Object> map) {
		int roomnum=0;
		
		try {
			roomnum = dao.selectOne("user.reservation.getroomnum",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return roomnum;
	}

	@Override
	public void insertReservation(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("user.reservation.insertReservation", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void nomeminsertReservation(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("user.reservation.noMemberinsertReservation",map);
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public String gethotelname(Map<String, Object> map) {
		String hotelName = null;
		try {
			hotelName=dao.selectOne("user.reservation.selectHotelName",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return hotelName;
	}

	@Override
	public void optadd(List<Map<String, Object>> optlist) throws Exception{	
		
			try {
				for(Map<String , Object> map : optlist) {
					dao.insertData("user.reservation.addopt", map);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		
	}

	@Override
	public int getreserNum() {
		int reserNum=0;
		try {
			reserNum=dao.selectOne("user.reservation.getreservationNum");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return reserNum;
	}
}
