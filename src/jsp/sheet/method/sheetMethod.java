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

public class sheetMethod {
	sheetBean sheet = new sheetBean();
	MemberBean member = new MemberBean();
	
	
	public MemberBean getMember() {
		return member;
	}

	// 싱글톤 패턴
	public sheetMethod() {
	
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
		sheet.setService(service);
	}

	// 메인 시트 불러오기
	public void access() throws GeneralSecurityException, IOException, ServiceException {
		SpreadsheetService service = sheet.getService();
		List<SpreadsheetEntry> spreadsheets;
		SpreadsheetFeed feed = service.getFeed(
				new URL("https://spreadsheets.google.com/feeds/spreadsheets/private/full"), SpreadsheetFeed.class);
		spreadsheets = feed.getEntries();

		sheet.setSpreadsheets(spreadsheets);
		sheet.setFeed(feed);

		for (int i = 0; i < sheet.getSpreadsheets().size(); i++) {
			SpreadsheetEntry entry = sheet.getSpreadsheets().get(i);	// 접근가능 모든파일중 filename찾기
			if (entry.getTitle().getPlainText().equals(sheet.getFileName())) {	//filename 일치 확인
				sheet.setEntry(entry);	// suresoft-pms파일 저장
				break;
			}
		}
		List<WorksheetEntry> worksheets = sheet.getEntry().getWorksheets(); // 시트 타이틀
		sheet.setWorksheets(worksheets);	// 시트타이틀 저장
	}
	
	// WorkSheet 찾기
	public void findSheet(String sheetName) {
		for (int k = 0; k < sheet.getWorksheets().size(); k++) {
    		WorksheetEntry worksheet = sheet.getWorksheets().get(k);
    		if (worksheet.getTitle().getPlainText().equals(sheetName)) {
    			sheet.setWorksheet(worksheet);
    			break;
    		}
    		
    	}
	}
	

	// 로그인 체크
	public int loginCheck(String id, String pw) throws GeneralSecurityException, IOException, ServiceException
    {
		
		int check = 0;
		connect();
		access();
    	findSheet("#인력");
    	
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
    	ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
    	
    	List<ListEntry> list = listFeed.getEntries();	// 모든 행 가져오기
  
    	for(int a = 0; a < list.size(); a++)	{
    		ListEntry li = list.get(a);	// 첫 번째 행 데이터 부터 가져옴
    		if(li.getCustomElements().getValue("id").equals(id)) {
    			if(li.getCustomElements().getValue("pw").equals(pw)) {
    				check = 1;
    				break;
    			} else
    				check = 0;
    				break;
    			
    		} else 
    			check = 0;
    	}
    	return check;
    }
	
	
	// 세션 ID를 받아 회원정보 bean 클래스에 저장
	public void saveUser_info(String id)throws GeneralSecurityException, IOException, ServiceException {
		connect();
		access();
    	findSheet("#인력");
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
    	ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
    	List<ListEntry> list = listFeed.getEntries();	// 모든 행 가져오기
    	//List userInfo = new ArrayList()
    	for(int a = 0; a < list.size(); a++) {
    		ListEntry li = list.get(a);
    		
    		if(li.getCustomElements().getValue("id").equals(id)) {
    			System.out.println("34");
    			member.setID(id);
    			member.setNAME(li.getCustomElements().getValue("이름"));
    			member.setNO(li.getCustomElements().getValue("no"));
    			member.setPART(li.getCustomElements().getValue("소속"));
    			member.setTEAM(li.getCustomElements().getValue("팀"));
    			member.setGMAIL(li.getCustomElements().getValue("gmail"));
    			member.setRANK(li.getCustomElements().getValue("직급"));
    			member.setMOBILE(li.getCustomElements().getValue("mobile"));
    			member.setADDRESS(li.getCustomElements().getValue("주소"));
    			//member.setNOTE(li.getCustomElements().getValue("이름"));
    			//member.setPASSWORD(li.getCustomElements().getValue(""));
    			
    			break;
    			
    		}
    	}
		
    }
	
