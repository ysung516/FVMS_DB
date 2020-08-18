package jsp.smtp.method;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator{
	protected PasswordAuthentication getPasswordAuthentication() {
		final String username = "fvms@dsc05157.cafe24.com"; // gmail 사용자;
		final String password = "suresoft1!"; // 패스워드;
		return new PasswordAuthentication(username, password);
	}

}
