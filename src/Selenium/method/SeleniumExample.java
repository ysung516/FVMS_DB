package Selenium.method;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class SeleniumExample {
	
	//WebDriver 설정
	private WebDriver driver;
	private WebElement element;
	private String url;
	
	//Properties 설정
	public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static String WEB_DRIVER_PATH = "C:\\Users\\User\\git\\FVMS_DB\\chromedriver.exe";
	public static String TEST_URL = "http://suresofttech.hanbiro.net/ngw/app/#/sign";
	public static String URL = "http://suresofttech.hanbiro.net/ngw/app/#/addrbook/list/0_196/";
	
	public SeleniumExample() {
		//System Property SetUp
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
        
		//Driver SetUp
		ChromeOptions options = new ChromeOptions();
		options.addArguments("--start-maximized");            // 전체화면으로 실행
        options.addArguments("--disable-popup-blocking");    // 팝업 무시
        options.addArguments("--disable-default-apps");    
		driver = new ChromeDriver(options);        
	}
    
    public void login() {
       try {
            driver.get(TEST_URL);
            //로그인 버튼 클릭
            // class로 찾아도 되지만, xpath(상대 or 절대)로 찾는게 나은 거 같습니다.
            Thread.sleep(5000);
            element = driver.findElement(By.xpath("//*[@id=\"log-userid\"]"));
            element.click();

            //아이디 입력
            // id 값으로도 찾을 수 있습니다. 
            //element = driver.findElement(By.id("id"));
            // 크롤링으로 text를 입력하면 굉장히 빠릅니다, 인식하지 못한 상태에서 이벤트를 발생시키면, 제대로 작동하지 않기 때문에 thread sleep으로 기다려줍니다.
            Thread.sleep(500); 
            element.sendKeys("fvms",Keys.TAB,"suresoft1!");
            // 유저 정보를 담은 객체에서 아이디값을 가져와서 넣어주면 되겠죠-

            Thread.sleep(500); 
            //전송
            element = driver.findElement(By.id("btn-log"));
            element.click();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //driver.close();
        }

    }
    public void loadPage() {
    	try {
			Thread.sleep(3000);
			driver.get(URL);
			Thread.sleep(10000);
			int x = driver.findElements(By.xpath("//*[@id=\"ngw.addrbook.container.addrbook_0_196\"]/split-screen-view/list-view/div/div[2]/div/div[2]/div[2]/button"))
					.get(0).getLocation().getX();
			int y = driver.findElements(By.xpath("//*[@id=\"ngw.addrbook.container.addrbook_0_196\"]/split-screen-view/list-view/div/div[2]/div/div[2]/div[2]/button"))
					.get(0).getLocation().getY();
			
			while(x != 0 && y != 0) {
				driver.findElements(By.xpath("//*[@id=\"ngw.addrbook.container.addrbook_0_196\"]/split-screen-view/list-view/div/div[2]/div/div[2]/div[2]/button")).get(0).click();
				Thread.sleep(5000);
				x = driver.findElements(By.xpath("//*[@id=\"ngw.addrbook.container.addrbook_0_196\"]/split-screen-view/list-view/div/div[2]/div/div[2]/div[2]/button"))
						.get(0).getLocation().getX();
				y = driver.findElements(By.xpath("//*[@id=\"ngw.addrbook.container.addrbook_0_196\"]/split-screen-view/list-view/div/div[2]/div/div[2]/div[2]/button"))
						.get(0).getLocation().getY();
			}
			
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	   
    }
    public void crawldata() {
    	try {
			Thread.sleep(3000);
	    	List<WebElement> emailList;
	    	List<WebElement> partList;
	    	List<WebElement> mobileList;
	    	List<WebElement> namerankList;
	    	
	    	namerankList = driver.findElements(By.xpath("//span[@class='org-name-info']//a[@class='dark']"));
	        partList = driver.findElements(By.xpath("//span[@class='group item-hiding-group group-cps']"));
	        mobileList = driver.findElements(By.xpath("//span[@class='tel item-hiding-tel tel-cps']")); //a[@class='text']//span[@class='hidden-xs']
	        emailList = driver.findElements(By.xpath("//span[@class='email item-hiding-email email-cps']//a[@class='text']//span[@class='hidden-xs']"));
    
	       for(int i=0; i<namerankList.size(); i++) {
	           System.out.print(namerankList.get(i).getText());
	           System.out.print(" - ");
	           System.out.print(partList.get(i+1).getText());
	           System.out.print(" - ");
	           System.out.print(mobileList.get(i).getText());
	           System.out.print(" - ");
	           System.out.println(emailList.get(i).getText().split("@")[0]);
	          }
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
            driver.close();
        }

    
    }
}