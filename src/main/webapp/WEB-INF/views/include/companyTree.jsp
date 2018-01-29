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
<div id="" class="company_tree vali-ignore" style="display:none; position: absolute;">
	<div class="input-group tree-input">
		<input id="treeSearchInput" type="text" class="form-control" placeholder="请输入名称">
	</div><!-- /input-group -->
	<ul id="menuTree" class="ztree company_tree_ul" style="position: relative;margin-top:0; width:100%; height: 300px;"></ul>
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
	
	var companyTree;
	
 	function childQuery (data) {
 		$.fn.zTree.init($(".company_tree_ul"), menuSetting, data);
		companyTree = $.fn.zTree.getZTreeObj("menuTree");
		companyTree.expandAll(true);
 	};
 	
 	$(function () {
 		// 取到数据，初始化树插件
 		$.ajax({
 			url: "${ctx}/settings/company/list",
 			data: {
 				types: "1,2"
 			},
 			success: function(data) {
	    		ztreeData = data;
	            $.each(data, function (index, item) {
	            	item.pId = item.parentId
	            })
	            childQuery(data)
		 		// 给所有的选项加上点击事件（由于原有的事件并不能行）
				$('.company_tree_ul .chk').click(function () {
					onCheckOut($(this))
				});
                $('.company_tree_ul .chk').siblings('a').click(function () {
                    onCheckOut($(this).siblings('.company_tree_ul .chk'))
                });
 			}
 		})
 	})

	function onClick(e, treeId, treeNode) {
		companyTree.checkNode(treeNode, !treeNode.checked, null, true);
		return false;
	}

	function onCheck(e, treeId, treeNode) {
		// console.log("e: ", e)
		nodes = companyTree.getCheckedNodes(true)
		v = "";
		id = "";
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
			id = nodes[i].id;
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		setTimeout(function () {
			var $ulDiv = $('.company_tree_ul .chk[state=true]').closest('.company_tree');
			// var $ulDiv = $(e.currentTarget).closest('.company_tree');
			$ulDiv.siblings(".citySel").val(v);
			$ulDiv.siblings(".citySelId").val(id);
			$ulDiv.siblings(".citySel").blur();
			// console.log("v: ", v);
			hideMenu();
		}, 0)
	}

	// 选中dom节点
	function onCheckOut (that) {
		$('.company_tree_ul .chk').attr('state', false)
		that.attr('state', true)
	}

	$(".citySel").click(function () {
		console.log("this: ", $(this))
		console.log("部门")
		var cityOffset = $(".citySel").offset();
		$(this).siblings(".company_tree").css({zIndex: 10000, width: '100%'}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
		// 回显
		var val = $(this).siblings("input[name=companyId]").val();
		if (val) {
			companyTree.checkNode(companyTree.getNodeByParam("id", val, null), true, true);
		}
	})
	function hideMenu() {
		$(".company_tree").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
	function onBodyDown(event) {
		console.log("event: ", event)
		if (!(event.target.id == "menuBtn" || event.target.className == "citySel" || event.target.className == "company_tree" || $(event.target).parents(".company_tree").length>0)) {
			hideMenu();
		}
	}

	$(function () {
		$(document).on('input', '#treeSearchInput', function () {
//			var inputText = $('#treeSearchInput').val();
			var inputText = $(this).val();
            menuSearch(inputText);
        });
    });
	// 搜索功能
	function menuSearch(searchText) {
		var treeObj = $.fn.zTree.getZTreeObj("menuTree");
		var allNodes = treeObj.getNodesByParamFuzzy("name", "", null);
		$.each(allNodes, function (index, allNode) {
			$('#'+allNode.tId).children('a').removeClass('high-light-red');
		});
		if (searchText !== ''){
			var nodes = treeObj.getNodesByParamFuzzy("name", searchText, null);
			$.each(nodes, function (index, node) {
				$('#'+node.tId).children('a').addClass('high-light-red');
			});
			var scrollTop = $('.company_tree').scrollTop();
			console.log(scrollTop);
			if (nodes[0] == undefined) {
				return
			}
			var offsetTop = $('#'+nodes[0].tId).children('a').position().top;
            console.log(offsetTop);
			$('.company_tree').stop().animate({scrollTop:offsetTop-scrollTop},500);
		}
	}
	
</script>

