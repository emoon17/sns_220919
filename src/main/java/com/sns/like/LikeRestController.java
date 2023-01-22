package com.sns.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.sns.like.bo.LikeBO;

import jakarta.servlet.http.HttpSession;

@RestController
public class LikeRestController {

	@Autowired
	private LikeBO likeBO;
	
	//togle기능이 들어가는 API
	@GetMapping("/like/{postId}") // = like?postId=13 @RequestParam , like/13@PathVariable
	public Map<String, Object> like(
			@PathVariable int postId,
			HttpSession session){
		// 로그인 정보, 어느글에 눌렀는지.
		Map<String, Object> result = new HashMap<>();
		
		//userId 가져오기
		Integer userId = (Integer)session.getAttribute("userId"); 
		
		if (userId == null) {
			result.put("code", 500);
			result.put("errorMessage", "로그인을 다시 해주세요.");
			return result;
		}
		//로그인 된 사람은 insert 
		likeBO.addLikeByPostIdUserId(userId, postId);
		result.put("code", 1);
		
		//응답 내리기
		return result;
	}
}
