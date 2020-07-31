package jsp.sheet.method;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.security.GeneralSecurityException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import jsp.Bean.model.*;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.gdata.client.spreadsheet.SpreadsheetService;
import com.google.gdata.data.PlainTextConstruct;
import com.google.gdata.data.TextConstruct;
import com.google.gdata.data.sites.CreationActivityEntry;
import com.google.gdata.data.spreadsheet.ListEntry;
import com.google.gdata.data.spreadsheet.ListFeed;
import com.google.gdata.data.spreadsheet.SpreadsheetEntry;
import com.google.gdata.data.spreadsheet.SpreadsheetFeed;
import com.google.gdata.data.spreadsheet.WorksheetEntry;
import com.google.gdata.data.spreadsheet.WorksheetFeed;
import com.google.gdata.model.gd.CreateId;
import com.google.gdata.util.ServiceException;

public class backUp_sheetMethod {

	sheetMethod method = new  sheetMethod();
	backUpBean bcSheet = new backUpBean();
	
	public backUp_sheetMethod() {
	}
	// 연결
	public void connect() throws GeneralSecurityException, IOException, ServiceException {
		SpreadsheetService service;
		ClassLoader classloader = Thread.currentThread().getContextClassLoader();
		URL url = classloader.getResource("service.p12");
		final File file = new File(url.getFile());

		HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
		JsonFactory JSON_FACTORY = new JacksonFactory();

		Credential credential = new GoogleCredential.Builder().setTransport(HTTP_TRANSPORT).setJsonFactory(JSON_FACTORY)
				.setServiceAccountId("ymyou-1@e-tensor-282602.iam.gserviceaccount.com") // 서비스 계정 생성 당시의 정보
				.setTokenServerEncodedUrl("https://accounts.google.com/o/oauth2/token")
				.setServiceAccountScopes(Arrays.asList("https://www.googleapis.com/auth/drive",
						"https://spreadsheets.google.com/feeds", "https://docs.google.com/feeds"))
				.setServiceAccountPrivateKeyFromP12File(file).build();

		// 버전이 v1부터 v3까지 있었는데 사실 그 차이에대해선 아직 알아보지못했다
		service = new SpreadsheetService("MySpreadsheetIntegration-v1");
		service.setOAuth2Credentials(credential); // 이거 하려고 위에 저렇게 코딩 한거다. 이게 인증의 핵심
		bcSheet.setService(service);
	}
	
	// 백업 시트 불러오기
	public void backUpaccess() throws GeneralSecurityException, IOException, ServiceException {
		SpreadsheetService service = bcSheet.getService();
		List<SpreadsheetEntry> spreadsheets;
		SpreadsheetFeed feed = service.getFeed(
				new URL("https://spreadsheets.google.com/feeds/spreadsheets/private/full"), SpreadsheetFeed.class);
		spreadsheets = feed.getEntries();

		bcSheet.setSpreadsheets(spreadsheets);
		bcSheet.setFeed(feed);
		SpreadsheetEntry entry;
		for (int i = 0; i < bcSheet.getSpreadsheets().size(); i++) {
			entry = bcSheet.getSpreadsheets().get(i);	// 접근가능 모든파일중 filename찾기
			
			if (entry.getTitle().getPlainText().equals(bcSheet.getFileName())) {	//filename 일치 확인
				bcSheet.setEntry(entry);	// suresoft-pms파일 저장
				break;
			}
		}
		List<WorksheetEntry> worksheets = bcSheet.getEntry().getWorksheets(); // 시트 타이틀
		bcSheet.setWorksheets(worksheets);	// 시트타이틀 저장
	}
	
	// WorkSheet 찾기
	public void findSheet(String sheetName) {
		for (int k = 0; k < bcSheet.getWorksheets().size(); k++) {
    		WorksheetEntry worksheet = bcSheet.getWorksheets().get(k);
    		if (worksheet.getTitle().getPlainText().equals(sheetName)) {
    			bcSheet.setWorksheet(worksheet);
    			break;
    		}
    		
    	}
	}
	
	
	
public void insertSheet () throws GeneralSecurityException, IOException, ServiceException{
		connect();
		backUpaccess();
		SpreadsheetEntry entry = bcSheet.getEntry();
		SpreadsheetService service = bcSheet.getService();
		
		SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd");
		Date currentTime = new Date();
		String dTime = formatter.format (currentTime);
		WorksheetEntry me = method.backUpEntry();
		ListFeed MlistFeed = method.backUpEntry2();
		
		// 타이틀 만들기
		URL workFeedUrl = entry.getWorksheetFeedUrl();
	      WorksheetEntry e = new WorksheetEntry(me);
	      WorksheetFeed workFeed = service.getFeed(workFeedUrl, WorksheetFeed.class);
	      TextConstruct con = new PlainTextConstruct(dTime);
	      e.setTitle(con);
	      e.setSource(me.getSource());
	      workFeed.insert(e);
	     
	      
		  	findSheet("2020-07-28");
			URL listFeedUrl = bcSheet.getWorksheet().getListFeedUrl();
			ListFeed listFeed = bcSheet.getService().getFeed(listFeedUrl, ListFeed.class);
			listFeed.setEtag(MlistFeed.getEtag());
			//listFeed.insert(list.get(0));
	      
//	      findSheet("2020-07-27");
//	      URL listFeedUrl = bcSheet.getWorksheet().getListFeedUrl();
//	      ListFeed listFeed = service.getFeed(listFeedUrl, ListFeed.class);
//	      
//	      
//	      
//	      listFeed.insert(method.backUpEntry2().get(0));
//	      
//	      listFeed.setEtag("no");
//	      listFeed.setEtag("id");
//	         
	      
	}
public void insertContent () throws GeneralSecurityException, IOException, ServiceException {
	insertSheet();

	
}





}	// end
