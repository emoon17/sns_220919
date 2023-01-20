package com.sns.timeline.model;

import java.util.List;

import com.sns.comment.model.CommentView;
import com.sns.post.model.Post;
import com.sns.user.model.User;

// View용 객체
// 글 1개와 매핑
public class CardView {
	// 글 1개 - 포스트 객체 가져오기 
	private Post post;
	
	// 글쓴이 정보 - user 객체 가져오기
	private User user;

	// 댓글들 N개
	private List<CommentView> commentList;
	
	// 내가(로그인 된 사람) 좋아요를 눌렀는지 (boolean)
	private boolean filledLike;
	
	//좋아요 개수
	

	public boolean isFilledLike() {
		return filledLike;
	}

	public void setFilledLike(boolean filledLike) {
		this.filledLike = filledLike;
	}

	// post g-stter
	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	// 댓글 g-stter
	public List<CommentView> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<CommentView> commentList) {
		this.commentList = commentList;
	}


	
	
	
	
}
