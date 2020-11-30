package jsp.sheet.method;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.gdata.client.spreadsheet.SpreadsheetService;
import com.google.gdata.data.spreadsheet.CellEntry;
import com.google.gdata.data.spreadsheet.CellFeed;
import com.google.gdata.data.spreadsheet.ListEntry;
import com.google.gdata.data.spreadsheet.ListFeed;
import com.google.gdata.data.spreadsheet.SpreadsheetEntry;
import com.google.gdata.data.spreadsheet.SpreadsheetFeed;
import com.google.gdata.data.spreadsheet.WorksheetEntry;
import com.google.gdata.util.ServiceException;

import jsp.Bean.model.*;
import jsp.DB.method.MemberDAO;
import jsp.DB.method.ProjectDAO;

public class sheetMethod {

	final static String FileName = "SureSoft-PMS";	// 동기화 할 구글스프레드시트 파일 이름
	final static String keyPath = "service.p12";

	// 싱글톤 패턴
	public sheetMethod() {
	}

	// 연결
	public static SpreadsheetService connect() throws GeneralSecurityException, IOException, ServiceException {
		SpreadsheetService service;
		ClassLoader classloader = Thread.currentThread().getContextClassLoader();
		URL url = classloader.getResource(keyPath);
		final File file = new File(url.getFile());

		HttpTransport HTTP_TRANSPORT = new NetHttpTransport();
		JsonFactory JSON_FACTORY = new JacksonFactory();

		Credential credential = new GoogleCredential.Builder().setTransport(HTTP_TRANSPORT).setJsonFactory(JSON_FACTORY)
				.setServiceAccountId("ymyou-1@e-tensor-282602.iam.gserviceaccount.com") // 서비스 계정 생성 당시의 정보
				.setTokenServerEncodedUrl("https://accounts.google.com/o/oauth2/token")
				.setServiceAccountScopes(Arrays.asList("https://www.googleapis.com/auth/drive",
						"https://spreadsheets.google.com/feeds", "https://docs.google.com/feeds"))
				.setServiceAccountPrivateKeyFromP12File(file).build();
		service = new SpreadsheetService("MySpreadsheetIntegration-v1");
		// 버전이 v1부터 v3까지 있었는데 사실 그 차이에대해선 아직 알아보지못했다
		service.setOAuth2Credentials(credential); // 이거 하려고 위에 저렇게 코딩 한거다. 이게 인증의 핵심

		return service;
	}

	// 메인 시트 불러오기
	public static List<WorksheetEntry> access() throws GeneralSecurityException, IOException, ServiceException {
		SpreadsheetService service = connect();	// 스프레드시트 연결
		List<SpreadsheetEntry> spreadsheets;
		SpreadsheetFeed feed = service.getFeed(
				new URL("https://spreadsheets.google.com/feeds/spreadsheets/private/full"), SpreadsheetFeed.class);
		spreadsheets = feed.getEntries();	// 계정이 가지고 있는 스프레드시트 리스트를 가져옴
		SpreadsheetEntry entry = null;
		for (int i = 0; i < spreadsheets.size(); i++) {
			entry = spreadsheets.get(i); // 접근가능 모든파일중 filename찾기
			if (entry.getTitle().getPlainText().equals(FileName)) {
				break;
			}
		}
		List<WorksheetEntry> worksheets = entry.getWorksheets();	// 찾은 파일이 가지고 있는 시트 리스트
		
		return worksheets;
	}

	// WorkSheet 찾기
	public static WorksheetEntry findSheet(String sheetName)
			throws GeneralSecurityException, IOException, ServiceException {
		List<WorksheetEntry> worksheets = access();	// 연결 후 시트파일이 가진 시트리스트 불러옴
		WorksheetEntry worksheet = null;
		for (int k = 0; k < worksheets.size(); k++) {
			worksheet = worksheets.get(k);
			if (worksheet.getTitle().getPlainText().equals(sheetName)) {
				break;
			}
		}
		return worksheet;	// 동기화 할 시트
	}

