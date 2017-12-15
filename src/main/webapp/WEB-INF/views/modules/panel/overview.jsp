<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
	<link href="${ctxStatic}/js/plugins/bootstrap-select/css/bootstrap-select.min.css" rel="stylesheet">
<style>
.tabsNav .item {
  margin-bottom: 20px;
}
.tabsNav .item .title {
	margin: 0;
	padding: 10px 0 10px 10px;
}
.tabsNav .item .item-wrapper {
  border: 1px solid #ededed;
}
.wrapper {
	padding: 0 20px;
}

.ibox {
	clear: both;
	margin-bottom: 25px;
	margin-top: 0;
	padding: 0;
}

.ibox-content {
	background-color: #ffffff;
	color: inherit;
	padding: 15px 20px 20px 20px;
	border-color: #e7eaec;
	-webkit-border-image: none;
	-o-border-image: none;
	border-image: none;
	border-style: solid solid none;
	border-width: 1px 0px;
	clear: both;
}

.echarts {
	height: 240px;
}
.box-wrapper {
  margin-bottom: 10px;
}
h3 {
	font-size: 16px;
	font-weight: 600;
}
.box-wrapper .box{
  height: 80px;
  text-align: center;
}
.tabsNav .item .box {
  background-color: ;
}
.box-wrapper .box .title {
  font-size: 16px;
  color: #fff;
}
.box-wrapper .box .number {
  font-size: 16px;
  color: #fff;
}
.box-wrapper .box .number span{
  font-size: 23px;
}
.green-color {
  background-color: #12b2b4;
}
.yellow-color {
  background-color: #ec9d19;
}
.blue-color {
  background-color: #4194cf;
}
.item-wrapper .select-area{
	display: inline-block;
	padding-top: 1px;
	float: right;
}
.bootstrap-select button{
	background-color: #fff;
	color: #444444;
}
.dropdown-menu>li>a{
	margin: 0 4px;
}
</style>
<body class="skin-1">
	<div class="wrapper animated fadeInRight">
		<div class="tabsNav" id="tabsNav2">
			<div class="tabs-container">
				<div class="item col-sm-12">
					<div class="row">
						<div class="col-sm-12">
							<div class="item-wrapper">
								<h3 class="title" style="display: inline-block;">排行榜</h3>
								<div class="select-area" style="display: none">
									<select id="chartSelect1" name="chartSelect1" class="" multiple data-width="fit">
									</select>
									<button id="selectBtn1" class="btn btn-primary">确认</button>
								</div>
								<div class="ibox float-e-margins">
									<div class="ibox-content echarts-name">
										<div class="echarts" id="main1"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="item col-sm-6">
					<div class="row">
						<div class="col-sm-12">
              				<div class="item-wrapper">
	  							<h3 class="title">热门信息资源</h3>
	  							<div class="ibox float-e-margins">
	  								<div class="ibox-content">
	  									<div class="echarts" id="main2" style="height: 330px;"></div>
	  								</div>
	  							</div>
	              			</div>
						</div>
					</div>
				</div>
				<div class="item col-sm-6">
					<div class="row">
						<div class="col-sm-12">
              				<div class="item-wrapper">
	  							<h3 class="title">热门信息项</h3>
	  							<div class="ibox float-e-margins">
	  								<div class="ibox-content">
	  									<div class="echarts" id="main3" style="height: 330px;"></div>
	  								</div>
	  							</div>
	              			</div>
						</div>
					</div>
				</div>
				<div class="item col-sm-12">
					<div class="row">
						<div class="col-sm-12">
              				<div class="item-wrapper">
	  							<h3 class="title" style="display: inline-block;">各部门资源数据对比（信息系统、信息项、信息资源、基础资源、主题资源）</h3>
								<select id="chartSelect2" name="chartSelect2" data-max-options="7" class="" multiple data-width="fit" style="display: none">
								</select>
	  							<div class="ibox float-e-margins">
	  								<div class="ibox-content">
	  									<div class="echarts" id="main4"></div>
	  								</div>
	  							</div>
	              			</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>


