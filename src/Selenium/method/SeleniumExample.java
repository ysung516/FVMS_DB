package Selenium.method;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxProfile;

import jsp.Bean.model.*;
import jsp.DB.method.*;

public class SeleniumExample {

	// WebDriver 설정
	private WebDriver driver;
	private WebElement element;
	private String url;

	// Properties 설정
	public static String WEB_DRIVER_ID = "webdriver.gecko.driver";
	//public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
	
	//public static String WEB_DRIVER_PATH = "geckodriver";
	public static String WEB_DRIVER_PATH = "chromedriver";
	
	//public static String WEB_DRIVER_PATH = "C:\\Users\\User\\git\\FVMS_DB\\chromedriver.exe";
	public static String login_URL = "http://suresofttech.hanbiro.net/ngw/app/#/sign";
	
//	public static String coop_URL = "http://suresofttech.hanbiro.net/ngw/app/#/addrbook/list/0_196/";
	//public static String vt_URL = "http://suresofttech.hanbiro.net/ngw/app/#/addrbook/list/0_173/";	

	public SeleniumExample() {
		// System Property SetUp
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
		
		
	
		
		ChromeOptions options = new ChromeOptions();
		options.addArguments("headless");
		//options.addArguments("--window-size=1920x1080"); 
		//options.addArguments("--disable-gpu");
		/*
		options.addArguments("--no-sandbox");
		options.addArguments("--disable-dev-shm-usage");
		options.addArguments("--remote-debugging-port=9222");
		options.setBinary("google-chrome-stable_current_x86_64.rpm");
		
	
		
		// Driver SetUp
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--start-maximized"); // 전체화면으로 실행
		options.addArguments("--disable-popup-blocking"); // 팝업 무시
		options.addArguments("--disable-default-apps");
		options.setBinary("google-chrome-stable_current_amd64.deb");
		*/
		
		driver = new ChromeDriver(options);
	}