	// 주간
	// 보고서 작성
	public int saveReport (String title, String writeDate,
			 String weekPlan, String weekPro, String nextPlan, String user_id, 
			 String name, String specialty, String note) throws GeneralSecurityException, IOException, ServiceException {
		connect();
		access();
    	findSheet("주간보고서");
    	
        // 주간보고서
         URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
         ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
         List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
         ListEntry li = new ListEntry(); //새로운 데이터 저장할  리스트
         int num;
         if (list.isEmpty() == true) {
         	num = 0;
         } else {
         	String no = list.get(list.size()-1).getCustomElements().getValue("no");
         	num = Integer.parseInt(no);
         }
         
         if (title != "" && writeDate != "") {
        	//방법2
        	 li.getCustomElements().setValueLocal("no",Integer.toString((num + 1)));
             li.getCustomElements().setValueLocal("프로젝트명", title);
             li.getCustomElements().setValueLocal("작성일", writeDate);
             li.getCustomElements().setValueLocal("금주계획", weekPlan);
             li.getCustomElements().setValueLocal("금주진행", weekPro);
             li.getCustomElements().setValueLocal("차주계획", nextPlan);
             li.getCustomElements().setValueLocal("id", user_id);
             li.getCustomElements().setValueLocal("이름", name);
             li.getCustomElements().setValueLocal("특이사항", specialty);
             li.getCustomElements().setValueLocal("비고", note);
             listFeed.insert(li);
             
             return 1;

         } else return 0;
	}
	
	// 주간보고서 리스트 목록 가져오기
	public ArrayList<BoardBean> getBoardList()throws GeneralSecurityException, IOException, ServiceException{
		
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		connect();
		access();
    	findSheet("주간보고서");
    	
        // 주간보고서
        URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        
        for(int i=0; i < list.size(); i++) {
        	ListEntry li = list.get(i);
        	BoardBean board = new BoardBean();
        	board.setNo(li.getCustomElements().getValue("no"));
        	board.setId(li.getCustomElements().getValue("id"));
        	board.setName(li.getCustomElements().getValue("이름"));
        	board.setRank(li.getCustomElements().getValue("직급"));
        	board.setTeam(li.getCustomElements().getValue("팀"));
        	board.setTitle(li.getCustomElements().getValue("프로젝트명"));
        	board.setDate(li.getCustomElements().getValue("작성일"));
        	board.setWeekPlan(li.getCustomElements().getValue("금주계획"));
        	board.setWeekPro(li.getCustomElements().getValue("금주진행"));
        	board.setNextPlan(li.getCustomElements().getValue("차주계획"));
        	boardList.add(board);
        }
        
		
		return boardList;
		
	}
	
	// 넘버별 주간보고서 데이터 가져오기
	public BoardBean getBoard(String NO)throws GeneralSecurityException, IOException, ServiceException{
		connect();
		access();
		findSheet("주간보고서");
		// 주간보고서
        URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        BoardBean board = new BoardBean();
		for(int i = 0; i < list.size(); i++) {
			ListEntry li = list.get(i);
			if(li.getCustomElements().getValue("no").equals(NO)) {
	        	board.setNo(li.getCustomElements().getValue("no"));
	        	board.setId(li.getCustomElements().getValue("id"));
	        	board.setName(li.getCustomElements().getValue("이름"));
	        	board.setRank(li.getCustomElements().getValue("직급"));
	        	board.setTeam(li.getCustomElements().getValue("팀"));
	        	board.setTitle(li.getCustomElements().getValue("프로젝트명"));
	        	board.setDate(li.getCustomElements().getValue("작성일"));
	        	board.setWeekPlan(li.getCustomElements().getValue("금주계획"));
	        	board.setWeekPro(li.getCustomElements().getValue("금주진행"));
	        	board.setNextPlan(li.getCustomElements().getValue("차주계획"));
				break;
			}
		}
		
		return board;
	}
	
