package co.kr.teamb;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import co.kr.teamb.dto.CartDTO;
import co.kr.teamb.dto.OrderlistDTO;
import co.kr.teamb.dto.UserDTO;

@RequestMapping("/cart")
@Controller
public class CartController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("cartList.do")
	public String CartL(Model model, HttpServletRequest request) {
		
		List<CartDTO> list=null;
		
		HashMap<String,Object> map=new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		
		map.put("uid", session.getAttribute("id"));
		list=sqlSession.selectList("cart.cartList",map);
		
		model.addAttribute("list",list);
		
		return ".teamb.cart.cartList";//insertCartForm.jsp
	}
	
	@RequestMapping(value="/insertCartPro.do",method=RequestMethod.POST)
	public String insertCartP(@ModelAttribute("cartDto") CartDTO cartDto,
			HttpServletRequest request,int gid, String uid){
		
		cartDto.setGid(gid);
		cartDto.setUid(uid);
		
		int goodsStock=sqlSession.selectOne("cart.goodsList",gid);
		
		int stock=Integer.parseInt(request.getParameter("stock"));
		if(stock>goodsStock) {
			request.setAttribute("msg","재고보다 적은 수량을 입력해 주세요.");
			 
			 return "alert";
		}else {
			cartDto.setStock(stock);
		}
		List<CartDTO> list=null;
		
		HashMap<String,Object> map=new HashMap<String, Object>();
		
		map.put("uid", uid);
		map.put("gid", gid);
		
		list=sqlSession.selectList("cart.cartList", uid);
		
		int x=0;
		for(CartDTO i:list) {
			if((gid+"").equals(i.getGid()+"")) {
				x=1;
				break;
			}else {
				x=0;
			}
		}
		
		if(x==1) {
			sqlSession.update("cart.cartUpdate", cartDto);
			request.setAttribute("msg","구매 수량 수정 되었습니다.");
		}else if(x==0){
			sqlSession.insert("cart.insertCart", cartDto);
			request.setAttribute("msg","장바구니에 추가 되었습니다.");
		}else {
			
		}
		
		return "alert";
	}
	
	@RequestMapping("cartUpdate.do")
	public String cartUpdate(@ModelAttribute("cartDto") CartDTO cartDto,
			HttpServletRequest request,int gid, String uid) {
		
		int goodsStock=sqlSession.selectOne("cart.goodsList",gid);
		int stock=Integer.parseInt(request.getParameter("stock"));
		cartDto.setStock(stock);
		
		if(stock>goodsStock) {
			request.setAttribute("msg","재고보다 적은 수량을 입력해 주세요.");
			 
			 return "alert";
		}else {
			cartDto.setStock(stock);
			request.setAttribute("msg","수량 수정 되었습니다.");
		}
		
		
		sqlSession.update("cart.cartUpdate", cartDto);
		
		return "alert";
	}
	
	@RequestMapping("cartDelete.do")
	public String cartDelete(@ModelAttribute("cartDto") CartDTO cartDto,
			HttpServletRequest request,int gid) {
		HttpSession session = request.getSession();
		
		cartDto.setUid((String)session.getAttribute("id"));
		
		sqlSession.delete("cart.cartDelete", cartDto);
		
		return "redirect:/cart/cartList.do";
	}
	
	@RequestMapping("orderListInsertForm.do")
	public String orderListInsertF(@ModelAttribute("OrderlistDTO") OrderlistDTO orderlistDTO, @ModelAttribute("cartDto") CartDTO cartDto, @ModelAttribute("UserDto") UserDTO userDto,
			HttpServletRequest request,int gid,Model model) {
		
		List<CartDTO> list=null;
		List<OrderlistDTO> list2=new ArrayList<OrderlistDTO>();
		
		HashMap<String,Object> map=new HashMap<String, Object>();
		HashMap<String,OrderlistDTO> map2=new HashMap<String, OrderlistDTO>();
		
		OrderlistDTO orderlist=new OrderlistDTO();
		
		HttpSession session = request.getSession();
		map.put("uid", session.getAttribute("id"));
		
		list=sqlSession.selectList("cart.cartList",map);
		
		String userid=(String)session.getAttribute("id");
		String tel=(String)session.getAttribute("tel");
		String name=(String)session.getAttribute("name");
		String zipcode=(String)session.getAttribute("zipcode");
		String address=(String)session.getAttribute("address");
		
		for(CartDTO i:list) {
			if((gid+"").equals(i.getGid()+"")) {
				int goodsid=i.getGid();
				int stock=i.getStock();
				String img=i.getImg();
				int price=i.getPrice();
				
				String gName=i.getName();
				
				model.addAttribute("gid",goodsid);
				model.addAttribute("stock",stock);
				model.addAttribute("img",img);
				model.addAttribute("price",price);
				model.addAttribute("gName",gName);
				
				orderlist.setUid(userid);
				orderlist.setGid(goodsid);
				orderlist.setName(name);
				orderlist.setTel(tel);
				orderlist.setZipcode(zipcode);
				orderlist.setAddress(address);
				orderlist.setImg(img);
				orderlist.setStock(stock);
				orderlist.setPrice(price);
			}
			map2.put(i.getGid()+"", orderlist);
			list2.add(orderlist);
		}
		
		model.addAttribute("uid",userid);
		model.addAttribute("tel",tel);
		model.addAttribute("name",name);
		model.addAttribute("zipcode",zipcode);
		model.addAttribute("address",address);
		
		model.addAttribute("list",list2);
		
		return ".teamb.cart.orderListInsertForm";
	}
	
	@RequestMapping("orderListInsertPro.do")
	public String orderListInsertP(@ModelAttribute("OrderlistDTO") OrderlistDTO orderlistDTO, @ModelAttribute("cartDto") CartDTO cartDto,
			HttpServletRequest request) {
		
		orderlistDTO.setGid(Integer.parseInt(request.getParameter("gid")));
		orderlistDTO.setUid(request.getParameter("uid"));
		orderlistDTO.setName(request.getParameter("name"));
		orderlistDTO.setTel(request.getParameter("tel"));
		orderlistDTO.setZipcode(request.getParameter("zipcode"));
		orderlistDTO.setAddress(request.getParameter("address"));
		orderlistDTO.setImg(request.getParameter("img"));
		orderlistDTO.setStock(Integer.parseInt(request.getParameter("stock")));
		orderlistDTO.setPrice(Integer.parseInt(request.getParameter("price")));
		
		cartDto.setGid(Integer.parseInt(request.getParameter("gid")));
		cartDto.setUid(request.getParameter("uid"));
		
		sqlSession.update("cart.insertOrder", orderlistDTO);
		sqlSession.delete("cart.cartDelete", cartDto);
		
		return "redirect:/cart/cartList.do";
	}
	
}
