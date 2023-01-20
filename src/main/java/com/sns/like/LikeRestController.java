package com.sns.like;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LikeRestController {

	
	//togle기능이 들어가는 API
	/*@GetMapping("/like/{postId}") // = like?postId=13 @RequestParam , like/13@PathVariable
	public Map<String, Object> like(
			@PathVariable int postId){
		*/// 로그인 정보, 어느글에 눌렀는지.
		
	//}
}
