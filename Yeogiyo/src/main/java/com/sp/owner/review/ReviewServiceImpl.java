package com.sp.owner.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("owner.review.reviewService")
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Review> listReview(Map<String, Object> map) {
		List<Review> list = null;
		try {
			list = dao.selectList("owner.review.selectReview", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("owner.review.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReport(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("owner.review.insertReport", map);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public List<Reply> replyList(int reviewNum) {
		List<Reply> list = null;
		try {
			list = dao.selectList("owner.review.selectReply",reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Review reviewOne(int reviewNum) {
		Review dto = null;
		try {
			dto = dao.selectOne("owner.review.selectReviewOne",reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dto.setReplyNum(dao.selectOne("owner.review.seq"));
			dao.insertData("owner.review.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteReply(int replyNum) throws Exception {
		try {
			dao.deleteData("owner.review.deleteReply", replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateReply(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("owner.review.updateReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
