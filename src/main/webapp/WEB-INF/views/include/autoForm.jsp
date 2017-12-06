<%@ page contentType="text/html;charset=UTF-8"%>

<c:forEach var="att" items="${fns:getAttList(type)}">

	<div
		class="form-group<c:if test="${att.inputLength=='2'}"> col-sm-6</c:if>">
		<label class="col-sm-3 control-label layerTips" data-tips-text="${att.remarks}">${att.nameCn} :</label>
		<c:choose>
			<c:when test="${att.inputType=='input'}">
				<div class="col-sm-7">
					<input type="text" name="${att.nameEn}" class="form-control" placeholder="${att.remarks}"
						<c:if test="${att.isRequire==1}" >required</c:if>>
				</div>
			</c:when>
			<c:when test="${att.inputType=='textarea'}">
				<div class="col-sm-7">
					<textarea type="text" name="${att.nameEn}" class="form-control" placeholder="${att.remarks}"
						<c:if test="${att.isRequire==1}" >required</c:if> 
						style="min-height: 115px;"></textarea>
				</div>
			</c:when>
			<c:when test="${att.inputType=='select'}">
				<div class="col-sm-7">
					<select name="${att.nameEn}" class="select-chosen" <c:if test="${att.isRequire==1}" >required</c:if> inputType="${att.inputType}" inputValue="${att.inputValue}">
						<option value=""></option>
						<c:forEach var="obj" items="${fns:getList(att.inputValue)}">
							<option value="${obj.id}">${obj.name}</option>
						</c:forEach>
					</select>
				</div>
			</c:when>
			<c:when test="${att.inputType=='dictselect'}">
				<div class="col-sm-7">
					<select name="${att.nameEn}" class="select-chosen" <c:if test="${att.isRequire==1}" >required</c:if> inputType="${att.inputType}" inputValue="${att.inputValue}">
						<option value=""></option>
						<c:forEach var="obj" items="${fns:getDictList(att.inputValue)}">
							<option value="${obj.value}">${obj.label}</option>
						</c:forEach>
					</select>
				</div>
			</c:when>
			<c:when test="${att.inputType=='companyselect'}">
				<div class="col-sm-7">
					<select name="${att.nameEn}" class="select-chosen" <c:if test="${att.isRequire==1}" >required</c:if>inputType="${att.inputType}" inputValue="${att.inputValue}">
						<option value=""></option>
						<c:forEach var="company" items="${fns:getList('company')}">
							<option value="${company.id}">${company.name}</option>
						</c:forEach>
					</select>
				</div>
			</c:when>
			
			<c:when test="${att.inputType=='dateselect'}">
				<div class="col-sm-7">
					<input type="text" name="${att.nameEn}" class="form-control datepicker"
						<c:if test="${att.isRequire==1}" >required</c:if> value="" readonly="readonly">
				</div>
			</c:when>
			<c:when test="${att.inputType=='radiobox'}">
				<%-- <div class="col-sm-7">
					<c:forEach var="obj" items="${fns:getDictList(att.inputValue)}">
						<label class="radio-inline i-checks">
							<input type="radio" value="${obj.value}" name="${att.nameEn}" 
							<c:if test="${att.isRequire==1}" >required</c:if>>  ${obj.label}</label>
					</c:forEach>
				</div> --%>
				<div class="col-sm-7">
					<c:forEach var="obj" items="${fns:getDictList(att.inputValue)}">
						<label class="radio-inline i-checks">
							<input type="radio" value="${obj.value}" name="${att.nameEn}-radio">  ${obj.label}</label>
					</c:forEach>
					<input type="text" stype="checkbox" name="${att.nameEn}" class="checkboxInput hide"
					<c:if test="${att.isRequire==1}" >required</c:if> inputType="${att.inputType}" inputValue="${att.inputValue}">
				</div>
			</c:when>
			<c:when test="${att.inputType=='checkbox'}">
				<div class="col-sm-7">
					<c:forEach var="obj" items="${fns:getDictList(att.inputValue)}">
						<label class="checkbox-inline i-checks">
							<input type="checkbox" value="${obj.value}">  ${obj.label}</label>
					</c:forEach>
					<input type="text" stype="checkbox" name="${att.nameEn}" class="checkboxInput hide"
					<c:if test="${att.isRequire==1}" >required</c:if>inputType="${att.inputType}" inputValue="${att.inputValue}">
				</div>
			</c:when>
			
			<c:when test="${att.inputType=='upload'}">
				<div class="col-sm-5 detail-hide edit-show">
					<input type="text" name="${att.nameEn}" class="form-control detail-hide"
						<c:if test="${att.isRequire==1}" >required</c:if> readonly>
				</div>
				<div class="col-sm-3">
					<a style="float: left; margin-right: 10px;" class="btn btn-primary"
						onclick="downloadFile(this);">下载</a> <a
						style="float: left; margin-right: 10px;" class="btn btn-primary"
						onclick="uploadFile(this);">上传文件</a> <input type="file"
						class="uploadFile hide" multiple="multiple">
				</div>
			</c:when>
			
		</c:choose>
	</div>
</c:forEach>

