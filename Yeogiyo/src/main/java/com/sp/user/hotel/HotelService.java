package com.sp.user.hotel;

import java.util.List;
import java.util.Map;

public interface HotelService {
	public Hotel detailHotel(Map<String, Object> map);
	public int HotelCount(Map<String, Object> map);
	
	public List<Hotel> listHotel(Map<String, Object> map);
	public List<Hotel> listPhoto(Map<String, Object> map);
	public List<Hotel> listHotelRoom(Map<String, Object> map);
	public List<Hotel> listaddopt(Map<String, Object> map);
	public List<Hotel> listReview(Map<String, Object> map);
	public List<Hotel> listHotPlace(Map<String, Object> map);
	
	public String getHotelId(String hotelName); 
	
	public void insertHotelQnA(Map<String, Object> map) throws Exception;
}
