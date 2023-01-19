package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.post.dao.PostDAO;
import com.sns.post.model.Post;

@Service
public class PostBO {
	
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
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
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
}