	public void login() {
		try {
			driver.get(login_URL);
			// 로그인 버튼 클릭
			// class로 찾아도 되지만, xpath(상대 or 절대)로 찾는게 나은 거 같습니다.
			Thread.sleep(5000);
			element = driver.findElement(By.xpath("//*[@id=\"log-userid\"]"));
			element.click();

			// 아이디 입력
			// id 값으로도 찾을 수 있습니다.
			// element = driver.findElement(By.id("id"));
			// 크롤링으로 text를 입력하면 굉장히 빠릅니다, 인식하지 못한 상태에서 이벤트를 발생시키면, 제대로 작동하지 않기 때문에 thread
			// sleep으로 기다려줍니다.
			Thread.sleep(500);
			element.sendKeys("fvms", Keys.TAB, "suresoft1!");
			// 유저 정보를 담은 객체에서 아이디값을 가져와서 넣어주면 되겠죠-

			Thread.sleep(500);
			// 전송
			element = driver.findElement(By.id("btn-log"));
			element.click();
			System.out.println(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// driver.close();
		}

	}
	
	public void loadPage(String URL) {
		String coop_URL = "http://suresofttech.hanbiro.net/ngw/app/#/addrbook/list/0_196/";
		String coop_btn = "//*[@id=\"ngw.addrbook.container.addrbook_0_196\"]/split-screen-view/list-view/div/div[2]/div/div[2]/div[2]/button";
		
	 	String vt_URL = "http://suresofttech.hanbiro.net/ngw/app/#/addrbook/list/0_173/";	
	 	String vt_btn = "//*[@id=\"ngw.addrbook.container.addrbook_0_173\"]/split-screen-view/list-view/div/div[2]/div/div[2]/div[2]/button";
	 	
	 	String R_URL="";
	 	String R_btn="";
	 	
	 	if(URL.equals("coop")) {
	 		R_URL = coop_URL;
	 		R_btn = coop_btn;
	 	} else if(URL.equals("vt")){
	 		R_URL = vt_URL;
	 		R_btn = vt_btn;
	 	}
	 	System.out.println(R_URL);
	
		try {
			Thread.sleep(3000);
			driver.get(R_URL);
			Thread.sleep(10000);

			if (driver.findElements(By.xpath("//button[@class='btn btn-xs btn-default no-border close-punch-btn']"))
					.size() != 0) {
				for (WebElement li : driver.findElements(
						By.xpath("//button[@class='btn btn-xs btn-default no-border close-punch-btn']"))) {
					li.click();
				}
			}
			Thread.sleep(500);
			element = driver.findElement(By.xpath("//label[@class='btn btn-xs btn-white btn-default']"));
			element.click();

			int x = driver.findElements(By.xpath(R_btn))
					.get(0).getLocation().getX();
			int y = driver.findElements(By.xpath(R_btn))
					.get(0).getLocation().getY();

			while (x != 0 && y != 0) {
				driver.findElements(By.xpath(R_btn)).get(0).click();
				Thread.sleep(5000);
				x = driver.findElements(By.xpath(R_btn)).get(0).getLocation().getX();
				y = driver.findElements(By.xpath(R_btn)).get(0).getLocation().getY();
			}
			System.out.println(2);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			driver.close();
		}

	}

	public HashMap<String, ArrayList<MemberBean>> crawldata() {
		login();
		loadPage("coop");
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		ArrayList<MemberBean> sucList = new ArrayList<MemberBean>();
		HashMap<String, ArrayList<MemberBean>> reList = new HashMap<String, ArrayList<MemberBean>>();
		HashMap<String, ArrayList<MemberBean>> falseList = new HashMap<String, ArrayList<MemberBean>>();
		falseList.put("false", list);
		
		MemberDAO memberDao = new MemberDAO();
		ArrayList<MemberBean> coopList = memberDao.getMember_coop();
		int result = 0;
		int count = 0;
		String id = "";
		String name = "";
		String part = "";
		String rank = "";
		String mobile = "";
		String gmail = "";

		try {
			Thread.sleep(3000);
			List<WebElement> emailList;
			List<WebElement> partList;
			List<WebElement> mobileList;
			List<WebElement> namerankList;

			namerankList = driver.findElements(By.xpath("//span[@class='org-name-info']//a[@class='dark']"));
			partList = driver.findElements(By.xpath("//span[@class='group item-hiding-group group-cps']"));
			mobileList = driver.findElements(By.xpath("//span[@class='tel item-hiding-tel tel-cps']")); // a[@class='text']//span[@class='hidden-xs']
			emailList = driver.findElements(By.xpath(
					"//span[@class='email item-hiding-email email-cps']//a[@class='text']//span[@class='hidden-xs']"));
			for (int i = 0; i < namerankList.size(); i++) {
				int cnt = 0;
				for (int a = 0; a < coopList.size(); a++) {
					if (coopList.get(a).getID().trim().equals(emailList.get(i).getText().split("@")[0].trim())) {
						MemberBean mem = new MemberBean();
						mem.setID(emailList.get(i).getText().split("@")[0]);
						mem.setPART(partList.get(i + 1).getText());
						mem.setNAME(namerankList.get(i).getText().split(" ")[0]);
						list.add(mem);
						cnt = 1;
						break;
					}
				}
				if (cnt == 0) {
					id = emailList.get(i).getText().split("@")[0];
					String pw = "12345";
					part = partList.get(i + 1).getText();
					String team = "미래차검증전략실";
					if (namerankList.get(i).getText().contains(" ")) {
						name = namerankList.get(i).getText().split(" ")[0];
						rank = namerankList.get(i).getText().split(" ")[1];
						if (!(rank.equals("전임") || rank.equals("선임") || rank.equals("책임") || rank.equals("수석"))) {
							rank = "-";
						}
					} else {
						name = namerankList.get(i).getText();
						rank = "-";
					}
					String position = "-";
					String permission = "3";
					mobile = mobileList.get(i).getText();
					gmail = emailList.get(i).getText();
					result = memberDao.insertMember(name, id, pw, part, team, rank, position, permission, mobile, gmail);
					count++;
					
					MemberBean mem = new MemberBean();
					mem.setID(emailList.get(i).getText().split("@")[0]);
					mem.setPART(partList.get(i + 1).getText());
					mem.setNAME(namerankList.get(i).getText().split(" ")[0]);
					sucList.add(mem);
				}
			}
			System.out.println(count);
			reList.put("suc", sucList);
			reList.put("fail", list);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			driver.close();
			return falseList;
		} finally {
			
		}

		return reList;
	}
	
	public HashMap<String, ArrayList<MemberBean>> vtdata() {
		loadPage("vt");
		ArrayList<MemberBean> list = new ArrayList<MemberBean>();
		ArrayList<MemberBean> sucList = new ArrayList<MemberBean>();
		HashMap<String, ArrayList<MemberBean>> reList = new HashMap<String, ArrayList<MemberBean>>();
		HashMap<String, ArrayList<MemberBean>> falseList = new HashMap<String, ArrayList<MemberBean>>();
		falseList.put("false", list);

		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy");
		int year = Integer.parseInt(sf.format(nowTime));
		MemberDAO memberDao = new MemberDAO();
		ArrayList<MemberBean> memList = memberDao.getMemberData(year);
		int result = 0;
		int count = 0;
		String id = "";
		String name = "";
		String team = "";
		String rank = "";
		String mobile = "";
		String gmail = "";

		try {
			Thread.sleep(3000);
			List<WebElement> emailList;
			List<WebElement> partList;
			List<WebElement> mobileList;
			List<WebElement> namerankList;

			namerankList = driver.findElements(By.xpath("//span[@class='org-name-info']//a[@class='dark']"));
			partList = driver.findElements(By.xpath("//span[@class='group item-hiding-group group-cps']"));
			mobileList = driver.findElements(By.xpath("//span[@class='tel item-hiding-tel tel-cps']")); // a[@class='text']//span[@class='hidden-xs']
			emailList = driver.findElements(By.xpath(
					"//span[@class='email item-hiding-email email-cps']//a[@class='text']//span[@class='hidden-xs']"));
			for (int i = 0; i < namerankList.size(); i++) {
				int cnt = 0;
				for (int a = 0; a < memList.size(); a++) {
					if (memList.get(a).getID().trim().equals(emailList.get(i).getText().split("@")[0].trim())) {
						MemberBean mem = new MemberBean();
						mem.setID(emailList.get(i).getText().split("@")[0]);
						mem.setPART(partList.get(i + 1).getText());
						mem.setNAME(namerankList.get(i).getText().split(" ")[0]);
						list.add(mem);
						cnt = 1;
						break;
					}
				}
				if (cnt == 0) {
					id = emailList.get(i).getText().split("@")[0];
					String pw = "12345";
					String part = "슈어소프트테크";
					team = partList.get(i + 1).getText();
					if (namerankList.get(i).getText().contains(" ")) {
						name = namerankList.get(i).getText().split(" ")[0];
						rank = namerankList.get(i).getText().split(" ")[1];
						if (!(rank.equals("전임") || rank.equals("선임") || rank.equals("책임") || rank.equals("수석"))) {
							rank = "-";
						}
					} else {
						name = namerankList.get(i).getText();
						rank = "-";
					}
					String position = "-";
					String permission = "2";
					mobile = mobileList.get(i).getText();
					gmail = emailList.get(i).getText();
					result = memberDao.insertMember(name, id, pw, part, team, rank, position, permission, mobile, gmail);
					count++;
					
					MemberBean mem = new MemberBean();
					mem.setID(emailList.get(i).getText().split("@")[0]);
					mem.setTEAM(partList.get(i + 1).getText());
					mem.setNAME(namerankList.get(i).getText().split(" ")[0]);
					sucList.add(mem);
				}
			}
			System.out.println(count);
			reList.put("suc", sucList);
			reList.put("fail", list);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			driver.close();
			return falseList;
		} finally {
			driver.close();
		}

		return reList;
	}
}