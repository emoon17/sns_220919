package com.sns.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public interface PostDAO {
	public List<Map<String, Object>> selectPostListTest();
	
	public int insertPost(
			@Param("content") String content, 
			@Param("imagePath") String imagePath,
			@Param("userId") int userId);
}
