package com.sns.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.dao.CommentDAO;
import com.sns.comment.model.Comment;
import com.sns.comment.model.CommentView;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

@Service
public class CommentBO {

	@Autowired
	private CommentDAO commentDAO;
	
	@Autowired
	private UserBO userBO;	
	
	
	public void addCommentByContent(int userId, int postId, String content) {
		commentDAO.insertCommentByContent(userId, postId, content);
	}
	
	private List<Comment> getCommentListByPostId(int postId){
		// 글 번호에 해당되는 애만 가져온다.
		return commentDAO.selectCommentListByPostId(postId);
	}
	
	public List<Comment> getCommentList(){
		return commentDAO.selectCommentList();
	}
	
	// input : 글 번호
	// output: 글 번호에 해당하는 댓글(+댓글쓴이 정보) 목록을 가져온다.
	public List<CommentView> generateCommentViewLsitByPostId(int postId){
		
		// 결과물 담을 객체
		List<CommentView> commentViewList = new ArrayList<>();
		
		// 댓글 목록 가져오기
		List<Comment> commentList = getCommentListByPostId(postId);
		
		// 반복문 => commentView 넣고 = > 결과물에 넣는다.
		for (Comment comment : commentList) {
			CommentView commentView = new CommentView();
			// 댓글 넣기
			commentView.setComment(comment);
			
			// 댓글쓴이 넣기
			User user = userBO.getUserById(comment.getUserId());
			commentView.setUser(user);
			
			// 리스트에 넣기
			commentViewList.add(commentView);
		}
		
		//결과물 리턴
		return commentViewList;
		
	}
	public void deleteCommentByUserIdPostId(int userId, int postId) {
		commentDAO.deleteCommentByUserIdPostId(userId, postId);
	}
}
