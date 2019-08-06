package com.sp.board;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public void insertBoard(Board dto, String mode) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Board> listBoard(Map<String, Object> map);
	
	public void updateHitCount(int boardNum) throws Exception;
	public Board readBoard(int boardNum);
	public Board preReadBoard(Map<String, Object> map);
	public Board nextReadBoard(Map<String, Object> map);
	
	public void updateBoard(Board dto) throws Exception;
	public void deleteBoard(int boardNum, String userId) throws Exception;
	
	public List<Board> listArticleBoard(int groupNum);
}
