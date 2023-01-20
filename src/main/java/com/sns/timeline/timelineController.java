package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sns.timeline.bo.TimeLineBO;
import com.sns.timeline.model.CardView;

@Controller
public class timelineController {

	@Autowired
	private TimeLineBO timelineBO;
	
	/**
	 * 타임라인 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/timeline/timeline_view")
	public String timelineView(Model model) {
		
		
		// select
		//List<Post> postList = postBO.getPostList(); // 글만 있는 비오
		//model.addAttribute("postList", postList);
		
		// 카드뷰로 카드 가져오기 - 댓글,글,사진 다 있는 거
		List<CardView> cardList = timelineBO.generateCardList();
		model.addAttribute("cardList", cardList);
		
		// 응답 내리기
		model.addAttribute("viewName", "timeline/timeline");
		return "template/layout";
	}
	
}
