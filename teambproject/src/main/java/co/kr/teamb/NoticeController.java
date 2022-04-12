package co.kr.teamb;

//import java.text.DateFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.ModelAttribute;
//import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import java.util.*; //Map,List
import co.kr.teamb.dto.NoticeDTO;


@RequestMapping("/notice")
@Controller
public class NoticeController {
	@Autowired
	private SqlSession sqlSession; //자동 세터 작업

	//입력 폼
	@RequestMapping("/insertForm.do")
	public String insertForm() {
		return ".teamb.notice.insertForm"; //뷰리턴
	}

	//insert
	@RequestMapping(value="/insertPro.do", method=RequestMethod.POST)
	public String insertPro(@ModelAttribute("noticeDto") NoticeDTO noticeDto) {


		sqlSession.insert("notice.insertNotice", noticeDto);

		return "redirect:/notice/list.do"; //리퉌
		//return ".teamb.notice.insertForm";
	}

	//리스트
	@RequestMapping("/list.do")
	public String listBoard(@ModelAttribute("noticeDto") NoticeDTO noticeDto,Model model,
	@RequestParam(value="pageNum",required = false)String pageNum,HttpServletRequest request) {

		if(pageNum==null) {
			pageNum="1";
		}
		int pageSize=10;
		int currentPage=Integer.parseInt(pageNum);
		int startRow=(currentPage-1)*pageSize+1; //한페이지의 첫번째 row를 구한다
		int endRow=currentPage&pageSize; //한페이지의 마지막 row를 구한다

		int count=0; //총글수 넣을 변수
		int pageBlock=10; //블럭당 페이지수

		count=sqlSession.selectOne("notice.selectCount"); //총 글갯수 얻기
		int number=count-(currentPage-1)*pageSize; //글번호 역순으로 출력

		int pageCount=count/pageSize+(count%pageSize==0?0:1); //총페이지수
		int startPage=(currentPage/10)*10+1;
		int endPage=startPage+pageBlock-1;
		//				1+10-1=10 <=end페이지가 된당

		HashMap<String,Integer> map=new HashMap<String, Integer>();
		map.put("start", startRow-1); //시작 위치,mysql은 0부터 시작한다
		map.put("cnt", pageSize);//갯수

		String keyField=request.getParameter("keyField");
		String keyWord=request.getParameter("keyWord");

		HashMap<String, Object> map2=new HashMap<String, Object>();
		map2.put("start", startRow-1);
		map2.put("cnt", pageSize);
		map2.put("keyField", keyField);
		map2.put("keyWord", keyWord);

		List<NoticeDTO> list=null;

		if(keyWord!=null) { //키워드가 있으면(null이 아니면)
			//검색어가 있으면
			list=sqlSession.selectList("notice.searchListDao",map2);
		}else {
			//검색어가 없으면 걍 리스트로
			list=sqlSession.selectList("notice.selectAll",map);//매개변수로 map너음
			//          데이터 가져오눈거

		}

		//jsp에서 사용할 데이터
		model.addAttribute("currentPage",currentPage); //현재페이지
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow); 

		model.addAttribute("pageBlock",pageBlock); 
		model.addAttribute("pageCount",pageCount); 

		model.addAttribute("startPage",startPage); //시작페이지
		model.addAttribute("endPage",endPage);

		model.addAttribute("count",count);
		model.addAttribute("pageSize",pageSize);

		model.addAttribute("number",number); //글번호(역순으로)
		model.addAttribute("list",list); 


		return ".teamb.notice.list";
	}
	
	//로그인
	@RequestMapping("/loginForm.do")
	public String loginForm() {
		return ".teamb.notice.loginForm";
	}
	
	//서쉑스
	@RequestMapping("/loginSuccess.do")
	public String loginS(String adminID, Model model) {
		
		model.addAttribute("adminID",adminID);
		
		return ".teamb.notice.loginSuccess";
	}
	
	//조회수 증가, 글내용 보기
	@RequestMapping("content.do")
	public String content(Model model, String id,String pageNum) {
		int id1=Integer.parseInt(id); //문자열이니까 숫자로 바꿔주는거임
		sqlSession.update("notice.readcountNotice",id1); //파라미터 값 넘겨줌, 조회수증가
		NoticeDTO noticeDto=sqlSession.selectOne("notice.getNotice",id1);

		model.addAttribute("noticeDto",noticeDto);//jsp에서 사용할 데이터
		model.addAttribute("id",id1);
		model.addAttribute("pageNum",pageNum);

		//return "/notice/list"; //content.jsp 뷰리텬
		return ".teamb.notice.content"; //content.jsp 뷰리텬
	}
	//글수정 폼
	@RequestMapping("editForm.do")
	public String editForm(String id,String pageNum,Model model) {
		int id1=Integer.parseInt(id);//num을 정수로 변환
		NoticeDTO noticeDto=sqlSession.selectOne("notice.getNotice",id1);
		model.addAttribute("noticeDto",noticeDto);
		model.addAttribute("pageNum",pageNum);

		return ".teamb.notice.editForm"; //editForm.jsp 뷰리턴
	}

	//DB글수정
	@RequestMapping(value="editPro.do",method=RequestMethod.POST)
	public String editPro(NoticeDTO noticeDto,String pageNum,Model model) {
		sqlSession.update("notice.noticeUpdate",noticeDto);
		model.addAttribute("pageNum",pageNum);

		return "redirect:/notice/list.do";
	}
		
	//DB글삭제
	@RequestMapping("delete.do")
	public String deletePro(Model model,String id,String pageNum) {
		sqlSession.delete("notice.noticeDelete",new Integer(id));

		model.addAttribute("pageNum",pageNum);
		return "redirect:/notice/list.do";
	}
}//class-end
