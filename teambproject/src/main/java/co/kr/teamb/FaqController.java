package co.kr.teamb;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession; // MyBatis 사용
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import co.kr.teamb.dto.FaqDTO;

@RequestMapping("/faq")
@Controller

public class FaqController {
   @Autowired
   SqlSession sqlSession; //자동 setter작업
   
   @RequestMapping("/insertForm.do")
   public String insertForm() {
      return ".teamb.faq.insertForm";
   }
   
   		//insert 작업
 		@RequestMapping(value="/insertPro.do",method=RequestMethod.POST)
 		public String insertAA(@ModelAttribute("faqDto") FaqDTO faqDto, HttpServletRequest request) {
 			
 			sqlSession.insert("faq.insertFAQ", faqDto);
 			
 			return "redirect:/faq/list.do";
 		}
 		
 				//list 
 				@RequestMapping("/list.do")
 				public ModelAndView listdo() {
 					
 					List<HashMap<String, String>> list 
 					= sqlSession.selectList("faq.selectAll");
 					
 					ModelAndView mv = new ModelAndView(".teamb.faq.list", "list", list);
 					
 					return mv; //뷰 리턴
 				}
 				
 				//글내용보기
 				@RequestMapping("/content.do")
 				public String content(Model model, String num) {
 				
 				int num1=Integer.parseInt(num);
 				
 				System.out.println(num1);
 				
 				FaqDTO faqDto=sqlSession.selectOne("faq.selectOne", num1);
 				
 				model.addAttribute("id",num1);
 				
 				model.addAttribute("FaqDto", faqDto);

 				return ".teamb.faq.content";
 			
 				}
 				
 				//글수정 폼
 				  @RequestMapping("/editForm.do")
 				  public String editForm(String num, Model model) {
 					  int num1=Integer.parseInt(num);
 					  FaqDTO faqDto=sqlSession.selectOne("faq.RewriteFaq",num1);
 					  model.addAttribute("FaqDto",faqDto);
 					  
 					 return ".teamb.faq.editForm";
 				  }
 				  
 				//DB글 수정
 				  @RequestMapping(value="/editPro.do",method=RequestMethod.POST)
 				  public String editPro(FaqDTO faqDto, Model model) {
 					  
 					  sqlSession.update("faq.faqUpdate",faqDto);
 					  
 					  return "redirect:/faq/list.do";
 				  }
 				  
 				
 				//DB글 삭제
 				  @RequestMapping("/delete.do")
 				  public String deletePro(Model model,String num) {
 					  
 					  sqlSession.delete("faq.faqDelete",new Integer(num));
 					  
 					  
 					  return "redirect:/faq/list.do";
 				  }

}//class-end
   
   