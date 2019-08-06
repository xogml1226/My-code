package com.sp.admin.main;

import java.util.List;
import java.util.Map;

public interface GrantedService {

	public int dataCount();
	public List<Granted> listHotel(Map<String, Object> map);
	public Granted readHotel(String hotelId);
	public void updateGranted(Granted dto) throws Exception;
	
}
