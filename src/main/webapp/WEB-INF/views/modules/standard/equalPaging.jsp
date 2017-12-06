<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<style>
#clean_layer_form {
}
#clean_layer_form .clean_layer_left {
	width: 69%;
	display: inline-block;
	height: 370px;
	overflow-y: scroll;
	overflow-x: hidden;
	vertical-align: top;
}
#clean_layer_form .clean_layer_right {
	width: 29%;
	display: inline-block;
	vertical-align: top;
	overflow: hidden;
}
#clean_layer_form .clean_layer_right span.label-info {
	display: inline-block;
}
#clean_layer_form .clean_layer_right span.value-span {
    cursor: pointer;
    display: block;
    white-space: normal;
    text-align: left;
}
</style>

	<!-- 选择数据元 -->
	<div id="select_layer_form" style="display: none;" class="ibox-content">
		<div id="select_Form" class="form-horizontal">
			<div class="ibox-content">
				<div class="alert alert-info">请勾选需要进行清洗的信息项。</div>
				<input class="hide" name="id">
				<table id="selectEqualTable">
					<thead>
						<tr>	
							<th data-checkbox=true></th>
							<th data-field="idCode">内部标识符</th>
							<th data-field="nameCn">中文名称</th>
							<th data-field="nameEn">英文名称</th>
							<th data-field="Score" data-formatter="selectTableButton" class="col-sm-4">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 清洗同义信息项 -->
	<div id="clean_layer_form" style="display: none;" class="ibox-content">
		<div class="clean_layer_left">
			<form id="clean_Form" class="form-horizontal">
				<input type="text" name="id" class="hide">
				<input type="text" name="delId" class="hide">
				<div class="form-group">
					<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">信息项名称：</label>
					<div class="col-sm-7">
						<input type="text" name="nameCn" class="form-control" placeholder="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源" required>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的英文标题">英文名称：</label>
					<div class="col-sm-7">
						<input type="text" name="nameEn" class="form-control" placeholder="描述信息资源中具体数据项的英文标题" required>
					</div>
				</div>
				<%@include file="/WEB-INF/views/include/dataType.jsp"%>
	            <div class="form-group">
					<label class="col-sm-3 control-label layerTips" data-tips-text="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该信息项对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该信息项内容字数的上限，并折算成字节数，该字节数即为数据长度">数据长度：</label>
					<div class="col-sm-7">
						<input type="text" name="len" class="form-control" placeholder="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）" >
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
				
				<div class="form-group">
					<label class="col-sm-3 control-label">数据标记：</label>
					<div class="col-sm-7">
						<select name="dataLabel" class="select-chosen">
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
						<select name="companyId" class="select-chosen">
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
						<select name="isDict" class="select-chosen">
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
						<select name="shareCondition" class="select-chosen">
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
						<select name="shareMode" class="select-chosen">
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
						<select name="openType" class="select-chosen">
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
			</form>
		</div>
		<div class="clean_layer_right">
			
		</div>
	</div>
	
	<!-- 查看		信息项详情 -->
	<div id="lookout_layer_form" style="display: none;" class="ibox-content">
		<form id="lookout_Form" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">信息项名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" placeholder="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的英文标题">英文名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" placeholder="描述信息资源中具体数据项的英文标题" required>
				</div>
			</div>
			
			<%@include file="/WEB-INF/views/include/dataType.jsp"%>
             <div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该信息项对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该信息项内容字数的上限，并折算成字节数，该字节数即为数据长度">数据长度：</label>
				<div class="col-sm-7">
					<input type="text" name="len" class="form-control" placeholder="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）" >
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
			
			<div class="form-group">
				<label class="col-sm-3 control-label">数据标记：</label>
				<div class="col-sm-7">
					<select name="dataLabel" class="select-chosen">
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
					<select name="companyId" class="select-chosen">
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
					<select name="isDict" class="select-chosen">
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
		</form>
	</div>
	
	<!-- 相关信息资源 -->
	<div id="about_layer_form" style="display: none;" class="ibox-content">
		<div id="about_Form" class="form-horizontal">
			<div class="ibox-content">
				<input class="hide" name="id">
				<input class="hide" name="ids">
				<table id="aboutEqualTable">
					<thead>
						<tr>
							<th data-field="nameEn">信息资源代码</th>
							<th data-field="nameCn">信息资源名称</th>
							<th data-field="companyName">所属部门</th>
							<th data-field="isAudit" data-formatter="isAuditTrans">状态</th>
							<th data-field="Score" data-formatter="aboutTableButton" class="col-sm-4" data-width="100">操作</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
	</div>
	
	<!-- 信息资源详情 -->
	<div id="infoDetail_layer_form" style="display: none;" class="ibox-content">
		<form id="infoDetail_Form" class="form-horizontal">
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
								<select name="companyId" class="select-chosen" required>
									<option value=""></option>
									<c:forEach var="company" items="${fns:getList('company')}">
										<option value="${company.id}">${company.name}</option>
									</c:forEach>
								</select>
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
		</form>
		<div id="infoDetail_search_form">
			<input type="text" class="hide" name="id" />
		</div>
		<table id="infoDetailEqualTable">
			<thead>
				<tr>
					<th data-field="idCode">内部标识符</th>
					<th data-field="nameCn">信息项名称</th>
					<th data-field="dataTypeName">数据类型</th>
					<th data-field="len">数据长度</th>
					<th data-field="companyName">来源部门</th>
					<th data-field="Score" data-formatter="infoDetailTableButton" class="col-sm-4">操作</th>
				</tr>
			</thead>
		</table>
	</div>
	
	<!-- 信息项详情 -->
	<div id="information_layer_form" style="display: none;" class="ibox-content">
		<form id="information_Form" class="form-horizontal">
			<input type="text" name="id" class="hide">
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源">信息项名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameCn" class="form-control" placeholder="描述信息资源中具体数据项的中文标题。适用于格式为数据库、电子表格类的信息资源" required>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="描述信息资源中具体数据项的英文标题">英文名称：</label>
				<div class="col-sm-7">
					<input type="text" name="nameEn" class="form-control" placeholder="描述信息资源中具体数据项的英文标题" required>
				</div>
			</div>
			<%@include file="/WEB-INF/views/include/dataType.jsp"%>
			<div class="form-group">
				<label class="col-sm-3 control-label layerTips" data-tips-text="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）。属于数据库类的，数据长度即该信息项对应的字段在数据库中的指定长度或默认长度；属于电子表格类的，估算该信息项内容字数的上限，并折算成字节数，该字节数即为数据长度">数据长度：</label>
				<div class="col-sm-7">
					<input type="text" name="len" class="form-control" placeholder="标明该信息项在计算机中存储时占用的字节数，适用于结构化数据（数据库类、电子表格类）" >
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
			
			<div class="form-group">
				<label class="col-sm-3 control-label">数据标记：</label>
				<div class="col-sm-7">
					<select name="dataLabel" class="select-chosen">
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
					<select name="companyId" class="select-chosen">
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
					<select name="isDict" class="select-chosen">
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
					<select name="shareCondition" class="select-chosen">
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
					<select name="shareMode" class="select-chosen">
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
					<select name="openType" class="select-chosen">
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
		</form>
	</div>
    <%@ include file="/WEB-INF/views/include/footer.jsp"%>
	<script>
	
	$(function () {
		// 选择信息元
		selectTable = new selectTableInit();
		selectTable.Init();
		// 相关信息资源
		aboutDetail = new aboutTableInit();
		aboutDetail.Init();
		// 信息资源详情
		infoDetail = new infoDetailTableInit();
		infoDetail.Init();
		// 四级联动
		var relConfigInfo = {
			ajax: '${ctx}/catalogset/infoSort/queryList',
			select: '.linkagesel-select-info',
			loaderImg: ''
		};
		window.linkRelInfo = new LinkageSel(relConfigInfo);
		// 没有找到数据返回之后的回调函数，所以写了一个延时效果
		setTimeout(function () {
			$(".LinkageSel").hide();
			$(".LinkageSel").chosen({width: "48%"});
			$(".LinkageSel").trigger("chosen:updated");
		}, 500);
		linkRelInfo.onChange(function () {
			$(".linkagesel-select-div select").each(function (index, item) {
				var hideHtml = "div:eq(" + index + ")";
				// 如果为零表示是select为空，隐藏掉，并且将select的name值去掉
				if ($(this).children('option').length == 0) {
					$(".linkagesel-select-div").children(hideHtml).hide();
					$(this).removeAttr("name");
					$(this).attr('disabled', 'disabled');
					linkageselChosen()
				} else {
					$(".linkagesel-select-div").children(hideHtml).show();
					$(this).attr("name", "infoType" + (index + 1));
					$(this).attr('disabled', 'disabled');
					linkageselChosen()
				}
			});
		})
		// 开放、共享表单事件绑定
	    shareToggleMethod();
	})
	
	// 选择数据元的弹框
	function openSelectLayer(title) {
		$("#selectEqualTable").bootstrapTable('refresh', {url: url + 'listById'});
		selectLayeForm = layer.open({
			title: title,
			type : 1,
			area : [ '90%', '90%' ],
			scrollbar : false,
			zIndex : 100,
			btn : [ '清洗', '关闭' ],
			yes : function(index, layero) {
				var data = $("#selectEqualTable").bootstrapTable('getSelections');
				if (data.length == 0) {
					return
				}
				openCleanLayer("清洗同义信息项", data);
			},
			end : function() {
			},
			content : $("#select_layer_form")
		});
	}
	
	// 清洗
	function openCleanLayer(title, data) {
		$(".clean_layer_right").html("");
		console.log("data: ", data);
		var row = {};
		var delId = []
		// 首先处理数据，将单独的数据给回显，重复的数据放出来认为选择
		$.each(data, function (i, item) {
			delId.push(item.id);
			$.each(item, function (m, mItem) {
				if (row[m] == undefined) {
					row[m] = [];
				}
				if (mItem != "" && mItem != null) {
					if (row[m].length == 0) {
						row[m].push({data: mItem, count: 1, ids: [item.id]})
					} else {
						$.each(row[m], function (n, nItem) {
							if (nItem.data == mItem) {
								row[m][n].count++;
								row[m][n].ids.push(item.id)
								return false;
							}
							if (n == row[m].length -1) {
								row[m].push({data: mItem, count : 1, ids: [item.id]});
							}
						})
					}
				}
			})
		})
		console.log("row: ", row);
		$("#clean_Form input[name=delId]").val(delId);
		// 回显
		var obj = row;
		var key, value, tagName, type, arr;
		for (x in obj) {
			// 如果数据只有一条，直接显示，如果存在两个以上的数据，标明"存在歧义"，并将数据显示在右侧
			key = x;
			value = obj[x];
			var html = '<span class="is-ambiguity" style="color:#23c6c8;font-size: 13px;"><i class="fa fa-info-circle"></i>&nbsp;存在分歧</span>';
			$("#clean_Form").find('[name=' + key + ']').each(function () {
				var name = $(this).attr("name");
				tagName = $(this)[0].tagName;
				type = $(this).attr('type');
				if (value.length == 1) {
					if (tagName == 'INPUT') {
						$(this).val(value[0].data);
					} else if (tagName == 'SELECT') {
						$(this).val(value[0].data);
						$(this).trigger("chosen:updated");
					}
					$(this).click(function () {
						$(".clean_layer_right").html("");
					})
					$(this).siblings(".chosen-container").click(function () {
						$(".clean_layer_right").html("");
					})
				} else if (value.length > 1) {
					// 加上歧义标签和焦点事件
					$(this).closest(".col-sm-7").append(html);
					$(this).click(function () {
						displayList(obj, name, $(this));
					})
					$(this).siblings(".chosen-container").click(function () {
						displayList(obj, name, $(this));
					})
				}
			})
		}
		$("#clean_Form").validate().form();
		cleanLayeForm = layer.open({
			title: title,
			type : 1,
			area : [ '85%', '85%' ],
			scrollbar : false,
			zIndex : 200,
			btn : [ '清洗', '关闭' ],
			yes : function(index, layero) {
				$("#clean_Form").submit();
			},
			end : function() {
				$(".is-ambiguity").remove();
				endMethod("#clean_Form");
			},
			cancel: function () {
				$(".is-ambiguity").remove();
				endMethod("#clean_Form");
			},
			content : $("#clean_layer_form")
		});
	}
	
	function displayList (obj, name, $this) {
		console.log("obj: ", obj);
		console.log("name: ", name);
		console.log("value: ", obj[name]);
		$(".clean_layer_right").html("");
		var rightHtml = '<div class="alert alert-info">点击<i class="fa fa-gg detail-span"></i>查看相关信息资源<br>点击文字快速复制。</div>';
		$.each(obj[name], function (index, item) {
			rightHtml += '<p><span class="label label-info">';
			rightHtml += '<span class="value-span" data-value="' + item.data + '" style="cursor:pointer;">';
			rightHtml += item.data + '(' + item.count + ')';
			rightHtml += ' <i class="fa fa-gg detail-span-i" data-ids="' + item.ids + '" style="cursor:pointer;"></i></span></span></p>';
		})
		$(".clean_layer_right").append(rightHtml);
		$(".value-span").click(function () {
			// 将取到的值赋值到对应的表单中
			$this.val($(this).attr("data-value"));
			$this.blur();
			$this.prev("select").val($(this).attr("data-value"));
			$this.prev("select").trigger("chosen:updated");
			$this.prev("select").blur();
		})
		$(".detail-span-i").click(function () {
			$("#about_Form input[name=ids]").val($(this).attr("data-ids"));
			console.log("ids: ", $(this).attr("data-ids"))
			aboutInfo();
		})
	}
	
	// 清洗同义信息项
	$(function () {
		$("#clean_Form").validate({
			ignore: ":hidden:not(select,input)",
	        submitHandler: function(form){
	        	$("#clean_Form").ajaxSubmit({
	    			url : url + 'cleanElePool',
	    			type : 'post',
	    			success : function(data){
	    				layer.close(cleanLayeForm);
	    				$("#selectEqualTable").bootstrapTable('refresh');
	    				layer.msg(data);
	    				initWeb();
	    				endMethod("#clean_Form");
	    			},
	    			error : function(XmlHttpRequest, textStatus, errorThrown){
	    				layer.close(cleanLayeForm);
	    				$("#selectEqualTable").bootstrapTable('refresh');
	    				layer.msg("数据操作失败!");
	    				endMethod("#clean_Form");
	    			},
	    			resetForm : true
	    		});
	    		return false;
	        }
	    });
	})
	
	// 选择数据元按钮
	function selectTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="detailSelectRow('
				+ row.id + ',\'' + row.name + '\')"><i class="fa fa-pencil"></i>&nbsp;查看</button>';
		return html;
	}
	
	// 查看
	function detailSelectRow (id) {
		var row = $("#selectEqualTable").bootstrapTable('getRowByUniqueId', id);
		loadToData(row, 'lookout_Form')
		disabledMenu('#lookout_Form')
		lookoutLayeForm = layer.open({
			title: "信息项详情",
			type : 1,
			area : [ '80%', '80%' ],
			scrollbar : false,
			zIndex : 200,
			content : $("#lookout_layer_form")
		});
	}
	
	// 选择数据元
	var selectTableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$("#selectEqualTable").bootstrapTable({
				// url : url + 'listById',
				method : 'get',
				striped : true, // 是否显示行间隔色
				pagination : true, // 是否显示分页（*）
				queryParams : oTableInit.queryParams, // 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
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
			var equalObj = {};
			equalObj.id = parseInt($("#select_Form input[name=id]").val());
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				obj : JSON.stringify(equalObj)
			};
			return temp;
		};
		return oTableInit;
	};
	
	// 相关信息资源
	function aboutInfo () {
		$("#aboutEqualTable").bootstrapTable("refresh", {url: url + 'infoListByEleId'});
		aboutLayeForm = layer.open({
			title: "相关信息资源",
			type : 1,
			area : [ '80%', '80%' ],
			scrollbar : false,
			zIndex : 300,
			content : $("#about_layer_form")
		});
	}
	
	function aboutTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="infoDetailAboutRow('
				+ row.id + ')"><i class="fa fa-pencil"></i>&nbsp;查看</button>';
		return html;
	}
	
	// 查看按钮-信息项详情
	function infoDetailAboutRow (id) {
		var row = $("#aboutEqualTable").bootstrapTable('getRowByUniqueId', id);
		/* $("#infoDetail_Form").find("*").each(function (index, item) {
			$(this).attr("disabled", "disabled");
		}) */
		loadToData(row, 'infoDetail_Form')
		$("#infoDetail_search_form input[name=id]").val(id);
		$("#infoDetailEqualTable").bootstrapTable("refresh", {url: url + 'eleByInfoId'});
		$("#infoDetail_Form input").attr('disabled', 'disabled');
		$("#infoDetail_Form select").attr('disabled', 'disabled');
		$("#infoDetail_Form select").trigger("chosen:updated");
		infoDetailLayeForm = layer.open({
			title: "信息资源详情",
			type : 1,
			area : [ '75%', '75%' ],
			scrollbar : false,
			zIndex : 300,
			content : $("#infoDetail_layer_form")
		});
	}
	
	var infoDetailTableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$("#infoDetailEqualTable").bootstrapTable({
				// url : url + 'listById',
				method : 'get',
				striped : true, // 是否显示行间隔色
				pagination : true, // 是否显示分页（*）
				queryParams : oTableInit.queryParams, // 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
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
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				id : parseInt($("#infoDetail_search_form input[name=id]").val())
			};
			return temp;
		};
		return oTableInit;
	};
	
	// 相关信息资源表格
	var aboutTableInit = function() {
		var oTableInit = new Object();
		// 初始化Table
		oTableInit.Init = function() {
			$("#aboutEqualTable").bootstrapTable({
				// url : url + 'listById',
				method : 'get',
				striped : true, // 是否显示行间隔色
				pagination : true, // 是否显示分页（*）
				queryParams : oTableInit.queryParams, // 传递参数（*）
				sidePagination : "server", // 分页方式：client客户端分页，server服务端分页（*）
				pageNumber : 1, // 初始化加载第一页，默认第一页
				pageSize : 10, // 每页的记录行数（*）
				pageList : [ 10, 25, 50, 100 ], // 可供选择的每页的行数（*）
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
			var temp = {
				pageNum : params.offset / params.limit + 1,
				pageSize : params.limit,
				queryParams : $("#about_Form input[name=ids]").val()
			};
			return temp;
		};
		return oTableInit;
	};
	
	function infoDetailTableButton (index, row, element) {
		var html = '';
		html += '<div class="btn-group">';
		html += '<button type="button" class="btn btn-white" onclick="infoDetailRow('
				+ row.id + ')"><i class="fa fa-pencil"></i>&nbsp;查看</button>';
		return html;
	}
	
	// 信息项详情
	function infoDetailRow (id) {
		var row = $("#infoDetailEqualTable").bootstrapTable('getRowByUniqueId', id);
		loadToData(row, 'information_Form')
		informationLayeForm = layer.open({
			title: "信息资源详情",
			type : 1,
			area : [ '70%', '70%' ],
			scrollbar : false,
			zIndex : 300,
			content : $("#information_layer_form")
		});
		disabledMenu('#information_Form');
	}
	
	function isAuditTrans (value) {
		if (value == 0) {
			return "待审核"
		} else if (value == 1) {
			return "已审核"
		}
	}

	</script>

	<script src="${ctxStatic}/js/common/common.js"></script>
</body>
</html>

