//JavaScript Document
var box_view_btn="loginBtn";//初始化按钮值
var base = document.getElementById('loginJs').getAttribute('data');
$(function () {
	getVerifyCode();
	//监听docuemnt的onkeydown事件看是不是按了回车键
	$(document).keydown(function(event){
		event = event ? event : window.event;
		if (event.keyCode === 13){
			$("#"+box_view_btn).trigger("click");
		}
	});
	//登录
	$("#loginBtn").click(function () {
		if("" == $("#accountNameId").val()){
			//$("#accountNameId").tips({side : 3,msg : "用户名不能为空！",bg : '#FF2D2D',time : 2});
			layer.tips('用户名不能为空！', '#accountNameId', {
				  tips: [1, '#F54533'],
				  time: 4000
				});
			$("#accountNameId").focus();
		}else if("" == $("#passwordId").val()){
			layer.tips('密码不能为空！', '#passwordId', {
				  tips: [1, '#F54533'],
				  time: 4000
				});
			$("#passwordId").focus();
		}else if("" == $("#verifyCodeId").val()){
			layer.tips('验证码不能为空！', '#verifyCodeId', {
				  tips: [1, '#F54533'],
				  time: 4000
				});
			$("#verifyCodeId").focus();
		}else{
			//dialogloading();
			// console.log(base)
			var loginname = $("#accountNameId").val();
			var password = $("#passwordId").val();
			var verifyCode=$("#verifyCodeId").val();
			var code = loginname+",jy,"+$.md5(password)+",jy,"+verifyCode;
			$.ajax({type:'POST',url:base +'/login',data:{username:loginname,password:password},
		            dataType:'json',success:function(data, textStatus) {
		            	//dialogloadingClose();	            
		            	var result=data.code;
		            	console.log('result ',result);
		            	if (0 != result) {  //如果登录不成功，则再次刷新验证码
		            		//dialogloadingClose();
		            		clearLoginForm();//清除信息
							loginAlert(result);		
						}else{
							window.location.href=base+"/backstage/index";
						}
		            }
		     });
		}
	});
	
	$("#vimg").click(function () {
		getVerifyCode();
	});
	
});
function clearLoginForm(){	
	$("#verifyCodeId").val("");
	$("#passwordId").val("");
	getVerifyCode();
}
//切换窗口
function show_box(id) {
	 var strs= new Array(); //定义一数组 
	 strs=id.split("-"); //字符分割 
	 box_view_btn=strs[0]+"Btn";
	 jQuery('.widget-box.visible').removeClass('visible');
	 jQuery('#'+id).addClass('visible');
}	
//刷新验证码
function getVerifyCode() {
	$("#vimg").attr("src", "verifyCode/slogin.do?random=" + Math.random());
}
function loginAlert(msg) {
	console.log('loginAlert',msg);
//	var obj = {
//		"codeerror": {
//			'tipsText': '验证码不正确！',
//			'id': '#verifyCodeId'
//		}
//	}
//	
//	var text = obj[msg].tipsText
//	var id = obj[msg].id
//	layer.tips(text, id, {
//		tips: [1, '#F54533'],
//		 time: 4000
//	})
//	$(id).focus();
	
	if("codeerror" == msg){
		
		layer.tips('验证码不正确！', '#verifyCodeId', {
			  tips: [1, '#F54533'],
			  time: 4000
			});
		$("#verifyCodeId").focus();
	}else if("nullup" == msg){
		layer.tips('用户名或密码不能为空！', '#accountNameId', {
			  tips: [1, '#F54533'],
			  time: 4000
			});
		$("#accountNameId").focus();
	}else if("nullcode" == msg){
		layer.tips('验证码不能为空！', '#verifyCodeId', {
			  tips: [1, '#F54533'],
			  time: 4000
			});
		$("#verifyCodeId").focus();
	}else if("usererror" == msg){
		layer.tips('用户名或密码有误！', '#accountNameId', {
			  tips: [1, '#F54533'],
			  time: 4000
			});
		$("#accountNameId").focus();
	}else if("attemptserror" == msg){
		//dialogerror("错误次数过多！");
		layer.msg('错误次数过多！');
	}else if("error" == msg){
		//dialogerror("输入有误！");
		layer.msg('输入有误！');
	}else if("inactive" == msg){
		//dialogerror("未激活！");
		layer.msg('未激活！');
	}
}
