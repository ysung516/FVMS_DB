

import Selenium.method.SeleniumExample;
public class maintest {

		
	public static void main(String[] args) {
		 //TODO Auto-generated method stub
//		String mainURL = "http://suresofttech.hanbiro.net/ngw/app/#/sign";
//		String connectURL = "http://suresofttech.hanbiro.net/ngw/sign/auth"; 
//		String URL = "http://suresofttech.hanbiro.net/ngw/app/#/addrbook/list/0_196/";
		
		SeleniumExample test = new SeleniumExample(); 
		test.login();
		test.loadPage();
		test.crawldata();
		}

    
	}
	



