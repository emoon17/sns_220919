package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sns.post.bo.PostBO;
import com.sns.post.model.Post;

import jakarta.servlet.http.HttpSession;

@Controller
public class timelineController {

	@Autowired
	private PostBO postBO;
	
	/**
	 * 타임라인 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/timeline/timeline_view")
	public String timelineView(Model model) {
		
		
		// select
		List<Post> postList = postBO.getPostList();
		model.addAttribute("postList", postList);
		
		// 응답 내리기
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
	
}
