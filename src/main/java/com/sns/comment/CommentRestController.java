package com.sns.comment;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.comment.bo.CommentBO;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/comment")
@RestController
public class CommentRestController {

	@Autowired
	private CommentBO commentBO;
	
	@GetMapping("/create")
	public Map<String, Object> createComment(
			@RequestParam("content") String content,
			@RequestParam("postId") int postId,
			HttpSession session){

		Map<String, Object> result = new HashMap<>();
		
		//session으로 userId 가져오기
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 500);
			result.put("errorMessage", "로그인을 다시 해주세요.");
			return result;
		}
		
		// 로그인 된 사람은 - insert
		commentBO.addCommentByContent(userId, postId, content);
		result.put("code", 1);
		result.put("result", "성공");
				
		// 응답하기
		return result;
	}
}
