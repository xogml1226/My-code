package com.sp.user.mail;

import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("user.mail.mailSender")
public class MailSender {
	@Autowired
	private CommonDAO dao;
	
	public String readId(Mail dto) {
		String userId=null;
		try {
			userId=dao.selectOne("user.mail.readId", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
	}
	
	public String readPwd(Mail dto) {
		String userPwd=null;
		try {
			userPwd=dao.selectOne("user.mail.readPwd", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userPwd;
	}
	
	public String getRandomPwd() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
									'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
									'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
									'U', 'V', 'W', 'X', 'Y', 'Z' }; 
		int idx = 0; 
		StringBuffer sb = new StringBuffer(); 
		 
		for (int i = 0; i < 10; i++) { 
			idx = (int) (charSet.length * Math.random()); 
			sb.append(charSet[idx]);  
		}

		return sb.toString();		
							
	}
	
	public void updatePwd(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("user.mail.updatePwd", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	private String mailType; // 메일 타입
	private String encType;
	
	public MailSender() {
		this.encType = "utf-8";
		// this.encType = "euc-kr";
		this.mailType = "text/html; charset=utf-8";
		// this.mailType = "text/html; charset=euc-kr";
		// this.mailType = "text/plain; charset=utf-8";
	}

	public void setMailType(String mailType, String encType) {
		this.mailType = mailType;
		this.encType = encType;
	}
	
	// 네이버를 이용하여 메일을 보내는 경우 보내는사람의 이메일이 아래 계정(SMTP 권한 계정)과 다르면 메일 전송이 안된다. 
	// gmail은 기본적으로 <a href ...> 태그가 있으면 href를 제거한다.
	// SMTP 권한
	private class SMTPAuthenticator extends javax.mail.Authenticator {
	  
		@Override
		public PasswordAuthentication getPasswordAuthentication() {  
		// 지메일은 경고메시지 전송 - 전송받은 메일에서 보안 수준을 낮추는 링크를 클릭하고 수준을 낮추면 메일 전송가능
		// gmail : 내계정 - 로그인 및 보안 => 아래부분 보안수준이 낮은 앱 사용  허용으로 변경
		// 네이버 : 메일 아래부분 환경설정 클릭후 POP3등을 허용
    	  
        String username =  "xogml1226@naver.com"; // 네이버 사용자;
        // String username =  "지메일아이디"; // gmail 사용자;  
        String password = "java$!java$!"; // 패스워드;  
        return new PasswordAuthentication(username, password);  
        }  
	}
	
	public boolean mailSend(Mail dto) {
		boolean b=false;
		
		Properties p = new Properties();   
  
		// SMTP 서버의 계정 설정   
		// Naver와 연결할 경우 네이버 아이디
		// Gmail과 연결할 경우 Gmail 아이디
		p.put("mail.smtp.user", dto.getUserEmail());   
  
		// SMTP 서버 정보 설정   
		p.put("mail.smtp.host", "smtp.naver.com"); // 네이버   
		// p.put("mail.smtp.host", "smtp.gmail.com"); // gmail
		       
		// 네이버와 지메일 동일   
		p.put("mail.smtp.port", "465");   
		p.put("mail.smtp.starttls.enable", "true");   
		p.put("mail.smtp.auth", "true");   
		// p.put("mail.smtp.debug", "true");   
		p.put("mail.smtp.socketFactory.port", "465");   
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		p.put("mail.smtp.socketFactory.fallback", "false");  
		
		try {
			Authenticator auth = new SMTPAuthenticator();  
			Session session = Session.getDefaultInstance(p, auth);
			// 메일 전송시 상세 정보 콘솔에 출력 여부
			session.setDebug(true);
			
			Message msg = new MimeMessage(session);

			// 보내는 사람
			msg.setFrom(new InternetAddress(dto.getSenderEmail(), dto.getSenderName(), encType));
			
			// 받는 사람
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(dto.getUserEmail()));
			
			// 제목
			msg.setSubject(dto.getSubject());
			// 내용
			msg.setText(dto.getContent());
			msg.setHeader("Content-Type", mailType);
			msg.setHeader("X-Mailer", dto.getSenderName());
			
			// 메일 보낸 날짜
			msg.setSentDate(new Date());
			
			// 메일 전송
			Transport.send(msg);

			
			
			b=true;
						
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return b;
	}
		
		
}
