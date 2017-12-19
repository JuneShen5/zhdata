<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<link rel="stylesheet" href="${ctxStatic}/css/plugins/ztree/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" href="${ctxStatic}/css/plugins/ztree/ztree.css" />
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<title>深圳气象局数据资产登记系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
<style>
#tableMain .ztree div.diy:nth-of-type(1) {
    width: 25%;
}

#tableMain .ztree div.diy:nth-of-type(2) {
    width: 15%;
}

#tableMain .ztree div.diy:nth-of-type(3) {
    width: 10%;
}

#tableMain .ztree div.diy:nth-of-type(4) {
    width: 15%;
}

#tableMain .ztree div.diy:last-of-type {
    width: 35%;
}
#tableMain .ztree div.diy{
	height: 44px;
	line-height: 44px;
}
.search-container>.form-group{
	padding: 0;
	margin-bottom: 10px;
}
.high-light-red{
	background-color: #f2dede!important;
}
</style>
</head>

<body style="background-color: #fff;padding: 20px;">
<!-- <div class="ibox-title">菜单管理</div> -->
<div class="search-container form-inline clearfix">
	<div class="form-group">
		<input id="sName" sName="nameCN" type="text" placeholder="输入名称"
			   class="form-control col-sm-8">
	</div>
	<div class="form-group">
		<div class="text-center">
			<button type="button" id="searchFor"
					onclick="menuSearch($('#sName').val())"
					class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
		</div>
	</div>
	<div class="form-group">
		<div class="text-center">
			<button id="examineButton" data-toggle="modal" class="btn btn-yellow"
					onclick="cleanSearch()"><i class="fa fa-trash"></i> 清空搜索条件</button>
		</div>
	</div>
	<div class="form-group">
		<div class="text-center">
			<button id="examineButton" data-toggle="modal" class="btn btn-green"
					onclick="menuAdd()"><i class="fa fa-plus-square-o"></i> 新增</button>
		</div>
	</div>
</div>
<div class="layer">
    <div id="tableMain">
        <ul id="dataTree" class="ztree">

        </ul>
    </div>
</div>

<div id="layer_form" style="display: none;" class="ibox-content">
		<form id="eform" class="form-horizontal" type="post">
			<input type="text" id="id" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label">上级菜单：</label>
				<div class="col-sm-7">
					<input id="citySelId" name="parentId" class="form-control hide" type="text">
					<input id="citySel" name="parentName" class="form-control" type="text" ReadOnly />
				</div>
			</div>
			<div class="form-group tooltip-demo">
				<label class="col-sm-3 control-label">名称：</label>
				<div class="col-sm-7">
					<input type="text" name="name" class="form-control" rangelength="[1, 10]" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">链接：</label>
				<div class="col-sm-7">
					<input type="text" name="href" class="form-control">
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">目标：</label>
				<div class="col-sm-7">
					<input type="text" name="target" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">图标：</label>
				<div class="col-sm-7">
					<input type="text" name="image" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">排序：</label>
				<div class="col-sm-7">
					<input type="number" name="sort" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">可见：</label>
				<div class="col-sm-7">
					<select name="isShow" class="select-chosen" required>
						<option value=""></option>
					<c:forEach var="dict" items="${fns:getDictList('show_hide')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">权限标识：</label>
				<div class="col-sm-7">
					<input type="text" name="permission" class="form-control">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">备注：</label>
				<div class="col-sm-7">
					<input type="text" name="remarks" class="form-control">
				</div>
			</div>
		</form>
		<!-- 添加子级菜单的上级菜单 -->
		<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="menuTree" class="ztree" style="margin-top:0; width:100%; height: 300px;"></ul>
		</div>
	</div>
	
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script src="${ctxStatic}/js/plugins/ztree/jquery.ztree.all.min.js"></script>

