package com.sp.owner.review;

import java.util.List;
import java.util.Map;

public interface ReviewService {
	public List<Review> listReview(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public void insertReport(Map<String, Object> map) throws Exception;
	public List<Reply> replyList(int reviewNum);
	public Review reviewOne(int reviewNum);
	public void insertReply(Reply dto) throws Exception;
	public void deleteReply(int replyNum) throws Exception;
	public void updateReply(Map<String, Object> map) throws Exception;
}
