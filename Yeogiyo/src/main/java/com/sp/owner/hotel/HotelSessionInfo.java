package com.sp.owner.hotel;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class HotelSessionInfo {
	// hotel 테이블
	private String hotelId;
	private String hotelName;

	// hoteldetail 테이블
	private String detail;
	private String mainPhoto;
	private String addr1;
	private String addr2;
	private String postCode;
	private String latitude;
	private String longitude;
	private String hotelSize;
	private String hotelTel;
	private String hotelCreated;
	private String checkIn;
	private String checkOut;
	private String businessNum;
	private int grade;

	// hotelprepare 테이블
	private String prepareContent;

	// hoteltype 테이블
	private int typeNum;

	// roomDetail 테이블
	private String roomDetails;

	private List<MultipartFile> uploads;
	private MultipartFile mainUpload;

	// convenient 테이블
	private List<String> recommendation;
	private List<String> internet;
	private List<String> access;
	private List<String> kitchen;
	private List<String> convenient;
	private List<String> safety;
	private List<String> others;
	private List<String> notFree;
	private List<String> conPrices;

	public String getHotelId() {
		return hotelId;
	}

	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}

	public String getHotelName() {
		return hotelName;
	}

	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getMainPhoto() {
		return mainPhoto;
	}

	public void setMainPhoto(String mainPhoto) {
		this.mainPhoto = mainPhoto;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getHotelSize() {
		return hotelSize;
	}

	public void setHotelSize(String hotelSize) {
		this.hotelSize = hotelSize;
	}

	public String getHotelTel() {
		return hotelTel;
	}

	public void setHotelTel(String hotelTel) {
		this.hotelTel = hotelTel;
	}

	public String getHotelCreated() {
		return hotelCreated;
	}

	public void setHotelCreated(String hotelCreated) {
		this.hotelCreated = hotelCreated;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public String getBusinessNum() {
		return businessNum;
	}

	public void setBusinessNum(String businessNum) {
		this.businessNum = businessNum;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public String getPrepareContent() {
		return prepareContent;
	}

	public void setPrepareContent(String prepareContent) {
		this.prepareContent = prepareContent;
	}

	public int getTypeNum() {
		return typeNum;
	}

	public void setTypeNum(int typeNum) {
		this.typeNum = typeNum;
	}

	public String getRoomDetails() {
		return roomDetails;
	}

	public void setRoomDetails(String roomDetails) {
		this.roomDetails = roomDetails;
	}

	public List<MultipartFile> getUploads() {
		return uploads;
	}

	public void setUploads(List<MultipartFile> uploads) {
		this.uploads = uploads;
	}

	public MultipartFile getMainUpload() {
		return mainUpload;
	}

	public void setMainUpload(MultipartFile mainUpload) {
		this.mainUpload = mainUpload;
	}

	public List<String> getRecommendation() {
		return recommendation;
	}

	public void setRecommendation(List<String> recommendation) {
		this.recommendation = recommendation;
	}

	public List<String> getInternet() {
		return internet;
	}

	public void setInternet(List<String> internet) {
		this.internet = internet;
	}

	public List<String> getAccess() {
		return access;
	}

	public void setAccess(List<String> access) {
		this.access = access;
	}

	public List<String> getKitchen() {
		return kitchen;
	}

	public void setKitchen(List<String> kitchen) {
		this.kitchen = kitchen;
	}

	public List<String> getConvenient() {
		return convenient;
	}

	public void setConvenient(List<String> convenient) {
		this.convenient = convenient;
	}

	public List<String> getSafety() {
		return safety;
	}

	public void setSafety(List<String> safety) {
		this.safety = safety;
	}

	public List<String> getOthers() {
		return others;
	}

	public void setOthers(List<String> others) {
		this.others = others;
	}

	public List<String> getNotFree() {
		return notFree;
	}

	public void setNotFree(List<String> notFree) {
		this.notFree = notFree;
	}

	public List<String> getConPrices() {
		return conPrices;
	}

	public void setConPrices(List<String> conPrices) {
		this.conPrices = conPrices;
	}

}
