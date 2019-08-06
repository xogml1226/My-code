package com.sp.owner.jungsanD;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("owner.jungsanD.jungsanDServiceImpl")
public class JungsanDServiceImpl implements JungsanDService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insert(Map<String, Object> map) throws Exception{
		try {
			dao.deleteData("owner.jungsanD.deleteJungsan",map);
			dao.updateData("owner.jungsanD.insertJungsan",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<JungsanD> select(Map<String, Object> map) {
		List<JungsanD> list = null;
		try {
			list =  dao.selectList("owner.jungsanD.selectJunsan", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<JungsanD> selectDay(Map<String, Object> map) {
		List<JungsanD> list = null;
		try {
			list =  dao.selectList("owner.jungsanD.selectDay", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
