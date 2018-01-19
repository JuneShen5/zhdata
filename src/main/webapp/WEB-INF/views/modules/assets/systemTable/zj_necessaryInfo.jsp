<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 项目建设必要性说明 -->
<fieldset>
    <legend>系统建设必要性</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">系统建设/立项依据</label>
        </div>
        <div class="col-sm-7 column-content">
            <textarea name="xtjsyj" hasNoSpace="true" class="form-control" rows="3" placeholder="权责清单、政策等相关文件" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设预期目标</label>
        </div>
        <div class="col-sm-7 column-content">
            <textarea name="jsyqmb" hasNoSpace="true" class="form-control" rows="3" placeholder="建设此系统的业务目标等" required></textarea>
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
            <textarea name="jpcdsm" hasNoSpace="true" class="form-control" rows="3" placeholder="根据单位具体情况进行说明" required></textarea>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">预估使用对象</label>
        </div>
        <div class="col-sm-7 column-content">
           <!--  <input type="text" class="form-control" hasNoSpace="true" name="ygsydx" placeholder="预估使用对象" required> -->
           <select name="ygsydx" class="form-control is-multiple-select" multiple="multiple" required>
                <c:forEach var="dict" items="${fns:getDictList('estimate_use_object')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
    
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">预估使用对象详细说明</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="ygsydxxxsm" placeholder="填写详细使用对象，具体到部门或某群体">
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
            <input type="text" class="form-control datepicker" vali-standardDate="true" name="yjhtrsysj" readonly="readonly" placeholder="预期系统投入使用时间" required>
        </div>
    </div>
</fieldset>