package com.sp.user.reservation;

import java.util.List;
import java.util.Map;

public interface ReservationService {
	public Reservation reservationdetail(int roomnum);
	public int roomnum(Map<String, Object> map);
		
	public void insertReservation(Map<String, Object> map) throws Exception;
	
	public void nomeminsertReservation(Map<String, Object> map) throws Exception;
	public int getreserNum();
	
	public String gethotelname(Map<String, Object> map);
	public void optadd(List<Map<String, Object>> optlist) throws Exception;
	
}
