<%@ page contentType="text/html;charset=UTF-8"%>
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