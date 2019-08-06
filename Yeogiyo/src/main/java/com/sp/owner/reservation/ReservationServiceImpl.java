package com.sp.owner.reservation;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("owner.reservation.reservationServiceImpl")
public class ReservationServiceImpl implements ReservationService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Reservation> select(Map<String, Object> map) {
		List<Reservation> list = null;
		try {
			list =  dao.selectList("owner.reservation.reservation", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
