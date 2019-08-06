package com.sp.user.review;

import java.util.List;
import java.util.Map;

public interface ReviewService {
	public void createReview(Map<String, Object> map) throws Exception;
	public Review beforeCreate(int reservationNum);
	
	public List<Review> reviewList(Map<String, Object> map);
	public int check(Map<String, Object> map);
	
	public int reviewCount(String userId);

	
	public Review reviewArticle(int reviewNum);
	
	public void deleteReview(int reviewNum) throws Exception;
	public void deleteReportReview(int reviewNum) throws Exception;
	public void updateReview(Review dto) throws Exception;
	
	
	public void report(Map<String, Object> map) throws Exception;
	
	// --------------------------------------------댓글
	
	public List<Review> ListReply(int reviewNum); 
	public void insertReply(Map<String, Object> map) throws Exception;
	public void deleteReply(int replyNum) throws Exception;
	public void deleteAllReply(int reviewNum) throws Exception;
}
