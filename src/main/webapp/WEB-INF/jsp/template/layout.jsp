<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Moonstagram</title>
	<!-- jquery : bootstrap, datepicker -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>  

        <!-- bootstrap -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        
        <link rel="stylesheet" type="text/css" href="/static/css/signup.css">
</head>
<body>
  <div id="wrap">
            <header>
               <jsp:include page="../include/header.jsp"/>
            </header>
            
            <section class="contents d-flex mt-5">
                <div class="input-boxs justify-content-center col-12">
                    <input type="text" id="address" name="address" placeholder="휴대폰 번호 또는 이메일주소" style="height:50px;" class="form-control pl-3 mt-3">
                    <input type="text" id="name" name="name" placeholder="성명" style="height:50px;" class="form-control pl-3 mt-3">
                    <input type="text" id="userId" name="userId" placeholder="아이디" style="height:50px;" class="form-control pl-3 mt-3">
                    <input type="password" id="password" name="password" placeholder="비밀번호" style="height:50px;" class="form-control pl-3 mt-3">
                    <div class="login_btn">
                        <button type="button" class="btn btn-primary mt-5" style="width:370px; height:50px;">가입</button>
                    </div>
                    <div class="line"></div>
                </div>
                
            </section>
            <footer>
                <div class="forget-box">
                    <div class="text-center"><a href="#" class="password-forget">비밀번호를 잊으셨나요?</a></div>
                    <div class="text-center">계정이 있으신가요? <a href="#" class="sing-up text-primary font-weight-bold"> 로그인</a></div>
                    
                </div>
            </footer>
        </div>
</body>
</html>