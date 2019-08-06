package com.sp.customer.inquiry;

import java.util.List;
import java.util.Map;

public interface InquiryService {
	public void insertInquiry(Inquiry dto, String mode) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Inquiry> listInquiry(Map<String, Object> map);
	
	public List<Inquiry> relationInquiry(int num);
	public Inquiry readInquiry(int num);
	
	public void updateInquiryState(Map<String, Object> map) throws Exception;
	public void updateInquiry(Inquiry dto) throws Exception;
	public void deleteInquiry(int num) throws Exception;
}
