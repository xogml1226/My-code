package com.sp.user.confirm;

import java.util.List;
import java.util.Map;

public interface ConfirmService {

	public List<Confirm> listConfirm(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Confirm readConfirm(int reservationNum);
	public void deleteReservation(int reservationNum) throws Exception;
	
	public int noMemberdataCount(Map<String, Object> map);
	public List<Confirm> listNoMemberConfirm(Map<String, Object> map);
	public Confirm readnoMemberConfirm(int reservationNum);
}
