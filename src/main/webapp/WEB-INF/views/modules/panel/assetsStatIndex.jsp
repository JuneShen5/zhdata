<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<link href="https://cdn.bootcss.com/iCheck/1.0.2/skins/square/blue.css" rel="stylesheet">
<!-- <link href="https://cdn.bootcss.com/iCheck/1.0.2/skins/all.css" rel="stylesheet"> -->
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<style>
.skin-7 .btn-green {
    background-color: #20c03d !important;
    border-color: #20c03d !important;
    color: #fff !important;
}
.skin-7 .btn-yellow {
    background-color: #ec9d19 !important;
    border-color: #ec9d19 !important;
    color: #fff !important;
}
.skin-7 .btn-cyan {
    background-color: #12b2b4 !important;
    border-color: #12b2b4 !important;
    color: #fff !important;
}
.skin-7 .btn-purple {
    background-color: #b653b9 !important;
    border-color: #b653b9 !important;
    color: #fff !important;
}
.skin-7 .btn-blue {
	color: #fff !important;
	background-color: #20a0ff !important;
	border-color: #20a0ff !important;
}
.skin-7 .statistics-box {
	color: #666;
}
.skin-7 .statistics-box .small-box {
	position: relative;
	background: #f6f8f9;
	border: 1px solid #ededed;
	min-height: 60px;
	font-size: 16px;
}
.skin-7 .statistics-box .small-box .icon-container{
	position: absolute;
    top: 10px;
    left: 10px;
    width: 60px;
    height: 60px;
    line-height: 50px;
    text-align: center;
    border-radius: 5px;
    vertical-align: middle;
}
.skin-7 .statistics-box .small-box i {
    font-size: 40px;
	line-height: 60px;
}
.skin-7 .statistics-box .small-box .content {
	padding-left: 80px;
	line-height: 80px;
	font-size: 16px;
	color: #000;
}
.skin-7 .statistics-box .small-box .content b{
	font-weight: 400;
	margin: 0 5px;
    font-size: 24px;
    color: #015293;
    vertical-align: middle;
}

.skin-7 .panel-container .panel-default .panel-heading {
	background-color: #f6f8f9;
	padding: 5px 15px;
	font-size: 16px;
    font-weight: 600;
}
.skin-7 .panel-item ul li {
	margin-bottom: 0;
	line-height:36px;
    vertical-align: middle;
}
.skin-7 .panel-item ul, .skin-7 .panel-item ul p {
	margin-bottom: 0;
}
.skin-7 .panel-item ul li + li{
	border-top: 1px dashed #ccc;
}
.skin-7 .box-info .panel-container  .panel-body {
	padding: 0;
}
ul, li {
	list-style: none;
}
.div_cs{
	font-size: 20px;
	padding-top: 10px;
}
.container {width: 100%;}
.panel-body {padding: 0;}
.assets-layout{
	padding-top: 15px;
}
.top-penal>p{
	margin: 0;
	cursor: default;
}
.top-penal>p>em{
	font-style: normal;
}
.layui-layer-loading .layui-layer-content {
    width: auto!important;
    height: 24px;
    background: url(loading-0.gif) no-repeat;
    font-size: 24px;
    color: #fff;
    padding-top: 25px;
    margin-left: 110px;
    cursor: default;
}
.page-info{
	display: inline-block;
	margin: 20px 0;
	font-size: 14px;
	color: #777;
	cursor: default;
}
.page-info>strong{
	color: #444444;
}
.search-container>.form-group{
	margin: 20px 0 0 10px;
}
.box-info-container{
	position: relative;
}
.box-info-container .panel-item{
	margin: 15px 10px;
}
.loading-area{
	position: absolute;
	width: 100%;
	height: 100%;
	z-index: 100;
	background-color: rgba(255,255,255,.7);
	text-align: center;
	padding-top: 130px;
}
.loading-area p{
	margin-top: 10px;
	font-size: 16px;
	cursor: default;
}
.pswp__preloader__icn{
	margin-left: 48%;
}
	.no-result-area{
		text-align: center;
		line-height: 138px;
		font-size: 16px;
	}
