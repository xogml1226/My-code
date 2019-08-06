package com.sp.user.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {

	public void insertNotice(Notice dto) throws Exception;
	
	public int dataCount();
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	
	public Notice readNotice(int noticeNum);
	public Notice preReadNotice(int noticeNum);
	public Notice nextReadNotice(int noticeNum);
	
	public void updateNotice(Notice dto) throws Exception;
	public void deleteNotice(int noticeNum) throws Exception;
	
}
