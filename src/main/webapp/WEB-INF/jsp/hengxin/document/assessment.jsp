<%--
  Created by IntelliJ IDEA.
  User: 向敬光
  Date: 2016/8/25
  Time: 22:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>评估报告</title>
    <base href="<%=basePath%>">
    <%@ include file="../../system/admin/top.jsp"%>

</head>
<body>
<h3 class="header smaller lighter green">评估报告文档上传</h3>
<div class="row-fluid">
    <div class="span5">
        <div class="widget-box">
            <div class="widget-header">
                <h4>信息填写</h4>
            </div>
            <div class="widget-body">
                <div class="widget-main no-padding">
                    <form id="form1" class="form-horizontal" role="form"  action="#"  method="POST" enctype="multipart/form-data">
                        <fieldset>
                            <label>地址</label>
                            <input type="text" name="address" id="address" placeholder="地址">
                            <label>银行</label>
                            <input type="text" name="bank" id="bank" placeholder="银行">
                            <label>委托方</label>
                            <input type="text" name="client" id="client" placeholder="委托方">
                            <label>出报告时间</label>
                            <input class="span10 date-picker" name="EXP_TIME" id="EXP_TIME" value="${pd.EXP_TIME}" type="text" width="10px" data-date-format="yyyy-mm-dd" placeholder="这里输入出报告时间" title="出报告时间"/>
                            <div class="widget-main">
                                <input type="file" name="file" id="id-input-file-1" accept=".xls,.xlsx,.doc,.docx"/>
                            </div>
                        </fieldset>
                        <div class="form-actions center">
                            <c:if test="${QX.add == 1 }">
                                <input id="submit" type="button" value="上传" class="btn btn-small btn-success" onclick="fSubmit();"/>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>
<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- 引入 -->
<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<script type="text/javascript" src="static/js/ajaxfileupload.js"></script>
<script type="text/javascript">
    $(function(){
        //日期框
        $('.date-picker').datepicker();

        $('#id-input-file-1 , #id-input-file-2').ace_file_input({
            no_file:'未选择任何文件 ...',
            btn_choose:'选择',
            btn_change:'已选',
            droppable:false,
            onchange:null,
            thumbnail:false //| true | large
            //whitelist:'doc|xdoc|xls|xlsx'
            //blacklist:'exe|php'
            //onchange:''
            //
        });
    })
    <!-- 关闭进度 -->
    $(top.hangge());
    function fSubmit(){
        var a = /^(\d{4})-(\d{2})-(\d{2})$/
        if ($("#EXP_TIME").val()!=""&&!a.test($("#EXP_TIME").val())) {
            alert("日期格式不正确!应为YYYY-MM-DD格式");
            return;
        }
        $.ajaxFileUpload({
            url: '/monitor/document/webUpload',
            fileElementId: 'id-input-file-1',
            dataType: 'json',
            data: {address:$("#address").val(),bank:$("#bank").val(),client:$("#client").val(),type:"1001",EXP_TIME:$("#EXP_TIME").val()},
            success: function(data, status) {
                if("success"==data.status)
                    alert('上传成功!');
                else{
                    alert(data.message);
                    location.reload();
                }
            },
            error: function(data, status, e) {
                alert("上传错误："+e);
                location.reload();
            }
        })
        return false;
    }
</script>

</body>
</html>