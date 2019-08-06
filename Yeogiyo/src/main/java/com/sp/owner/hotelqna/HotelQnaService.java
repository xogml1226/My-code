package com.sp.owner.hotelqna;

import java.util.List;
import java.util.Map;

public interface HotelQnaService {
	public void insertHotelQna(HotelQna dto) throws Exception;
	public List<HotelQna> listHotelQna(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public void deleteHotelQna(int qnaNum) throws Exception;
	public void updateHotelQna(HotelQna dto) throws Exception;
	public List<HotelQna> listHotelQna(int qnaNum);
}
