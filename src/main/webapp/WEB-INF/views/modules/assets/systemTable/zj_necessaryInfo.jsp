<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 项目建设必要性说明 -->
<fieldset>
    <legend>项目建设必要性说明</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">项目建设/立项依据</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="xtjsyj" placeholder="权责清单、政策等相关文件" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设预期目标</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="jsyqmb" placeholder="建设此系统的业务目标等" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设项目的紧迫程度</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="jsxmjpcd" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('project_urgency')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">紧迫程度说明</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="jpcdsm" placeholder="根据单位具体情况进行说明" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">预估使用对象</label>
        </div>
        <div class="col-sm-7 column-content">
            <%--<input type="text" class="form-control" hasNoSpace="true" name="ygsydx" placeholder="请输入预估使用对象" required>--%>
            <select name="ygsydx" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('estimate_use_object')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">预估使用规模（注册用户个数/个）</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" digits="true" name="ygsygm" placeholder="涉及用户的具体数量" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">原计划投入使用时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="yjhtrsysj" readonly="readonly" placeholder="预期系统投入使用时间" required>
        </div>
    </div>
</fieldset>