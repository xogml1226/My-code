package com.sp.user.event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.FileManager;
import com.sp.common.dao.CommonDAO;

@Service("user.event.eventController")
public class EventServiceImpl implements EventService {

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertEvent(Event dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setEventPhoto(saveFilename);
				dao.insertData("user.event.insertEvent", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public void updateEventStatus(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("user.event.updateEventStatus", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("user.event.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) throws Exception {
		List<Event> list=null;
		try {
			list=dao.selectList("user.event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Event readEvent(int eventNum) {
		Event dto=null;
		try {
			dto=dao.selectOne("user.event.readEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Event preReadEvent(Map<String, Object> map) {
		Event dto=null;
		try {
			dto=dao.selectOne("user.event.preReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Event nextReadEvent(Map<String, Object> map) {
		Event dto=null;
		try {
			dto=dao.selectOne("user.event.nextReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateEvent(Event dto, String pathname) throws Exception {
		try {
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			
			if(saveFilename!=null) {
				if(dto.getEventPhoto().length()!=0) {
					fileManager.doFileDelete(dto.getEventPhoto(), pathname);
				}
				dto.setEventPhoto(saveFilename);
			}
			dao.updateData("user.event.updateEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteEvent(int eventNum, String pathname) throws Exception {
		try {
			Event dto=readEvent(eventNum);
			if(dto==null) {
				return;
			}
			
			if(dto.getEventPhoto()!=null) {
				fileManager.doFileDelete(dto.getEventPhoto(), pathname);
			}
			dao.deleteData("user.event.deleteEvent", eventNum);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertEventLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("user.event.insertEventLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int eventLikeCount(int eventNum) {
		int result=0;
		try {
			result=dao.selectOne("user.event.eventLikeCount", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertEventReply(EventReply dto) throws Exception {
		try {
			dao.insertData("user.event.insertEventReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<EventReply> listEventReply(Map<String, Object> map) {
		List<EventReply> list=null;
		try {
			list=dao.selectList("user.event.listEventReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int eventReplyCount(int eventNum) {
		int result=0;
		try {
			result=dao.selectOne("user.event.eventReplyCount", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteEventReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("user.event.deleteEventReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<EventReply> listEventReplyAnswer(int eventreplyAnswer) {
		List<EventReply> list=null;
		try {
			list=dao.selectList("user.event.listEventReplyAnswer", eventreplyAnswer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int eventReplyAnswerCount(int eventreplyAnswer) {
		int result=0;
		try {
			result=dao.selectOne("user.event.eventReplyAnswerCount", eventreplyAnswer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
