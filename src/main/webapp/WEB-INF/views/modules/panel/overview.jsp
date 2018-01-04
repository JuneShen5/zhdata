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
.wrapper td{
	border: solid 1px #ccc;
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
	height: 300px;
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
.item-wrapper .select-area>.bootstrap-select{
	max-width: 600px;
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
								<h3 class="title" style="display: inline-block;">部门资源概览</h3>
								<div class="select-area" style="display: none">
									<select id="chartSelect1" name="chartSelect1" class="" multiple data-width="fit">
									</select>
									<button id="selectBtn1" class="btn btn-primary">确定</button>
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
	  							<h3 class="title" style="display: inline-block;">各部门资源数据对比</h3>
								<div class="select-area" style="display: none">
									<select id="chartSelect2" name="chartSelect2" class="" multiple data-width="fit">
									</select>
									<button id="selectBtn2" class="btn btn-primary">确认</button>
								</div>
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
        var axisChart1 = echarts.init(document.getElementById("main1"));
        var axisChart2 = echarts.init(document.getElementById("main4"));
        axisChart1.showLoading();
        axisChart2.showLoading();
        // 获取下拉框数据
        $.ajax({
            url:'${ctx}/settings/company/list',
            dataType: 'json',
            type:'get',
            data: {
                types: "1,2"
            },
            success: function (data) {
                $.each(data,function (index,selectItem) {
                    $('<option></option>').val(selectItem.id).text(selectItem.name).appendTo($('#chartSelect1'));
                    $('<option></option>').val(selectItem.id).text(selectItem.name).appendTo($('#chartSelect2'));
                });
                chartSet1();
			}
		});

        // 获取柱状图数据
		function chartSet1() {

		$.ajax({
			url:'${ctx}/panel/ass/queryCountList',
			dataType: 'json',
			type:'get',
            data: {
                pageNum: 1,
                pageSize: 6,
                obj: JSON.stringify({'name': ''}),
                companyIds: ''
            },
			success: function (data) {
                $('.select-area').show();
                axisChart1.hideLoading();
                axisChart2.hideLoading();
                // 排行榜图形设置-begin
				var chartData1 = {
					companyName: [],
					sourceName: ['信息系统数目','信息项数目','信息资源数目'],
					data1: [],
					data2: [],
					data3: []
				};
				var selectedId1 = [];
				$.each(data.rows,function (index,pItem) {
					chartData1.companyName.unshift(pItem.companyName);
					chartData1.data1.unshift(pItem.sCount);
					chartData1.data2.unshift(pItem.eCount);
					chartData1.data3.unshift(pItem.iCount);
					selectedId1.push(pItem.companyId);
				});
                $('#chartSelect1').val(selectedId1).addClass('selectpicker').selectpicker({
                    maxOptions: 10,
                    maxOptionsText: '最多选择10个显示项！',
                    dropdownAlignRight: 'auto',
                    liveSearch: true
                });
				var axisoption1 = {
					title: {
                        show: false,
						text: '部门资源概览'
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
							dataView : {
							    show: true,
								optionToContent: function(opt) {
									var axisData = opt.yAxis[0].data;
									var series = opt.series;
									var table = '<table style="width:100%;text-align:center"><tbody><tr>'
										+ '<td>部门名称</td>'
										+ '<td>' + series[0].name + '</td>'
                                        + '<td>' + series[1].name + '</td>'
                                        + '<td>' + series[2].name + '</td>'
										+ '</tr>';
									for (var i = 0, l = axisData.length; i < l; i++) {
										table += '<tr>'
											+ '<td>' + axisData[i] + '</td>'
											+ '<td>' + series[0].data[i] + '</td>'
											+ '<td>' + series[1].data[i] + '</td>'
                                            + '<td>' + series[2].data[i] + '</td>'
											+ '</tr>';
									}
									table += '</tbody></table>';
									return table;
								},
                                readOnly: true
							},
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
						data: chartData1.companyName
					},
					series: [
						{
							name: chartData1.sourceName[0],
							type: 'bar',
							data: chartData1.data1
						},
						{
							name: chartData1.sourceName[1],
							type: 'bar',
							data: chartData1.data2
						},
						{
							name: chartData1.sourceName[2],
							type: 'bar',
							data: chartData1.data3
						}
					]
				};
                axisChart1.setOption(axisoption1);
				$(window).resize(axisChart1.resize);
				// 部门选择展示按钮1
				$('#selectBtn1').on('click', function () {
                    var selectedItems = $('#chartSelect1').val();
                    var ids = '';
                    axisChart1.showLoading();
                    if (!selectedItems){
                        selectedItems = '';
					}else {
                        $.each(selectedItems, function (index, item) {
                            if (index === selectedItems.length-1){
                                ids += item;
                            }else{
                                ids += item + ',';
                            }
                        });
					}
                    $.ajax({
                        url:'${ctx}/panel/ass/queryCountList',
                        dataType: 'json',
                        type:'get',
                        data: {
                            pageNum: 1,
                            pageSize: selectedItems.length,
                            obj: JSON.stringify({'name': ''}),
                            companyIds: ids
                        },
                        success: function (data) {
                            axisChart1.hideLoading();
                            chartData1.companyName=[];
                            chartData1.data1=[];
                            chartData1.data2=[];
                            chartData1.data3=[];
                            $.each(data.rows,function (index,pItem) {
                                chartData1.companyName.unshift(pItem.companyName);
                                chartData1.data1.unshift(pItem.sCount);
                                chartData1.data2.unshift(pItem.eCount);
                                chartData1.data3.unshift(pItem.iCount);
                            });
                            axisoption1.yAxis.data = chartData1.companyName;
                            axisoption1.series[0].data = chartData1.data1;
                            axisoption1.series[1].data = chartData1.data2;
                            axisoption1.series[2].data = chartData1.data3;
                            axisChart1.setOption(axisoption1, true);
                        }
                    });
                });
                // 排行榜图形设置-end

                // 各部门资源数据对比图形设置-begin
                var chartData4 = {
                    companyName: [],
                    sourceName: ['信息系统','信息项','信息资源','基础资源','主题资源'],
                    data: []
                };
                var selectedId2 = [];
                $.each(data.rows,function (index,pItem) {
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
                    selectedId2.push(pItem.companyId);
                });
                $('#chartSelect2').val(selectedId2).addClass('selectpicker').selectpicker({
                    maxOptions: 10,
                    maxOptionsText: '最多选择10个显示项！',
                    dropdownAlignRight: 'auto',
                    liveSearch: true
                });
                var axisoption2 = {
                    title: {
                        show: false,
                        text: '各部门资源数据对比',
                        subtext: ''
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
                            dataView : {show: true,
                                optionToContent: function(opt) {
                                    var axisData = opt.xAxis[0].data;
                                    var series = opt.series;
                                    console.log(series.length);
                                    var table = '<table style="width:100%;text-align:center"><tbody><tr>'
                                        + '<td>部门名称</td>';
                                    for (var i = 0; i < series.length; i++) {
                                        table += '<td>' + series[i].name + '</td>';
                                    }
                                    table += '</tr>';
									for (var k = 0; k < axisData.length; k++) {
										table += '<tr>'
                                        table += '<td>' + axisData[k] + '</td>';
										for (var j = 0; j < series.length; j++) {
											table += '<td>' + series[j].data[k] + '</td>';
										}
                                        table += '</tr>';
									}
                                    table += '</tbody></table>';
                                    return table;
                                },
                                readOnly: true
							},
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
                axisChart2.setOption(axisoption2);
                $(window).resize(axisChart2.resize);

                // 部门选择展示按钮2
                $('#selectBtn2').on('click', function () {
                    var selectedItems = $('#chartSelect2').val();
                    var ids = '';
                    axisChart2.showLoading();
                    if (!selectedItems){
                        selectedItems = '';
                    }else {
                        $.each(selectedItems, function (index, item) {
                            if (index === selectedItems.length-1){
                                ids += item;
                            }else{
                                ids += item + ',';
                            }
                        });
                    }
                    $.ajax({
                        url:'${ctx}/panel/ass/queryCountList',
                        dataType: 'json',
                        type:'get',
                        data: {
                            pageNum: 1,
                            pageSize: selectedItems.length,
                            obj: JSON.stringify({'name': ''}),
                            companyIds: ids
                        },
                        success: function (data) {
                            axisChart2.hideLoading();
                            chartData4.companyName = [];
                            chartData4.data = [];
                            $.each(data.rows,function (index,pItem) {
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
                            axisoption2.legend.data = chartData4.companyName;
                            axisoption2.series = chartData4.data;
                            axisChart2.setOption(axisoption2, true);
                        }
                    });
				});
                // 各部门资源数据对比图形设置-end
			}
		});
	}
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
</script>
</html>

