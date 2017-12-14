<%@ page contentType="text/html;charset=UTF-8"%>

	<input type="text" name="id" class="hide">
	<div class="form-group">
		<label class="col-sm-3 control-label">信息项名称：</label>
		<div class="col-sm-7">
			<input type="text" name="nameCn" class="form-control" required>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">英文名称：</label>
		<div class="col-sm-7">
			<input type="text" name="nameEn" class="form-control" required>
		</div>
	</div>
	
	<%@include file="/WEB-INF/views/include/dataType.jsp"%>
	
	<div class="form-group">
		<label class="col-sm-3 control-label">数据长度：</label>
		<div class="col-sm-7">
			<input type="text" name="len" class="form-control" required>
		</div>
	</div>
	 <div class="form-group">
		<label class="col-sm-3 control-label">对象类型：</label>
		<div class="col-sm-7">
			<select name="dataType" class="select-chosen" required>
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
			<select name="dataLabel" class="select-chosen" required>
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
			<select name="companyId" class="select-chosen" required>
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
			<select name="isDict" class="select-chosen" required>
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

<script>

</script>
