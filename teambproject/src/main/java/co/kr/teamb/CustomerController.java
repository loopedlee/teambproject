package co.kr.teamb;

import java.awt.print.Pageable;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.taglibs.standard.extra.spath.Step;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.kr.teamb.dto.CustomerDTO;
import co.kr.teamb.dto.ReplyDTO;

@RequestMapping("/customer")
@Controller
public class CustomerController {
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/customer.do", method = RequestMethod.GET)
	public String customer(Model model, HttpServletRequest request) {	
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum==null){
			pageNum="1";
		}
		
		int currentPage=Integer.parseInt(pageNum);
		
		int pageSize=10;
		
		int startRow=(currentPage-1)*pageSize+1;
		
		int endRow=currentPage*pageSize;
		
		int count = sqlSession.selectOne("customer.getCount");
		
		int number=0;
		
		int pageBlock=10;
		
		number=count-(currentPage-1)*pageSize;
		
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		
		int startPage=(int)(currentPage/pageBlock)*10+1;
		
		int endPage=startPage+pageBlock-1;
		
		HashMap<String, Object> clist = new HashMap<String, Object>();
		clist.put("start", startRow-1);
		clist.put("cnt", pageSize);
		
		List<CustomerDTO> paging = null;

		paging = sqlSession.selectList("customer.pagIng",clist);

		model.addAttribute("list",paging);
		
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		
		model.addAttribute("pageBlock",pageBlock);
		model.addAttribute("pageCount",pageCount);
		
		model.addAttribute("count",count);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("number",number);
        
		return ".teamb.customer.index";
	}
	
	@RequestMapping(value = "/cdetail.do/{id}")
	public String customerdetail(@PathVariable int id, Model model) {
		
		sqlSession.update("customer.readcountCustomer", id);
		
		CustomerDTO dto = sqlSession.selectOne("customer.selectOne",id);
		
		List<ReplyDTO> reply = sqlSession.selectList("reply.viewReply",id);
		
		model.addAttribute("list",dto);
		
		model.addAttribute("rlist",reply);
		
		return ".teamb.customer.detail";
	}
	
	@RequestMapping(value = "/insertct.do")
	public String insertcustomer() {
		return ".teamb.customer.insertct";
	}
	
	@RequestMapping(value = "/insertconfirm.do", method = RequestMethod.POST)
	@ResponseBody
	public String insertconfirm(CustomerDTO dto) {
		
		sqlSession.insert("customer.insertCustomer", dto);
		
		return ".teamb.customer.insertct";
	}
	
	@RequestMapping(value = "/updatect.do/{id}")
	public String updatecustomer(@PathVariable int id, Model model) {
		
		CustomerDTO dto = sqlSession.selectOne("customer.selectOne",id);
		
		model.addAttribute("list",dto);
		
		return ".teamb.customer.update";
	}
	
	@RequestMapping(value = "/updateconfirm.do", method = RequestMethod.POST)
	@ResponseBody
	public String updateconfirm(CustomerDTO dto) {
		
		sqlSession.update("customer.updateCustomer", dto);
		
		return ".teamb.customer.update";
	}
	
	@RequestMapping(value = "/deletect.do", method = RequestMethod.POST)
	public String deleteconfirm(int id) {
		
		System.out.println(id);
		
		sqlSession.delete("customer.deleteCustomer",id);
		
		return ".teamb.customer.detail";
	}
	
	@RequestMapping(value = "/ctsearch.do", method = RequestMethod.GET)
	public String searchct(HttpServletRequest request, Model model) {
		
		String keyword = request.getParameter("keyword");
		
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum==null) {
			pageNum = "1";
		}
		
		System.out.println(pageNum);
		System.out.println(keyword);
		
		int currentPage=Integer.parseInt(pageNum);
		
		int pageSize=10;
		
		int startRow=(currentPage-1)*pageSize+1;
		
		int endRow=currentPage*pageSize;
		
		int count = sqlSession.selectOne("customer.searchCount",keyword);
		
		int number=0;
		
		int pageBlock=10;
		
		number = count-(currentPage-1) * pageSize;
		
		int pageCount = count/pageSize + (count%pageSize==0?0:1);
		
		int startPage=(int)(currentPage/pageBlock)*10+1;
		
		int endPage=startPage+pageBlock-1;
		
		HashMap<String, Object> clist = new HashMap<String, Object>();
		
		clist.put("start", startRow-1);
		
		clist.put("cnt", pageSize);
		
		clist.put("keyword", keyword);
		
		List<CustomerDTO> paging = null;

		paging = sqlSession.selectList("customer.searchKeyword",clist);

		model.addAttribute("list",paging);
		
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("keyword",keyword);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		
		model.addAttribute("pageBlock",pageBlock);
		model.addAttribute("pageCount",pageCount);
		
		model.addAttribute("count",count);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("number",number);
		
		return ".teamb.customer.index";
	}
	
}
