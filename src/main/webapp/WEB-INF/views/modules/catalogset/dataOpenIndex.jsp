<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<link rel="stylesheet"
		href="${ctxStatic}/css/plugins/bootstrap-table/bootstrap-table.min.css">
	<link href="${ctxStatic}/css/style-add.css" rel="stylesheet" />
</head>
<body class="white-bg body-style">
	<div class="wrapper-main animated fadeInRight">
		<div class="form-inline" style="margin: 20px 0 0 35px;">
			<div class="form-group">
				<input id="sName" name="name" type="text" placeholder="请输入接口名称"
					class="form-control col-sm-8">
				<div class="input-group-btn col-sm-4">
					<button type="button" onclick="searchForRes()" class="btn btn-primary">搜索</button>
				</div>
			</div>
		</div>
		<div id="dataOpenContent" class="dataopen-content">
			<label>为您找到相关接口 <em></em> 个</label>
		</div>
	</div>
	<div id="dataOpenForm" style="display:none;" class="data-open-form">
	</div>
</body>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
</html>

<style>
	.wrapper-main{
		margin: 10px 20px;
		padding: 10px;
		min-height: 200px;
		background-color: #fff;
	}
	.dataopen-content{
		margin-top: 15px;
		list-style: none;
	}
	.dataopen-content>label{
		font-size: 14px;
    	font-weight: normal;
	}
	.dataopen-content>label>em{
		font-weight: bold;
		font-style: normal;
		color: #FF4500;
	}
	.dataopen-content>li{
		display: block;
		border: solid 2px #ddd;
		margin: 10px 0;
	}
	.dataopen-result-container{
		padding: 10px 15px;
		cursor: default;
	}
	.dataopen-result-title{
		font-size: 16px;
		color: #444;
	}
	.dataopen-result-title>.label{
	    background-color: #337ab7;
		margin-left: 4px;
		padding: 4px 8px;
	}
	.dataopen-result-intro{
		margin-bottom: 0;
		font-size: 14px;
		color: #999;
	}
	.dataopen-result-btn>button{
		float: right;
		margin: 19px 0;
	}
	.data-open-form{
		width: 80%;
		height: 70%;
		margin: 100px auto 0;
	}
	.data-open-form>.jumbotron{
		cursor: default;
		height: 100%;
	}
</style>

<script>
	window.onload=function(){
		$.ajax({
			url:'${ctx}/catalogset/data/getDataOpen',
			type:'get',
			success: function (data) {
				var i = "";
				$.each(data, function(index, list){
					var listLi = $("<li></li>").addClass("row clearfix").appendTo($("#dataOpenContent"));
					var liContainer = $("<div></div>").addClass("col-sm-10 dataopen-result-container").appendTo(listLi);
					var liBtn = $("<div></div>").addClass("col-sm-2 dataopen-result-btn").appendTo(listLi);
					$("<p></p>").addClass("dataopen-result-title").append(list.nameCn+'<span class="label label-primary">信息中心</span>').appendTo(liContainer);
					$("<p></p>").addClass("dataopen-result-intro").text(list.nameCn).appendTo(liContainer);
					$("<button></button>").addClass("btn btn-primary").attr("onclick","itemDetail('"+list.code+"','"+list.nameCn+"')").text("查看详情").appendTo(liBtn);
					i++;
				});
				$("#dataOpenContent").find("em").text(i);
			}
		});
	};
	
	function itemDetail (code,name) {
		//$("#dataOpenTable").bootstrapTable('refresh', {url: '${ctx}/drs/data/getDataOpen'});
		$("#dataOpenForm").empty();
		var itemHtml = '<div class="jumbotron"><p>数据接口地址：</p><p>http://183.245.210.26:18080/qxdata/drs/information/getdata?code=' + code + '</p></div>';
		layeForm = layer.open({
			title: "接口详情---"+name,
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			content : $("#dataOpenForm").append(itemHtml)
		});
	};

</script>