	public WorksheetEntry backUpEntry() throws GeneralSecurityException, IOException, ServiceException{
		connect();
		access();
		findSheet("주간보고서");
		WorksheetEntry e = sheet.getWorksheet();
		
		return e;
	}
	public ListFeed backUpEntry2() throws GeneralSecurityException, IOException, ServiceException{
		connect();
		access();
		findSheet("주간보고서");

        URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
		return listFeed;
	}
	
	
	// 일간
	// 보고서 작성
	public int save_DayReport (String title, String writeDate,
			 String weekPlan, String weekPro, String nextPlan, String user_id, 
			 String name, String rank, String team) throws GeneralSecurityException, IOException, ServiceException {
		connect();
		access();
    	findSheet("일간보고서");
    	
        // 주간보고서
         URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
         ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
         List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
         ListEntry li = new ListEntry(); //새로운 데이터 저장할  리스트
         int num;
         if (list.isEmpty() == true) {
         	num = 0;
         } else {
         	String no = list.get(list.size()-1).getCustomElements().getValue("no");
         	num = Integer.parseInt(no);
         }
         
         if (title != "" && writeDate != "") {
        	//방법2
        	 li.getCustomElements().setValueLocal("no",Integer.toString((num + 1)));
             li.getCustomElements().setValueLocal("제목", title);
             li.getCustomElements().setValueLocal("작성일", writeDate);
             li.getCustomElements().setValueLocal("금일계획", weekPlan);
             li.getCustomElements().setValueLocal("금일진행", weekPro);
             li.getCustomElements().setValueLocal("내일계획", nextPlan);
             li.getCustomElements().setValueLocal("id", user_id);
             li.getCustomElements().setValueLocal("이름", name);
             li.getCustomElements().setValueLocal("직급", rank);
             li.getCustomElements().setValueLocal("팀", team);
             listFeed.insert(li);
             
             return 1;

         } else return 0;
	}
	
	// 일간보고서 리스트 목록 가져오기
	public ArrayList<BoardBean> get_DayBoardList()throws GeneralSecurityException, IOException, ServiceException{
		
		ArrayList<BoardBean> boardList = new ArrayList<BoardBean>();
		connect();
		access();
    	findSheet("일간보고서");
    	
        // 주간보고서
        URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        
        for(int i=0; i < list.size(); i++) {
        	ListEntry li = list.get(i);
        	BoardBean board = new BoardBean();
        	board.setNo(li.getCustomElements().getValue("no"));
        	board.setId(li.getCustomElements().getValue("id"));
        	board.setName(li.getCustomElements().getValue("이름"));
        	board.setRank(li.getCustomElements().getValue("직급"));
        	board.setTeam(li.getCustomElements().getValue("팀"));
        	board.setTitle(li.getCustomElements().getValue("제목"));
        	board.setDate(li.getCustomElements().getValue("작성일"));
        	board.setWeekPlan(li.getCustomElements().getValue("금일계획"));
        	board.setWeekPro(li.getCustomElements().getValue("금일진행"));
        	board.setNextPlan(li.getCustomElements().getValue("내일계획"));
        	boardList.add(board);
        }
        
		
		return boardList;
		
	}
	
	
	// 넘버별 일간보고서 데이터 가져오기
	public BoardBean get_DayBoard(String NO)throws GeneralSecurityException, IOException, ServiceException{
		connect();
		access();
		findSheet("일간보고서");
		// 주간보고서
        URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        BoardBean board = new BoardBean();
		for(int i = 0; i < list.size(); i++) {
			ListEntry li = list.get(i);
			if(li.getCustomElements().getValue("no").equals(NO)) {				
	        	board.setNo(li.getCustomElements().getValue("no"));
	        	board.setId(li.getCustomElements().getValue("id"));
	        	board.setName(li.getCustomElements().getValue("이름"));
	        	board.setRank(li.getCustomElements().getValue("직급"));
	        	board.setTeam(li.getCustomElements().getValue("팀"));
	        	board.setTitle(li.getCustomElements().getValue("제목"));
	        	board.setDate(li.getCustomElements().getValue("작성일"));
	        	board.setWeekPlan(li.getCustomElements().getValue("금일계획"));
	        	board.setWeekPro(li.getCustomElements().getValue("금일진행"));
	        	board.setNextPlan(li.getCustomElements().getValue("내일계획"));
				break;
			}
		}
		
		return board;
	}
	
