package com.sp.user.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	
	public void insertEvent(Event dto, String pathname) throws Exception;
	public void updateEventStatus(Map<String, Object> map) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Event> listEvent(Map<String,Object> map) throws Exception;
	public Event readEvent(int eventNum);
	public Event preReadEvent(Map<String, Object> map);
	public Event nextReadEvent(Map<String, Object> map);
	public void updateEvent(Event dto, String pathname) throws Exception;
	public void deleteEvent(int eventNum, String pathname) throws Exception;
	
	public void insertEventLike(Map<String, Object> map) throws Exception;
	public int eventLikeCount(int eventNum);
	
	public void insertEventReply(EventReply dto) throws Exception;
	public List<EventReply> listEventReply(Map<String, Object> map);
	public int eventReplyCount(int eventNum);
	public void deleteEventReply(Map<String, Object> map) throws Exception;
	
	public List<EventReply> listEventReplyAnswer(int eventreplyAnswer);
	public int eventReplyAnswerCount(int eventreplyAnswer);
}
