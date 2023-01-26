package com.sns.post.bo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.comment.bo.CommentBO;
import com.sns.common.FileManagerService;
import com.sns.like.bo.LikeBO;
import com.sns.post.dao.PostDAO;
import com.sns.post.model.Post;

@Service
public class PostBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());// slf4j 임포트 - 로그를 찍고 싶은 부분에서 사용하면 됌.
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	public int addPost(String content, 
			MultipartFile file, int userId, String loginId) {
		
		// 파일 업로드 => 내 컴퓨터 서버에만 올린다. 경로로 보여지기.
		String imagePath = null;
		if (file != null) {
			// 파일이 있을 때만 업로드 -> 이미지 경로를 얻어냄
			imagePath = fileManagerService.saveFile(loginId, file);
		}
		
		return postDAO.insertPost(content, imagePath, userId);
	}
	
	public int deletePostByPostIdUserId(int postId, int userId) {
		
		// 기존 글 가져오기
		Post post = getPostByPostIdUserId(postId, userId);
		if (post == null) {
			logger.warn("[글 삭제] post is null. postId:{}, userId{}", postId, userId);
			return 0;
		}
		// 이미지 있으면 이미지 삭제
		if (post.getImagePath() != null) {
			fileManagerService.deleteFile(post.getImagePath());
		}
		// 글 삭제
		
		// 댓글들 삭제
		commentBO.deleteCommentByUserIdPostId(userId, postId);
		// 좋아요 삭제
		likeBO.deleteLikeByPostIdUserId(postId, userId);
		
		return postDAO.deletePostByPostIdUserId(postId, userId);
	}
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
	
	public Post getPostByPostIdUserId(int postId, int userId) {
		return postDAO.selectPostByPostIdUserId(postId, userId);
	}
	
}
