package com.sp.user.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.notice.noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertNotice(Notice dto) throws Exception {
		try {
			int noticeseq=dao.selectOne("user.notice.noticeseq");
			dto.setNoticeNum(noticeseq);
			
			dao.insertData("user.notice.insertNotice", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount() {
		int result=0;
		try {
			result=dao.selectOne("user.notice.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list=null;
		try {
			list=dao.selectList("user.notice.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Notice> listNoticeTop() {
		List<Notice> list=null;
		try {
			list=dao.selectList("user.notice.listNoticeTop");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Notice readNotice(int noticeNum) {
		Notice dto=null;
		try {
			dto=dao.selectOne("user.notice.readNotice", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Notice preReadNotice(int noticeNum) {
		Notice dto=null;
		try {
			dto=dao.selectOne("user.notice.preReadNotice", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Notice nextReadNotice(int noticeNum) {
		Notice dto=null;
		try {
			dto=dao.selectOne("user.notice.nextReadNotice", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateNotice(Notice dto) throws Exception {
		try {
			dao.updateData("user.notice.updateNotice", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteNotice(int noticeNum) throws Exception {
		try {
			dao.deleteData("user.notice.deleteNotice", noticeNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	

}
