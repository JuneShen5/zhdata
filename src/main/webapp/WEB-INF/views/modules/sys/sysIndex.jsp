<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="renderer" content="webkit">
		<title>珠海市政府数据资源普查系统</title>
		<%@ include file="/WEB-INF/views/include/head.jsp"%>
		<link rel="stylesheet" href="${ctxStatic}/css/index.css">
		<link rel="stylesheet" href="${ctxStatic}/css/skin/skin.css">
		<link href="${ctxStatic}/fonts/default-font/iconfont.css" rel="stylesheet">
		<link href="${ctxStatic}/js/plugins/tab/tab.css" rel="stylesheet">
		<!-- <link rel="stylesheet"
			href="${ctxStatic}/static/css/skin/skin-<//%=ServiceUtil.getThemeType(10)%>.css"> -->
		<!--[if lte IE 8]><script>window.location.href='http://cdn.dmeng.net/upgrade-your-browser.html?referrer='+location.href;</script><![endif]-->
	</head>
	<style>
		.rel {
			position: relative;
		}

		.default-skin {
			background-color: #d2d2d3;
		}

		.default-skin:hover {
			background-color: #b8b8b9;
		}

		.black-skin {
			background-color: rgb(111, 111, 111);
		}

		.black-skin:hover {
			background-color: rgb(60, 60, 60);
		}

		.blue-skin {
			background: rgb(121, 136, 160);
		}

		.blue-skin:hover {
			background: rgb(72, 96, 134);
		}
		.nav>li {margin: 0;}
		.nav>li>a {font-weight: 400;margin: 0;}
		.nav>li.active>a {color: #333;}
		.nav {background-color: #f0f5f6;}
		.nav>li>a:focus, .nav>li>a:hover,.navbar-default .nav li li a:hover, .navbar-default .nav li li a:focus {background-color: #d1dbe5;}
		.nav-second-level li a {padding-left: 30px;}
		.nav-third-level li a {padding-left: 50px;}
		.nav-fourth-level li a {padding-left: 70px;}
		.nav .nav-second-level, .nav .nav-third-level, .nav .nav-fourth-level{background-color: #f7fafa;}
		.header .logo {padding-top: 10px;}

		.skin-1 .header {background-color: #005392;color: #fff;}
		.skin-1 .header h1 {color: #fff;}
		.skin-1 .btn-group-wrapper {line-height: 78px;}
		.skin-1 .btn-signout{line-height: 78px;display: block;float:left;padding: 0 20px;color: #fff; font-size: 14px;}
		.skin-1 .btn-signout + .btn-signout {border-left: 1px solid rgba(255, 255, 255, 0.2);}
		.skin-1 .btn-signout i {margin-right: 8px;font-size: 24px;    vertical-align: middle;}
		.skin-1 .btn-signout:hover {background-color: rgba(255, 255, 255, 0.2);}
		.skin-1 .count-info {color: #fff;}
		.tabs-container {margin: 0;}
	</style>
	<body class="fixed-sidebar full-height-layout index-skin skin-1" style="overflow: hidden">
		<header id="homeIndex" class="header">
			<div class="container-fluid">
				<div class="row">
					<div class="pull-left" style="margin-top: 15px;font-size: 24px;">
						<img style="width: 50px;vertical-align: bottom;" class="logo" src="${ctxStatic}/images/skin/skin-1/dnalogo.png"/>
						珠海市政府数据资源普查系统
					</div>
					<div class="pull-right rel btn-group-wrapper">
						<div class="dropdown message-group btn-signout">
							<a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
								<i class="iconfont gm-message"></i>消息<span class="label label-primary" id="message_number"></span>
							</a>
							<ul class="dropdown-menu dropdown-alerts" style="left: -70px;right: auto;">
								<!-- <li>
									<a href="#" url="${ctxStatic}/backstage/subscribe/index" id="153" name="订阅管理">
										<div>
											<i class="fa fa-envelope fa-fw"></i>
											您订阅的信息资源有1条更新
										</div>
									</a>
								</li>
								<li class="divider"></li> -->
								<li>
									<a href="#" class="other-url" url="/zhdata/catalog/information/check" id="75" name="待办事宜">
										<div>
											<i class="fa fa-envelope fa-fw"></i>
											信息资源有<i id="message_count" style="color: #f00;"></i>条待审核
										</div>
									</a>
								</li>
								<!-- <div>
									<i class="fa fa-envelope fa-fw"></i>没有新消息
								</div> -->
							</ul>
						</div>
						<div class="dropdown message-group btn-signout">
							<a class="dropdown-toggle count-info " data-toggle="dropdown"
							   href="#"><i class="iconfont gm-help"></i>帮助</a>
							<ul class="dropdown-menu dropdown-alerts" style="left: -50px;right: auto;">
								<li>
									<a href="${ctxStatic}/upload/word/OperationManual.doc">
										<div>
											用户操作手册(暂缺)
										</div>
									</a>
								</li>
								<li>
									<a href="${ctxStatic}/upload/excel/ChromeStandalone_56.0.2924.87_Setup.exe">
										<div>
											适配浏览器下载
										</div>
									</a>
								</li>
							</ul>
						</div>
						<c:set var="user" value="${fns:getCurrentUser()}" />
						<a href="#" class="name btn-signout"><i class="iconfont gm-user"></i>${user.name}</a>
						<a href="/zhdata/login/system_logout" class="btn-signout btn-sign-out"><i class="iconfont gm-closeb"></i>退出</a>
						<!-- <div class="theme-skin">
							<a href="#" class="btn-signout theme" style="margin-right: 15px;"
								data-skin=" skin-<//%=ServiceUtil.getThemeType(10)%>">主题</a>
						</div> -->
					</div>
				</div>
			</div>
		</header>
		<div id="wrapper">
			<!--左侧导航开始-->
			<nav class="navbar-default navbar-static-side" role="navigation">
				<div class="sidebar-collapse">
					<ul class="nav" id="side-menu">
						${menuHtml}
					</ul>
				</div>
			</nav>
			<!--左侧导航结束-->
			<!--右侧部分开始-->
			<div id="page-wrapper" class="dashbard-1 content" style="padding: 0;overflow: hidden">
				  <div class="tabs-container">
					<div class="tabs">
					</div>
					<div class="tabs-content">
					</div>
				  </div>
				  <iframe class="default-iframe" width="100%" height="100%"
							src="${ctx}/panel/overview"
							frameborder="0"></iframe>
				</div>
			<!--右侧部分结束-->
		</div>

		<!-- 全局js -->
		<%--<script src="https://unpkg.com/vue/dist/vue.js"></script>--%>
		<%--<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>--%>
		<!-- [if !IE]> -->
		<script src="${ctxStatic}/js/jquery.min.js?v=2.1.4" type="text/javascript"></script>
		<!-- <![endif] -->
		<!--[if lte IE 8] -->
		<script src="${ctxStatic}/js/jquery-1.9.1.js" type="text/javascript"></script>
		<!-- [endif] -->
		<%--<script src="${ctxStatic}/js/jquery.min.js?v=2.1.4"></script>--%>
		<script src="${ctxStatic}/js/bootstrap.min.js?v=3.3.6"></script>
		<script src="${ctxStatic}/js/plugins/metisMenu/jquery.metisMenu.js"></script>
		<script
				src="${ctxStatic}/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
		<script src="${ctxStatic}/js/hplus.js?v=4.1.0"></script>
		<script src="${ctxStatic}/js/common/init.js"></script>

		<!-- 弹框插件 -->
		<script src="${ctxStatic}/js/plugins/layer/layer.js"></script>
		<script src="${ctxStatic}/js/plugins/tab/tab.js"></script>

		<script>
		// $('.sidebar-collapse .nav li').on('click', function() {
		// 	  var url = $(this).find('a').attr('href');
		// 	  var openMethod=$(this).find('a').attr('data-type');
		// 	  if (url.indexOf('/') != -1) {
		// 		  if(openMethod!='undefined'&&openMethod==2){
		// 			  window.open(url);
		// 		  }else{
		// 			  $('#page-wrapper iframe').attr('src', url);
		// 		  }

		// 	    return false;
		// 	  }
		// 	});

//        new Vue({
//            el: '#homeIndex',
//            data: {
//                message: '广州珠海资源普查系统'
//            }
//        })
		$(function () {
			$(".J_menuItem").each(function (index) {
				$(this).attr('id', index+1);
			});
		});
		  themeInit();
		$('#side-menu').slimScroll({
		  height: '100%',
		  railOpacity: 0.9,
		  alwaysVisible: false,
		  size: '10px'
		});

		function themeInit() {
		  $('body').addClass($('.theme').attr('data-skin'));
		}
		$('.tabs-container').Tabs({
			menuCurrent: 'nav a',
		});
		function newTab (params) {
			$('.tabs-container').Tabs({
				menuCurrent: 'nav a',
				params: params
			});
		}

		// 查询需要审核的消息
		$(function () {
			updateCount();
		})
		
		function updateCount () {
			$.ajax({
				url: '${ctx}/catalog/information/list',
				data: {
					pageNum:1,
					pageSize:6,
					obj:JSON.stringify({isAudit: 0,
						isAuthorize:1,
						nameCn:"",
						nameEn:""
						}),
					companyIds:""
					
				},
				success: function (res) {
					$('#message_number').text(res.total);
					$('#message_count').text(res.total);
				}
			})
		}
		</script>
	</body>

</html>
