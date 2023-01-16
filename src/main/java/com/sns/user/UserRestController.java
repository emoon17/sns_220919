package com.sns.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.common.EncryptUtils;
import com.sns.user.bo.UserBO;
import com.sns.user.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
@RequestMapping("/user")
@RestController
public class UserRestController {
	
	@Autowired
	private UserBO userBO;
	/**
	 * 아이디 중복확인 API
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId){
		//select하기
		Map<String, Object> result = new HashMap<>();
		boolean isDuplicated = userBO.existLoginId(loginId);
		//중복일 때 아닐 때 코드 구분
		if (isDuplicated) {
			// 중복일 때
			result.put("code", 1);
			result.put("result", true);
		} else {
			
			result.put("result", false);
			
		}
		//응답내리기
		return result;
	}
	
	/**
	 * 회원가입 API
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@RequestMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email
			){
		//비밀번호 해싱하기
		String HashedPassword = EncryptUtils.md5(password);
		
		//db insert하기
		userBO.addUser(loginId, HashedPassword, name, email);
		
		Map<String, Object> result = new HashMap<>();
		result.put("code", 1);
		result.put("result", "성공");
		
		//응답 내리기
		return result;
	}
	
	/**
	 *  로그인 API
	 * @param loginId
	 * @param password
	 * @param request
	 * @return
	 */
	@PostMapping("sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request){
		
		// 비빌번호 해싱하기
		String HashedPassword = EncryptUtils.md5(password);
		
		//db select
		User user = userBO.getUserByIdPassword(loginId, HashedPassword);
		
		// result 코드 구분, session 담기
		Map<String, Object> result = new HashMap<>();
		if (user != null) {
			result.put("code", 1);
			result.put("result", "성공");
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("loginId", user.getLoginId());
			session.setAttribute("name", user.getName());
			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "존재하지 않는 사용자입니다");
		}
		
		// 응답하기
		return result;
	}
}
