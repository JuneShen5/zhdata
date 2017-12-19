<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 项目建设必要性说明 -->
<fieldset>
    <legend>项目建设必要性说明</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">项目建设立项依据</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="xtjsyj" placeholder="请输入项目建设立项依据，如国家政策、需求" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设预期目标</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="jsyqmb" placeholder="建设预期目标，如经济效益、民生效益等" required>
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
            <label class="control-label">紧迫程度简要说明</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="jpcdsm" placeholder="紧迫程度简要说明" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">预估使用对象</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="ygsydx" placeholder="请输入预估使用对象" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">预估使用规模</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="ygsygm" placeholder="请输入预估使用规模（注册用户数/个）" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">原计划投入使用时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="yjhtrsysj" readonly="readonly" placeholder="原计划投入使用时间" required>
        </div>
    </div>
</fieldset>