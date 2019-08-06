package com.sp.user.confirm;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.confirm.confirmService")
public class ConfirmServiceImpl implements ConfirmService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("user.confirm.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Confirm> listConfirm(Map<String, Object> map) {
		List<Confirm> list=null;
		try {
			list=dao.selectList("user.confirm.listConfirm", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Confirm readConfirm(int reservationNum) {
		Confirm dto=null;
		try {
			dto=dao.selectOne("user.confirm.readConfirm", reservationNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteReservation(int reservationNum) throws Exception {
		int resDetailNum=0;
		try {
			resDetailNum=dao.selectOne("user.confirm.resDetailNum", reservationNum);
			dao.deleteData("user.confirm.deleteReserdetail", resDetailNum);
			dao.deleteData("user.confirm.deletePay", reservationNum);
			dao.deleteData("user.confirm.deleteReseropt", reservationNum);
			dao.deleteData("user.confirm.deleteMemberreser", reservationNum);
			dao.deleteData("user.confirm.deleteReservation", reservationNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	@Override
	public int noMemberdataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("user.confirm.noMemberDataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Confirm> listNoMemberConfirm(Map<String, Object> map) {
		List<Confirm> list=null;
		try {
			list=dao.selectList("user.confirm.nomemberList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public Confirm readnoMemberConfirm(int reservationNum) {
		Confirm dto=null;
		try {
			dto=dao.selectOne("user.confirm.nomemberConfirm", reservationNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	
	

	

}
