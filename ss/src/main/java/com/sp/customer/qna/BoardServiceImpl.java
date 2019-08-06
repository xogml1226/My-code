package com.sp.customer.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("customer.qna.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertBoard(Board dto) throws Exception {
		try {
			dao.insertData("qna.insertBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("qna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		try {
			list=dao.selectList("qna.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Board readQuestion(int num) {
		Board dto=null;
		
		try{
			dto=dao.selectOne("qna.readQuestion", num);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Board readAnswer(int parent) {
		Board dto=null;
		
		try{
			dto=dao.selectOne("qna.readAnswer", parent);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public Board preReadQuestion(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.selectOne("qna.preReadQuestion", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@Override
	public Board nextReadQuestion(Map<String, Object> map) {
		Board dto=null;
		
		try{
			dto=dao.selectOne("qna.nextReadQuestion", map);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateBoard(Board dto) throws Exception {
		try{
			dao.updateData("qna.updateBoard", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteQuestion(int num) throws Exception {
		try{
			dao.deleteData("qna.deleteQuestion", num);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteAnswer(int num) throws Exception {
		try{
			dao.deleteData("qna.deleteAnswer", num);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertCategory(Board dto) throws Exception {
		try {
			dao.insertData("qna.insertCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateCategory(Board dto) throws Exception {
		try {
			dao.updateData("qna.updateCategory", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteCategory(int categoryNum) throws Exception {
		try {
			dao.deleteData("qna.deleteCategory", categoryNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Board> listCategory() {
		List<Board> list=null;
		
		try {
			list=dao.selectList("qna.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
