<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body class="white-bg skin-7">
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:100%;"></div>
</body>

<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script src="${ctxStatic}/js/plugins/echarts/echarts.js"></script>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('main'));
myChart.showLoading();
$.ajax({url: "${ctx}/assets/echarts/relation", success: function(res) {
	console.log("res: ", res);
	myChart.hideLoading();
	option = {
	    title: {
	        text: ''
	    },
	    tooltip: {},
        toolbox: {
	        show: true
        },
	    animationDurationUpdate: 1500,
	    animationEasingUpdate: 'quinticInOut',
	    legend: {
	        x: "center",
	        show: true,
	        data: ['部门', "系统", "信息资源", '数据元'] // 此处不显示根节点学生
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
	                name: '部门',
	                itemStyle: {
	                	normal: {
	                		color: '#f36a5a'
	                	}
	                }
	            }, {
	                name: '系统',
	                itemStyle: {
	                	normal: {
	                		color: '#95ce67'
	                	}
	                }
	            }, {
	                name: '信息资源',
	                itemStyle: {
	                	normal: {
	                		color: '#C0A8D8'
	                	}
	                }
	            }, {
	                name: '数据元',
	                itemStyle: {
	                	normal: {
	                		color: '#30C0C0'
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
	                repulsion: 80,
	              	initLayout: 'circular',
	                edgeLength: 120,
	                gravity: 0.07
	            },
	            tooltip: {
	                formatter: function(node) { // 区分连线和节点，节点上额外显示其他数字
	                    /*if (!node.value) {
	                        return node.data.name;
	                    } else {
	                        return node.data.name + ":" + node.data.showNum;
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
}})
//替换GALERY中代码
</script>
</html>