	// 프로젝트 가져오기
	public ArrayList<ProjectBean> getProjectList()throws GeneralSecurityException, IOException, ServiceException{
		ArrayList<ProjectBean> projectList = new ArrayList<ProjectBean>();
		connect();
		access();
    	findSheet("#PRJ");
    	
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        for(int i=0; i<list.size(); i++) {
        	ListEntry li = list.get(i);
        	ProjectBean pj = new ProjectBean();
        	pj.setTEAM(li.getCustomElements().getValue("팀"));
        	pj.setPROJECT_CODE(li.getCustomElements().getValue("프로젝트 코드"));
        	pj.setPROJECT_NAME(li.getCustomElements().getValue("프로젝트명"));
        	pj.setSTATE(li.getCustomElements().getValue("상태"));
        	pj.setPART(li.getCustomElements().getValue("실"));
        	pj.setCLIENT(li.getCustomElements().getValue("고객사"));
        	pj.setClIENT_PART(li.getCustomElements().getValue("고객부서"));
        	pj.setMAN_MONTH(li.getCustomElements().getValue("M/N"));
        	pj.setPROJECT_DESOPIT(li.getCustomElements().getValue("프로젝트계약금액(백만)"));
        	pj.setFH_ORDER(li.getCustomElements().getValue("상반기수주"));
        	pj.setFH_SALES_PROJECTIONS(li.getCustomElements().getValue("상반기예상매출"));
        	pj.setFH_SALES(li.getCustomElements().getValue("상반기매출"));
        	pj.setSH_ORDER(li.getCustomElements().getValue("하반기수주"));
        	pj.setSH_SALES_PROJECTIONS(li.getCustomElements().getValue("하반기예상매출"));
        	pj.setSH_SALES(li.getCustomElements().getValue("하반기매출"));
        	pj.setPROJECT_START(li.getCustomElements().getValue("착수"));
        	pj.setPROJECT_END(li.getCustomElements().getValue("종료"));
        	pj.setCLIENT_PTB(li.getCustomElements().getValue("고객담당자"));
        	pj.setWORK_PLACE(li.getCustomElements().getValue("근무지"));
        	pj.setWORK(li.getCustomElements().getValue("업무"));
        	pj.setPROJECT_MANAGER(li.getCustomElements().getValue("PM"));
        	pj.setWORKER_LIST(li.getCustomElements().getValue("투입명단"));
        	pj.setASSESSMENT_TYPE(li.getCustomElements().getValue("평가유형"));
        	pj.setEMPLOY_DEMAND(li.getCustomElements().getValue("채용수요"));
        	pj.setOUTSOURCE_DEMAND(li.getCustomElements().getValue("외주수요"));
        	projectList.add(pj);
        }
		return projectList;
	}
	
	// 관리자 일정 가져오기
	public ArrayList<MSC_Bean> getMSCList()throws GeneralSecurityException, IOException, ServiceException{
		ArrayList<MSC_Bean> MSCList = new ArrayList<MSC_Bean>();
		connect();
		access();
    	findSheet("관리자일정");
    	
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        for(int i=0; i<list.size(); i++) {
        	ListEntry li = list.get(i);
        	MSC_Bean mb = new MSC_Bean();
        	mb.setNo(li.getCustomElements().getValue("no"));
        	mb.setID(li.getCustomElements().getValue("ID"));
			mb.setAMplace(li.getCustomElements().getValue("오전장소"));
			mb.setPMplace(li.getCustomElements().getValue("오후장소"));
			mb.setDate(li.getCustomElements().getValue("날짜"));
        	mb.setName(li.getCustomElements().getValue("이름"));
        	mb.setTeam(li.getCustomElements().getValue("팀"));
        	mb.setLevel(li.getCustomElements().getValue("level"));
        	MSCList.add(mb);
        }
        
		return MSCList;
	}
	
	// 아이디, 데이트로 해당 관리자 일정 데이터 no가져오기
	public String returnNo (String id, String date)throws GeneralSecurityException, IOException, ServiceException {
		connect();
		access();
    	findSheet("관리자일정");
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
    	String no = "";
        for(int i=0; i<list.size(); i++) {
        	ListEntry li = list.get(i);
        	if(list.get(i).getCustomElements().getValue("ID").equals(id) 
        			&& list.get(i).getCustomElements().getValue("날짜").equals(date)) {
        		no = list.get(i).getCustomElements().getValue("no");
        	}
        }
       return no;
	}
	

