package com.sp.customer.qna;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public void insertBoard(Board dto) throws Exception;
	public int dataCount(Map<String, Object> map);
	
	public List<Board> listBoard(Map<String, Object> map);
	
	public Board readQuestion(int num);
	public Board readAnswer(int parent);
	
	public Board preReadQuestion(Map<String, Object> map);
	public Board nextReadQuestion(Map<String, Object> map);
	
	public void updateBoard(Board dto) throws Exception;
	
	public void deleteQuestion(int num) throws Exception;
	public void deleteAnswer(int num) throws Exception;
	
	public void insertCategory(Board dto) throws Exception;
	public void updateCategory(Board dto) throws Exception;
	public void deleteCategory(int categoryNum) throws Exception;
	public List<Board> listCategory();
}
