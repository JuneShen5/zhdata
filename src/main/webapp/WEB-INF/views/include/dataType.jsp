<%@ page contentType="text/html;charset=UTF-8"%>

<%--<%@ include file="/WEB-INF/views/include/head.jsp"%>--%>

<div class="form-group">
    <label class="col-sm-3 control-label">数据类型：</label>
    <div class="col-sm-7">
        <div class="col-sm-6" style="padding: 0;">
            <select id="dataTypeEn" class="select-chosen-datatype" name="dataTypen" value="" required>
                <option value=""></option>
                <c:forEach var="obj" items="${fns:getDictList('data_type_en')}">
                    <option value="${obj.value}" sData="${obj.pid}">${obj.label}</option>
                </c:forEach>
            </select>
        </div>
        <div class="col-sm-6" style="padding: 0;padding-left: 15px;">
            <select id="" class="select-chosen" name="dataType" value="" required>
                <option value=""></option>
                <c:forEach var="obj" items="${fns:getDictList('data_type')}">
                    <option value="${obj.value}">${obj.label}</option>
                </c:forEach>
            </select>
        </div>
    </div>
</div>

<!-- [if !IE]> -->
<script src="${ctxStatic}/js/jquery.min.js?v=2.1.4" type="text/javascript"></script>
<!-- <![endif] -->
<!--[if lte IE 8] -->
<script src="${ctxStatic}/js/jquery-1.9.1.js" type="text/javascript"></script>
<!-- [endif] -->
<script	src="${ctxStatic}/js/plugins/validate/jquery.validate.js"></script>
<script	src="${ctxStatic}/js/plugins/validate/messages_zh.min.js"></script>
<script src="${ctxStatic}/js/jquery/jquery.form.js"></script>
<script src="${ctxStatic}/js/plugins/chosen/chosen.jquery.js"></script>
<script src="${ctxStatic}/js/plugins/select2/select2.full.min.js"></script>
<!-- xxxxx -->
<script>
    $(function () {
        $(".select-chosen-datatype").chosen({width: "100%"}).change(function (e) {
            var data = $(this).find("option:checked").attr("sData");
            console.log("data: ", data);
            $.ajax({
                url: '${ctx}/settings/dict/queryDictByValue',
                data: {value: parseInt(data)},
                success: function (res) {
                    var html = '<option value="' + data + '">' + res + '</option>'
                    $("select[name=dataType]").html("");
                    $("select[name=dataType]").append(html);
                    $("select[name=dataType]").trigger("chosen:updated");
                    $("select[name=dataTypen]").blur();
                    $("select[name=dataType]").blur();
                }
            })
        });
    })

</script>