</style>
<body class="white-bg-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<!-- <div class="ibox-title">部门资产统计</div> -->
		<div class="ibox-content clearfix assets-layout">
			<div class="clearfix statistics-box">
				
			</div>
			<div class="search-container form-inline clearfix" style="display: none;">
				<div class="form-group">
					<select type="text" name="searchType" class="form-control col-sm-6" style="margin-right: 5px">
						<option value="name">系统名称</option>
						<option value="companyName">单位名称</option>
					</select>
					<input class="form-control col-sm-8 search-input" placeholder="请输入搜索项名称" />
					<div class="input-group-btn col-sm-4">
						<button class="btn btn-primary search-btn">搜索</button>
					</div>
				</div>
			</div>
			<div class="box-info-container clearfix">
				<!-- 加载动画 -->
				<div class="loading-area" style="display: none;">
					<div class="pswp__preloader__icn">
						<div class="pswp__preloader__cut">
							<div class="pswp__preloader__donut"></div>
						</div>
					</div>
					<p>载入中...</p>
				</div>
				<!-- 未搜索到部门 -->
				<div class="no-result-area" style="display: none;">
					<p><i class="fa fa-ban" aria-hidden="true"></i> 未搜索到结果！</p>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script type="text/javascript">
	$(function(){
	    // 请求顶部总数
		$.ajax({
            url: "${ctx}/panel/ass/querySum",
            type: 'get',
            success: function (data) {
                $('.search-container').show();
                // 拼接顶部信息资源统计
                var topHtml1 = '<div class="col-sm-4" style="padding: 0 10px;">';
                topHtml1 += '<div class="small-box box-1"><div class="icon-container text-center btn-cyan"><i class="fa fa-cubes"></i></div><div class="content top-penal"><p>信息系统总数 : <em>';
                topHtml1 += data.ysCount + " 个 ";
                topHtml1 += '</em></p></div></div></div>';
                topHtml1 += '<div class="col-sm-4" style="padding: 0 10px;">';
                topHtml1 += '<div class="small-box box-1"><div class="icon-container text-center btn-yellow"><i class="fa fa-database"></i></div><div class="content top-penal"><p>系统年度运维总金额 : <em>';
                topHtml1 += data.ywjSum + " 万元 ";
                topHtml1 += '</em></p></div></div></div>';
                $(".statistics-box").append(topHtml1);
            }
		});
        $('.loading-area').show();
		$.ajax({
			url: "${ctx}/assets/yjSystem/list",
			type: 'get',
			data: {
                pageNum: 1,
                pageSize: 6,
                obj: JSON.stringify({'name': ''})
			},
			success: function (data) {
//                layer.close(layer.index);
				$('.loading-area').hide();
                // 设置分页参数
                var pageSize = 6; // 只需要设置每页显示数目
                // 分页相关设置
                var totalCounts = data.total;
                var pageNum = Math.ceil(totalCounts/pageSize);
				// 拼接部门详细资源
				$('.top-company-count').find('em').text(data.total + ' 个');
                    $("<div></div>").addClass("box-info clearfix").appendTo($(".box-info-container"));
				$.each(data.rows, function(index,dataList){
				    var searchHtml = '<option value="'+dataList.id+'">' + dataList.name + '</option>';
//				    $('.search-container').find('select').append(searchHtml);
					var listHtml = '<div class="panel-container col-xs-4" data-item-id="'+dataList.id+'">';
						listHtml += '<div class="panel panel-default  panel-item">';
						listHtml += '<div class="panel-heading text-center text-hidden">' + dataList.name + '</div>';
						listHtml += '<div class="panel-body content"><ul>';
						 listHtml += '<li class="clearfix"><p class="col-xs-3 text-right">单位名称：</p><p class="col-xs-9 text-left"><span>'+dataList.companyName+'</span></p></li>';
                         listHtml += '<li class="clearfix"><p class="col-xs-4 text-right">年度运维金额：</p><p class="col-xs-8 text-left"><span>'+dataList.ywje+' 万元'+'</span></p></li>';
						listHtml += '</ul></div></div></div>';
				    $(".box-info").append(listHtml);
				});
                paginatorInit(pageSize,totalCounts,pageNum);
			}
		});

		// 选择资源条目
		$('.search-btn').on('click', function () {
		    var thisSearchType = $('select[name=searchType]').val();
//            $('.search-container').find('.search-input').attr('sName', thisSearchType);
			var thisValue = $('.search-container').find('.search-input').val();
			var searchObj = {};
            searchObj[thisSearchType] = thisValue;
            $('.loading-area').show();
            $.ajax({
                url: "${ctx}/assets/yjSystem/list",
                type: 'get',
                data: {
                    pageNum: 1,
                    pageSize: 6,
                    obj: JSON.stringify(searchObj)
                },
                success: function (data) {
                    $('.loading-area').hide();
                    $(".box-info").empty();

                    // 设置分页参数
                    var pageSize = 6; // 只需要设置每页显示数目
                    // 分页相关设置
                    var totalCounts = data.total;
                    var pageNum = Math.ceil(totalCounts/pageSize);
                    if (totalCounts>0){
                    // 拼接部门详细资源
                    $.each(data.rows, function(index,dataList){
                        $('.no-result-area').hide();
                        var searchHtml = '<option value="'+dataList.id+'">' + dataList.name + '</option>';
//                        $('.search-container').find('select').append(searchHtml);
                        var listHtml = '<div class="panel-container col-xs-4" data-item-id="'+dataList.id+'">';
                        listHtml += '<div class="panel panel-default  panel-item">';
                        listHtml += '<div class="panel-heading text-center text-hidden">' + dataList.name + '</div>';
                        listHtml += '<div class="panel-body content"><ul>';
                        listHtml += '<li class="clearfix"><p class="col-xs-3 text-right">单位名称：</p><p class="col-xs-9 text-left"><span>'+dataList.companyName+'</span></p></li>';
                        listHtml += '<li class="clearfix"><p class="col-xs-4 text-right">年度运维金额：</p><p class="col-xs-8 text-left"><span>'+dataList.ywje+' 万元'+'</span></p></li>';
                        listHtml += '</ul></div></div></div>';
                        $(".box-info").append(listHtml);
                    });

                    paginatorInit(pageSize,totalCounts,pageNum);
                    }else {
                        $('.no-result-area').show();
                        paginatorInit(6,1,0);
                        $('#pageInfo').html('总共 <strong>' + 0 + '</strong> 个部门，总共 <strong>' + 0 + '</strong> 页，当前第 <strong>' + 0 + '</strong> 页');
					}
                }
            });
        });
	});

	function paginatorInit(pageSize,totalCounts,pageNum) {
        // 创建分页
        $("<span></span>").addClass("page-info pull-left").attr("id","pageInfo").appendTo($(".box-info-container"));
        $("<ul></ul>").addClass("pagination pull-right").attr("id","paginator").appendTo($(".box-info-container"));
        // 设置分页插件
        $('#paginator').jqPaginator({
            totalCounts: totalCounts,
            pageSize: pageSize,
            visiblePages: 5,
            currentPage: 1,
            first:'<li class="first"><a href="javascript:;">首页</a></li>',
            prev:'<li class="prev"><a href="javascript:;">前一页</a></li>',
            next:'<li class="next"><a href="javascript:;">后一页</a></li>',
            last:'<li class="last"><a href="javascript:;">末页</a></li>',
            page: '<li class="page"><a href="javascript:;">{{page}}</a></li>',
            onPageChange: function (num, type) {
                if (type==="init"){
                    $(".box-info[data-page-index='0']").show();
                }else{
                    $('.loading-area').show();
                    $.ajax({
                        url: "${ctx}/assets/yjSystem/list",
                        type: 'get',
                        data: {
                            pageNum: num,
                            pageSize: 6,
                            obj: JSON.stringify({'name': ''})
                        },
                        success: function (data) {
                            $('.loading-area').hide();
                            $(".box-info").empty();

                            // 设置分页参数
                            var pageSize = 6; // 只需要设置每页显示数目
                            // 分页相关设置
                            var totalCounts = data.total;
                            var pageNum = Math.ceil(totalCounts/pageSize);
                            // 拼接部门详细资源
                            $.each(data.rows, function(index,dataList){
                                var searchHtml = '<option value="'+dataList.id+'">' + dataList.name + '</option>';
//                                $('.search-container').find('select').append(searchHtml);
                                var listHtml = '<div class="panel-container col-xs-4" data-item-id="'+dataList.id+'">';
                                listHtml += '<div class="panel panel-default  panel-item">';
                                listHtml += '<div class="panel-heading text-center text-hidden">' + dataList.name + '</div>';
                                listHtml += '<div class="panel-body content"><ul>';
                                listHtml += '<li class="clearfix"><p class="col-xs-3 text-right">单位名称：</p><p class="col-xs-9 text-left"><span>'+dataList.companyName+'</span></p></li>';
                                listHtml += '<li class="clearfix"><p class="col-xs-4 text-right">年度运维金额：</p><p class="col-xs-8 text-left"><span>'+dataList.ywje+' 万元'+'</span></p></li>';
    
                                listHtml += '</ul></div></div></div>';
                                $(".box-info").append(listHtml);
                            });
//                            paginatorInit(pageSize,totalCounts,pageNum);
                        }
                    });
                }
                $('#pageInfo').html('总共 <strong>' + totalCounts + '</strong> 个部门，总共 <strong>' + pageNum + '</strong> 页，当前第 <strong>' + num + '</strong> 页');
            }
        });
    }
	
    </script>
	<script src="${ctxStatic}/js/plugins/jqPaginator/jqpaginator.min.js"></script>
	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>
