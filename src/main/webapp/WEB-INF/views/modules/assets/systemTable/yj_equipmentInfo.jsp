<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 关键设备信息 -->
<fieldset>
    <legend>关键设备信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">PC服务器品牌数量</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control digits" name="pcfwqppsl" placeholder="请输入PC服务器品牌数量" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">操作系统类型数量</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control digits" name="czxtlxsl" placeholder="请输入操作系统类型数量" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">小型机品牌数量</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control digits" name="xxjppsl" placeholder="请输入小型机品牌数量" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">备份设备数量</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control digits" name="bfsbsl" placeholder="请输入备份设备数量" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">网络设备（路由器、交换机）数量</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control digits" name="wlsbsl" placeholder="请输入网络设备（路由器、交换机）数量" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">中间件类型和数量</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="zjjlxhsl" placeholder="请输入中间件类型和数量" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">存储容量（TB）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" isNonnegative="true" name="ccrl" placeholder="请输入存储容量（单位：TB）" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">实际用量（TB）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" isNonnegative="true" name="sjyl" placeholder="请输入实际用量（单位：TB）" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">服务器</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="fwq" placeholder="X86,CPU总核数：_____,内存总容量：____,其他（小型机）：____" required>
        </div>
    </div>
</fieldset>
