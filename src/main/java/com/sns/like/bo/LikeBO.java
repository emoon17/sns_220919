package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.dao.LikeDAO;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;
	
	public void likeTogle(int postId, int userId){
		// 좋아요가 있는지 확인
		if (likeDAO.selectLikeCountByPostIdOrUserId(postId, userId) > 0) {
			// 있으면 제거
			likeDAO.deleteLikeByPostIdUserId(postId, userId);
		} else {
			// 없으면 추가
			likeDAO.insertLikeByPostIdUserId(userId, postId);
		}
	}
	
	public boolean existLike(int postId, Integer userId) {
		// 비로그인인지 확인도 해야 됌.(비로그인도 받긴 할거기 때문에 Integer)
		
		if (userId == null) { // 비로그인
			return false;
		}
		// 로그인
		return likeDAO.selectLikeCountByPostIdOrUserId(postId, userId) > 0 ? true : false;
		
	}
	
	//행의 갯수를 가져오기
	public int getLikeCountByPostId(int postId) {
		return likeDAO.selectLikeCountByPostIdOrUserId(postId, null);
	}
	
	
}
