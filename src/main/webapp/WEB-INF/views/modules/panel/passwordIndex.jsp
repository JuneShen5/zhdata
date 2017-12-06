<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">修改密码</div> -->
			<div class="ibox-content">
				<div class="pwd-content">
					<form id="eform" class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-3 control-label">旧密码 ：</label>
							<div class="col-sm-7" required>
								<input type="text" name="oldPwd" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">新密码：</label>
							<div class="col-sm-7" required>
								<input type="password" name="newPwd" class="form-control" id="newPwd">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">确认密码：</label>
							<div class="col-sm-7" required>
								<input type="password" name="conPwd" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label"></label>
							<div class="col-sm-7 submit-right" required>
								<button data-toggle="modal" class="btn btn-primary">提交</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<style>
		.pwd-content {
			padding-top: 80px;
			min-height: 500px;
		}
		.submit-right {
			text-align: right;
		}
	</style>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '';
		var layerId = '';
		var formId = ''; //form ids
		var toolbar = '';
		var url = '${ctx}/settings/user/';
		var obj = {};
		var pwdFormId = '#eform';
		
		$(function () {
			$(pwdFormId).validate({
		        submitHandler: function(form){
		        	$(pwdFormId).ajaxSubmit({
		    			url : url + 'updatePwd',
		    			type : 'post',
		    			success : function(res){
		    				// layer.msg(res);
		    				console.log("res:", res)
		    				layer.msg(res);
		    				endMethod(formId);
		    			},
		    			error : function(res){
		    				console.log("res:", res)
		    				layer.msg(res);
		    				// layer.msg(res);
		    			},
		    			resetForm : true
		    		});
		    		return false;
		        },
		        rules: {
		        	oldPwd: {
		        	    required: true,
	        		    minlength: 6
	        		},
	        		newPwd: {
	        		    required: true,
	        		    minlength: 6
       		    	},
       		    	conPwd: {
	        		    required: true,
	        		    equalTo: "#newPwd"
       		    	}
		        }
		    });
		})
	</script>
	<script src="${ctxStatic}/js/common/common.js"></script>
	
</body>
</html>