<script>
	var formId = "#eform";
	var tableId = "";
	var url = '${ctx}/settings/menu/';
	var layerId = '#layer_form';
    var zTreeNodes;
    var zTree;
    var zTreeSetting = {
        view: {
            showLine: false,
            showIcon: false,
            addDiyDom: addDiyDom
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        key: {
            name: "ename"
        }
    };
    /**
     * 自定义DOM节点
     */
     
    function addDiyDom(treeId, treeNode) {
        var spaceWidth = 15;
        var liObj = $("#" + treeNode.tId);
        var aObj = $("#" + treeNode.tId + "_a");
        var switchObj = $("#" + treeNode.tId + "_switch");
        var icoObj = $("#" + treeNode.tId + "_ico");
        var spanObj = $("#" + treeNode.tId + "_span");
        aObj.attr('title', '');
        aObj.append('<div class="diy swich"></div>');
        var div = $(liObj).find('div').eq(0);
        switchObj.remove();
        spanObj.remove();
        icoObj.remove();
        div.append(switchObj);
        div.append(spanObj);
        var spaceStr = "<span style='height:1px;display: inline-block;width:" + (spaceWidth * treeNode.level) + "px'></span>";
        switchObj.before(spaceStr);
        var editStr = '';
        for (var i in treeNodeHtml) {
        	editStr += '<div class="diy">' + (treeNode[treeNodeHtml[i].name] == null ? '&nbsp;' : treeNode[treeNodeHtml[i].name]) + '</div>'
        }
        editStr += '<div class="diy">' + formatHandle(treeNode) + '</div>';
        aObj.append(editStr);
    }
    // 搜索功能
    function menuSearch(searchText) {
        var treeObj = $.fn.zTree.getZTreeObj("dataTree");
        var allNodes = treeObj.getNodesByParamFuzzy("name", "", null);
        $.each(allNodes, function (index, allNode) {
            $('#'+allNode.tId).children('a').removeClass('high-light-red');
        });
        if (searchText !== ''){
			var nodes = treeObj.getNodesByParamFuzzy("name", searchText, null);
			$.each(nodes, function (index, node) {
				$('#'+node.tId).children('a').addClass('high-light-red');
			});
			var scrollTop = $(window).scrollTop();
			if (nodes[0] == undefined) {
				return
			}
			var offsetTop = $('#'+nodes[0].tId).children('a').offset().top;
			$('body,html').animate({scrollTop:offsetTop-scrollTop-50},500);
        }
    }

    // 清空搜索
    function cleanSearch () {
    	$('#sName').val('');
    	$('.high-light-red').removeClass('high-light-red');
    }

    // 新增功能
	function menuAdd() {
        ztreeAddMenu(1,'功能菜单');
    }
    /**
     * 查询数据
     */
    function query(data) {
        //初始化列表
        zTreeNodes = data;
        //初始化树
        $.fn.zTree.init($("#dataTree"), zTreeSetting, zTreeNodes);
        //添加表头
        var li_head = ' <li class="head"><a>'
        li_head += '<div class="diy">名称</div>'
        for (var i in treeNodeHtml) {
        	li_head +='<div class="diy">' + treeNodeHtml[i].chName + '</div>'
        }
        li_head += '<div class="diy">操作</div>'
        li_head += '</a></li>';
        var rows = $("#dataTree").find('li');
        if (rows.length > 0) {
            rows.eq(0).before(li_head)
        } else {
            $("#dataTree").append(li_head);
            $("#dataTree").append('<li ><div ;line-height: 30px;" >无符合条件数据</div></li>')
        }
        zTree = $.fn.zTree.getZTreeObj("dataTree");
		zTree.expandAll(true);
    }
    /**
     * 根据展示功能按钮
     * @param treeNode
     * @returns {string}
     */
    function formatHandle(treeNode) {
        var htmlStr = '';
        htmlStr += '<div class="btn-group"><button class="btn btn-white" onclick="ztreeAddMenu(' + treeNode.id + ',\'' + treeNode.name + '\')"><i class="fa fa-plus"></i>添加子级菜单</button><button class="btn btn-white" onclick="ztreeEditMenu(' + treeNode.id + ')"><i class="fa fa-pencil"></i>修改</button><button class="btn btn-white" onclick="ztreeDeleteMenu(' + treeNode.id + ')"><i class="fa fa-trash"></i>删除</button></div>'
        return htmlStr;
    }
    
 	// 传入数组拼接表单
    var treeNodeHtml = [{chName: "链接", name: "href"}, {chName: "排序", name: "sort"}, {chName: "创建时间", name: "createDate"}]
    var ztreeData;
    // 获取数据
    function startZtree () {
    	$.ajax({url: "/zhdata/settings/menu/list", success: function(data) {
    		ztreeData = data;
            $.each(data, function (index, item) {
            	item.pId = item.parentId
            })
            query(data);
            childQuery(data)
        }})
    }
    startZtree()
 	
 	// 添加子菜单
 	function ztreeAddMenu (id, name) {
    	openLayer("添加子级菜单");
		$("#citySelId").val(id);
		if (name == "null") {
			return
		}
		$("#citySel").val(name);
 	}
 	// 修改
 	function ztreeEditMenu (id) {
 		var row;
 		for (var i in ztreeData) {
 			if (id == ztreeData[i].id) {
 				row = ztreeData[i]
 			}
 		}
    	openLayer("菜单修改");
    	loadData(row);
    	// 通过验证
		$(formId).validate().form();
 	}
 	// 删除
 	function ztreeDeleteMenu(ids){
 		layeConfirm = layer.confirm('此菜单下可能存在子菜单，您确定要删除么？', {
 			btn : [ '确定', '取消' ]
 		}, function() {
 			$.post(url + 'delete', {
 				ids : ids
 			}, function(data) {
 				layer.msg(data);
				startZtree();
 			}, 'json');
 		});
 	}
 	
 	function resetPage (res) {
 		if (res) {
 			console.log("close")
 			return
 		}
 		startZtree()
 	}
 	
 	// 添加子菜单中的上级菜单单选树插件
 	var menuSetting = {
			check: {
				enable: true,
				chkStyle: "radio",
				radioType: "all"
			},
			view: {
				dblClickExpand: false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				onClick: onClick,
				onCheck: onCheck
			}
		};
 	
 		var menuTree;
	 	function childQuery (data) {
	 		$.fn.zTree.init($("#menuTree"), menuSetting, data);
			menuTree = $.fn.zTree.getZTreeObj("menuTree");
			menuTree.expandAll(true);
	 	};

		function onClick(e, treeId, treeNode) {
			menuTree.checkNode(treeNode, !treeNode.checked, null, true);
			return false;
		}

		function onCheck(e, treeId, treeNode) {
			nodes = menuTree.getCheckedNodes(true),
			v = "";
			id = "";
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				id = nodes[i].id;
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			$("#citySel").val(v);
			$("#citySelId").val(id);
			console.log("v: ", v);
			hideMenu();
		}

		$("#citySel").click(function () {
			var cityOffset = $("#citySel").offset();
			// $("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + "px"}).slideDown("fast");
			$("#menuContent").css({left:cityOffset.left + "px", top: "50px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		})
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
 	
</script>
<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>
