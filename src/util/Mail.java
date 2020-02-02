package util;

import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail {
	
	public static boolean sendMail(String text, String title, List<String> email){
		boolean bRet = false;
		try{
			String host = "smtp.naver.com";
			// ���� ���̵� ���
			final String username = "proxschool";
			final String password = "idesign1101";
			int port=465;
			
			// ���Ⱑ ���� ���� �����ؼ� ����Ʈȭ ��Ų��.
			InternetAddress[] toAddr = new InternetAddress[email.size()];
			for(int i=0; i<email.size(); i++){
				toAddr[i] = new InternetAddress(email.get(i));
			}
			
			String subject = title;
			String body = text;
			
			Properties props = System.getProperties();
			
			props.put("mail.smtp.user", "proschool");
			props.put("mail.smtp.host", host);
			props.put("mail.smtp.port", port);
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.debug", "true");
			props.put("mail.smtp.ssl.enable", "true");
			props.put("mail.smtp.ssl.trust", host);
			
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator(){
				String un=username;
				String pw=password;
				
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(un, pw);
				}
			});
			session.setDebug(true);
			
			Message mimeMessage = new MimeMessage(session);
			mimeMessage.setFrom(new InternetAddress("proxschool@naver.com", "proxschool"));
			mimeMessage.setRecipients(Message.RecipientType.TO, toAddr);
			mimeMessage.setSubject(subject);
			mimeMessage.setContent(body, "text/html;charset=utf-8");
			Transport.send(mimeMessage);
			
			bRet = true;
			System.out.println("메일 발송에 성공하였습니다.");
		}catch(Exception e){
			System.out.println("메일 발송에 실패하였습니다.");
			System.out.println(e);
			bRet = false;
			
		}
		
		return bRet;
	}
}
