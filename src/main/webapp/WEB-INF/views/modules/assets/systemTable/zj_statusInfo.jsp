<%@ page contentType="text/html;charset=UTF-8" %>
<!-- 项目建设状态 -->
<fieldset>
    <legend>项目建设状态</legend>
    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">当前建设阶段</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="dqjsjd" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('construction_stage')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">建设方式</label>
        </div>
        <div class="col-sm-7 column-content">
            <select name="jsfs" class="form-control" required>
                <option value="">== 请选择 ==</option>
                <c:forEach var="dict" items="${fns:getDictList('construction_mode')}">
                    <option value="${dict.value}">${dict.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title">
            <label class="control-label">承建单位名称</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" hasNoSpace="true" name="cjdwmc" placeholder="负责此项目的承建商名称" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">承建单位联系人</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content">
                <input type="text" class="form-control" hasNoSpace="true" name="cjdwlxr" placeholder="承建方负责人姓名" required>
            </div>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">承建单位联系电话</label>
        </div>
        <div class="col-sm-7 form-border-nobottom">
            <div class="form-contact column-content form-border-left">
                <input type="text" class="form-control" isMobile="true" name="cjdwlxdh" placeholder="承建方联系电话" required>
            </div>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">合同签署时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="htqssj" readonly="readonly" placeholder="与承建方签署合同日期时间" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">合同约定完成时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="htydwcsj" readonly="readonly" placeholder="与承建方所签署合同约定完成时间" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">合同签署的维保到期时间</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control datepicker" name="htqsdwbdqsj" readonly="readonly" placeholder="合同约定的维保到期时间" required>
        </div>
    </div>

    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">已付合同金额</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" name="yfhtje" placeholder="已付合同金额（万元）" required>            
        </div>
    </div>
    
    <div class="form-group">
        <div class="col-sm-3 column-title form-border-left">
            <label class="control-label">已付合同金额比例</label>
        </div>
        <div class="col-sm-7 column-content">
            <input type="text" class="form-control" name="yfhtjebl" placeholder="已付合同金额比例" required>            
        </div>
    </div>
</fieldset>