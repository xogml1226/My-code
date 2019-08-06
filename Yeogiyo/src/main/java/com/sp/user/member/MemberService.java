package com.sp.user.member;

public interface MemberService {

	public Member readMember(String userId);
	
	public void insertMember(Member dto) throws Exception;
	
	public void updateMember(Member dto) throws Exception;
	public void deleteMember(String userId) throws Exception;
	

}
