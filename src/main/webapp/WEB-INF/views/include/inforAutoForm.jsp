<%@ page contentType="text/html;charset=UTF-8"%>

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
					<option value="${sys.id}">${sys.nameCn}</option>
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
						<%-- <select name="companyId" class="select-chosen" required>
							<option value=""></option>
							<c:forEach var="company" items="${fns:getList('company')}">
								<option value="${company.id}">${company.name}</option>
							</c:forEach>
						</select> --%>
						<input id="citySelId" name="companyId" class="form-control hide" type="text">
						<input id="citySel" name="companyName" class="form-control" type="text" ReadOnly />
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

<script>

</script>
