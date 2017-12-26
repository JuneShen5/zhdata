<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 系统使用信息 -->
<fieldset>
    <legend>系统使用信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">是否为僵尸信息系统</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sfjsxt" class="form-control js-hasChild" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group ele-hide" data-parent="sfjsxt">
        <div class="col-sm-3 column-title">
            <label class="control-label">使用对象</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="sydx" placeholder="请输入使用对象，如政府单位内部，注册用户数_个">
        </div>
    </div>
    <div class="form-group ele-hide" data-parent="sfjsxt">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">用户规模</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" digits="true" name="ygsygm" placeholder="涉及用户的具体数量（注册用户的总数）" required>
        </div>
    </div>

    <div class="form-group ele-hide" data-parent="sfjsxt">
        <div class="col-sm-3 column-title">
            <label class="control-label">使用频度</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="sypd" placeholder="请输入使用频度，如每月系统使用用户量">
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">涉及的服务器IP</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="sydx" placeholder="请输入涉及的服务器IP">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">系统访问地址</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="sydx" placeholder="此系统的网址及登录信息（访问网址、账号、密码）">
        </div>
    </div>
</fieldset>
