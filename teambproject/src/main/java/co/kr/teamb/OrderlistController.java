package co.kr.teamb;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.kr.teamb.dto.OrderlistDTO;

@RequestMapping("/order")
@Controller
public class OrderlistController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/adminindex")
	public String orderadmin(HttpSession session, Model model) {
		
		if(session.getAttribute("grade").equals(1)) {
			
		List<OrderlistDTO> adminlist = null;
		
		adminlist = sqlSession.selectList("orderlist.adminAll");
		
		model.addAttribute("list",adminlist);
		
		return ".teamb.orderlist.adminindex";
		
		}else {
			return ".teamb.orderlist.adminindex";
		}
		
		
	}
	
	@RequestMapping(value = "/baseindex")
	public String orderbase(HttpSession session, Model model) {
		
		if(session.getAttribute("id") != null) {
			
			String uid = (String) session.getAttribute("id");
					
			List<OrderlistDTO> baselist = null;
			
			baselist = sqlSession.selectList("orderlist.baseAll", uid);
			
			model.addAttribute("list",baselist);
			
			return ".teamb.orderlist.baseindex";
			
		} else {
			return ".teamb.orderlist.baseindex";
		}
		
	}
	
	@RequestMapping(value = "/updatest", method = RequestMethod.POST)
	@ResponseBody
	public String adminupdatest(OrderlistDTO dto) {
		
		System.out.println(dto.getState());
		System.out.println(dto.getId());
		
		int id = dto.getId();
		
		int state = dto.getState();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("state", state);
		
		sqlSession.update("orderlist.updateState", map);
		
		
		return "true";
	}
	
	@RequestMapping(value = "/updatebst", method = RequestMethod.POST)
	@ResponseBody
	public String baseupdatest(OrderlistDTO dto) {
		
		System.out.println(dto.getState());
		System.out.println(dto.getId());
		
		int id = dto.getId();
		
		int state = dto.getState();
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("state", state);
		
		sqlSession.update("orderlist.updateState", map);
		
		
		return "true";
	}

}
