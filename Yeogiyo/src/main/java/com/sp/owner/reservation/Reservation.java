package com.sp.owner.reservation;

public class Reservation {
	private String roomName;
	private String roomType;
	private int peopleCount;
	private String checkInday;
	private String checkOutday;
	private String userName;
	private String userTel;
	
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getRoomType() {
		return roomType;
	}
	public void setRoomType(String roomType) {
		this.roomType = roomType;
	}
	public int getPeopleCount() {
		return peopleCount;
	}
	public void setPeopleCount(int peopleCount) {
		this.peopleCount = peopleCount;
	}
	public String getCheckInday() {
		return checkInday;
	}
	public void setCheckInday(String checkInday) {
		this.checkInday = checkInday;
	}
	public String getCheckOutday() {
		return checkOutday;
	}
	public void setCheckOutday(String checkOutday) {
		this.checkOutday = checkOutday;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	
}
