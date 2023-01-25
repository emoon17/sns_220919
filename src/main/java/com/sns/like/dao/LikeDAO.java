package com.sns.like.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {

	public void insertLikeByPostIdUserId(
			@Param("userId") int userId,
			@Param("postId") int postId);
	
	//public boolean existLike(
	//		@Param("postId") int postId, 
	//		@Param("userId") int userId);
	
	//public int selectLikeCountByPostId(int postId);
	
	public void deleteLikeByPostIdUserId(
			@Param("postId") int postId,
			@Param("userId") int userId
			);
	
	public int selectLikeCountByPostIdOrUserId(
			@Param("postId") int postId, 
			@Param("userId") Integer userId);
}
