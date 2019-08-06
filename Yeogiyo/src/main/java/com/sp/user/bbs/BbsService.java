package com.sp.user.bbs;

import java.util.List;
import java.util.Map;

public interface BbsService {
	public void insertBbs(Bbs dto) throws Exception;
	public List<Bbs> listBbs(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Bbs readBbs(int num);
	
	public void updateHitCount(int num) throws Exception;
	public Bbs preReadBbs(Map<String, Object> map);
	public Bbs nextReadBbs(Map<String, Object> map);
	public void updataBbs(Bbs dto) throws Exception;
	public void deleteBbs(int num) throws Exception;
	
	public void insertBbsLike(Map<String, Object> map) throws Exception;
	public int bbsLikeCount(int num);
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(int num);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public int replyLikeCount(int replyNum);
}
