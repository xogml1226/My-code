package com.sp.user.faq;

import java.util.List;
import java.util.Map;

public interface FaqService {
	
	public void insertFaq(Faq dto) throws Exception;

	public List<Faq> listFaq(Map<String, Object> map);
	public int dataCount();
	public Faq readFaq(int faqNum);
	
	public void updateFaq(Faq dto) throws Exception;
	public void deleteFaq(int faqNum) throws Exception;
}
