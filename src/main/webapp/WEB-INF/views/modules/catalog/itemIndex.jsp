<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<style>
	.search-option {
		margin-right: 28px;
	}
</style>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">数据元</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input sName="name" type="text" placeholder="输入数据元名称"
								class="form-control search-option col-sm-8">
							<input sName="code" type="text" placeholder="输入数据元编码"
								class="form-control search-option col-sm-8">
							<input sName="type" type="text" placeholder="输入数据元中文类型"
								class="form-control search-option col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#elementTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<!-- <a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('eform', 'layer_form');"><i class="fa fa-plus-square-o"></i> 新增</a> -->
								<button class="btn btn-yellow" type="button" onclick="deleteAll();"><i class='fa fa-trash-o'></i> 批量删除</button>
							</div>
						</div>
					</div>
				</div>
				<table id="elementTable">
					<thead>
						<tr>
							<th data-checkbox="true"></th>
							<th data-field="code">数据元编码</th>
							<th data-field="name">数据元名称</th>
							<th data-field="type">数据元类别</th>
							<th data-field="Score" data-formatter="initDataTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<!-- 新增修改 -->
	<div id="layer_form" style="display:none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<div class="form-group hide">
				<label class="col-sm-3 control-label">名称：</label>
				<div class="col-sm-7">
					<input type="text" name="id" class="hide">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="">数据元编码：</label>
				<div class="col-sm-7">
					<input type="text" name="code" maxlength="50" class="form-control hasNoSpace" placeholder="" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">数据元名称：</label>
				<div class="col-sm-7">
					<input type="text" name="name" maxlength="50" class="form-control hasNoSpace" placeholder="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源" required>
				</div>
			</div>
			<div class="form-group">
			    <label class="col-sm-3 control-label">数据元类别：</label>
			    <div class="col-sm-7">
			        <select class="select-chosen" name="type" required>
			            <option value=""></option>
			            <c:forEach var="obj" items="${fns:getDictList('data_type')}">
			                <option value="${obj.value}">${obj.label}</option>
			            </c:forEach>
			        </select>
			    </div>
			</div>
			<div class="form-group">
			    <label class="col-sm-3 control-label">数据元类型：</label>
			    <div class="col-sm-7">
			        <select class="select-chosen" name="typen" required>
			            <option value=""></option>
			            <c:forEach var="obj" items="${fns:getDictList('data_type_en')}">
			                <option value="${obj.value}">${obj.label}</option>
			            </c:forEach>
			        </select>
			    </div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="标明该数据元在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该数据元对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该数据元内容字数的上限，并折算成字节数，该字节数即为数据长度">数据元长度：</label> 
				<div class="col-sm-7">
					<input type="posNum" name="len" class="form-control" placeholder="标明该数据元在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">对应代码集：</label>
				<div class="col-sm-7">
					<select name="zhiyu" class="select-chosen-zhiyu" >
						<option value=""></option>
						<c:forEach var="codeId" items="${fns:getList('zhiyu')}">
							<option value="${codeSet.id}">${codeSet.pname}</option>
						</c:forEach>
					</select>
        			<!-- <span class="col-sm-12 dt-span zhiyuziji"></span> -->
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="">值域：</label>
				<div class="col-sm-7">
					<input type="text" name="range" maxlength="50" class="form-control hasNoSpace" placeholder="" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="">说明：</label>
				<div class="col-sm-7">
					<input type="text" name="remarks" maxlength="50" class="form-control hasNoSpace" placeholder="" required>
				</div>
			</div>
		</form>
	</div>

	<!-- 详情 -->
	<div id="detail_layer" style="display:none" class="ibox-content">
		<form id="detail_form" class="form-horizontal">
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">中文名称：</label>
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="nameCn"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的英文标题">英文名称：</label>
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="nameEn"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的数据元标记">数据元标记：</label>
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="sign"></span>
				</div>
			</div>
			<div class="form-group">
			    <label class="col-sm-3 control-label">数据类型：</label>
			    <div class="col-sm-7">
			        <select class="hide" name="dataType" required>
			            <option value=""></option>
			            <c:forEach var="obj" items="${fns:getDictList('data_type')}">
			                <option value="${obj.value}">${obj.label}</option>
			            </c:forEach>
			        </select>
        			<span class="col-sm-12 dt-span" name=""></span>
			    </div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="标明该数据元在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该数据元对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该数据元内容字数的上限，并折算成字节数，该字节数即为数据长度">数据长度：</label> 
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="len"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">值域：</label>
				<div class="col-sm-7">
					<select name="zhiyu" class="hide" >
					<option value=""></option>
						<c:forEach var="codeSet" items="${fns:getList('zhiyu')}">
							<option value="${codeSet.id}">${codeSet.pname}</option>
						</c:forEach>
					</select>
        			<span class="col-sm-12 dt-span" name=""></span>
				</div>

			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">值域详细：</label>
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="zhiyuZiji"></span>
				</div>

			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="对该数据元的定义">定义：</label>
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="definit"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="数据元引用的标准来源">引用标准：</label>
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="standard"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="对该数据元的备注">备注：</label>
				<div class="col-sm-7">
        			<span class="col-sm-12 dt-span" name="remarks"></span>
				</div>
			</div>
		</form>
	</div>

	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
	var excelName = "数据元";
	var url = '${ctx}/catalog/item/';

	$(function () {
		oTable = new TableInit('elementTable', {url: url+'list'});
		oTable.Init();
		initFormValide('eform', 'save', 'elementTable');
		// select-chosen-zhiyu
		$('.select-chosen-zhiyu').chosen({
	        width : "100%"
	    }).change(function (e) {
	    	$.ajax({
	    		url: url + 'getZiJi',
	    		type: 'post',
	    		data: {id: $(this).find('option:selected').val()},
	    		success: function (res) {
	    			console.log("res: ", res)
	    			$('.zhiyuziji').html(res);
	    		}
	    	})
	        $(e.currentTarget).blur();
	    });
	})

	function initDataTableButton (value, row, element) {
        var html = '';
        html += '<div class="btn-group">';
        html += '<button type="button" class="btn btn-white" onclick="datailDataElement('
                + row.id + ')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
        html += '<button type="button" class="btn btn-white" id="edit"  onclick="editDataElementRow('
                + row.id + ')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
        html += '<button type="button" class="btn btn-white" onclick="deleteRow('
                + row.id + ')"><i class="fa fa-trash"></i>&nbsp;删除</button>';
        html += '</div>';
        return html;
    }

    function editDataElementRow (id) {
    	editRow(id, 'eform', 'layer_form', 'elementTable')
    	$('.select-chosen-zhiyu').change()
    }

    function datailDataElement (id) {
    	var row = $('#elementTable').bootstrapTable('getRowByUniqueId', id);
    	row.zhiyuZiji == null ? row.zhiyuZiji = "" : row.zhiyuZiji;
    	loadDetail('detail_form', row)
    	layeForm = layer.open({
			title: '数据元详情',
			type : 1,
			area : [ '100%', '100%' ],
			scrollbar : false,
			zIndex : 100,
			content : $('#detail_layer'),
			cancel : function () {
				endMethod('detail_form', "close");
			}
		});
    }

    // 清空所有按钮事件
    function deleteAllRows() {
        layer.confirm('确定要删除所有数据？（选择确定将删除所有数据，请慎重）', function(index){
            $.ajax({
                url: "${ctx}/catalog/element/model/deleteAll",
                type: 'get',
                success: function (data) {
                    layer.msg('删除成功！');
                    $('#elementTable').bootstrapTable('refresh');
                }
            });
            layer.close(index);
            //向服务端发送删除指令
        });

    }

    function resetPage (formId) {
        $('.zhiyuziji').html('')
    }

	</script>
	
	<script src="${ctxStatic}/js/common/common-model.js"></script>
</body>
</html>

