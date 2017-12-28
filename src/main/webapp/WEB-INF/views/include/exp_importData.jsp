<%@ page contentType="text/html;charset=UTF-8"%>
	<c:set var="isCore" value="0" />
		<!-- 导出数据开始 -->
	<div id="exportData" style="display: none;"  class="ibox-content">
		<form method="post" action="" class="form-horizontal" id="exportForm">
			<div class="alert alert-info">如导出数据量大，下载请耐心等待！</div>
			<c:forEach var="att" items="${fns:getAttList(type,isCore)}">
				<div class="col-md-3">
					<input type="checkbox" nameEn="${att.nameEn}" nameCn="${att.nameCn}" inputType="${att.inputType}"  inputValue="${att.inputValue}" checked/>
					${att.nameCn}
				</div>
			</c:forEach>
			
<!-- 			<div class="col-md-3">
				<input type="checkbox" nameCn="信息项" nameEn="elementIds" inputType="element" inputValue="" checked/>
				信息项
			</div> -->
			<input type="hidden" name="obj" value="">
		</form>
	</div>
	<!-- 导出数据结束 -->


<!-- excel导入开始 -->
	<div id="importData" style="display: none;"  class="ibox-content">
		<form method="post" class="form-horizontal" action=""  id="importForm">
			<div class="form-group" style="padding: 10px;">
				<div class="alert alert-info ">
					请先下载信息资源模版，根据模版填写数据。 <a class="alert-link " href="javascript:void(0)" onclick="downloadTemplate();">Excel模版下载</a>.<br />
					如导入数据量大，上传请耐心等待！
				</div>
				<div id="uploader-demo">
					<label class="col-sm-3 control-label"></label>
					<div class="col-sm-7">
						<label class="col-sm-3" id="img_label"> </label>
						<div class="col-sm-9" id="filePicker"></div>
					</div>
				</div>
			</div>
			<div class="ibox float-e-margins">
				<div class="ibox-content" id="file-message"></div>
				<div class="ibox-content" id="message"></div>
			</div>
			<input type="hidden" id="obj" name="obj" value="">
		</form>
	</div>