<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<style type="text/css">
.com-count {
	padding: 7px 15px 7px 15px;
	color: #333;
	cursor: pointer;
}

.com-count .badge {
	margin-left: 5px;
}

.label-info, .badge-info {
	font-size: 14px;
}
.rr .form-group {
	display:inline-block;
}

.rr .form-control{
    display: inline-block;
    width: auto;
}
#repeatForm .form-group {
	display:block;
}
#repeatForm .form-group input{
	width: 100%;
}
.rr .form-group {
	margin:0;
}
#layer_form {
}
#layer_form .clean_layer_left {
	width: 69%;
	display: inline-block;
	height: 370px;
	overflow-y: scroll;
	overflow-x: hidden;
	vertical-align: top;
}
#layer_form .clean_layer_right {
	width: 29%;
	display: inline-block;
	vertical-align: top;
	overflow: hidden;
}
#layer_form .clean_layer_right span.label-info {
	display: inline-block;
}
#layer_form .clean_layer_right span.value-span {
    cursor: pointer;
    display: block;
    white-space: normal;
    text-align: left;
}
</style>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
	
		<div class="ibox float-e-margins">
			<div class="ibox-content ">
				<div class="form-group rr" style="margin-bottom: 10px;">
					<div class="form-group">
						<input type="text" placeholder="输入信息项中文名" name="search_nameCn" class="form-control">
						<input type="text" name="search_sort" class="form-control hide" value=1>
						<div class="btn-group">
							<button class="btn btn-primary" type="submit"
								onclick="initWeb();"><i class="iconfont gm-search"></i>搜索</button>
						</div>
					</div>
					<div class="form-group">
						<button class="btn btn-primary  btn-cyan change-sort" onclick="sort()">
							按次数排序&nbsp;<i class="fa fa-sort-desc"></i>
						</button>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="clearfix"></div>
				<div class="hr-line-dashed"
					style="margin-top: 0px; margin-bottom: 0px;"></div>
				<div class="panel panel-default">
					<div class="p-xs panel-heading">
						<h3>重复数据</h3>
					</div>
					
					<div id="content" class="panel-body">
						<div class="col-sm-12 repeat-content">
							
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
	
	<!-- 清洗重复信息项 -->
	<div id="layer_form" style="display: none;" class="ibox-content">
		<div class="clean_layer_left">
			<form id="eForm" class="form-horizontal">
				<input type="text" name="delId" class="hide">
				<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
				
			</form>
		</div>
		<div class="clean_layer_right">
			
		</div>
	</div>

	<!-- 相关信息资源 -->
	<div id="about_layer_form" style="display: none;" class="ibox-content">
		<div id="about_Form" class="form-horizontal">
			<div class="ibox-content">
				<input class="hide" name="id">
				<input class="hide" name="ids">
				<table id="aboutRepeatTable">
					<thead>
						<tr>
							<th data-field="nameEn">信息资源代码</th>
							<th data-field="nameCn">信息资源名称</th>
							<th data-field="companyName">所属部门</th>
							<th data-field="isAudit" data-formatter="isAuditTrans">状态</th>
							<th data-field="Score" data-formatter="aboutTableButton" class="col-sm-4" data-width="100">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<!-- 信息资源详情 -->
	<div id="infoDetail_layer_form" style="display: none;" class="ibox-content">
		<form id="infoDetail_Form" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/inforAutoForm.jsp"%>
			
		</form>
		<div id="infoDetail_search_form">
			<input type="text" class="hide" name="id" />
		</div>
		<table id="infoDetailRepeatTable">
			<thead>
				<tr>
					<th data-field="idCode">内部标识符</th>
					<th data-field="nameCn">信息项名称</th>
					<th data-field="dataTypeName">数据类型</th>
					<th data-field="len">数据长度</th>
					<th data-field="companyName">来源部门</th>
					<th data-field="Score" data-formatter="infoDetailTableButton" class="col-sm-4">操作</th>
				</tr>
			</thead>
		</table>
	</div>

	<!-- 信息项详情 -->
	<div id="information_layer_form" style="display: none;" class="ibox-content">
		<form id="information_Form" class="form-horizontal">
			<%@include file="/WEB-INF/views/include/eleAutoForm.jsp"%>
			
		</form>
	</div>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
	var tableId = '';
	var toolbar = '';
	var layerId = '#layer_form';
	var formId = ''; //form id
	var url = '${ctx}/standard/repeat/';
	var obj = {};
	var editTitle = "统一重复信息项";
	var detailTitle = "";
	var cleanForm = '#eForm'
	
	$(function () {
		initWeb();
		// 相关信息资源
		aboutDetail = new aboutTableInit();
		aboutDetail.Init();
		// 信息资源详情
		infoDetail = new infoDetailTableInit();
		infoDetail.Init();
		// 四级联动
		var relConfigInfo = {
			ajax: '${ctx}/catalogset/infoSort/queryList',
			select: '.linkagesel-select-info',
			loaderImg: ''
		};
		window.linkRelInfo = new LinkageSel(relConfigInfo);
		// 没有找到数据返回之后的回调函数，所以写了一个延时效果
		setTimeout(function () {
			$(".LinkageSel").hide();
			$(".LinkageSel").chosen({width: "48%"});
			$(".LinkageSel").trigger("chosen:updated");
		}, 500);
		linkRelInfo.onChange(function () {
			$(".linkagesel-select-div select").each(function (index, item) {
				var hideHtml = "div:eq(" + index + ")";
				// 如果为零表示是select为空，隐藏掉，并且将select的name值去掉
				if ($(this).children('option').length == 0) {
					$(".linkagesel-select-div").children(hideHtml).hide();
					$(this).removeAttr("name");
					$(this).attr('disabled', 'disabled');
					linkageselChosen()
				} else {
					$(".linkagesel-select-div").children(hideHtml).show();
					$(this).attr("name", "infoType" + (index + 1));
					$(this).attr('disabled', 'disabled');
					linkageselChosen()
				}
			});
		})
		// 开放、共享表单事件绑定
	    shareToggleMethod();
	})
	
	function initWeb () {
		var params = {
			nameCn: $("input[name=search_nameCn]").val(),
			isDesc: $("input[name=search_sort]").val()
		}
		$.ajax({
			url: url + 'list',
			data: params,
			success: function (res) {
				$(".repeat-content").html("");
				if (res.length == 0) {
					$(".repeat-content").html('<div class="alert alert-success" style="margin:10px;">暂无符合条件的重复信息项需要清洗。 </div>')
					return
				}
				var html = '';
				$.each(res, function (index, item) {
					html += '<div class="com-count col-sm-3" index="' + item.nameCn + '">' + item.nameCn + ' (' + item.count + ')</div>';
				})
				$(".repeat-content").append(html);
				$(".com-count").click(function () {
					var row = res[$(this).attr("index")];
					openRepeatLayer($(this).attr("index"), editTitle);
					loadData(row);
					// 通过验证
					$(cleanForm).find("input").blur();
					$(cleanForm).find("textarea").blur();
					$(cleanForm).find("select").blur();
				})
			}
		})
	}
	
	// 排序
	function sort () {
		var $this = $("input[name=search_sort]");
		var $button = $("button.change-sort").find("i");
		if ($this.val() == 1) {
			$this.val(0);
			$button.removeClass("fa-sort-desc");
			$button.addClass("fa-sort-asc");
		} else if ($this.val() == 0) {
			$this.val(1);
			$button.removeClass("fa-sort-asc");
			$button.addClass("fa-sort-desc");
		}
		initWeb();
	}
	
	function openRepeatLayer(name, title) {
		$.ajax({
			url: url + 'repeatList',
			data: {nameCn: name},
			success: function (res) {
				openCleanLayer(title, res);
			}
		})
		layer.open({
			title: title,
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			btn : [ '保存', '关闭' ],
			yes : function(index, layero) {
				// cleanElePool
				$(cleanForm).submit();
			},
			end : function() {
				$(".is-ambiguity").remove();
				$(cleanForm).resetForm();
				endMethod(cleanForm, "close");
			},
			cancel: function () {
				$(".is-ambiguity").remove();
				endMethod(cleanForm);
			},
			content : $(layerId)
		});
	}
	
	$(function () {
		$(cleanForm).validate({
			ignore: ":hidden:not(select,input)",
	        submitHandler: function(form){
	        	$(cleanForm).ajaxSubmit({
	    			url : '${ctx}/standard/equal/' + 'cleanElePool',
	    			type : 'post',
	    			success : function(data){
	    				layer.close(layer.index);
	    				initWeb();
	    				layer.msg(data);
	    				endMethod(cleanForm);
	    			},
	    			error : function(XmlHttpRequest, textStatus, errorThrown){
	    				layer.close(layer.index);
	    				initWeb();
	    				layer.msg("数据操作失败!");
	    				endMethod(cleanForm);
	    			},
	    			resetForm : true
	    		});
	    		return false;
	        }
	    });
	})
	
	// 清洗
	function openCleanLayer(title, data) {
		$(".clean_layer_right").html("");
		console.log("data: ", data);
		var row = {};
		var delId = []
		// 首先处理数据，将单独的数据给回显，重复的数据放出来认为选择
		$.each(data, function (i, item) {
			delId.push(item.id);
			$.each(item, function (m, mItem) {
				if (row[m] == undefined) {
					row[m] = [];
				}
				if (mItem != "" && mItem != null) {
					if (row[m].length == 0) {
						row[m].push({data: mItem, count: 1, ids: [item.id]})
					} else {
						$.each(row[m], function (n, nItem) {
							if (nItem.data == mItem) {
								row[m][n].count++;
								row[m][n].ids.push(item.id)
								return false;
							}
							if (n == row[m].length -1) {
								row[m].push({data: mItem, count : 1, ids: [item.id]});
							}
						})
					}
				}
			})
		})
		console.log("row: ", row);
		$("#eForm input[name=delId]").val(delId);
		// 回显
		var obj = row;
		var key, value, tagName, type, arr;
		for (x in obj) {
			// 如果数据只有一条，直接显示，如果存在两个以上的数据，标明"存在歧义"，并将数据显示在右侧
			key = x;
			value = obj[x];
			var html = '<span class="is-ambiguity" style="color:#23c6c8;font-size: 13px;"><i class="fa fa-info-circle"></i>&nbsp;存在分歧</span>';
			$("#eForm").find('[name=' + key + ']').each(function () {
				var name = $(this).attr("name");
				tagName = $(this)[0].tagName;
				type = $(this).attr('type');
				if (value.length == 1) {
					if (tagName == 'INPUT') {
						$(this).val(value[0].data);
					} else if (tagName == 'SELECT') {
						$(this).val(value[0].data);
						$(this).trigger("chosen:updated");
					}
					$(this).click(function () {
						$(".clean_layer_right").html("");
					})
					$(this).siblings(".chosen-container").click(function () {
						$(".clean_layer_right").html("");
					})
				} else if (value.length > 1) {
					// 加上歧义标签和焦点事件
					$(this).closest(".col-sm-7").append(html);
					$(this).click(function () {
						displayList(obj, name, $(this));
					})
					$(this).siblings(".chosen-container").click(function () {
						displayList(obj, name, $(this));
					})
				}
			})
		}
		$("#eForm").validate().form();
	}
	
	// 右侧分歧显示
	function displayList (obj, name, $this) {
		console.log("obj: ", obj);
		console.log("name: ", name);
		console.log("value: ", obj[name]);
		$(".clean_layer_right").html("");
		var rightHtml = '<div class="alert alert-info">点击<i class="fa fa-gg detail-span"></i>查看相关信息资源<br>点击文字快速复制。</div>';
		$.each(obj[name], function (index, item) {
			rightHtml += '<p><span class="label label-info">';
			rightHtml += '<span class="value-span" data-value="' + item.data + '" style="cursor:pointer;">';
			rightHtml += item.data + '(' + item.count + ')';
			rightHtml += ' <i class="fa fa-gg detail-span-i" data-ids="' + item.ids + '" style="cursor:pointer;"></i></span></span></p>';
		})
		$(".clean_layer_right").append(rightHtml);
		$(".value-span").click(function () {
			// 将取到的值赋值到对应的表单中
			$this.val($(this).attr("data-value"));
			$this.blur();
			$this.prev("select").val($(this).attr("data-value"));
			$this.prev("select").trigger("chosen:updated");
			$this.prev("select").blur();
		})
		$(".detail-span-i").click(function () {
			$("#about_Form input[name=ids]").val($(this).attr("data-ids"));
			console.log("ids: ", $(this).attr("data-ids"))
			aboutInfo();
		})
	}
	
	// 相关信息资源
	function aboutInfo () {
		$("#aboutRepeatTable").bootstrapTable("refresh", {url: '${ctx}/standard/equal/infoListByEleId'});
		aboutLayeForm = layer.open({
			title: "相关信息资源",
			type : 1,
			area : [ '80%', '80%' ],
			scrollbar : false,
			zIndex : 300,
			content : $("#about_layer_form")
		});
	}
	
	// 相关信息资源表格
	var aboutTableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$("#aboutRepeatTable").bootstrapTable({
				// url : url + 'listById',
				method : 'get',
				striped : true, // 是否显示行间隔色
				pagination : true, // 是否显示分页（*）
				queryParams : oTableInit.queryParams, // 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
				iconSize : 'outline',
				icons : {
					refresh : 'glyphicon-repeat',
					columns : 'glyphicon-list'
				},
				uniqueId : "id", // 每一行的唯一标识，一般为主键列
			});
		};
	
		// 得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				queryParams : $("#about_Form input[name=ids]").val()
			};
			return temp;
		};
		return oTableInit;
	};

	function aboutTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="infoDetailAboutRow('
				+ row.id + ')"><i class="fa fa-pencil"></i>&nbsp;查看</button>';
		return html;
	}

	// 查看按钮-信息项详情
	function infoDetailAboutRow (id) {
		var row = $("#aboutRepeatTable").bootstrapTable('getRowByUniqueId', id);
		loadToData(row, 'infoDetail_Form');
		$("#infoDetail_search_form input[name=id]").val(id);
		$("#infoDetailRepeatTable").bootstrapTable("refresh", {url: '${ctx}/standard/equal/eleByInfoId'});
		$("#infoDetail_Form input").attr('disabled', 'disabled');
		$("#infoDetail_Form select").attr('disabled', 'disabled');
		$("#infoDetail_Form select").trigger("chosen:updated");
		infoDetailLayeForm = layer.open({
			title: "信息资源详情",
			type : 1,
			area : [ '75%', '75%' ],
			scrollbar : false,
			zIndex : 300,
			content : $("#infoDetail_layer_form")
		});
	}

	function infoDetailTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="infoDetailRow('
				+ row.id + ')"><i class="fa fa-pencil"></i>&nbsp;查看</button>';
		return html;
	}

	// 信息项详情
	function infoDetailRow (id) {
		var row = $("#infoDetailRepeatTable").bootstrapTable('getRowByUniqueId', id);
		loadToData(row, 'information_Form')
		disabledMenu('#information_Form')
		informationLayeForm = layer.open({
			title: "信息资源详情",
			type : 1,
			area : [ '70%', '70%' ],
			scrollbar : false,
			zIndex : 300,
			content : $("#information_layer_form")
		});
	}

	var infoDetailTableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$("#infoDetailRepeatTable").bootstrapTable({
				// url : url + 'listById',
				method : 'get',
				striped : true, // 是否显示行间隔色
				pagination : true, // 是否显示分页（*）
				queryParams : oTableInit.queryParams, // 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
				iconSize : 'outline',
				icons : {
					refresh : 'glyphicon-repeat',
					columns : 'glyphicon-list'
				},
				uniqueId : "id", // 每一行的唯一标识，一般为主键列
			});
		};
	
		// 得到查询的参数
		oTableInit.queryParams = function(params) {
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				id : parseInt($("#infoDetail_search_form input[name=id]").val())
			};
			return temp;
		};
		return oTableInit;
	};

	function isAuditTrans (value) {
		if (value == 0) {
			return "待审核"
		} else if (value == 1) {
			return "已审核"
		}
	}

	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

