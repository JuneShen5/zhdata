<%@ page contentType="text/html;charset=UTF-8"%>

<%--<%@ include file="/WEB-INF/views/include/head.jsp"%>--%>
<link rel="stylesheet" href="${ctxStatic}/css/plugins/ztree/ztree.css" />

<style>
.company_tree {
   background-color: #fff;
    border: 1px solid #eee;
    max-height: 300px;
    overflow: auto;
}
</style>

<!-- 添加子级菜单的上级菜单 -->
<div id="" class="company_tree" style="display:none; position: absolute;">
	<ul id="menuTree" class="ztree" style="margin-top:0; width:100%; height: 300px;"></ul>
</div>

<!-- [if !IE]> -->
<script src="${ctxStatic}/js/jquery.min.js?v=2.1.4" type="text/javascript"></script>
<!-- <![endif] -->
<!--[if lte IE 8] -->
<script src="${ctxStatic}/js/jquery-1.9.1.js" type="text/javascript"></script>
<!-- [endif] -->
<script	src="${ctxStatic}/js/plugins/validate/jquery.validate.js"></script>
<script	src="${ctxStatic}/js/plugins/validate/messages_zh.min.js"></script>
<script src="${ctxStatic}/js/jquery/jquery.form.js"></script>
<script src="${ctxStatic}/js/plugins/ztree/jquery.ztree.core.js"></script>
<script src="${ctxStatic}/js/plugins/ztree/jquery.ztree.excheck.js"></script>
<!-- xxxxx -->
<script>
	
//添加子菜单中的上级菜单单选树插件
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
 	
 	$(function () {
 		$.ajax({url: "/zhdata/settings/company/list", success: function(data) {
    		ztreeData = data;
            $.each(data, function (index, item) {
            	item.pId = item.parentId
            })
            childQuery(data)
        }})
 	})

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
		console.log("部门")
		var cityOffset = $("#citySel").offset();
		$(this).siblings(".company_tree").css({zIndex: 10000, width: '100%'}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	})
	function hideMenu() {
		$(".company_tree").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		console.log("event: ", event)
		if (!(event.target.id == "menuBtn" || event.target.id == "citySel" || event.target.className == "company_tree" || $(event.target).parents(".company_tree").length>0)) {
			hideMenu();
		}
	}
	
</script>

