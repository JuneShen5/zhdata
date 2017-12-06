<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
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
.skin-7 .wrapper{
	height: 100%;
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
.layui-layer-wrap{
	height: 100%;
}
.echarts-box{
	width: 100%;
	height: 100%;
}
.text-center i {
	line-height: 60px;
}
</style>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
	
		<div class="clearfix assets-layout">
			<div class="clearfix statistics-box">
				<div class="col-sm-4" style="padding: 0 10px;">
					<div class="small-box box-1">
						<div class="icon-container text-center  btn-cyan">
							<i class="fa fa-cubes"></i>
						</div>
						<div class="content">
							信息项总数 <b id="top_total_first"></b>
						</div>
					</div>
				</div>
				<div class="col-sm-4" style="padding: 0 10px;">
					<div class="small-box box-2">
						<div class="icon-container text-center btn-yellow">
							<i class="fa fa-database"></i>
						</div>
						<div class="content">
							信息资源总数 <b id="top_total_second"></b>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="clearfix box-info">
		
		</div>
		
	</div>
	<div id="echartLayer" style="display: none">
		<div class="echarts-box" id="main"></div>
	</div>
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		$(function () {
			layer.open({
				type: 3,
		  		title: '等待载入',
		  		content: '载入中...'
			})
			$.ajax({
				url: "${ctx}/standard/analy/list",
				type: 'get',
				success: function (res) {
					console.log('res: ', res);
					$("#top_total_first").html(res.eleCount);
					$("#top_total_second").html(res.infoCount);
					$.each(res.data, function(index, dataList){

						var listHtml = '<div class="panel-container col-xs-4">';
						    listHtml += '<div class="panel panel-default panel-item echart-show" data-id="' + dataList.id + '" data-nameCn="' + dataList.nameCn + '" style="cursor: pointer;">';
					    	listHtml += '<div class="panel-heading text-center text-hidden">' + dataList.nameCn + '</div>';
					    	listHtml += '<div class="panel-body content"><ul>';
					    	listHtml += '<li class="clearfix"><p class="col-xs-8 text-right">涉及部门数量：</p><p class="col-xs-4 text-left"><span>'+dataList.compCount+'</span></p></li>';
					    	listHtml += '<li class="clearfix"><p class="col-xs-8 text-right">信息资源使用数量：</p><p class="col-xs-4 text-left"><span>'+dataList.infoCount+'</span></p></li>';

					    $(".box-info").append(listHtml);
					});
					layer.close(layer.index);
					$(document).on("click",".echart-show",function(){
		                // 弹出框设置
		                layeForm = layer.open({
		                    title: "关系图",
		                    type : 1,
		                    area : [ '90%', '90%' ],
		                    scrollbar : false,
		                    closeBtn: 1,
		                    zIndex : 100,
		                    content : $("#echartLayer")
		                });
		                // 绘制图表。
		                var myChart = echarts.init(document.getElementById('main'));
		                myChart.showLoading();
		                console.log("data:", {id: $(this).attr("data-id"), nameCn: $(this).attr("data-nameCn")})
		                $.ajax({
		                	url: "${ctx}/standard/analy/relation", 
		                	data: {id: $(this).attr("data-id"), nameCn: $(this).attr("data-nameCn")},
		                	success: function(res) {
		                    console.log("res: ", res);
		                    myChart.hideLoading();
		                    option = {
		                        title: {
		                            text: ''
		                        },
		                        tooltip: {},
		                        animationDurationUpdate: 1500,
		                        animationEasingUpdate: 'quinticInOut',
		                        legend: {
		                            x: "center",
		                            show: true,
		                            data: ['信息项', '信息资源', '部门']
		                        },
		                        series: [
		                            {
		                                type: 'graph',
		                                layout: 'force',
		                                symbolSize: function(size) {
		                                    switch (size){
		                                        case 60:
		                                            size = size + 10;
		                                        case 55:
		                                            size = size + 5;
		                                        case 45:
		                                            size = size + 5;
		                                        case 40:
		                                            size = size + 5;
		                                        case 35:
		                                            size = size - 7;
		                                        default:
		                                            break;
		                                    }
		                                    return size;
		                                },
		                                focusNodeAdjacency: true,
		                                roam: true,
		                                draggable: true,
		                                categories: [{
		                                    name: '信息项',
		                                    itemStyle: {
		                                        normal: {
		                                            color: '#f36a5a'
		                                        }
		                                    }
		                                }, {
		                                    name: '信息资源',
		                                    itemStyle: {
		                                        normal: {
		                                            color: '#95ce67'
		                                        }
		                                    }
		                                }, {
		                                    name: '部门',
		                                    itemStyle: {
		                                        normal: {
		                                            color: '#C0A8D8'
		                                        }
		                                    }
		                                }],
		                                label: {
		                                    normal: {
		                                        show: true,
		                                        textStyle: {
		                                            fontSize: 12
		                                        },
		                                    }
		                                },
		                                force: {
		                                    repulsion: 280,
		                                    initLayout: 'circular',
		                                    edgeLength: 120,
		                                    gravity: 0.17
		                                },
		                                tooltip: {
		                                    formatter: function(node) { // 区分连线和节点，节点上额外显示其他数字
		                                        /*if (!node.value) {
		                                            return node.data.name;
		                                        } else {
		                                            return node.data.name + ":" + node.data.value;
		                                        }*/
		                                        return '关系分析：' + node.data.name;
		                                    },
		                                },
		                                lineStyle: {
		                                    normal: {
		                                        opacity: 0.9,
		                                        width: 1,
		                                        curveness: 0.3
		                                    }
		                                },
		                                data: res.node,
		                                links: res.link
		                            }
		                        ]
		                    };
		                    myChart.setOption(option);
		                }});
					});
				}
			})
        });
	</script>
	<script src="${ctxStatic}/js/plugins/echarts/echarts.js"></script>

	 <%--<script src="${ctxStatic}/js/common/common.js"></script>--%>
</body>
</html>

