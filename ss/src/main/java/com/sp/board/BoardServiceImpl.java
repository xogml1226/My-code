package com.sp.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("board.boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertBoard(Board dto, String mode) throws Exception {
		try {
			
			int seq=dao.selectOne("board.seq");
			
			if(mode.equals("created")) { // 새글등록시
				dto.setBoardNum(seq);
				dto.setGroupNum(seq);
				dto.setDepth(0);
				dto.setOrderNo(0);
				dto.setParent(0);
			} else { // 답글 등록시
				// orderNo 변경
				Map<String, Object> map = new HashMap<>();
				map.put("groupNum", dto.getGroupNum());
				map.put("orderNo", dto.getOrderNo());
				dao.updateData("board.updateOrderNo", map);
				
				dto.setBoardNum(seq);
				dto.setDepth(dto.getDepth()+1);
				dto.setOrderNo(dto.getOrderNo()+1);
			}
			
			dao.insertData("board.insertBoard", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("board.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list=null;
		
		try {
			list=dao.selectList("board.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateHitCount(int boardNum) throws Exception {
		try {
			dao.updateData("board.updateHitCount", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Board readBoard(int boardNum) {
		Board dto=null;
		try {
			dto=dao.selectOne("board.readBoard", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto=null;
		try {
			dto=dao.selectOne("board.preReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto=null;
		try {
			dto=dao.selectOne("board.nextReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateBoard(Board dto) throws Exception {
		try {
			dao.updateData("board.updateBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteBoard(int boardNum, String userId) throws Exception {
		try {
			Board dto=readBoard(boardNum);
			if(dto==null || (! userId.equals("admin") && ! userId.equals(dto.getUserId())))
				return;
			
			dao.deleteData("board.deleteBoard", boardNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Board> listArticleBoard(int groupNum) {
		List<Board> list=null;
		
		try {
			list=dao.selectList("board.listArticleBoard", groupNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
