<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<link rel="stylesheet" href="${ctxStatic}/css/plugins/ztree/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" href="${ctxStatic}/css/plugins/ztree/ztree.css" />
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<title>贵州省数据资产登记系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0" />
<style>
#tableMain .ztree div.diy:nth-of-type(1) {
    width: 35%;
}

#tableMain .ztree div.diy:nth-of-type(2) {
    width: 30%;
}

#tableMain .ztree div.diy:last-of-type {
    width: 35%;
}
</style>
</head>

<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!--<div class="ibox-title">领域分类</div>-->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline" style="margin: 10px auto">
						<!-- <div class="form-group">
							<input id="sName" sName="name" type="text" placeholder="输入资源分类名称"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#roleTable').bootstrapTable('refresh');"
									class="btn btn-primary">搜索</button>
							</div>
						</div> -->
						<div class="form-group" style="margin-left: 15px;">
							<div class="text-center">
								<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('领域新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
							</div>
						</div>
					</div>
				</div>
			    <div id="tableMain">
			        <ul id="dataTree" class="ztree">
			
			        </ul>
			    </div>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display: none;" class="ibox-content">
		<form id="eform" class="form-horizontal" type="post">
			<input type="text" id="id" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label">上级领域：</label>
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
				<label class="col-sm-3 control-label">代码：</label>
				<div class="col-sm-7">
					<input type="text" name="code" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">排序：</label>
				<div class="col-sm-7">
					<input type="number" name="sort" class="form-control" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">备注：</label>
				<div class="col-sm-7">
					<input type="text" name="remarks" class="form-control">
				</div>
			</div>
		</form>
		<!-- 添加子级领域的上级领域 -->
		<div id="menuContent" class="menuContent" style="display:none; position: absolute;">
			<ul id="menuTree" class="ztree" style="margin-top:0; width:100%; height: 300px;"></ul>
		</div>
		
		
	</div>
	
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script src="${ctxStatic}/js/plugins/ztree/jquery.ztree.all.min.js"></script>

<script>
	var formId = "#eform";
	var tableId = "";
	var url = '${ctx}/catalogset/infoSort/';
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
    /**
     * 查询数据
     */
    function query(data) {
        // 初始化列表
        zTreeNodes = data;
        // 初始化树
        $.fn.zTree.init($("#dataTree"), zTreeSetting, zTreeNodes);
        // 添加表头
        var li_head = ' <li class="head"><a>'
        li_head += '<div class="diy">名称</div>'
        console.log("treeNodeHtml: ", treeNodeHtml)
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
		// zTree.expandAll(true);
    }
    /**
     * 根据展示功能按钮
     * @param treeNode
     * @returns {string}
     */
    function formatHandle(treeNode) {
    	console.log("treeNode: ", treeNode)
        var htmlStr = '';
        htmlStr += '<div class="btn-group"><button class="btn btn-white" onclick="ztreeAddMenu(' + treeNode.id + ',\'' + treeNode.name + '\')"><i class="fa fa-plus"></i>添加子级</button><button class="btn btn-white" onclick="ztreeEditMenu(' + treeNode.id + ')"><i class="fa fa-pencil"></i>修改</button><button class="btn btn-white" onclick="ztreeDeleteMenu(' + treeNode.id + ')"><i class="fa fa-trash"></i>删除</button></div>'
        return htmlStr;
    }
    
 	// 传入数组拼接表单
    var treeNodeHtml = [{chName: "代码", name: "code"}]
    var ztreeData;
    // 获取数据
    function startZtree () {
    	$.ajax({url: "/zhdata/catalogset/infoSort/list", success: function(data) {
    		ztreeData = data;
            $.each(data, function (index, item) {
            	item.pId = item.parentId
            })
            query(data);
            childQuery(data)
        }})
    }
    startZtree()
 	
    // 新增
    function ztreeAddNew () {
    	openLayer("新增");
    }
 	// 添加子领域
 	function ztreeAddMenu (id, name) {
    	openLayer("添加子级领域");
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
    	openLayer("领域修改");
    	loadData(row);
    	// 通过验证
		$(formId).find("input").blur();
		$(formId).find(".select-chosen").blur();
 	}
 	// 删除
 	function ztreeDeleteMenu(ids){
 		layeConfirm = layer.confirm('您确定要删除么？', {
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
 	
 	// 添加子领域中的上级领域单选树插件
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
	 		// 首先处理一下数据，将所有的关键字去掉
	 		$.each(data, function (index, item) {
	 			delete item.icon;
	 		})
	 		$.fn.zTree.init($("#menuTree"), menuSetting, data);
			menuTree = $.fn.zTree.getZTreeObj("menuTree");
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
			var cityObj = $("#citySel");
			cityObj.attr("value", v);
			$("#citySelId").attr("value", id);
			hideMenu();
		}

		// 点击input框弹出树结构的下拉框
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
