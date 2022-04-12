package co.kr.teamb;

import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import co.kr.teamb.dto.GoodsDTO;
import co.kr.teamb.dto.NoticeDTO;
import co.kr.teamb.dto.ReviewDTO;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.apache.ibatis.session.SqlSession;
import org.omg.CORBA.Request;

@RequestMapping("/goods")
@Controller
public class GoodsController {
	@Autowired
	SqlSession sqlSession;//자동 setter
	
	@RequestMapping("goodsList.do")
	public String goodslist(@ModelAttribute("goodsDto") GoodsDTO goodsDto,
			Model model, @RequestParam(value="pageNum",required=false)String pageNum,
			HttpServletRequest request) {
		
		if(pageNum==null) {
			pageNum="1";
		}
		
		int pageSize=9;
		int currentPage=Integer.parseInt(pageNum);
		int startRow=(currentPage-1)*pageSize+1;//한 페이지의 첫번째 row를 구한다.
		int endRow=currentPage*pageSize;//한 페이지의 마지막 row를 구한다
		
		int count=0;//총 글수 넣을 변수
		int pageBlock=10;//블럭당 페이지 수
		
		count=sqlSession.selectOne("goods.countList");//총 글 갯수 얻기
		int number=count-(currentPage-1)*pageSize;//글번호 역순으로 출력

		int pageCount=count/pageSize+(count%pageSize==0?0:1);//총 페이지 수
		int startPage=(currentPage/10)*10+1;
		int endPage=startPage+pageBlock-1;
		
		HashMap<String,Integer> map=new HashMap<String, Integer>();
		map.put("start", startRow-1);//시작위치, mysql은 0부터 시작
		map.put("cnt", pageSize);
		
		String keyField=request.getParameter("keyField");
		String keyWord=request.getParameter("keyWord");
		
		HashMap<String,Object> map2=new HashMap<String,Object>();
		map2.put("start", startRow-1);
		map2.put("cnt", pageSize);
		map2.put("keyField", keyField);
		map2.put("keyWord", keyWord);
		
		List<GoodsDTO> list=null;
		
		if(keyWord != null) {
			list=sqlSession.selectList("goods.searchList",map2);
		}else {
			list=sqlSession.selectList("goods.listPage",map);
		}
		//JSP에서 사용할 데이터
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startRow",startRow);
		model.addAttribute("endRow",endRow);
		
		model.addAttribute("pageBlock",pageBlock);
		model.addAttribute("pageCount",pageCount);
		
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		
		model.addAttribute("count",count);
		model.addAttribute("pageSize",pageSize);
		
		model.addAttribute("number",number);
		model.addAttribute("list",list);
		
		return ".teamb.goods.goodsList";
	}
	
	@RequestMapping("writeForm.do")
	public String writeForm() {
		
		return ".teamb.goods.writeForm";//writeForm.jsp
	}
	
	@RequestMapping(value="/writePro.do",method=RequestMethod.POST)
	public String fileUpLoadPro(@ModelAttribute("goodsDto") GoodsDTO goodsDto,MultipartHttpServletRequest mRequest, HttpServletRequest request) 
			throws IOException {
	
	String realPath=request.getSession().getServletContext().getRealPath("/");	
	String upPath=realPath+"/resources/flowerimgs/";
	
	MultipartFile uploadFile=mRequest.getFile("imgFile");
	
	if(!uploadFile.isEmpty()) {
		String originalFileName=uploadFile.getOriginalFilename();//원래 파일 이름
		uploadFile.transferTo(new File(upPath+originalFileName));
	}
	String originalFileName=uploadFile.getOriginalFilename();
	goodsDto.setImg(originalFileName);//DB에 저장하기 위해서
	
	sqlSession.insert("goods.insertGoods", goodsDto);
	
	return "redirect:/goods/goodsList.do";
    }
	
	//글내용 보기
	@RequestMapping("content.do")
	public String content(Model model, int id, String pageNum, @ModelAttribute("reviewDto") ReviewDTO reviewDto) {
		
		sqlSession.update("goods.upCount",id);
		
		GoodsDTO goodsDto=sqlSession.selectOne("goods.selectOne",id);
		
		model.addAttribute("goodsDto",goodsDto);//jsp에서 사용할 데이터
		
		model.addAttribute("id",id);
		
		model.addAttribute("pageNum",pageNum);
		
		if(pageNum==null) {
			pageNum="1";
		}
		int pageSize=10;
		int currentPage=Integer.parseInt(pageNum);
		int startRow=(currentPage-1)*pageSize+1; //한페이지의 첫번째 row를 구한다
		int endRow=currentPage&pageSize; //한페이지의 마지막 row를 구한다

		int count=0; //총글수 넣을 변수
		int pageBlock=10; //블럭당 페이지수

		count=sqlSession.selectOne("review.selectCount",id); //총 글갯수 얻기
		int number=count-(currentPage-1)*pageSize; //글번호 역순으로 출력

		int pageCount=count/pageSize+(count%pageSize==0?0:1); //총페이지수
		int startPage=(currentPage/10)*10+1;
		int endPage=startPage+pageBlock-1;
		//				1+10-1=10 <=end페이지가 된당

		HashMap<String,Integer> map=new HashMap<String, Integer>();
		map.put("gid",id);
		map.put("start", startRow-1); //시작 위치,mysql은 0부터 시작한다
		map.put("cnt", pageSize);//갯수
	
		List<ReviewDTO> list=null;

		list=sqlSession.selectList("review.reviewList",map);
		
		System.out.println(count);
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
		
		
		return ".teamb.goods.content";//content.jsp
	}
	
	//추천!
	@RequestMapping("rateUp.do")
	public String rateUp(Model model,int id) {
		sqlSession.update("goods.upRate",id);
		
		model.addAttribute("id",id);
		
		return "redirect:/goods/content.do";
	}
	
	@RequestMapping("editForm.do")
	public String editForm(int id,String pageNum,Model model) {
		
		GoodsDTO goodsDto=sqlSession.selectOne("goods.selectOne", id);
		
		model.addAttribute("goodsDto",goodsDto);
		model.addAttribute("img", goodsDto.getImg());
		model.addAttribute("pageNum",pageNum);
		
		return ".teamb.goods.editForm";//editForm.jsp 뷰 리턴
	}
	
	@RequestMapping(value="editPro.do",method=RequestMethod.POST)
	public String editPro(@ModelAttribute("goodsDto") GoodsDTO goodsDto,MultipartHttpServletRequest mRequest, 
			HttpServletRequest request,String pageNum,Model model) 
					throws IOException{
		
		String realPath=request.getSession().getServletContext().getRealPath("/");	
		String upPath=realPath+"/resources/flowerimgs/";
		
		MultipartFile uploadFile=mRequest.getFile("imgFile");
		
		if(!uploadFile.isEmpty()) {
			String originalFileName=uploadFile.getOriginalFilename();//원래 파일 이름
			uploadFile.transferTo(new File(upPath+originalFileName));
			goodsDto.setImg(originalFileName);//DB에 저장하기 위해서
		}
		goodsDto.setImg(goodsDto.getImg());
		
		sqlSession.update("goods.updateGoods",goodsDto);
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/goods/goodsList.do";
	}
	
	@RequestMapping("delete.do")
	public String deleteP(Model model,int id,String pageNum) {
		
		sqlSession.delete("goods.deleteGoods", id);
		
		model.addAttribute("pageNum",pageNum);
		
		return "redirect:/goods/goodsList.do";
	}
}
