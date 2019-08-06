package com.sp.owner.hotel;

import org.springframework.web.multipart.MultipartFile;

public class Hotel {
	// hotel 테이블
	private String hotelId;
	private String hotelName;
	private int granted;

	// hoteladdopt 테이블
	private int optNum;
	private String optName;
	private String optPrice;

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

	// hotelphoto 테이블
	private int hotelPhotoNum;
	private String hotelPhotoName;

	// hotelprepare 테이블
	private int prepareNum;
	private String prepareContent;

	// hoteltype 테이블
	private int typeNum;
	private String type;

	// convenient 테이블
	private int conNum;
	private String conName;
	private String conType;
	private String conPrice; // conOpenTime, closeTime DB에서 삭제하기

	// room 테이블
	private int roomNum;
	private String roomName;
	private int stair;
	private String roomType;
	private int maxPeople;
	private String roomStatus; // default 처리 해주기
	private int roomPrice;
	private int extraPrice; // 까먹지 말고 방 추가 때 넣기

	// roomDetail 테이블
	private int roomDetailNum;
	private String roomDetails;

	// roomPhoto 테이블
	private int roomPhotoNum;
	private String roomPhotoName;

	// hotelPhoto 테이블
	private MultipartFile mainUpload;
	private MultipartFile upload;

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

	public int getGranted() {
		return granted;
	}

	public void setGranted(int granted) {
		this.granted = granted;
	}

	public int getOptNum() {
		return optNum;
	}

	public void setOptNum(int optNum) {
		this.optNum = optNum;
	}

	public String getOptName() {
		return optName;
	}

	public void setOptName(String optName) {
		this.optName = optName;
	}

	public String getOptPrice() {
		return optPrice;
	}

	public void setOptPrice(String optPrice) {
		this.optPrice = optPrice;
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

	public int getHotelPhotoNum() {
		return hotelPhotoNum;
	}

	public void setHotelPhotoNum(int hotelPhotoNum) {
		this.hotelPhotoNum = hotelPhotoNum;
	}

	public String getHotelPhotoName() {
		return hotelPhotoName;
	}

	public void setHotelPhotoName(String hotelPhotoName) {
		this.hotelPhotoName = hotelPhotoName;
	}

	public int getPrepareNum() {
		return prepareNum;
	}

	public void setPrepareNum(int prepareNum) {
		this.prepareNum = prepareNum;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getConNum() {
		return conNum;
	}

	public void setConNum(int conNum) {
		this.conNum = conNum;
	}

	public String getConName() {
		return conName;
	}

	public void setConName(String conName) {
		this.conName = conName;
	}

	public String getConType() {
		return conType;
	}

	public void setConType(String conType) {
		this.conType = conType;
	}

	public String getConPrice() {
		return conPrice;
	}

	public void setConPrice(String conPrice) {
		this.conPrice = conPrice;
	}

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public int getStair() {
		return stair;
	}

	public void setStair(int stair) {
		this.stair = stair;
	}

	public String getRoomType() {
		return roomType;
	}

	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}

	public int getMaxPeople() {
		return maxPeople;
	}

	public void setMaxPeople(int maxPeople) {
		this.maxPeople = maxPeople;
	}

	public String getRoomStatus() {
		return roomStatus;
	}

	public void setRoomStatus(String roomStatus) {
		this.roomStatus = roomStatus;
	}

	public int getRoomPrice() {
		return roomPrice;
	}

	public void setRoomPrice(int roomPrice) {
		this.roomPrice = roomPrice;
	}

	public int getExtraPrice() {
		return extraPrice;
	}

	public void setExtraPrice(int extraPrice) {
		this.extraPrice = extraPrice;
	}

	public int getRoomDetailNum() {
		return roomDetailNum;
	}

	public void setRoomDetailNum(int roomDetailNum) {
		this.roomDetailNum = roomDetailNum;
	}

	public String getRoomDetails() {
		return roomDetails;
	}

	public void setRoomDetails(String roomDetails) {
		this.roomDetails = roomDetails;
	}

	public int getRoomPhotoNum() {
		return roomPhotoNum;
	}

	public void setRoomPhotoNum(int roomPhotoNum) {
		this.roomPhotoNum = roomPhotoNum;
	}

	public String getRoomPhotoName() {
		return roomPhotoName;
	}

	public void setRoomPhotoName(String roomPhotoName) {
		this.roomPhotoName = roomPhotoName;
	}

	public MultipartFile getMainUpload() {
		return mainUpload;
	}

	public void setMainUpload(MultipartFile mainUpload) {
		this.mainUpload = mainUpload;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}

}
