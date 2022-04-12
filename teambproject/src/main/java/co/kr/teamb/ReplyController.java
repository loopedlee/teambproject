package co.kr.teamb;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import co.kr.teamb.dto.ReplyDTO;

@RequestMapping("/reply")
@Controller
public class ReplyController {

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/addreply.do", method = RequestMethod.POST)
	@ResponseBody
	public List<ReplyDTO> addreply(HttpServletRequest request) {
		
		String cid = request.getParameter("cid");
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		
		System.out.println(cid);
		System.out.println(writer);
		System.out.println(content);
		
		int num = Integer.parseInt(cid);
		
		HashMap<String, Object> rlist = new HashMap<String, Object>();
		
		rlist.put("cid", cid);
		rlist.put("writer", writer);
		rlist.put("content", content);
		
		sqlSession.update("reply.addComment",cid);
		
		sqlSession.insert("reply.addReply", rlist);
		
		List<ReplyDTO> list = sqlSession.selectList("reply.viewReply",num);
		
		System.out.println(list);
		
		return list;
	}
	
	@RequestMapping(value="/deleterp.do", method = RequestMethod.POST)
	@ResponseBody
	public List<ReplyDTO> deletereply(HttpServletRequest request){
		
		int cid = Integer.parseInt(request.getParameter("cid"));
		
		int rid = Integer.parseInt(request.getParameter("rid"));
		
		sqlSession.delete("reply.delReply",rid);
		
		sqlSession.update("reply.removeComment", cid);
		
		List<ReplyDTO> list = sqlSession.selectList("reply.viewReply",cid); 
		
		return list;
		
	}
	
	@RequestMapping(value="/updaterp.do", method = RequestMethod.POST)
	@ResponseBody
	public List<ReplyDTO> updatereply(HttpServletRequest request){
		
		int cid = Integer.parseInt(request.getParameter("cid"));
		
		int rid = Integer.parseInt(request.getParameter("rid"));
		
		String content = request.getParameter("content");
		
		System.out.println(rid);
		
		System.out.println(content);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("rid", rid);
		map.put("content", content);
		
		sqlSession.update("reply.updateReply", map);
		
		List<ReplyDTO> list = sqlSession.selectList("reply.viewReply",cid);
		
		return list;
		
	}
}
