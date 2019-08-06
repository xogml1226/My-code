package com.sp.owner.hotelqna;

public class HotelQna {
	private int rnum;
	private int qnaNum;
	private String qnaTitle;
	private String qnaContent;
	private int qnaParent;
	private String userId;
	private String hotelId;
	private String qnaCreated;
	private String userName;
	private int count;
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public String getQnaCreated() {
		return qnaCreated;
	}
	public void setQnaCreated(String qnaCreated) {
		this.qnaCreated = qnaCreated;
	}
	public int getQnaNum() {
		return qnaNum;
	}
	public void setQnaNum(int qnaNum) {
		this.qnaNum = qnaNum;
	}
	public String getQnaTitle() {
		return qnaTitle;
	}
	public void setQnaTitle(String qnaTitle) {
		this.qnaTitle = qnaTitle;
	}
	public String getQnaContent() {
		return qnaContent;
	}
	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}
	public int getQnaParent() {
		return qnaParent;
	}
	public void setQnaParent(int qnaParent) {
		this.qnaParent = qnaParent;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getHotelId() {
		return hotelId;
	}
	public void setHotelId(String hotelId) {
		this.hotelId = hotelId;
	}
		
}
