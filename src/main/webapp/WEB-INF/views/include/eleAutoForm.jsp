<%@ page contentType="text/html;charset=UTF-8"%>

	<input type="text" name="id" class="hide">
	<!-- 新增 -->
	<div class="form-group">
		<label class="col-sm-3 control-label">信息项编码：</label>
		<div class="col-sm-7">
			<input type="text" name="code" class="form-control" placeholder="请输入信息项编码" required>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">信息项中文名称：</label>
		<div class="col-sm-7">
			<input type="text" name="nameCn" class="form-control" placeholder="描述信息资源中具体数据项（数据元）的中文标题" required>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">信息项英文名称：</label>
		<div class="col-sm-7">
			<input type="text" name="nameEn" class="form-control" placeholder="描述信息资源中具体信息项的英文标题" required>
		</div>
	</div>
	
	<!-- 新增 -->
	<div class="form-group">
		<label class="col-sm-3 control-label">信息项描述说明：</label>
		<div class="col-sm-7">
			<input type="text" name="des" class="form-control" placeholder="对该信息项的内容进行简要描述" required>
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-3 control-label">信息项数据类型：</label>
		<div class="col-sm-7">
			<select name="dataType" class="select-chosen" required>
				<option value=""></option>
				<c:forEach var="dict" items="${fns:getDictList('data_type')}">
					<option value="${dict.value}">${dict.label}</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<%-- <%@include file="/WEB-INF/views/include/dataType.jsp"%> --%>
	
	<div class="form-group">
		<label class="col-sm-3 control-label">信息项数据长度：</label>
		<div class="col-sm-7">
			<input type="text" name="len" class="form-control" placeholder="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）" required>
		</div>
	</div>
	<c:set var="user" value="${fns:getCurrentUser()}" />
		<div class="form-group">
			<label class="col-sm-3 control-label">来源部门：</label>
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
	<div class="form-group">
	<%-- 	<label class="col-sm-3 control-label">来源部门：</label>
		<div class="col-sm-7">
			<select name="companyId" class="select-chosen" required>
				<option value=""></option>
				<c:forEach var="company" items="${fns:getList('company')}">
					<option value="${company.id}">${company.name}</option>
				</c:forEach>
			</select>
			<input id="" name="companyId" class="form-control citySelId hide" type="text">
			<input id="" name="companyName" class="form-control citySel" type="text" ReadOnly required/>
			<%@include file="/WEB-INF/views/include/companyTree.jsp"%>
		</div>
	</div> --%>
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
	
	<%-- <div class="form-group">
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
 --%>
<script>

</script>
