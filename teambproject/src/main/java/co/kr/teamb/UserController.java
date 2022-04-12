package co.kr.teamb;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.kr.teamb.dto.UserDTO;

@RequestMapping("/user")
@Controller
public class UserController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/login.do")
	public String login() {
		return ".teamb.user.login";
	}
	
	@RequestMapping(value = "/loginconfirm.do", method = RequestMethod.POST)
	public String loginconfirm(HttpServletRequest request) {
		
		String id = request.getParameter("id");
		
		String pw = request.getParameter("pw");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("id", id);
		map.put("pw", pw);
		
		UserDTO dto = new UserDTO();
		
		dto = sqlSession.selectOne("user.selectMember",map);
		
		try {
			
			if (dto == null) {
				return ".teamb.user.login";
			}
			
			if(id.equals(dto.getId()) && pw.equals(dto.getPw())) {
				HttpSession session = request.getSession();
				
				session.setAttribute("id", dto.getId());
				session.setAttribute("pw", dto.getPw());
				session.setAttribute("name", dto.getName());
				session.setAttribute("tel", dto.getTel());
				session.setAttribute("email", dto.getEmail());
				session.setAttribute("zipcode", dto.getZipcode());
				session.setAttribute("address", dto.getAddress());
				session.setAttribute("regdate", dto.getRegdate());
				session.setAttribute("grade", dto.getGrade());
						
			}
			
		} catch (NullPointerException e) {
			// TODO: handle exception
			System.out.println("시발"+e);
		}
		
		return ".teamb.user.loginconfirm";
		/*
		if(id.equals(dto.getId()) && pw.equals(dto.getPw())) {
			HttpSession session = request.getSession();
			
			session.setAttribute("id", dto.getId());
			session.setAttribute("pw", dto.getPw());
			session.setAttribute("name", dto.getName());
			session.setAttribute("tel", dto.getTel());
			session.setAttribute("email", dto.getEmail());
			session.setAttribute("zipcode", dto.getZipcode());
			session.setAttribute("address", dto.getAddress());
			session.setAttribute("regdate", dto.getRegdate());
			session.setAttribute("grade", dto.getGrade());
			
			return ".teamb.user.loginconfirm";
		}else {
			
			return ".teamb.user.login";
		}
		*/
	}
	
	@RequestMapping(value = "/updateform.do")
	public String updateform() {
		return ".teamb.user.updateform";
	}
	
	@RequestMapping(value = "/updatepro.do", method = RequestMethod.POST)
	public String updateconfirm(UserDTO dto, HttpSession session) { //dto형식으로 인수받고 session가져오기
		
		sqlSession.update("user.updateMember",dto); //수정된 데이터를 db에 업데이트
		
		UserDTO dto2 = new UserDTO(); //새로운 userdto선언
		
		dto2 = sqlSession.selectOne("user.oneMember",dto.getId());//새로운 userdto에 수정된 데이터값을 받아옴
		
		session.setAttribute("id", dto2.getId());//세션에 새 데이터를 입력
		session.setAttribute("pw", dto2.getPw());//세션에 새 데이터를 입력
		session.setAttribute("name", dto2.getName());//세션에 새 데이터를 입력
		session.setAttribute("tel", dto2.getTel());//세션에 새 데이터를 입력		
		session.setAttribute("email", dto2.getEmail());//세션에 새 데이터를 입력
		session.setAttribute("zipcode", dto2.getZipcode());//세션에 새 데이터를 입력
		session.setAttribute("address", dto2.getAddress());//세션에 새 데이터를 입력
		session.setAttribute("regdate", dto2.getRegdate());//세션에 새 데이터를 입력
		session.setAttribute("grade", dto2.getGrade());//세션에 새 데이터를 입력
		
		
		return ".teamb.user.updateform";//폼 뷰를 리턴
	}
	
	@RequestMapping(value = "/joinform.do")
	public String joinform() {
		
		return ".teamb.user.joinform";
	}
	
	@RequestMapping(value = "/idcheck.do")
	@ResponseBody
	public int idcheck(String id) {
		
		int val = 0;
		
		val = sqlSession.selectOne("user.idCheck", id);
		
		return val;
	}
	
	@RequestMapping(value = "/insertuser.do", method = RequestMethod.POST)
	public String joinuser(UserDTO dto) {
		
		sqlSession.insert("user.insertMember",dto);
		
		return ".teamb.user.joinpro";
	}
	
	@RequestMapping(value = "/deleteuser.do", method = RequestMethod.POST)
	@ResponseBody
	public String deleteuser(String id) {
		
		System.out.println(id);
		
		sqlSession.delete("user.deleteMember",id);
		
		return "10";
	}
	
	
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return ".teamb.user.logout";
	}
	
	
}
