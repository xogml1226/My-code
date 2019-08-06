package com.sp.user.event;

import org.springframework.web.multipart.MultipartFile;

public class Event {

	private int eventNum;
	private String eventTitle, eventContent, eventPhoto;
	private String eventStart, eventEnd;
	private String eventCreated, eventStatus;
	private MultipartFile upload;
	
	private int eventLikeCount;
	
	public int getEventNum() {
		return eventNum;
	}
	public void setEventNum(int eventNum) {
		this.eventNum = eventNum;
	}
	public String getEventTitle() {
		return eventTitle;
	}
	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}
	public String getEventContent() {
		return eventContent;
	}
	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}
	public String getEventPhoto() {
		return eventPhoto;
	}
	public void setEventPhoto(String eventPhoto) {
		this.eventPhoto = eventPhoto;
	}
	public String getEventStart() {
		return eventStart;
	}
	public void setEventStart(String eventStart) {
		this.eventStart = eventStart;
	}
	public String getEventEnd() {
		return eventEnd;
	}
	public void setEventEnd(String eventEnd) {
		this.eventEnd = eventEnd;
	}
	public String getEventCreated() {
		return eventCreated;
	}
	public void setEventCreated(String eventCreated) {
		this.eventCreated = eventCreated;
	}
	public String getEventStatus() {
		return eventStatus;
	}
	public void setEventStatus(String eventStatus) {
		this.eventStatus = eventStatus;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public int getEventLikeCount() {
		return eventLikeCount;
	}
	public void setEventLikeCount(int eventLikeCount) {
		this.eventLikeCount = eventLikeCount;
	}
	
}
