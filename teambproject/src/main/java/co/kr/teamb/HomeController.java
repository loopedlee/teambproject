package co.kr.teamb;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import co.kr.teamb.dto.GoodsDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlSession;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {		
		
		List<GoodsDTO> list = null;
		
		list = sqlSession.selectList("goods.selectRate");
		
		model.addAttribute("rate",list);
		
		list = sqlSession.selectList("goods.selectReadCount");
		
		model.addAttribute("read",list);
		
		list = sqlSession.selectList("goods.selectSales");
		
		model.addAttribute("sales",list);
		
		return ".teamb.layout";
	}
	
}
