package com.sns.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.bo.PostBO;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@RestController
public class PostRestController {

	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpSession session){
		
		//필요한 세션 가져오기
		int userId = (int)session.getAttribute("userId");
		String loginId = (String)session.getAttribute("loginId");
		
		//db insert
		int rowCount = postBO.addPost(content, file, userId, loginId);
		//code 구분
		Map<String, Object> result = new HashMap<>();
		if (rowCount > 0) {
			result.put("code", 1);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("errorMessage", "관리자에게 문의해주세요");
		}
		
		// 응답내리기
		return result;
	}
}