	// 프로젝트 데이터 스프레드시트와 동기화
	public static void synchronization(String spreadsheet)
			throws GeneralSecurityException, IOException, ServiceException {
		ProjectDAO projectDao = new ProjectDAO();
		MemberDAO memberDao = new MemberDAO();
		ArrayList<ProjectBean> pjList = projectDao.getProject_synchronization();
		ArrayList<String> PMList = new ArrayList<String>();
		String PMname = "";
		String PMID = "";

		// 시트연결
		// findSheet("동기화시트");
		URL listFeedUrl = findSheet(spreadsheet).getListFeedUrl();
		ListFeed listFeed = connect().getFeed(listFeedUrl, ListFeed.class);
		List<ListEntry> li = listFeed.getEntries(); // 전체 데이터 리스트로 저장
		ListEntry li_new = new ListEntry(); // 새로운 데이터 저장할 리스트

		for (int i = 0; i < pjList.size(); i++) {
			String[] workerName;
			PMID = pjList.get(i).getPROJECT_MANAGER();
			PMname = memberDao.returnMember(PMID).getNAME();
			PMList.add(PMname);
			workerName = new String[pjList.get(i).getWORKER_LIST().split(" ").length];
			workerName = pjList.get(i).getWORKER_LIST().split(" ");

			StringBuffer name = new StringBuffer();
			for (int j = 0; j < pjList.get(i).getWORKER_LIST().split(" ").length; j++) {
				String str = memberDao.returnMember(workerName[j]).getNAME();
				if (str == null) {
					str = "";
					name.append(str + " ");
				} else {
					name.append(str + " ");
				}

			}

			if (i < li.size()) {
				li.get(i).getCustomElements().setValueLocal("팀수주", pjList.get(i).getTEAM_ORDER());
				li.get(i).getCustomElements().setValueLocal("팀매출", pjList.get(i).getTEAM_SALES());
				li.get(i).getCustomElements().setValueLocal("프로젝트코드", pjList.get(i).getPROJECT_CODE());
				li.get(i).getCustomElements().setValueLocal("프로젝트명계약명기준", pjList.get(i).getPROJECT_NAME());
				li.get(i).getCustomElements().setValueLocal("상태", pjList.get(i).getSTATE());
				li.get(i).getCustomElements().setValueLocal("실", pjList.get(i).getPART());
				li.get(i).getCustomElements().setValueLocal("고객사", pjList.get(i).getCLIENT());
				li.get(i).getCustomElements().setValueLocal("고객부서", pjList.get(i).getClIENT_PART());
				li.get(i).getCustomElements().setValueLocal("MM", String.valueOf(pjList.get(i).getMAN_MONTH()));
				li.get(i).getCustomElements().setValueLocal("프로젝트계약금액백만",
						String.valueOf(pjList.get(i).getPROJECT_DESOPIT()));
				li.get(i).getCustomElements().setValueLocal("상반기예상수주",
						String.valueOf(pjList.get(i).getFH_ORDER_PROJECTIONS()));
				li.get(i).getCustomElements().setValueLocal("상반기수주", String.valueOf(pjList.get(i).getFH_ORDER()));
				li.get(i).getCustomElements().setValueLocal("상반기예상매출",
						String.valueOf(pjList.get(i).getFH_SALES_PROJECTIONS()));
				li.get(i).getCustomElements().setValueLocal("상반기매출", String.valueOf(pjList.get(i).getFH_SALES()));
				li.get(i).getCustomElements().setValueLocal("하반기예상수주",
						String.valueOf(pjList.get(i).getSH_ORDER_PROJECTIONS()));
				li.get(i).getCustomElements().setValueLocal("하반기수주", String.valueOf(pjList.get(i).getSH_ORDER()));
				li.get(i).getCustomElements().setValueLocal("하반기예상매출",
						String.valueOf(pjList.get(i).getSH_SALES_PROJECTIONS()));
				li.get(i).getCustomElements().setValueLocal("하반기매출", String.valueOf(pjList.get(i).getSH_SALES()));
				li.get(i).getCustomElements().setValueLocal("착수", pjList.get(i).getPROJECT_START());
				li.get(i).getCustomElements().setValueLocal("종료", pjList.get(i).getPROJECT_END());
				li.get(i).getCustomElements().setValueLocal("고객담당자", pjList.get(i).getCLIENT_PTB());
				li.get(i).getCustomElements().setValueLocal("근무지", pjList.get(i).getWORK_PLACE());
				li.get(i).getCustomElements().setValueLocal("업무", pjList.get(i).getWORK());
				li.get(i).getCustomElements().setValueLocal("PM", PMList.get(i));
				li.get(i).getCustomElements().setValueLocal("투입명단", name.toString());
				li.get(i).getCustomElements().setValueLocal("상평가유형", pjList.get(i).getASSESSMENT_TYPE());
				li.get(i).getCustomElements().setValueLocal("채용수요", String.valueOf(pjList.get(i).getEMPLOY_DEMAND()));
				li.get(i).getCustomElements().setValueLocal("외주수요",
						String.valueOf(pjList.get(i).getOUTSOURCE_DEMAND()));
				li.get(i).update();
			} else {
				li_new.getCustomElements().setValueLocal("팀수주", pjList.get(i).getTEAM_ORDER());
				li_new.getCustomElements().setValueLocal("팀매출", pjList.get(i).getTEAM_SALES());
				li_new.getCustomElements().setValueLocal("프로젝트코드", pjList.get(i).getPROJECT_CODE());
				li_new.getCustomElements().setValueLocal("프로젝트명계약명기준", pjList.get(i).getPROJECT_NAME());
				li_new.getCustomElements().setValueLocal("상태", pjList.get(i).getSTATE());
				li_new.getCustomElements().setValueLocal("실", pjList.get(i).getPART());
				li_new.getCustomElements().setValueLocal("고객사", pjList.get(i).getCLIENT());
				li_new.getCustomElements().setValueLocal("고객부서", pjList.get(i).getClIENT_PART());
				li_new.getCustomElements().setValueLocal("MM", String.valueOf(pjList.get(i).getMAN_MONTH()));
				li_new.getCustomElements().setValueLocal("프로젝트계약금액백만",
						String.valueOf(pjList.get(i).getPROJECT_DESOPIT()));
				li_new.getCustomElements().setValueLocal("상반기예상수주",
						String.valueOf(pjList.get(i).getFH_ORDER_PROJECTIONS()));
				li_new.getCustomElements().setValueLocal("상반기수주", String.valueOf(pjList.get(i).getFH_ORDER()));
				li_new.getCustomElements().setValueLocal("상반기예상매출",
						String.valueOf(pjList.get(i).getFH_SALES_PROJECTIONS()));
				li_new.getCustomElements().setValueLocal("상반기매출", String.valueOf(pjList.get(i).getFH_SALES()));
				li_new.getCustomElements().setValueLocal("하반기예상수주",
						String.valueOf(pjList.get(i).getSH_ORDER_PROJECTIONS()));
				li_new.getCustomElements().setValueLocal("하반기수주", String.valueOf(pjList.get(i).getSH_ORDER()));
				li_new.getCustomElements().setValueLocal("하반기예상매출",
						String.valueOf(pjList.get(i).getSH_SALES_PROJECTIONS()));
				li_new.getCustomElements().setValueLocal("하반기매출", String.valueOf(pjList.get(i).getSH_SALES()));
				li_new.getCustomElements().setValueLocal("착수", pjList.get(i).getPROJECT_START());
				li_new.getCustomElements().setValueLocal("종료", pjList.get(i).getPROJECT_END());
				li_new.getCustomElements().setValueLocal("고객담당자", pjList.get(i).getCLIENT_PTB());
				li_new.getCustomElements().setValueLocal("근무지", pjList.get(i).getWORK_PLACE());
				li_new.getCustomElements().setValueLocal("업무", pjList.get(i).getWORK());
				li_new.getCustomElements().setValueLocal("PM", PMList.get(i));
				li_new.getCustomElements().setValueLocal("투입명단", name.toString());
				li_new.getCustomElements().setValueLocal("상평가유형", pjList.get(i).getASSESSMENT_TYPE());
				li_new.getCustomElements().setValueLocal("채용수요", String.valueOf(pjList.get(i).getEMPLOY_DEMAND()));
				li_new.getCustomElements().setValueLocal("외주수요", String.valueOf(pjList.get(i).getOUTSOURCE_DEMAND()));
				listFeed.insert(li_new);
			}
		}
		if (pjList.size() < li.size()) {
			for (int d = pjList.size(); d < li.size(); d++) {
				li.get(d).delete();
			}
		}
	}
} // end
