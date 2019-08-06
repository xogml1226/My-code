package com.sp.admin.report;

public class Report {
	
	public int listNum, reviewNum;
	public String hotelId, hotelName, userId;
	public String reportContent;
	public String reviewTitle, reviewContent;
	public String reviewCreated;
	public int resDetailNum;
	public int score;
	
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getReviewCreated() {
		return reviewCreated;
	}
	public void setReviewCreated(String reviewCreated) {
		this.reviewCreated = reviewCreated;
	}
	public int getResDetailNum() {
		return resDetailNum;
	}
	public void setResDetailNum(int resDetailNum) {
		this.resDetailNum = resDetailNum;
	}
	
	
}
