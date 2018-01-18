<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html >
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
</head>
<body class="white-bg skin-7">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="ibox float-e-margins">
			<!-- <div class="ibox-title">信息项</div> -->
			<div class="ibox-content">
				<div id="toolbar">
					<div class="form-inline">
						<div class="form-group">
							<input id="sName" sName="name" type="text" placeholder="输入部门名称"
								class="form-control col-sm-8">
							<div class="input-group-btn col-sm-4">
								<button type="button" id="searchFor"
									onclick=" $('#comInfoTable').bootstrapTable('refresh');"
									class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
									<!--<button type="button" id="searchMoreFor"
									onclick="$('.search-list').slideToggle();"
									class="btn btn-primary btn-drop"><span class="caret"></span></button>-->
							</div>
						</div>
						<div class="form-group">
							<div class="text-center">
								<!--<a data-toggle="modal" class="btn btn-green"
									onclick="openLayer('信息项新增');"><i class="fa fa-plus-square-o"></i> 新增</a>
								<button class="btn btn-cyan" type="button" onclick="exportData();"><i class='fa fa-sign-out'></i> 导出数据</button>
								<button class="btn btn-purple" type="button" onclick="importData(3);"><i class='fa fa-sign-in'></i> Excel导入</button>
								<button class="btn btn-yellow" type="button" onclick="deleteAll();"><i class='fa fa-trash-o'></i> 批量删除</button>
								<button class="btn btn-red" type="button" onclick="deleteAllRows();"><i class='fa fa-trash-o'></i> 清空所有</button>-->
							</div>
						</div>
					</div>
					<!--<div class="search-list" style="display: none;">
						<div class="check-search" style="display: inline-block;margin-right: 20px;">
							<label class="">来源部门：</label>
							<div class="check-search-item" style="width:200px;display: inline-block;">
								<select type="text" sName="companyId" class="form-control search-chosen select-chosen">
                        			<option value="">全部</option>
									<c:forEach var="company" items="${fns:getList('company')}">
										<option value="${company.id}">${company.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>-->
					
					
				</div>
				<table id="comInfoTable">
					<thead class="ele-hide">
						<tr>
							<!--<th data-checkbox="true"></th>-->
							<th data-field="name">部门名称</th>
							<th data-field="total2018">2018年度总指标金额(万元)</th>
							<!--<th data-field="dataTypeName">数据类型</th>
							<th data-field="len">数据长度</th>-->
							<!-- <th data-field="companyName">来源部门</th> -->
							<th data-width="230px" data-field="Score" data-formatter="comInfoTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>

	<div id="layer_form" style="display:none" class="ibox-content">
		<form id="eform" class="form-horizontal">
			<input type="text" id="id" name="id" class="hide">
			<div class="form-group tooltip-demo">
				<label class="col-sm-3 control-label">部门名称：</label>
				<div class="col-sm-7">
					<input type="text" name="name" hasNoSpace="true" class="form-control" rangelength="[1, 30]" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">部门信息化分管领导姓名：</label>
				<div class="col-sm-7">
					<input type="text" name="ldxm" hasNoSpace="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">部门信息化分管领导联系方式：</label>
				<div class="col-sm-7">
					<input type="text" name="ldlxfs" isMobile="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">部门信息化业务负责人姓名：</label>
				<div class="col-sm-7">
					<input type="text" name="fzrxm" hasNoSpace="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">部门信息化业务负责人联系方式：</label>
				<div class="col-sm-7">
					<input type="text" name="fzrlxfs" isMobile="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-3 control-label">
					<label class="control-label">承担信息化工作的内设机构：</label>
				</div>
				<div class="col-sm-7 column-content">
					<select name="nsjg1" class="form-control js-hasChild" required>
						<option value="">== 请选择 ==</option>
						<c:forEach var="dict" items="${fns:getDictList('inner_organ')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group ele-hide" data-parent="nsjg1">
				<div class="col-sm-3 column-title">
					<label class="control-label"></label>
				</div>
				<div class="col-sm-7 column-content">
					<select name="nsjg2" class="form-control" required>
						<option value="">== 请选择 ==</option>
						<c:forEach var="dict" items="${fns:getDictList('public_institution')}">
							<option value="${dict.value}">${dict.label}</option>
						</c:forEach>
					</select>
				</div>
			</div>



			<div class="form-group">
				<label class="col-sm-3 control-label">信息化机构人员行政编制人数：</label>
				<div class="col-sm-7">
					<input type="text" name="rybzqk1" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化机构人员政法专项编制人数：</label>
				<div class="col-sm-7">
					<input type="text" name="rybzqk2" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化机构人员事业编制人数：</label>
				<div class="col-sm-7">
					<input type="text" name="rybzqk3" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化机构人员其他编制人数：</label>
				<div class="col-sm-7">
					<input type="text" name="rybzqk4" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>

			<div class="form-group">
				<label class="col-sm-3 control-label">信息化人员技术无职称人数：</label>
				<div class="col-sm-7">
					<input type="text" name="ryjszc1" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化人员技术计算机初级人数：</label>
				<div class="col-sm-7">
					<input type="text" name="ryjszc2" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化人员技术计算机中级人数：</label>
				<div class="col-sm-7">
					<input type="text" name="ryjszc3" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化人员技术计算机高级(副教授)人数：</label>
				<div class="col-sm-7">
					<input type="text" name="ryjszc4" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化人员技术计算机正高级人数：</label>
				<div class="col-sm-7">
					<input type="text" name="ryjszc5" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">信息化人员技术其他人数：</label>
				<div class="col-sm-7">
					<input type="text" name="ryjszc6" digits="true" class="form-control" required>
					<div class="Validform_checktip"></div>
				</div>
			</div>


			<div class="form-group">
				<label class="col-sm-3 control-label">2013年度总指标金额（万元）：</label>
				<div class="col-sm-7">
					<input type="text" name="total2013" isNonnegative="true" class="form-control" placeholder="2013年度部门信息化系统预算" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">2014年度总指标金额（万元）：</label>
				<div class="col-sm-7">
					<input type="text" name="total2014" isNonnegative="true" class="form-control" placeholder="2014年度部门信息化系统预算" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">2015年度总指标金额（万元）：</label>
				<div class="col-sm-7">
					<input type="text" name="total2015" isNonnegative="true" class="form-control" placeholder="2015年度部门信息化系统预算" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">2016年度总指标金额（万元）：</label>
				<div class="col-sm-7">
					<input type="text" name="total2016" isNonnegative="true" class="form-control" placeholder="2016年度部门信息化系统预算" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">2017年度总指标金额（万元）：</label>
				<div class="col-sm-7">
					<input type="text" name="total2017" isNonnegative="true" class="form-control" placeholder="2017年度部门信息化系统预算" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">2018年度总指标金额（万元）：</label>
				<div class="col-sm-7">
					<input type="text" name="total2018" isNonnegative="true" class="form-control" placeholder="2018年度部门信息化系统预算" required>
				</div>
			</div>
		</form>
	</div>
	<c:set var="type" value="3" />
	<%@ include file="/WEB-INF/views/include/exp_importData.jsp"%>    
	<%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
		var tableId = '#comInfoTable';
		var layerId = '#layer_form';
		var formId = '#eform'; //form id
		var toolbar = '#toolbar';
		var url = '${ctx}/settings/company/';
		var obj = {
			name : $('#sName').val()
		};
		var editTitle = "信息项修改";
		var detailTitle = "信息项详情";

		var rowInput = "#exportData input[name='obj']";
		var uploaderServer = "element";

        var comTableInit = function() {
            var oTableInit = new Object();
            // 初始化Table
            oTableInit.Init = function() {
                $(tableId).bootstrapTable({
                    url : '${ctx}/settings/company/allist',
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
                /*$("#searchFor").parents(".form-group").find("input").each(function (index, item) {
                    obj[$(this).attr("sName")] = $(this).val();
                });*/
                $(toolbar).find(".form-control").each(function (index, item) {
                    if ($(this).attr("sName")!==undefined){
                        obj[$(this).attr("sName")] = $(this).val();
                    }
                });
                if ($(".search-list").length>0){
                    $(".search-list").find(".form-control").each(function (index, item) {
                        if ($(this).attr("sName")!==undefined) {
                            obj[$(this).attr("sName")] = $(this).val();
                        }
                    });
                }
                var temp = {
                    pageNum : params.offset / params.limit + 1,
                    pageSize : params.limit,
                    obj : JSON.stringify(obj)
                };
                return temp;
            };
            return oTableInit;
        };

        $(function () {
            // 1.初始化Table
            var oTable = new comTableInit();
            oTable.Init();
        });

        // 表单的按钮
        function comInfoTableButton(value, row, element) {
            var html = '';
            html += '<div class="btn-group">';
            html += '<button type="button" class="btn btn-white" onclick="datailRow(\''
                + row.id + '\')"><i class="fa fa-info-circle"></i>&nbsp;详情</button>';
            html += '<button type="button" class="btn btn-white" id="edit"  onclick="editRow(\''
                + row.id + '\')"><i class="fa fa-pencil"></i>&nbsp;修改</button>';
            html += '</div>';
            return html;
        }
	</script>
	
	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

