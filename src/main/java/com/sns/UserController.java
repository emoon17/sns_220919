package com.sns;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;
@RequestMapping("/user")
@Controller
public class UserController {

	// 회원가입
	/**
	 * 회원가입 URL
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/signUp"); 
		return "template/layout";
	}
	
	/**
	 * 로그인 URL
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/signIn");
		return "template/layout";
	}
	
	@GetMapping("/sign_out")
	public String singOutView(HttpSession session) {
		//로그아웃 - 세션에 있는 모든 것들을 비운다.
		session.removeAttribute("userId");
		session.removeAttribute("loginId");
		session.removeAttribute("name");
		
		// redirect
		return "redirect:/user/sign_in_view";
	}
	
	
}
