package com.sp.chat;

import org.springframework.web.socket.WebSocketSession;

public class GuestInfo {
	private String nickName;
	private WebSocketSession session;
	private RoomInfo room;
	
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public WebSocketSession getSession() {
		return session;
	}
	public void setSession(WebSocketSession session) {
		this.session = session;
	}
	public RoomInfo getRoom() {
		return room;
	}
	public void setRoom(RoomInfo room) {
		this.room = room;
	}
}