<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script src="${ctxStatic}/js/plugins/echarts/echarts.js"></script>
<script src="${ctxStatic}/js/plugins/echarts/echarts-wordcloud.min.js"></script>
<script	src="${ctxStatic}/js/plugins/bootstrap-select/js/bootstrap-select.min.js"></script>
<script	src="${ctxStatic}/js/plugins/bootstrap-select/js/i18n/defaults-zh_CN.min.js"></script>
<script>
    // 部门资源
	// 获取数据
	$(function () {
        var axisChart = echarts.init(document.getElementById("main1"));
        axisChart.showLoading();
		$.ajax({
			url:'${ctx}/panel/ass/queryCountList',
			dataType: 'json',
			type:'get',
			success: function (data) {
                axisChart.hideLoading();
				var chartData1 = {
					companyName: [],
					sourceName: ['信息系统数目','信息项数目','信息资源数目'],
					data1: [],
					data2: [],
					data3: []
				};
				$.each(data.data,function (index,pItem) {
				    $('<option></option>').val(index).text(pItem.companyName).appendTo($('#chartSelect1'));
					chartData1.companyName.unshift(pItem.companyName);
					chartData1.data1.unshift(pItem.sCount);
					chartData1.data2.unshift(pItem.eCount);
					chartData1.data3.unshift(pItem.iCount);
				});
//                if (data.data.length>5){
//                    chartData1.companyName = chartData1.companyName.slice(-5);
//                    chartData1.data1 = chartData1.data1.slice(-5);
//                    chartData1.data2 = chartData1.data2.slice(-5);
//                    chartData1.data3 = chartData1.data3.slice(-5);
//                }
                $('#chartSelect1').val([0,1,2,3,4]).addClass('selectpicker').selectpicker({
                    maxOptions: 7,
                    maxOptionsText: '最多选择7个显示项！',
                    dropdownAlignRight: 'auto',
                    liveSearch: true
				});
                $('.select-area').show();
				var axisoption = {
					title: {
						text: '部门资源概览',
//						subtext: '数据截取（信息系统、信息项、信息资源）'
					},
					tooltip: {
						trigger: 'axis',
						axisPointer: {
							type: 'shadow'
						}
					},
					toolbox: {
						show: true,
						feature : {
							dataView : {show: true, readOnly: false},
							magicType: {show: true, type: ['line', 'bar']},
							restore : {show: true},
							saveAsImage : {show: true}
						}
					},
					legend: {
						data: chartData1.sourceName
					},
					grid: {
						left: '3%',
						right: '4%',
						bottom: '3%',
						containLabel: true
					},
					color: ['#A878C0','#30C0C0','#FFC078','#0090D8','#f17c67'],
					xAxis: {
						type: 'value',
						boundaryGap: [0, 0.01]
					},
					yAxis: {
						type: 'category',
						data: chartData1.companyName.slice(-5)
					},
					series: [
						{
							name: chartData1.sourceName[0],
							type: 'bar',
							data: chartData1.data1.slice(-5)
						},
						{
							name: chartData1.sourceName[1],
							type: 'bar',
							data: chartData1.data2.slice(-5)
						},
						{
							name: chartData1.sourceName[2],
							type: 'bar',
							data: chartData1.data3.slice(-5)
						}
					]
				};
				axisChart.setOption(axisoption);
				$(window).resize(axisChart.resize);

				$('#selectBtn1').on('click', function () {
                    var selectedItems = $('#chartSelect1').val();
                    console.log(a);
                });
			}
		});
    });

