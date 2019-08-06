package com.sp.user.qna;

import java.util.List;
import java.util.Map;

public interface QnaService {
	public void insertQna(Qna dto, String mode) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Qna> listQna(Map<String, Object> map);
	
	public Qna readQna(int qnaNum);
	public Qna preReadQna(Map<String, Object> map);
	public Qna nextReadQna(Map<String, Object> map);
	
	public void updateQna(Qna dto) throws Exception;
	public void deleteQna(int qnaNum, String userId) throws Exception;
	
	public List<Qna> listArticleQna(int qnaGroupNum);

}
