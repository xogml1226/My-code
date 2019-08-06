package com.sp.user.faq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.faq.faqService")
public class FaqServiceImpl implements FaqService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertFaq(Faq dto) throws Exception {
		try {
			int faqseq=dao.selectOne("user.faq.faqseq");
			dto.setFaqNum(faqseq);
			dto.setFaqContent(dto.getFaqContent().replaceAll("\n", "<br>"));
			dao.insertData("user.faq.insertFaq", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Faq> listFaq(Map<String, Object> map) {
		List<Faq> list=null;
		try {
			list=dao.selectList("user.faq.listFaq", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Faq readFaq(int faqNum) {
		Faq dto=null;
		try {
			dto=dao.selectOne("user.faq.readFaq", faqNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateFaq(Faq dto) throws Exception {
		try {
			dao.updateData("user.faq.updateFaq", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteFaq(int faqNum) throws Exception {
		try {
			dao.deleteData("user.faq.deleteFaq", faqNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount() {
		int result=0;
		try {
			result=dao.selectOne("user.faq.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
