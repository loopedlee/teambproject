package co.kr.teamb;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {		
		return ".teamb.layout";
	}
	
	@RequestMapping(value = "/test1.do", method = RequestMethod.GET)
	public String test1Form() {
		return ".teamb.test.test1";
	}
	
	@RequestMapping(value = "/test2.do", method = RequestMethod.GET)
	public String test2Form() {
		return ".teamb.test.test2";
	}
	
}