	// 특정 관리자 일정 가져오기
	public MSC_Bean getMSCList_set(String no)throws GeneralSecurityException, IOException, ServiceException{
		MSC_Bean mb = new MSC_Bean();
		connect();
		access();
    	findSheet("관리자일정");
    	
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        for(int i=0; i<list.size(); i++) {
        	ListEntry li = list.get(i);
			if (list.get(i).getCustomElements().getValue("no").equals(no)) {
				mb.setNo(li.getCustomElements().getValue("no"));
				mb.setID(li.getCustomElements().getValue("ID"));
				mb.setAMplace(li.getCustomElements().getValue("오전장소"));
				mb.setPMplace(li.getCustomElements().getValue("오후장소"));
				mb.setDate(li.getCustomElements().getValue("날짜"));
				mb.setName(li.getCustomElements().getValue("이름"));
				mb.setTeam(li.getCustomElements().getValue("팀"));
				mb.setLevel(li.getCustomElements().getValue("level"));
			}
        }
        
		return mb;
	}
	
	// 관리자 일정 추가
	public int insert_MSC(String id, String amPlace, String pmPlace, String date, String team, String name, String level)throws GeneralSecurityException, IOException, ServiceException {
		connect();
		access();
    	findSheet("관리자일정");
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        ListEntry li = new ListEntry();
        int num;
        if (list.isEmpty() == true) {
        	num = 0;
        } else {
        	String no = list.get(list.size()-1).getCustomElements().getValue("no");
        	num = Integer.parseInt(no);
        }
        
        if (pmPlace != "" && amPlace != "" && date != "") {
        	li.getCustomElements().setValueLocal("no",Integer.toString((num + 1)));
        	li.getCustomElements().setValueLocal("ID",id);
        	li.getCustomElements().setValueLocal("오전장소",amPlace);
        	li.getCustomElements().setValueLocal("오후장소",pmPlace);
        	li.getCustomElements().setValueLocal("날짜",date);
        	li.getCustomElements().setValueLocal("팀",team);
        	li.getCustomElements().setValueLocal("이름",name);
        	li.getCustomElements().setValueLocal("level",level);
        	listFeed.insert(li);
        	return 1;
        }
        else return 0;
	}
	
	//관리자 일정 삭제
	public int delete_MSC(String no) throws GeneralSecurityException, IOException, ServiceException{
		connect();
		access();
		findSheet("관리자일정");
		URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        for(int i=0; i<list.size();i++) {
        	if(list.get(i).getCustomElements().getValue("no").equals(no)) {
        		list.get(i).delete();
        		return 1;
        	}
        }
        return 0;
	}
	
	//관리자 일정 수정
	public int update_MSC(String no, String amPlace, String pmPlace, String date) throws GeneralSecurityException, IOException, ServiceException{
		connect();
		access();
		findSheet("관리자일정");
		URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        for(int i=0; i<list.size();i++) {
        	if(list.get(i).getCustomElements().getValue("no").equals(no)) {
        		list.get(i).getCustomElements().setValueLocal("오전장소", amPlace);
        		list.get(i).getCustomElements().setValueLocal("오후장소", pmPlace);
        		list.get(i).getCustomElements().setValueLocal("날짜", date);
        		list.get(i).update();
        		return 1;
        	}
        }
        return 0;
	}
	
	//관리자 일정 같은 날짜에 ID가 중복되는지 확인
	public String doubleCheck(String id, String date)throws GeneralSecurityException, IOException, ServiceException {
		connect();
		access();
		findSheet("관리자일정");
		URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        String num = "";
        for(int i=0; i<list.size(); i++) {
        	if(date.equals(list.get(i).getCustomElements().getValue("날짜"))) {
        		if(id.equals(list.get(i).getCustomElements().getValue("ID"))) {
        			num = list.get(i).getCustomElements().getValue("no");
        			break;
        		}
        	}
        } 
		return num;
	}
	
