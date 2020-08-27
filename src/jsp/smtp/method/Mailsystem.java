package jsp.smtp.method;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;

public class Mailsystem {

	// TEXT만 보낼때
	public void sendEmail(String from, String to, String subject, String content) throws Exception {

		// Properties 설정
		// 프로퍼티 값 인스턴스 생성과 기본세션(SMTP 서버 호스트 지정)
		Properties props = new Properties();

		// G-Mail SMTP 사용시
		props.put("mail.transport.protocol", "smtp");// 프로토콜 설정
		props.put("mail.smtp.host", "smtp.cafe24.com");// SMTP 서비스 주소(호스트)
		props.put("mail.smtp.port", "587");// SMTP 서비스 포트 설정
		// 로그인 할때 Transport Layer Security(TLS)를 사용할 것인지 설정
		// gmail 에선 tls가 필수가 아니므로 해도 그만 안해도 그만
		props.put("mail.smtp.starttls.enable", "true");
		// gmail 인증용 Secure Socket Layer(SSL) 설정
		// gmail 에서 인증때 사용해주므로 요건 안해주면 안됨
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		// props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");// SMTP 인증을 설정

		/**
		 * SMTP 인증이 필요한 경우 반드시 Properties 에 SMTP 인증을 사용한다고 설정하여야 한다. 그렇지 않으면 인증을 시도조차 하지
		 * 않는다. 그리고 Authenticator 클래스를 상속받은 SMTPAuthenticator 클래스를 생성한다.
		 * getPasswordAuthentication() 메소드만 override 하면 된다. 머 사실 다른 메소드는 final 메소드여서
		 * override 할 수 조차 없다. -ㅅ-;
		 */
		Authenticator auth = new SMTPAuthenticator();
		Session mailSession = Session.getDefaultInstance(props, auth);

		// create a message
		Message msg = new MimeMessage(mailSession);

		// set the from and to address
		msg.setFrom(new InternetAddress(from));// 보내는 사람 설정
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));// 받는 사람설정

		// Setting the Subject and Content Type
		msg.setSubject(subject); // 제목 설정
		msg.setSentDate(new Date());// 보내는 날짜 설정
		msg.setText(content); // 내용 설정

		Transport.send(msg); // 메일 보내기
	}

	/**
	 * 한사람에게 메일을 발송한다. (첨부파일 포함.)
	 *
	 * @param mail_addr 송신주소
	 * @param name      송신자명
	 * @param title     제목
	 * @param contents  내용
	 * @param withFile  경로포함된 파일명(예:c:\temp\파일.xls)
	 * @throws UnsupportedEncodingException
	 */
	
	// 파일첨부
	public void sendMailWithFile(String mail_addr, String to, String title, String contents, String withFile) throws Exception{

		// Properties 설정
		// 프로퍼티 값 인스턴스 생성과 기본세션(SMTP 서버 호스트 지정)
		Properties props = new Properties();

		// G-Mail SMTP 사용시
		props.put("mail.transport.protocol", "smtp");// 프로토콜 설정
		props.put("mail.smtp.host", "smtp.cafe24.com");// SMTP 서비스 주소(호스트)
		props.put("mail.smtp.port", "587");// SMTP 서비스 포트 설정
		// 로그인 할때 Transport Layer Security(TLS)를 사용할 것인지 설정
		// gmail 에선 tls가 필수가 아니므로 해도 그만 안해도 그만
		props.put("mail.smtp.starttls.enable", "true");
		// gmail 인증용 Secure Socket Layer(SSL) 설정
		// gmail 에서 인증때 사용해주므로 요건 안해주면 안됨
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		// props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");// SMTP 인증을 설정

		/**
		 * SMTP 인증이 필요한 경우 반드시 Properties 에 SMTP 인증을 사용한다고 설정하여야 한다. 그렇지 않으면 인증을 시도조차 하지
		 * 않는다. 그리고 Authenticator 클래스를 상속받은 SMTPAuthenticator 클래스를 생성한다.
		 * getPasswordAuthentication() 메소드만 override 하면 된다. 머 사실 다른 메소드는 final 메소드여서
		 * override 할 수 조차 없다. -ㅅ-;
		 */
		SMTPAuthenticator auth = new SMTPAuthenticator();
		
		Session mailSession = Session.getDefaultInstance(props, auth);

		String attFile = java.net.URLDecoder.decode(withFile);

		// 받는 사람의 메일 주소를 설정합니다.
		InternetAddress address = new InternetAddress(to);

		// essage 클래스의 객체를 Session을 이용하여 생성합니다.
		// Message msg = new MimeMessage(session);
		MimeMessage msg = new MimeMessage(mailSession);
		msg.addHeader("Content-Transfer-Encoding", "base64"); // base64 처리

		msg.setRecipient(Message.RecipientType.TO, address);//보내는 사람
		
		// 보내는 사람의 이름과 메일주소를 설정합니다.
		// msg.setFrom(new InternetAddress(from, from));
		// msg.setFrom(new InternetAddress(new String(this.sendName.getBytes("euc-kr"),
		// "8859_1") + "<" + fromAddr + ">"));
		msg.setFrom(new InternetAddress(mail_addr, "FVMS 관리자"));	 //받는 사람
		// 제목을 설정합니다.
		// msg.setSubject(title);
		msg.setSubject(title, "utf-8");

		// Multipart 객체를 생성합니다.
		Multipart multiPart = new MimeMultipart();

		// 파일이 있을 경우를 생각해서 MimeBodyPart객체를 생성합니다.
		MimeBodyPart contentsBodyPart = new MimeBodyPart();
		// contentsBodyPart.setContent(contents, "text/html; charset=euc-kr");
		//contentsBodyPart.setContent(contents, "text/html; charset=utf-8");
		contentsBodyPart.setDataHandler(new DataHandler(new ByteArrayDataSource(contents, "text/html;charset=euc-kr")));

		multiPart.addBodyPart(contentsBodyPart);

		if (withFile.length() > 0) {
			MimeBodyPart fileBodyPart = new MimeBodyPart();
			FileDataSource fds = new FileDataSource(attFile);
			fileBodyPart.setDataHandler(new DataHandler(fds));
			// 한글파일일 경우를 생각해서 다시 KSC5601에서 8859_1로 변환시킵니다.
			fileBodyPart.setFileName(new String(fds.getName().getBytes("euc-kr"), "8859_1"));
			//mbp2.setFileName(MimeUtility.encodeText(fds.getName(), "euc-kr","B")); 
			multiPart.addBodyPart(fileBodyPart);
		}

		msg.setContent(multiPart);
		//msg.setDataHandler(new DataHandler(new ByteArrayDataSource(multiPark, "text/html;charset=euc-kr")));
		msg.setSentDate(new Date());

		// If the desired charset is known, you can use
		// setText(text, charset)

		// msg.setText(contents);

		Transport.send(msg);

	}
}
