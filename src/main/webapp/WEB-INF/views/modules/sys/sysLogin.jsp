<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" href="${ctxStatic}/images/icon/1.ico" type="image/x-icon"/>  
<title>珠海市政府数据资产普查系统</title>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static" />
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1,user-scalable=0" />

<link rel="shortcut icon" href="${ctxStatic}/favicon.ico">
<link href="${ctxStatic}/css/bootstrap.min.css?v=3.3.6"
	rel="stylesheet">
<!-- <link rel="stylesheet" href="${ctxStatic}/static/css/system/system/login.css" /> -->
<link href="${ctxStatic}/css/index.css" rel="stylesheet">
<%--<link rel="stylesheet"--%>
	<%--href="${ctxStatic}/static/css/skin/skin-<%=ServiceUtil.getThemeType(10)%>.css">--%>

<!--[if lte IE 8]><script>window.location.href='http://cdn.dmeng.net/upgrade-your-browser.html?referrer='+location.href;</script><![endif]-->

<style>
  .min-width-wrapper {width: 100%;min-width: 1200px;}
  .login {position: relative;width: 100%;height: 100vh;min-height: 620px;text-align: center;min-height: 620px;}
	.skin-1 .login{background: linear-gradient(#015293 50%, #fff 50%);background: -moz-linear-gradient(#015293 50%, #fff 50%);background: -webkit-linear-gradient(#015293 50%, #fff 50%);background: -o-linear-gradient(#015293 50%, #fff 50%);}
  .skin-1 .login-wrapper {position: absolute; top: 50%; left: 50%; width: 718px;margin-left: -359px;margin-top: -250px;}
  .skin-1 .login-wrapper .login-box{border-radius: 10px;margin: 30px auto;width: 718px;height: 350px;background: #fff;box-shadow: 2px 2px 2px #888888; padding: 60px;}
  .skin-1 .login-wrapper .content-left {width: 300px;}
  .skin-1 .login-wrapper .case-verify {width: 210px;}
  .skin-1 .pull-right .img {margin-top: -20px;}
  .skin-1 .btn-submit {background: #015293;color: #fff;}
  .skin-1 .btn-submit:hover {background: #0060ad;}
  .copyright {color: #444;font-size: 14px;}
  .title {font-size: 40px;color: #fff;line-height: 56px;display: inline-block;}
</style>
<body class="skin-1 min-width-wrapper">
	<div class="login">
    <div class="login-wrapper register-page">
      <div class="title">
    		<img class="logo" src="${ctxStatic}/images/skin/skin-1/dnalogo.png"/>
           珠海市政府数据资产普查系统
    	</div>
      <div class="login-box clearfix">
        <!--<div class="pull-left register-page-case content-left">
          <form id="loginForm" action="${ctx}/login" method="post">
            <div class="form-group user-case case">
              <input class="form-control" type="text"
                id="accountNameId" name="accountName" required="required"
                placeholder="请输入用户名">
            </div>
            <div class="form-group lock-case case">
              <input class="form-control" type="password"
                id="passwordId" name="password" required="required"
                maxlength="16" class="form-control" placeholder="请输入密码">
            </div>
            <div class="form-group verify-case case clearfix">
                <input class="form-control case-verify pull-left"
                  id="verifyCodeId" name="verifyCode" required="required"
                  maxlength="4" type="tel" class="form-control"
                  placeholder="请输入验证码" title="验证码"
                  onkeyup="this.value=this.value.replace(/\D/g,'')">
                  <img class="verify pull-right" id="vimg" style="cursor: pointer;" title="验证码"
                  width="90" height="34" src="${pageContext.request.contextPath}/login/verifyCode?random=0.7304289337922849" />
            </div>
              <input class="btn btn-default btn-submit btn-block" type="submit" value="登 录"/>
            <%--<button type="button" id="loginBtn" class="btn btn-default btn-submit btn-block">登 录</button>--%>
          </form>
        </div>-->
          <div class="pull-left register-page-case content-left">
              <form id="loginForm" action="${ctx}/login" method="post">
                  <div class="form-group user-case">
                      <input class="form-control" type="text"
                             id="loginName" name="loginName"
                             required="required" value="admin" autocomplete="off">
                  </div>
                  <div class="form-group lock-case">
                      <input class="form-control" type="password"
                             id="password" name="password"
                             required="required" maxlength="16" value="123456" autocomplete="off">
                  </div>
                  <div class="form-group verify-case clearfix">
                      <input class="form-control case-verify pull-left" id="verifyCodeId"
                          name="verifyCode" required="required" maxlength="4" type="tel"
                          onkeyup="this.value=this.value.replace(/\D/g,'')"> <img
                          class="verify pull-right" id="vimg" style="cursor: pointer;"
                          title="验证码" width="90" height="34"
                          src="${pageContext.request.contextPath}/login/verifyCode?random=0.7304289337922849"
                          autocomplete="off">
                          
                          <!-- 用于测试 -->
                      <!-- 	 <input type=hidden name="verifyCodeNum" value=""> -->
                       
                  </div>
                  <input class="btn btn-default btn-submit btn-block" type="submit" value="登 录"/>&nbsp;&nbsp;
                  <a
                          href="${ctxStatic}/upload/ChromeStandalone_56.0.2924.87_Setup.exe"
                          class="download-chrome pull-right">适配浏览器下载</a>
              </form>
          </div>
        <div class="pull-right">
          <img class="img" src="${ctxStatic}/images/skin/skin-1/zt.png"/>
        </div>
      </div>
      <p class="copyright">Copyright © 2017 国脉海洋信息发展有限公司</p>
      
    </div>
  </div>
	<!-- <div class="register-page">
		<div class="container-fluid">
			<div class="row skin-bg">
				<div
					class="col-md-4 col-sm-6 col-xs-10 col-md-offset-4 col-sm-offset-3 col-xs-offset-1 page-case">
					<h2 class="text-center title">
					</h2>
					<div class="register-page-case">
						<h3>账号登录</h3>
						<form id="loginForm" method="post">
							<div class="form-group user-case case">
								<i></i> <input class="form-control" type="text"
									id="accountNameId" name="accountName" required="required"
									placeholder="请输入用户名">
							</div>
							<div class="form-group lock-case case">
								<i></i> <input class="form-control" type="password"
									id="passwordId" name="password" required="required"
									maxlength="16" class="form-control" placeholder="请输入密码">
							</div>
							<div class="form-group verify-case case">
								<div class="">
									<i></i> <input class="form-control case-verify"
										id="verifyCodeId" name="verifyCode" required="required"
										maxlength="4" type="tel" class="form-control"
										placeholder="请输入验证码"
										onkeyup="this.value=this.value.replace(/\D/g,'')"> <img
										class="verify" id="vimg" style="cursor: pointer;" title="验证码"
										width="60" height="34" />
								</div>
							</div>
							<button type="button" id="loginBtn"
								class="btn btn-default btn-submit btn-block">登 录</button>
							<a
								href="${base}/upload/excel/ChromeStandalone_56.0.2924.87_Setup.exe"
								class="download-chrome pull-right">适配浏览器下载</a>
						</form>
					</div>
				</div>
			</div>
			<p class="last-copyright">Copyright © 2016 国脉海洋信息发展有限公司</p>
		</div>
	</div> -->
	<!-- /signup-box -->
	<!-- <script src="${ctxStatic}/js/jquery.min.js?v=2.1.4"></script> -->
  <!-- [if !IE]> -->
        <script src="${ctxStatic}/js/jquery.min.js" type="text/javascript"></script>
    <!-- <![endif] -->


    <!--[if lte IE 8] -->
         <script src="${ctxStatic}/js/jquery-1.9.1.js" type="text/javascript"></script>
    <!-- [endif] -->
	<script src="${ctxStatic}/js/jquery/jquery.md5.js"></script>
	<script src="${ctxStatic}/js/plugins/layer/layer.js"></script>
	<script>
  var base = '${ctxStatic}';
  function toIndex(){
    location.href=base+'/backstage/index';
  }
  layer.config({
	     extend: '../extend/layer.ext.js'
	   });
</script>
	<script src="${ctxStatic}/js/system/login/login.js"></script>
	<script>
// $(function() {
//   heightAuto()
//   $(window).resize(function(event) {
//     heightAuto()
//   });
// })
// function heightAuto() {
//   if (!$('body').hasClass('skin-4') && !$('body').hasClass('skin-5')) {
//     console.log('skin');
//     var box = $('.page-case'),
//       boxH = box.height(),
//       windowH = $(window).height();
//     if (windowH > boxH) {
//       box.css('marginTop', (windowH - boxH) / 2)
//     } else {
//       box.css('marginTop', 0)
//     }
//   }
// }

//刷新验证码
$("#vimg").click(function () {
    $("#vimg").attr("src", "${pageContext.request.contextPath}/login/verifyCode?random=" + Math.random());
    //setTimeout(function(){getVerifyCodeNum()},100)    用于测试
});



//用于测试
/* $(function(){
	getVerifyCodeNum();
}) */


//用于测试
/* function getVerifyCodeNum(){
	var url = "${pageContext.request.contextPath}/login/verifyCodeNum?random=" + Math.random();
	$.get(url,function(result){
		$("input[name='verifyCodeNum']").val(result);
	})
}
 */
 
 
</script>

	<%--<%@include file="../common/dialog.jsp"%>--%>
</body>
</html>