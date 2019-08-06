package com.sp.owner.jungsanM;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("owner.jungsanM.jungsanMServiceImpl")
public class JungsanMServiceImpl implements JungsanMService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insert(Map<String, Object> map) throws Exception{
		try {
			dao.deleteData("owner.jungsanM.deleteJungsan",map);
			dao.updateData("owner.jungsanM.insertJungsan",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<JungsanM> select(Map<String, Object> map) {
		List<JungsanM> list = null;
		try {
			list =  dao.selectList("owner.jungsanM.selectJunsan", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<JungsanM> selectDay(Map<String, Object> map) {
		List<JungsanM> list = null;
		try {
			list =  dao.selectList("owner.jungsanM.selectDay", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
