package com.sp.user.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.member.memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private CommonDAO dao;

	@Override
	public Member readMember(String userId) {
		Member dto=null;
		try {
			dto=dao.selectOne("user.member.readMember", userId);
			if(dto!=null) {
				
				if(dto.getUserEmail()!=null) {
					String [] e=dto.getUserEmail().split("@");
					dto.setEmail1(e[0]);
					dto.setEmail2(e[1]);
				}
			
				if(dto.getUserTel()!=null) {
					String [] t=dto.getUserTel().split("-");
					dto.setTel1(t[0]);
					dto.setTel2(t[1]);
					dto.setTel3(t[2]);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {
		try {
			if(dto.getEmail1()!=null && dto.getEmail1().length()!=0 &&
					dto.getEmail2()!=null && dto.getEmail2().length()!=0)
				dto.setUserEmail(dto.getEmail1()+"@"+dto.getEmail2());
			
			if(dto.getTel1()!=null && dto.getTel1().length()!=0 &&
					dto.getTel2()!=null && dto.getTel2().length()!=0 &&
					dto.getTel3()!=null && dto.getTel3().length()!=0)
				dto.setUserTel(dto.getTel1()+"-"+dto.getTel2()+"-"+dto.getTel3());
			dto.setEnabled(1);
			dto.setAuthority("ROLE_USER");
			dao.insertData("user.member.insertMember", dto);
			dao.insertData("user.member.insertAuthority", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void updateMember(Member dto) throws Exception {
		try {
			if(dto.getEmail1()!=null && dto.getEmail1().length()!=0 &&
					dto.getEmail2()!=null && dto.getEmail2().length()!=0)
				dto.setUserEmail(dto.getEmail1()+"@"+dto.getEmail2());
			
			if(dto.getTel1()!=null && dto.getTel1().length()!=0 &&
					dto.getTel2()!=null && dto.getTel2().length()!=0 &&
					dto.getTel3()!=null && dto.getTel3().length()!=0)
				dto.setUserTel(dto.getTel1()+"-"+dto.getTel2()+"-"+dto.getTel3());
			
			dao.updateData("user.member.updateMember", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteMember(String userId) throws Exception {
		try {
			dao.deleteData("user.member.deleteMember", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}


	
}
