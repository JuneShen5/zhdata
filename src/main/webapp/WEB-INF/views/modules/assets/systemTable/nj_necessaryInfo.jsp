<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 系统建设必要性 -->
<fieldset>
    <legend>系统建设必要性</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设紧迫程度</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="jsjpcd" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">系统建设时间要求</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="xtjcsjyq" readonly="readonly" placeholder="具体日期时间（CCYY-MM）" required>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">拟建系统依据/紧迫性</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="njxtyj" placeholder="如根据权责清单、政策文件等，是否需要尽快落实" required>
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
            <label class="control-label">预估使用对象</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="ygsydx" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('yes_no')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">预估使用规模</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" digits="true" name="ygsygm" placeholder="预估使用规模" required>
        </div>
    </div>
</fieldset>