package com.sp.customer.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("customer.inquiryService")
public class InquiryServiceImpl implements InquiryService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertInquiry(Inquiry dto, String mode) throws Exception {
		try {
			if(mode.equals("reply")) {
				// 문자 또는 이메일 답변처리
				
				dto.setType(1); // 답변
				dto.setState(1);
				dto.setPhoneRecv(0);
				dto.setPhone("");
				dto.setEmailRecv(0);
				dto.setEmail("");
				
				Map<String, Object> map=new HashMap<>();
				map.put("num", dto.getParent());
				map.put("state", "1");
				updateInquiryState(map);
			} else {
				dto.setType(0); // 질문
			}
			
			dao.insertData("inquiry.insertInquiry", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("inquiry.dataCount", map);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	@Override
	public List<Inquiry> listInquiry(Map<String, Object> map) {
		List<Inquiry> list=null;
		
		try {
			list=dao.selectList("inquiry.listInquiry", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Inquiry> relationInquiry(int num) {
		List<Inquiry> list=null;
		
		try {
			list=dao.selectList("inquiry.relationInquiry", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public void updateInquiryState(Map<String, Object> map) throws Exception {
		try{
			dao.updateData("inquiry.updateInquiryState", map);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Inquiry readInquiry(int num) {
		Inquiry dto=null;
		
		try{
			dto=dao.selectOne("inquiry.readInquiry", num);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateInquiry(Inquiry dto) throws Exception {
		try{
			dao.updateData("inquiry.updateInquiry", dto);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteInquiry(int num) throws Exception {
		try{
			dao.deleteData("inquiry.deleteInquiry", num);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
