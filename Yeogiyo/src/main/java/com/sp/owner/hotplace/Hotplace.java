package com.sp.owner.hotplace;

import org.springframework.web.multipart.MultipartFile;

public class Hotplace {
	
	private int placeNum;
	private double placeDis;
	private String placeName;
	private String placePhoto;
	private String hotelId;
	private String placeAddr1;
	private String placeAddr2;
	private String placeZip;
	
	private MultipartFile upload;
	
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public int getPlaceNum() {
		return placeNum;
	}
	public void setPlaceNum(int placeNum) {
		this.placeNum = placeNum;
	}
	public double getPlaceDis() {
		return placeDis;
	}
	public void setPlaceDis(double placeDis) {
		this.placeDis = placeDis;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getPlacePhoto() {
		return placePhoto;
	}
	public void setPlacePhoto(String placePhoto) {
		this.placePhoto = placePhoto;
	}
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
	public String getPlaceAddr1() {
		return placeAddr1;
	}
	public void setPlaceAddr1(String placeAddr1) {
		this.placeAddr1 = placeAddr1;
	}
	public String getPlaceAddr2() {
		return placeAddr2;
	}
	public void setPlaceAddr2(String placeAddr2) {
		this.placeAddr2 = placeAddr2;
	}
	public String getPlaceZip() {
		return placeZip;
	}
	public void setPlaceZip(String placeZip) {
		this.placeZip = placeZip;
	}
	
}
