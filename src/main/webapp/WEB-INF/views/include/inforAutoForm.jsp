<%@ page contentType="text/html;charset=UTF-8"%>

	<input type="text" name="id" class="hide">
	<div class="form-group linkagesel-select-group-info clearfix">
		<label class="col-sm-3 control-label">信息类分类：</label>
		<%-- <div class="col-sm-7 linkagesel-select-list clearfix">
			<div class="linkagesel-select-div" required>
				<select id="linkageSelSelect" class="linkagesel-select-info" name="infoType1" value="" required></select>
			</div>
		</div> --%>
		<div class="col-sm-7">
			<input type="text" name="infoType" class="form-control" placeholder="请输入信息类分类名称" required>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">信息资源名称：</label>
		<div class="col-sm-7">
			<input type="text" name="nameCn" class="form-control" placeholder="请输入权责清单名称" required>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label">信息资源摘要：</label>
		<div class="col-sm-7">
			<input type="text" name="summary" class="form-control" placeholder="请输入对信息资源内容（或关键字段）的概要描述" required>
		</div>
	</div>

	<c:set var="user" value="${fns:getCurrentUser()}" />
		<div class="form-group">
			<label class="col-sm-3 control-label">所属部门：</label>
			<c:choose>
				<c:when test="${user.roleId==1}">
					<div class="col-sm-7">
						<%-- <select name="companyId" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="company" items="${fns:getList('company')}">
								<option value="${company.id}">${company.name}</option>
							</c:forEach>
						</select> --%>
						<input id="" name="companyId" class="form-control citySelId hide" type="text">
						<input id="" name="companyName" class="form-control citySel" type="text" ReadOnly required />
						<%@include file="/WEB-INF/views/include/companyTree.jsp"%>
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
	
	<div class="form-group" style="display: none;">
		<label class="col-sm-3 control-label layerTips" data-tips-text="根据信息资源提供方自动生成">信息资源提供方代码：</label>
		<div class="col-sm-7">
			<input type="text" name="code" class="form-control">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label layerTips" data-tips-text="">所属处室：</label>
		<div class="col-sm-7">
			<input type="text" name="dept" class="form-control" required>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label layerTips" data-tips-text="">信息资源编码：</label>
		<div class="col-sm-7">
			<input type="text" name="nameEn" class="form-control">
		</div>
	</div>
	<!-- <div class="form-group">
		<label class="col-sm-3 control-label">数据表英文名称：</label>
		<div class="col-sm-7">
			<input type="text" name="tbName" class="form-control" required>
		</div>
	</div>	 -->	
	<%-- <c:set var="type" value="2" />
	<%@include file="/WEB-INF/views/include/autoForm.jsp"%> --%>
	<div class="form-group">
		<label class="col-sm-3 control-label">信息资源格式：</label>
		<div class="col-sm-7">
			<select name="resourceFormat" class="select-chosen" required>
				<option value=""></option>
				<c:forEach var="dict" items="${fns:getDictList('resource_format')}">
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
			<input type="text" name="shareCondition" class="form-control" placeholder="有条件共享的，应注明共享条件和共享范围；不予共享的，注明相关法律、行政法规中央、国家政策" required>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">共享方式：</label>
		<div class="col-sm-7">
			<input type="text" name="shareMode" class="form-control" placeholder="">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">是否向社会开放：</label>
		<div class="col-sm-7">
			<select name="isOpen" class="select-chosen js-hasChild" required>
				<option value=""></option>
				<c:forEach var="dict" items="${fns:getDictList('yes_no')}">
					<option value="${dict.value}">${dict.label}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="form-group ele-hide" data-parent="isOpen">
		<label class="col-sm-3 control-label">开放条件：</label>
		<div class="col-sm-7">
			<input type="text" name="openType" class="form-control" placeholder="">
		</div>
	</div>
	
	<div class="form-group ele-hide" data-parent="isOpen">
		<label class="col-sm-3 control-label">更新周期：</label>
		<div class="col-sm-7">
			<input type="text" name="updateCycle" class="form-control" placeholder="">
		</div>
	</div>
	
	
	<div class="form-group">
		<label class="col-sm-3 control-label">管理方式：</label>
		<div class="col-sm-7">
			<select name="manageStyle" class="select-chosen js-hasChild" required>
				<option value=""></option>
				<c:forEach var="dict" items="${fns:getDictList('manage_style')}">
					<option value="${dict.value}">${dict.label}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<div class="form-group ele-hide" data-parent="manageStyle">
		<label class="col-sm-3 control-label">关联信息系统：</label>
		<div class="col-sm-7">
			<select name="systemId" class="select-chosen">
				<option value=""></option>
				<c:forEach var="sys" items="${fns:getList('sys')}">
					<option value="${sys.id}">${sys.name}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label">关联业务事项：</label>
		<div class="col-sm-7">
			<input type="text" name="matter" class="form-control" placeholder="">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label">数据范围：</label>
		<div class="col-sm-7">
			<%-- <select name="ranges" class="select-chosen js-hasChild" required>
				<option value=""></option>
				<c:forEach var="dict" items="${fns:getDictList('data_range')}">
					<option value="${dict.value}">${dict.label}</option>
				</c:forEach>
			</select> --%>
			<input type="text" name="ranges" class="form-control" placeholder="" required>
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 control-label">备注：</label>
		<div class="col-sm-7">
			<input type="text" name="remarks" class="form-control" placeholder="">
		</div>
	</div>
	
<script>

</script>