//    function createRandomItemStyle() {
//        return {
//            normal: {
//                color: 'rgb(' + [
//                    Math.round(Math.random() * 160),
//                    Math.round(Math.random() * 160),
//                    Math.round(Math.random() * 160)
//                ].join(',') + ')'
//            }
//        };
//    }
	// 热门信息资源
	$(function () {
        var wordChart = echarts.init(document.getElementById("main2"));
        wordChart.showLoading();
        $.ajax({
            url:'${ctx}/panel/overview/list',
            dataType: 'json',
            type:'get',
            success: function (data) {
                wordChart.hideLoading();
                var dataArr = [];
                $.each(data,function (index,item) {
                    var chartData2 = {
                        name: '',
                        value: ''
//                        itemStyle: createRandomItemStyle()
                    };
                    chartData2.name = item.keyword;
                    chartData2.value = parseInt(item.count);
                    dataArr.push(chartData2);
                });
				var wordoption = {
					backgroundColor: '#F7F7F7',
					tooltip: {
						show: true
					},
					toolbox: {
						feature: {
							saveAsImage: {
								iconStyle: {
									normal: {
										color: '#FFFFFF'
									}
								}
							}
						}
					},
					series: [{
						name: '热点分析',
						type: 'wordCloud',
						//size: ['9%', '99%'],
						sizeRange: [20, 56],
						//textRotation: [0, 45, 90, -45],
						rotationRange: [-45, 90],
						//shape: 'circle',
						textPadding: 0,
						autoSize: {
							enable: true,
							minSize: 6
						},
                        textStyle: {
                            normal: {
                                color: function() {
                                    return 'rgb(' + [
                                        Math.round(Math.random() * 160),
                                        Math.round(Math.random() * 160),
                                        Math.round(Math.random() * 160)
                                    ].join(',') + ')';
                                }
                            },
                            emphasis: {
                                shadowBlur: 10,
                                shadowColor: '#333'
                            }
                        },
						data: dataArr
					}]
				};
//				wordoption.series[0].data = JosnList;
				wordChart.setOption(wordoption);
				$(window).resize(wordChart.resize);
            }
    	});
    });

    // 热门信息项
    $(function () {
        var wordChart = echarts.init(document.getElementById("main3"));
        wordChart.showLoading();
        $.ajax({
            url:'${ctx}/standard/analy/list',
            dataType: 'json',
            type:'get',
            success: function (data) {
                wordChart.hideLoading();
                var dataArr = [];
                $.each(data.data,function (index,item) {
                    var chartData2 = {
                        name: '',
                        value: ''
                    };
                    chartData2.name = item.nameCn;
                    chartData2.value = parseInt(item.compCount);
                    dataArr.push(chartData2);
                });
                var wordoption = {
                    backgroundColor: '#F7F7F7',
                    tooltip: {
                        show: true
                    },
                    toolbox: {
                        feature: {
                            saveAsImage: {
                                iconStyle: {
                                    normal: {
                                        color: '#FFFFFF'
                                    }
                                }
                            }
                        }
                    },
                    series: [{
                        name: '热点分析',
                        type: 'wordCloud',
                        //size: ['9%', '99%'],
                        sizeRange: [18, 48],
                        //textRotation: [0, 45, 90, -45],
                        rotationRange: [-45, 90],
                        //shape: 'circle',
                        textPadding: 0,
                        autoSize: {
                            enable: true,
                            minSize: 6
                        },
                        textStyle: {
                            normal: {
                                color: function() {
                                    return 'rgb(' + [
                                        Math.round(Math.random() * 160),
                                        Math.round(Math.random() * 160),
                                        Math.round(Math.random() * 160)
                                    ].join(',') + ')';
                                }
                            },
                            emphasis: {
                                shadowBlur: 10,
                                shadowColor: '#333'
                            }
                        },
                        data: dataArr
                    }]
                };
//				wordoption.series[0].data = JosnList;
                wordChart.setOption(wordoption);
                $(window).resize(wordChart.resize);
            }
        });
    });
    // 资源分类
    // 获取数据
	$(function () {
        var axisChart = echarts.init(document.getElementById("main4"));
        axisChart.showLoading();
		$.ajax({
			url:'${ctx}/panel/ass/queryCountList',
			dataType: 'json',
			type:'get',
			success: function (data) {
                axisChart.hideLoading();
				var chartData4 = {
					companyName: [],
					sourceName: ['信息系统','信息项','信息资源','基础资源','主题资源'],
					data: []
				};
				$.each(data.data,function (index,pItem) {
                    $('<option></option>').val(index).text(pItem.companyName).appendTo($('#chartSelect2'));
				    var dataInit = {};
					var dataIndex = "data" + (index+1);
					var dataArr = [];
                    chartData4.companyName.push(pItem.companyName);
                    dataArr.push(pItem.sCount);
                    dataArr.push(pItem.eCount);
                    dataArr.push(pItem.iCount);
                    dataArr.push(pItem.iCount1);
                    dataArr.push(pItem.iCount2);
                    dataInit['name'] = pItem.companyName;
                    dataInit['type'] = 'bar';
                    dataInit['data'] = dataArr;
                    chartData4.data.push(dataInit);
				});
                if (data.data.length>5){
                    chartData4.companyName = chartData4.companyName.slice(0,5);
                    chartData4.data = chartData4.data.slice(0,5);
                }
                $('#chartSelect2').addClass('selectpicker').selectpicker({
                    maxOptionsText: '最多选择7个显示项！'
                }).show();
				var axisoption = {
					title: {
					    show: false,
						text: ' ',
						subtext: '各部门资源数据对比'
					},
					tooltip: {
						trigger: 'axis',
						axisPointer: {
							type: 'shadow'
						}
					},
					toolbox: {
						show: true,
                        orient: 'vertical',
						feature : {
							dataView : {show: true, readOnly: false},
							magicType: {show: true, type: ['line', 'bar']},
							restore : {show: true},
							saveAsImage : {show: true}
						},
						iconStyle: {
							normal: {
                                textPosition: 'left'
                            }
                        },
                        right: '.8%'
					},
					legend: {
						data: chartData4.companyName
					},
					grid: {
						left: '3%',
						right: '4%',
						bottom: '3%',
						containLabel: true
					},
					color: ['#A878C0','#6ABD78','#30C0C0','#FFC078','#0090D8','#f17c67','#fdb933','#C7FFEC'],
					xAxis: {
						type: 'category',
						data: chartData4.sourceName
					},
					yAxis: {
						type: 'value',
						boundaryGap: [0, 0.01]
					},
					series: chartData4.data
				};
				axisChart.setOption(axisoption);
				$(window).resize(axisChart.resize);

			}
		});
    });
</script>
</html>

