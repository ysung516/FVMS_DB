package jsp.smtp.method;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.MessagingException;

public class PostMan {
	
	Date date = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	String backupDate = sf.format(date);
	final String from = "fvms@dsc05157.cafe24.com"; // 메일 보내는 사람
	final String to = "ymyou@suresofttech.com";	// 메일 받는 사람
	//final String to = "ysung516@gmail.com"; 
	//String to = "shinhaelim@gmail.com"; 
	
	public void post() {
		String subject = backupDate+"주간보고서 백업 파일 입니다.";// 제목
		String content = "안녕하세요. 반갑습니다.\n G-Mail을 이용한 메일 발송 입니다.\n 감사합니다.";// 내용

		if (from.trim().equals("")) {
			System.out.println("보내는 사람을 입력하지 않았습니다.");
		} else if (to.trim().equals("")) {
			System.out.println("받는 사람을 입력하지 않았습니다.");
		} else {
			try {
				Mailsystem mt = new Mailsystem();

				// 메일보내기
				//mt.sendEmail(from, to, cc, subject, content);
				mt.sendMailWithFile(from, to, subject, content, "Report-export.xlsx");
				//mt.sendMailWithFile(from, to, subject, content, "C:\\Users\\User\\git\\FVMS_DB\\Report-export.xlsx");
				System.out.println("메일 전송에 성공하였습니다.");
			} catch (MessagingException me) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("1.실패 이유 : " + me.getMessage());
			} catch (Exception e) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("2.실패 이유 : " + e.getMessage());
			}
		}
	}
	
	
	public void post2(){	
		String subject = backupDate+"회의록 파일 입니다.";// 제목
		String content = "안녕하세요. 반갑습니다.\n G-Mail을 이용한 메일 발송 입니다.\n 감사합니다.";// 내용

		if (from.trim().equals("")) {
			System.out.println("보내는 사람을 입력하지 않았습니다.");
		} else if (to.trim().equals("")) {
			System.out.println("받는 사람을 입력하지 않았습니다.");
		} else {
			try {
				Mailsystem mt = new Mailsystem();

				// 메일보내기
				//mt.sendEmail(from, to, cc, subject, content);
				mt.sendMailWithFile(from, to, subject, content, "MeetingLog-export.xlsx");
				System.out.println("메일 전송에 성공하였습니다.");
			} catch (MessagingException me) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("1.실패 이유 : " + me.getMessage());
			} catch (Exception e) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("2.실패 이유 : " + e.getMessage());
			}
		}
	}
	
	public void textPost(String  text){	
		String subject = backupDate+"회의록 입니다.";// 제목
		String content = ""; 
				content = text;

		if (from.trim().equals("")) {
			System.out.println("보내는 사람을 입력하지 않았습니다.");
		} else if (to.trim().equals("")) {
			System.out.println("받는 사람을 입력하지 않았습니다.");
		} else {
			try {
				Mailsystem mt = new Mailsystem();
				// 메일보내기
				mt.sendEmail(from, to, subject, content);
			
				System.out.println("메일 전송에 성공하였습니다.");
			} catch (MessagingException me) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("1.실패 이유 : " + me.getMessage());
			} catch (Exception e) {
				System.out.println("메일 전송에 실패하였습니다.");
				System.out.println("2.실패 이유 : " + e.getMessage());
			}
		}
	}

}
