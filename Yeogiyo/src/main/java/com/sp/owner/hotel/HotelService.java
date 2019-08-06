package com.sp.owner.hotel;

import java.util.List;

public interface HotelService {
	
	public Hotel selectAll(String hotelId) throws Exception;
	
	// hotel 테이블
	public Hotel selectHotel(String hotelId) throws Exception;
	public void insertHotel(Hotel hotel) throws Exception;
	public void updateHotel(Hotel hotel) throws Exception;
	public void updateGranted(String hotelId) throws Exception;
	public void updateRequest(String hotelId) throws Exception;
	public void deleteHotel(String hotelId) throws Exception;
	
	// hotelAddOpt 테이블
	public Hotel selectHotelAddOpt(String hotelId) throws Exception;
	public void insertHotelAddOpt(Hotel hotel, HotelSessionInfo hinfo) throws Exception;
	public void updateHotelAddOpt(Hotel hotel) throws Exception;
	public void deleteHotelAddOpt(String hotelId) throws Exception;
	
	// hotelDetail 테이블
	public Hotel selectHotelDetail(String hotelId) throws Exception;
	public void insertHotelDetail(Hotel hotel) throws Exception;
	public void updateHotelDetail(Hotel hotel) throws Exception;
	public void deleteHotelDetail(String hotelId) throws Exception;
	
	// hotelPhoto 테이블
	public Hotel selectHotelPhoto(String hotelId) throws Exception;
	public void insertHotelPhoto(Hotel hotel, String pathname, HotelSessionInfo hinfo) throws Exception;
	public void updateHotelPhoto(Hotel hotel, String pathname) throws Exception;
	public void deleteHotelPhoto(String hotelId, String pathname) throws Exception;
	
	// hotelPrepare 테이블
	public Hotel selectHotelPrepare(String hotelId) throws Exception;
	public void insertHotelPrepare(Hotel hotel) throws Exception;
	public void updateHotelPrepare(Hotel hotel) throws Exception;
	public void deleteHotelPrepare(String hotelId) throws Exception;
	
	// convenient 테이블 
	public Hotel selectConvenient(String hotelId) throws Exception;
	public void insertConvenient(Hotel hotel, HotelSessionInfo hinfo) throws Exception;
	public void updateConvenient(Hotel hotel) throws Exception;
	public void deleteConvenient(String hotelId) throws Exception;
	
	// room 테이블
	public List<Hotel> selectRoom(String hotelId) throws Exception;
	public void insertRoom(Hotel hotel) throws Exception;
	public void updateRoom(Hotel hotel) throws Exception;
	public void  deleteRoom(Hotel hotel) throws Exception;
	
	// roomDetail 테이블
	public List<Hotel> selectRoomDetail(String hotelId) throws Exception;
	public void insertRoomDetail(Hotel hotel) throws Exception;
	public void updateRoomDetail(Hotel hotel) throws Exception;
	public void deleteRoomDetail(Hotel hotel) throws Exception;
	
	// roomPhoto 테이블
	public List<Hotel> selectRoomPhoto(String hotelId) throws Exception;
	public void insertRoomPhoto(Hotel hotel, String pathname, HotelSessionInfo hinfo) throws Exception;
	public void updateRoomPhoto(Hotel hotel, String pathname) throws Exception;
	public void deleteRoomPhoto(Hotel hotel, String pathname) throws Exception;
	
}
