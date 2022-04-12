package co.kr.teamb;
//import java.text.DateFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.naming.NamingException;
//import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*; //Map,List

import co.kr.teamb.dto.NoticeDTO;
import co.kr.teamb.dto.ReviewDTO;

@RequestMapping("/review")
@Controller
public class ReviewController {
	@Autowired
	private SqlSession sqlSession; //자동 세터 작업

	//입력 폼
	@RequestMapping("/insertForm.do")
	public String insertForm() {
		return ".teamb.review.insertForm"; //뷰리턴
	}

	//insert
	@RequestMapping(value="/insertPro.do", method=RequestMethod.POST)
	public String insertPro(@ModelAttribute("reviewDto") ReviewDTO reviewDto, MultipartHttpServletRequest mRequest, HttpServletRequest request) 
			throws IOException, NamingException{

		
		//IOException,NamingException
		System.out.println("아이디값:"+reviewDto.getId());
		
		String realPath = request.getSession().getServletContext().getRealPath("/");
		
		String upPath = realPath+"/resources/imgs/";
		
		MultipartFile uploadFile = mRequest.getFile("reviewimg");
		
		if (uploadFile == null) {
			
			System.out.println("===============테스트1==================");
			
			reviewDto.setImg(null);
			
			sqlSession.insert("review.insertReview", reviewDto);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("state", 10);
			
			map.put("id", reviewDto.getId());
			
			sqlSession.update("orderlist.updateState",map);
			
			return ".teamb.orderlist.baseindex";
			
		} else {
			
			System.out.println("===============테스트2==================");
			
			String originalFileName=uploadFile.getOriginalFilename();
			
			uploadFile.transferTo(new File(upPath+originalFileName)); //얘가 업로드 하는거
			
			reviewDto.setImg(originalFileName);
			
			sqlSession.insert("review.insertReview", reviewDto);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			map.put("state", 10);
			
			map.put("id", reviewDto.getId());
			
			sqlSession.update("orderlist.updateState",map);
			
			return ".teamb.orderlist.baseindex";
		}
		
		
		
		/*
		if(!uploadFile.isEmpty()) {
			String originalFileName=uploadFile.getOriginalFilename();
			uploadFile.transferTo(new File(upPath+originalFileName)); //얘가 업로드 하는거
			reviewDto.setImg(originalFileName);
		}
		
		
		sqlSession.insert("review.insertReview", reviewDto);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("state", 10);
		map.put("id", reviewDto.getId());
		
		sqlSession.update("orderlist.updateState",map);
		 */
		//return "redirect:/review/list.do"; //리퉌
		//return ".teamb.review.insertForm";
		
	}
	
	
	@RequestMapping(value = "/updaterv")
	@ResponseBody
	public String updatereview(ReviewDTO dto) {
		
		sqlSession.update("review.updateReview",dto);

		return "true";
	}
	
	@RequestMapping(value = "/deleterv")
	@ResponseBody
	public String deletereview(int id) {
		
		System.out.println(id);
		
		sqlSession.delete("review.deleteReview",id);
		
		return "true";
	}
				
	@RequestMapping(value = "/pagingreview", method = RequestMethod.POST)
	@ResponseBody
	public List<ReviewDTO> pagingrv(@RequestParam("gid") int gid, @RequestParam("pageNum") int pageNum){
		
		int currentPage = pageNum;
		
		int pageSize=10;
		
		int startRow=(currentPage-1)*pageSize+1;
		
		int endRow=currentPage*pageSize;
		
		int count = sqlSession.selectOne("review.selectCount",gid);
		
		int number=0;
		
		int pageBlock=10;
		
		number = count-(currentPage-1) * pageSize;
		
		int pageCount = count/pageSize + (count%pageSize==0?0:1);
		
		int startPage=(int)(currentPage/pageBlock)*10+1;
		
		int endPage=startPage+pageBlock-1;
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("start", startRow-1);
		
		map.put("cnt", pageSize);
		
		map.put("gid", gid);
		
		List<ReviewDTO> list = null;
		
		list = sqlSession.selectList("review.reviewList",map);
		
		return list;
	}
		
}//class-end
