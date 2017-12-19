<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 僵尸系统信息 -->
<fieldset>
    <legend>僵尸系统信息</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">是否为僵尸信息系统</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="sfjsxt" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">使用对象</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="sydx" placeholder="请输入使用对象，如政府单位内部，注册用户数_个" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">使用频度</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="sypd" placeholder="请输入使用频度，如每月系统使用用户量" required>
        </div>
    </div>
</fieldset>
