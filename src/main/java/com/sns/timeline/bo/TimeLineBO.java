package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.model.CommentView;
import com.sns.post.bo.PostBO;
import com.sns.post.model.Post;
import com.sns.timeline.model.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

@Service
public class TimeLineBO { 
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CommentBO commentBO;
	
	// 로그인이 되지 않은 사람도 카드 목록이 보여야 한다.
	public List<CardView> generateCardList(){
		
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글목록 가져오기 (post)
		List<Post> postList = postBO.getPostList();
		
		//postList 글 하나하나 뽑는 반복문 => CardView => cardViewList에 넣는다.
		for (int i = 0; i < postList.size(); i++) {
			CardView cardView = new CardView();
			// 글
			cardView.setPost(postList.get(i));
			
			//글쓴이
			User user = userBO.getUserById(postList.get(i).getUserId());
			cardView.setUser(user);
			
			// 글 하나에 해당하는 댓글들 
			List<CommentView> commentList = commentBO.generateCommentViewLsitByPostId(postList.get(i).getId());
			cardView.setCommentList(commentList);
			
			// 내가 좋아요를 눌렀는지 filledLike
			
			// 카드리스트에 채우기!
			cardViewList.add(cardView);
		}
		return cardViewList;
	}
	
}