	// 회의록 조회
	public ArrayList<MeetBean> getMeetBean()throws GeneralSecurityException, IOException, ServiceException{
		ArrayList<MeetBean> MeetList = new ArrayList<MeetBean>();
		connect();
		access();
    	findSheet("회의록");
       	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        for(int i=0; i<list.size(); i++) {
        	ListEntry li = list.get(i);
        	MeetBean mb = new MeetBean();
        	mb.setNo(li.getCustomElements().getValue("no"));
        	mb.setId(li.getCustomElements().getValue("ID"));
        	mb.setDate(li.getCustomElements().getValue("작성날짜"));
			mb.setMeetName(li.getCustomElements().getValue("회의명"));
			mb.setWriter(li.getCustomElements().getValue("작성자"));
			mb.setMeetDate(li.getCustomElements().getValue("회의일시"));
        	mb.setMeetPlace(li.getCustomElements().getValue("회의장소"));
        	mb.setAttendees(li.getCustomElements().getValue("참석자"));
        	mb.setP_meetnote(li.getCustomElements().getValue("회의내용"));
        	mb.setP_nextplan(li.getCustomElements().getValue("향후일정"));
        	MeetList.add(mb);
        }
        
		return MeetList;
	}
	
	// 회의록 내용 조회
	public MeetBean getMeetList(String no)throws GeneralSecurityException, IOException, ServiceException {
		MeetBean mb = new MeetBean();
		connect();
		access();
    	findSheet("회의록");
     	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        
        for(int i=0; i<list.size(); i++) {
        	ListEntry li = list.get(i);
			if (list.get(i).getCustomElements().getValue("no").equals(no)) {
	        	mb.setNo(li.getCustomElements().getValue("no"));
	        	mb.setId(li.getCustomElements().getValue("ID"));
	        	mb.setDate(li.getCustomElements().getValue("작성날짜"));
				mb.setMeetName(li.getCustomElements().getValue("회의명"));
				mb.setWriter(li.getCustomElements().getValue("작성자"));
				mb.setMeetDate(li.getCustomElements().getValue("회의일시"));
	        	mb.setMeetPlace(li.getCustomElements().getValue("회의장소"));
	        	mb.setAttendees(li.getCustomElements().getValue("참석자"));
	        	mb.setP_meetnote(li.getCustomElements().getValue("회의내용"));
	        	mb.setP_nextplan(li.getCustomElements().getValue("향후일정"));
			}
        }
    	return mb;
	}
	
	// 회의록 작성
	public int saveMeet(String id, String MeetName, String writer, String MeetDate, String MeetPlace,
			String attendees, String meetnote, String nextplan, String date)throws GeneralSecurityException, IOException, ServiceException  {
		connect();
		access();
    	findSheet("회의록");
    	URL listFeedUrl = sheet.getWorksheet().getListFeedUrl();
        ListFeed listFeed = sheet.getService().getFeed(listFeedUrl, ListFeed.class);
        List<ListEntry> list = listFeed.getEntries(); //전체 데이터 리스트로 저장
        ListEntry li = new ListEntry(); //새로운 데이터 저장할  리스트
        int num;
        if (list.isEmpty() == true) {
        	num = 0;
        } else {
        	String no = list.get(list.size()-1).getCustomElements().getValue("no");
        	num = Integer.parseInt(no);
        }
        
        
        if (MeetName!= "" && MeetDate != "" && MeetPlace != "" && attendees != "" && meetnote != "" && nextplan != "") {
        	 li.getCustomElements().setValueLocal("no",Integer.toString((num + 1)));
             li.getCustomElements().setValueLocal("ID", id);
             li.getCustomElements().setValueLocal("회의명", MeetName);
             li.getCustomElements().setValueLocal("작성자", writer);
             li.getCustomElements().setValueLocal("작성날짜", date);
             li.getCustomElements().setValueLocal("회의일시", MeetDate);
             li.getCustomElements().setValueLocal("회의장소", MeetPlace);
             li.getCustomElements().setValueLocal("참석자", attendees);
             li.getCustomElements().setValueLocal("회의내용", meetnote);
             li.getCustomElements().setValueLocal("향후일정", nextplan);
             listFeed.insert(li);
             return 1;

             
        	} else return 0;
		}
	
	
}	// end
