package com.sp.user.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.qna.qnaService")
public class QnaServiceImpl implements QnaService {
	@Autowired
	private CommonDAO dao;
	@Override
	public void insertQna(Qna dto, String mode) throws Exception {
		try {
			int qnaNum=dao.selectOne("user.qna.qnaSeq");
			if(mode.equals("created")) {
				dto.setQnaNum(qnaNum);
				dto.setQnaGroupNum(qnaNum);
				dto.setQnaDepth(0);
				dto.setQnaDepth(0);
				dto.setQnaOrderNo(0);
				dto.setQnaParent(0);
			} else {
				Map<String, Object> map=new HashMap<>();
				map.put("qnaGroupNum", dto.getQnaGroupNum());
				map.put("qnaOrderNo", dto.getQnaOrderNo());
				dao.updateData("user.qna.updateQnaOrderNo", map);
				
				dto.setQnaNum(qnaNum);
				dto.setQnaDepth(dto.getQnaDepth()+1);
				dto.setQnaOrderNo(dto.getQnaOrderNo()+1);
			}
			dao.insertData("user.qna.insertQna", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("user.qna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Qna> listQna(Map<String, Object> map) {
		List<Qna> list=null;
		try {
			list=dao.selectList("user.qna.listQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Qna readQna(int qnaNum) {
		Qna dto=null;
		try {
			dto=dao.selectOne("user.qna.readQna", qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Qna preReadQna(Map<String, Object> map) {
		Qna dto=null;
		try {
			dto=dao.selectOne("user.qna.preReadQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Qna nextReadQna(Map<String, Object> map) {
		Qna dto=null;
		try {
			dto=dao.selectOne("user.qna.nextReadQna", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateQna(Qna dto) throws Exception {
		try {
			dao.updateData("user.qna.updateQna", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteQna(int qnaNum, String userId) throws Exception {
		try {
			Qna dto=readQna(qnaNum);
			if(dto==null || (! userId.equals("admin") && (! userId.equals(dto.getUserId())))) {
				return;
			}
			dao.deleteData("user.qna.deleteQna", qnaNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Qna> listArticleQna(int qnaGroupNum) {
		List<Qna> list=null;
		try {
			list=dao.selectList("user.qna.listArticleQna", qnaGroupNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
