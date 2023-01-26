package com.sns.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.model.Post;

@Repository
public interface PostDAO {
	public List<Map<String, Object>> selectPostListTest();
	
	public int insertPost(
			@Param("content") String content, 
			@Param("imagePath") String imagePath,
			@Param("userId") int userId);
	
	public List<Post> selectPostList();
	
	public Post selectPostByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	public int deletePostByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
}
