package jsp.DB.method;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator{
	protected PasswordAuthentication getPasswordAuthentication() {
		String username = "fvms@dsc05157.cafe24.com"; // gmail 사용자;
		String password = "suresoft1!"; // 패스워드;
		return new PasswordAuthentication(username, password);
	}

}
