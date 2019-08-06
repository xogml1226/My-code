package com.sp.customer.qna;

public class Board {
	private int listNum, num;

	private int questionPrivate;
	private String subject;
	private String content;
	private String userId, userName;
	private String created;
	private Integer parent;
	private int isAnswer;
	
	private int categoryNum;
	private String category;
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getQuestionPrivate() {
		return questionPrivate;
	}
	public void setQuestionPrivate(int questionPrivate) {
		this.questionPrivate = questionPrivate;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public Integer getParent() {
		return parent;
	}
	public void setParent(Integer parent) {
		this.parent = parent;
	}
	public int getIsAnswer() {
		return isAnswer;
	}
	public void setIsAnswer(int isAnswer) {
		this.isAnswer = isAnswer;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
}
