package com.sp.user.event;

public class EventReply {

	private int eventreplyNum, eventNum;
	private String userId;
	private String eventreplyContent, eventreplyCreated;
	private int eventreplyAnswer, eventreplyAnswerCount;
	
	public int getEventreplyNum() {
		return eventreplyNum;
	}
	public void setEventreplyNum(int eventreplyNum) {
		this.eventreplyNum = eventreplyNum;
	}
	public int getEventNum() {
		return eventNum;
	}
	public void setEventNum(int eventNum) {
		this.eventNum = eventNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEventreplyContent() {
		return eventreplyContent;
	}
	public void setEventreplyContent(String eventreplyContent) {
		this.eventreplyContent = eventreplyContent;
	}
	public String getEventreplyCreated() {
		return eventreplyCreated;
	}
	public void setEventreplyCreated(String eventreplyCreated) {
		this.eventreplyCreated = eventreplyCreated;
	}
	public int getEventreplyAnswer() {
		return eventreplyAnswer;
	}
	public void setEventreplyAnswer(int eventreplyAnswer) {
		this.eventreplyAnswer = eventreplyAnswer;
	}
	public int getEventreplyAnswerCount() {
		return eventreplyAnswerCount;
	}
	public void setEventreplyAnswerCount(int eventreplyAnswerCount) {
		this.eventreplyAnswerCount = eventreplyAnswerCount;
	}
	
	
}
