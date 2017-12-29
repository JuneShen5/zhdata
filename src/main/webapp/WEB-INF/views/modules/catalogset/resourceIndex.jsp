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
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">数据展示</div> -->
			<div class="ibox-content" style="min-height: 500px;">
				<div id="toolbar" class="toolbar">
					<div id="tagTop" class="toolbar-tag-top">
						<span class="active" data-tagid="">部门类</span>
					</div>
					<div id="tagList">
						<div class="form-inline" style="margin: 20px 0 0 35px;">
							<div class="form-group">
								<input id="sName" name="name" type="text" placeholder="输入名称"
									class="form-control col-sm-8">
								<div class="input-group-btn col-sm-4">
									<button type="button" onclick="searchForRes()" class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
								</div>
							</div>
						</div>
						<ul id="deper" class="deper clearfix">
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display: none;" class="ibox-content">
		<table id="resTable">
			<thead>
				<tr>
					<th data-field="nameEn">信息资源编号</th>
					<th data-field="nameCn">信息资源名称</th>
					<th data-field="companyName">所属部门</th>
					<c:forEach var="att" items="${fns:getAttList(4,2)}">
								<c:if test="${att.isShow=='yes'}"><th data-field="${att.nameEn}">${att.nameCn}</th></c:if>
					</c:forEach>
					<th data-field="Score" data-formatter="resTableButton">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div id="detail_layer_form" style="display: none;" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group linkagesel-select-group-info clearfix">
				<label class="col-sm-3 control-label">信息资源分类：</label>
				<div class="col-sm-7 linkagesel-select-list clearfix">
					<div class="linkagesel-select-div" required>
						<select id="linkageSelSelect" class="linkagesel-select-info" name="infoType1" value="" required></select>

					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息资源名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">所属系统：</label>
				<div class="col-sm-7">
					<select name="systemId" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="sys" items="${fns:getList('sys')}">
							<option value="${sys.id}">${sys.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		
			<c:set var="user" value="${fns:getCurrentUser()}" />
			<div class="form-group">
				<label class="col-sm-3 control-label">信息资源提供方：</label>
				<c:choose>
					<c:when test="${user.roleId==1}">
						<div class="col-sm-7">
							<select name="companyId" class="select-chosen" required>
								<option value=""></option>
								<c:forEach var="company" items="${fns:getList('company')}">
									<option value="${company.id}">${company.name}</option>
								</c:forEach>
							</select>
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-sm-7">
							<input type="text" name="companyId" class="form-control hide" value="${user.companyId}">
							<input type="text" name="companyName" class="form-control" value="${fns:queryCompanyName()}" required>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="根据信息资源提供方自动生成">信息资源提供方代码：</label>
				<div class="col-sm-7">
					<input type="text" name="code" class="form-control">
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="根据规则自动生成">信息资源代码：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">数据表英文名称：</label>
				<div class="col-sm-7">
					<input type="text" name="tbName" class="form-control" required>
				</div>
			</div>
			<c:set var="type" value="2" />
			<%@include file="/WEB-INF/views/include/autoForm.jsp"%>
			<div class="form-group">
				<label class="col-sm-3 control-label">共享类型：</label>
				<div class="col-sm-7">
					<select name="shareType" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="dict" items="${fns:getDictList('share_type')}">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">共享条件：</label>
				<div class="col-sm-7">
					<select name="shareCondition" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="dict" items="${fns:getDictList('share_condition')}">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">共享方式：</label>
				<div class="col-sm-7">
					<select name="shareMode" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="dict" items="${fns:getDictList('share_mode')}">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">是否向社会开放：</label>
				<div class="col-sm-7">
					<select name="isOpen" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">开放类型：</label>
				<div class="col-sm-7">
					<select name="openType" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="dict" items="${fns:getDictList('open_type')}">
								<option value="${dict.value}">${dict.label}</option>
							</c:forEach>
						</select>
				</div>
			</div>
		</form>
		<table id="elementTable">
			<thead>
			<tr>
				<th data-field="idCode">内部标识符</th>
				<th data-field="nameCn">信息项名称</th>
				<th data-field="dataTypeName">数据类型</th>
				<th data-field="len">数据长度</th>
				<th data-field="companyName">来源部门</th>
				<th data-field="Score" data-formatter="elementTableButton">操作</th>
			</tr>
			</thead>
		</table>
	</div>
	
	<div id="element_layer_form" style="display:none" class="ibox-content">
			<form id="elementform" class="form-horizontal">
				<input type="text" name="id" class="hide">
				<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">信息项名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" placeholder="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的英文标题">英文名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" placeholder="描述信息资源中具体数据项的英文标题" required>
				</div>
			</div>
			
			<%@include file="/WEB-INF/views/include/dataType.jsp"%>
			
            <div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该信息项对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该信息项内容字数的上限，并折算成字节数，该字节数即为数据长度">数据长度：</label>
				<div class="col-sm-7">
					<input type="text" name="len" class="form-control" placeholder="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）" >
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">对象类型：</label>
				<div class="col-sm-7">
					<select name="objectType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('object_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">数据标记：</label>
				<div class="col-sm-7">
					<select name="dataLabel" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			 <div class="form-group">
				<label class="col-sm-3 control-label">来源部门：</label>
				<div class="col-sm-7">
					<select name="companyId" class="select-chosen">
						<option value=""></option>
						<c:forEach var="company" items="${fns:getList('company')}">
							<option value="${company.id}">${company.name}</option>
						</c:forEach>
					</select>
				</div>
			</div> 
			
			<div class="form-group">
				<label class="col-sm-3 control-label">是否字典项：</label>
				<div class="col-sm-7">
					<select name="isDict" class="select-chosen">
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享类型：</label>
				<div class="col-sm-7">
					<select name="shareType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享条件：</label>
				<div class="col-sm-7">
					<select name="shareCondition" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_condition')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">共享方式：</label>
				<div class="col-sm-7">
					<select name="shareMode" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('share_mode')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">是否向全社会开放：</label>
				<div class="col-sm-7">
					<select name="isOpen" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">开放条件：</label>
				<div class="col-sm-7">
					<select name="openType" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('open_type')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group">
				<label class="col-sm-3 control-label">更新周期：</label>
				<div class="col-sm-7">
					<select name="updateCycle" class="select-chosen" required>
						<option value=""></option>
						<c:forEach var="dict" items="${fns:getDictList('update_cycle')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			</form>
		</div>

</body>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

<style>
	.search-text{
		font-size: 14px;
		cursor: default;
		padding-left: 35px;
	}
</style>

<script>
	var formId = "";
	var tableId = "";
	var resTableId = "#resTable";
	var layerId = '#layer_form';
	var url = '${ctx}/catalogset/res/';
	var detailLayerId = "#detail_layer_form";
	var obj = {
			nameCn : $('#sName').val(),
			companyId : 1,
			infoType1 : "",
			infoType2 : "",
			isAuthorize:0
		};
	var listData = new Array();
	var detailTitle = "信息项详情";
	var elementTableId = "#elementTable";
	var elementLayerId = '#element_layer_form';
	var elementFormId = "#elementform";
	
	function changeInit () {
		linkRelInfo.onChange(function () {
			$(".linkagesel-select-div select").each(function (index, item) {
				var hideHtml = "div:eq(" + index + ")";
				// 如果为零表示是select为空，隐藏掉，并且将select的name值去掉
				if ($(this).children('option').length == 0) {
					$(".linkagesel-select-div").children(hideHtml).hide();
					$(this).removeAttr("name");
				} else {
					$(".linkagesel-select-div").children(hideHtml).show();
					$(this).attr("name", "infoType" + (index + 1));
				}
			});
			// 由于执行存在顺序的原因，加上延时，模拟回调函数
			setTimeout(function () {
				$(".linkagesel-select-div").find("div.chosen-container").width("48%");
				$(".LinkageSel").hide();
				$('.LinkageSel').prop("disabled", true);
				$(".LinkageSel").chosen({width: "48%"});
				$(".LinkageSel").trigger("chosen:updated");
			}, 0)
		})
	}

	// 四级联动
	$(function () {
		var relConfigInfo = {
			ajax: '${ctx}/catalogset/infoSort/queryList',
			select: '.linkagesel-select-info',
			loaderImg: ''
		};
		window.linkRelInfo = new LinkageSel(relConfigInfo);
		// 没有找到数据返回之后的回调函数，所以写了一个延时效果
		setTimeout(function () {
			$(".LinkageSel").hide();
			$(".LinkageSel").chosen({width: "100%"});
			$(".LinkageSel").trigger("chosen:updated");
		}, 500);
		changeInit();
	})

	// 动态的将数据赋值进去
	function loadLinkageSel (data) {
		linkRelInfo.changeValues(data, true);
	};
	
	// 弹框关闭之后将多级联动回复初始化
	function resetPage (data) {
		linkRelInfo.reset();
		// 将code的input隐藏
		$("input[name=code]").closest(".form-group").hide();
	}

	// 动态获取tag的id及name
	$(function () {
		$.ajax({
			url:'${ctx}/catalogset/res/queryByPid',
			data:{
				id: '0'
			},
			dataType: 'json',
			type:'get',
			success: function (data) {
				for(var i in data){
					$("<span></span>").attr("data-tagId",data[i].id).text(data[i].name).appendTo($("#tagTop"));
					$("<ul></ul>").attr("id","deper"+data[i].id).addClass("deper clearfix").hide().appendTo($("#tagList"));
				}
				tagChange();
				getTagData();
			}
		});
	});
	
	// 标签点击设置obj参数infoType
	$(function(){
		var infoType = "";
		var tagID = "";
		var tagName = "";
		$("#tagList").on("click",".js-tag-item",function(){
			infoType = $(this).attr("data-infotype");
			tagID = parseInt($(this).attr("data-tagID"));
			tagName = $(this).attr("data-tagName");
			if(infoType==="0"){
				obj["companyId"] = tagID;
				obj["infoType1"] = "";
				obj["infoType2"] = "";
				resDetail ('list', tagID, tagName);
			}else if(infoType==="1"){
				obj["companyId"] = "";
				obj["infoType1"] = tagID;
				obj["infoType2"] = "";
				resDetail ('list', tagID, tagName);
			}else if(infoType==="2"){
				obj["companyId"] = "";
				obj["infoType1"] = "";
				obj["infoType2"] = tagID;
				resDetail ('list', tagID, tagName);
			}
		});
	});
	
	// 拼接ul中的列表
	$(function () {
		$.ajax({
			url:'${ctx}/catalogset/res/companyList',
			type:'get',
            data: {"isAudit":2},
			success: function (data) {
				listData = data
				var resHtml = "";
				$.each(listData, function (index, item) {
					resHtml += '<li class="col-sm-4"><span class="name label label-success fir js-tag-item" data-infoType="0" data-tagID="'+item.id+'" data-tagName="'+item.name+'">' + item.name +'<i>' + item.count + '</i></span></li>';
				});
				$("#deper").append(resHtml);
				// 初始化Table
				resTable = new resTableInit(data[0].id);
				resTable.Init();
			}
		});
	});
	
	function resDetail (list, id, name) {
		$(resTableId).bootstrapTable('refresh', {url: '${ctx}/catalog/information/' + list});
		layeForm = layer.open({
			title: name,
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			// btn : [ '保存', '关闭' ],
			yes : function(index, layero) {
				//$(formId).submit();
			},
			end : function() {
				//$(formId).resetForm();
				//endMethod(formId, "close");
			},
			content : $(layerId)
		});
	};

	var resTableInit = function(id) {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$(resTableId).bootstrapTable({
				/* url : url + 'listByType', */
				method : 'get',
				toolbar : toolbar, // 工具按钮用哪个容器
				striped : true, // 是否显示行间隔色
				pagination : true, // 是否显示分页（*）
				queryParams : oTableInit.queryParams, // 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
				showColumns : true, // 是否显示所有的列
				showRefresh : true, // 是否显示刷新按钮
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
				obj : JSON.stringify(obj)
			};
			return temp;
		};
		return oTableInit;
	};


    //用于elementTable,耳机列表
    var TableInit2 = function(e) {
        var oTableInit = new Object();
        // 初始化Table
        oTableInit.Init = function() {
            e.bootstrapTable({
                method : 'get',
                striped : true, // 是否显示行间隔色
                pagination : true, // 是否显示分页（*）
                queryParams : oTableInit.queryParams, // 传递参数（*）
                sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
                pageNumber : 1, // 初始化加载第一页，默认第一页
                pageSize : 10, // 每页的记录行数（*）
                pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
                showColumns : true, // 是否显示所有的列
                showRefresh : true, // 是否显示刷新按钮
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
            obj={};
            $("#searchForElement").parents(".form-inline").find("input").each(function (index, item) {
                if($(this).attr("eName")!=undefined)
                    obj[$(this).attr("eName")] = $(this).val();
                else
                    obj["dataType"]=$('#dataTypeSelect').val();
            });
            var temp = {
                pageNum : params.offset / params.limit + 1,
                pageSize : params.limit,
                obj : JSON.stringify(obj)
            };
            return temp;
        };
        return oTableInit;
    };

	function resTableButton(index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="openDetailLayer(\''
				+ row.id
				+ '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		html += '</div>';
		return html;
	}
	
	// 详情弹框
	function openDetailLayer(id) {
		var row = $(resTableId).bootstrapTable('getRowByUniqueId', id);
		loadData(row);
		// input
		$(detailLayerId).find("input").attr("readonly", "readonly");
		// 判断select
		$(detailLayerId).find("select").prop("disabled", true);
		$(detailLayerId).find("select").trigger("chosen:updated");
		// checkbox
		$(detailLayerId).find('.i-checks').iCheck('disable');
		layeForm = layer.open({
			title: "信息资源详情",
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			content : $(detailLayerId)
		});
	}

    function dataTo(value){
        dataEles=value;
        var ck=",";
        for(var j=0;j<dataEles.length;j++){
            ck+=dataEles[j].id+",";
        }
        checkedIds =ck;
        $("#selectElement").addClass("hide");
        $(elementTableId).bootstrapTable('refreshOptions',{
            data:value,
            totalRows:value.length
        })
    }

	// 搜索
	function searchForRes () {
		var resHtml = "";
		var itemArr = [];
		var j = [];
		$("#tagList").children(".deper").each(function (index,item) {
			if ($(item).is(":visible")){
                $(item).find("li,ul").each(function (index,listItem) {
                    itemArr.push($(listItem).find(".js-tag-item").attr("data-tagname"));
                });
                for (var i in itemArr){
                    $(item).find("li,ul").eq(i).show();
                    if (itemArr[i].indexOf($("#sName").val()) < 0){
                        $(item).find("li,ul").eq(i).hide();
                    }
                }
				if (!$(item).find("li,ul").is(":visible")){
                    $(".search-text").remove();
				    $("<div></div>").addClass("search-text").html('<i class="fa fa-times-circle" aria-hidden="true"></i> 没有找到匹配的记录').appendTo($("#tagList"));
				}else{
				    $(".search-text").hide();
				}
			}
        });
	};

	// 标签数据获取事件
	function getTagData() {
		// 拼接ids参数(以逗号分隔)
		var clickIndex = "";
		$("#tagTop").find("span").each(function(i){
			if($(this).attr("data-tagid")&&$(this).next().length){
				clickIndex += $(this).attr("data-tagid")+",";
			}else if($(this).attr("data-tagid")&&!$(this).next().length){
				clickIndex += $(this).attr("data-tagid");
			}
		});
		// 设置ajax请求，获取后面tag内容
		$.ajax({
			url: "${ctx}/catalogset/res/queryListByPid",
			type:'get',
			data:{
				ids: clickIndex
			},
			dataType: 'json',
			success: function (data) {
				listData = data;
				$.each(listData, function(index, tagList){
					var resHtml = "";
					$.each(tagList, function(index, item){
						var childrenListHtml = "";
//						$.each(item.children, function(index, item){
//							childrenListHtml += '<li class="col-sm-4"><span class="name label label-success fir js-tag-item" data-infoType="2" data-tagID="'+item.id+'" data-tagName="'+item.name+'">' + item.name + '</span></li>';
//						});
						if (item.count>0) {
                            resHtml += '<ul class="col-sm-4"><blockquote class="col-sm-12"><span class="name label label-success fir js-tag-item" data-infoType="2" data-tagID="' + item.id + '" data-tagName="' + item.name + '">' + item.name + '<i>' + item.count + '</i></span></blockquote>' + childrenListHtml + '</ul>';
                        }else{
                            resHtml += '<ul class="col-sm-4"><blockquote class="col-sm-12"><span class="name label label-success fir js-tag-item" data-infoType="2" data-tagID="' + item.id + '" data-tagName="' + item.name + '">' + item.name +'</span></blockquote>' + childrenListHtml + '</ul>';
						}
					});
					$("#deper"+tagList[0].parentId).append(resHtml);
//                    $("#deper"+tagList[0].parentId).find(".js-tag-item").attr("data-infoType", parseInt(index)+1);
				});
			}
		});

        // 表单里面的表格
        mTable = new TableInit2($(elementTableId));
        mTable.Init();
	}
	// 标签点击样式改变事件
	function tagChange(){
		$("#tagTop").on("click","span",function(){
			var $this = $(this);
			var $thisDeper = $("#deper"+$this.attr("data-tagid"));
			$("#sName").val("");
			$(".search-text").remove();
			$(".deper").hide(0,function(){
				$thisDeper.show();
                $(".deper").find("li,ul").show();
			});
			$(".toolbar .toolbar-tag-top>span").removeClass("active");
			$this.addClass("active");
		});
	}
	
	function elementTableButton(index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="elementDatailRow(\''
				+ row.id
				+ '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
		html += '</div>';
		return html;
	}
	
	//第三个弹出框（弹出框设置）
	function mOpenDetail(l,f) {
		layeForm = layer.open({
			title: detailTitle,
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			content : l,
			cancel : function () {
				// 当弹框被关闭的时候将所有加上的属性移除掉
				f.find("input").each(function () {
					$(this).removeAttr("disabled");
				});
				f.find("select").prop("disabled", false);
				f.find("select").trigger("chosen:updated");
				f.find('.i-checks').iCheck('enable');
			}
		});
	}
	// 第三个弹框
	function elementDatailRow(id) {
		var row;
		//if(flag==false){
			row = $(elementTableId).bootstrapTable('getRowByUniqueId', id);
		//}else{
			//row = $(elementTableId2).bootstrapTable('getRowByUniqueId', id);
		//}
		mOpenDetail($(elementLayerId),$(elementFormId));
		loadData(row);
		// 然后将所有表单中的选项做一个禁选中操作
		$(elementFormId).find("input").each(function () {
			$(this).attr("disabled","disabled");
		});
		// 判断select
		$(elementFormId).find("select").prop("disabled", true);
		$(elementFormId).find("select").trigger("chosen:updated");
		// checkbox
		$(elementFormId).find('.i-checks').iCheck('disable');	
	}
	
	// 动态的将数据赋值进去
	function loadLinkageSel (data) {
		linkRelInfo.changeValues(data, true);
	};
	
</script>

<script src="${ctxStatic}/js/common/common.js"></script>

</html>
