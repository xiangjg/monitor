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
    <meta name="description" content="overview & stats" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- basic styles -->
    <link href="static/UI_new/css/bootstrap.min.css" rel="stylesheet" />
    <link href="static/UI_new/css/bootstrap-responsive.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="static/UI_new/css/font-awesome.min.css" />
    <!--[if IE 7]>
    <link rel="stylesheet" href="static/UI_new/css/font-awesome-ie7.min.css" />
    <![endif]-->
    <!-- page specific plugin styles -->

    <link rel="stylesheet" href="static/UI_new/css/jquery-ui-1.10.2.custom.min.css" />
    <link rel="stylesheet" href="static/UI_new/css/chosen.css" />
    <link rel="stylesheet" href="static/UI_new/css/datepicker.css" />
    <link rel="stylesheet" href="static/UI_new/css/bootstrap-timepicker.css" />
    <link rel="stylesheet" href="static/UI_new/css/daterangepicker.css" />
    <link rel="stylesheet" href="static/UI_new/css/colorpicker.css" />
    <!-- ace styles -->
    <link rel="stylesheet" href="static/UI_new/css/ace.min.css" />
    <link rel="stylesheet" href="static/UI_new/css/ace-responsive.min.css" />
    <link rel="stylesheet" href="static/UI_new/css/ace-skins.min.css" />
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="static/UI_new/css/ace-ie.min.css" />
    <![endif]-->

</head>
<body>
<h3 class="header smaller lighter green">文档上传</h3>
<div class="row-fluid">
    <div class="span5">
        <div class="widget-box">
            <div class="widget-header">
                <h4>信息填写</h4>
            </div>
            <div class="widget-body">
                <div class="widget-main no-padding">
                    <form id="form1" class="form-horizontal" role="form"  action="#"  method="POST" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">地址</label>
                            <div class="col-sm-7" style="margin-left: 12px">
                                <input type="text" name="address" id="address" placeholder="地址"
                                       class="col-xs-10 col-sm-7"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">银行</label>
                            <div class="col-sm-7" style="margin-left: 12px">
                                <input type="text" name="bank" id="bank" placeholder="银行"
                                       class="col-xs-10 col-sm-7"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">委托方</label>
                            <div class="col-sm-7" style="margin-left: 12px">
                                <input type="text" name="client" id="client" placeholder="委托方"
                                       class="col-xs-10 col-sm-7"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label no-padding-right">选择文件</label>
                            <div class="col-sm-9">
                                <div class="col-sm-6" id="file_div">
                                    <input type="file" name="file" id="uploadFile"  accept=".xls,.xlsx,.doc,.docx"/>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix form-actions">
                            <div class="col-sm-offset-3 col-sm-2">
                                <input id="submit" type="button" value="上传" class="btn btn-info btn-block" onclick="fSubmit();"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- basic scripts -->
<script src="static/UI_new/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
    window.jQuery || document.write("<script src='static/UI_new/js/jquery-1.9.1.min.js'>\x3C/script>");
</script>

<script src="static/UI_new/js/bootstrap.min.js"></script>
<!-- page specific plugin scripts -->
<script src="static/UI_new/js/ace-elements.min.js"></script>
<script src="static/UI_new/js/ace.min.js"></script>
<script type="text/javascript" src="static/js/ajaxfileupload.js"></script>
<script type="text/javascript">
    <!-- 关闭进度 -->
    $(top.hangge());
    function fSubmit(){
        $.ajaxFileUpload({
            url: '/monitor/document/webUpload',
            fileElementId: 'uploadFile',
            dataType: 'json',
            data: {address:$("#address").val(),bank:$("#bank").val(),client:$("#client").val(),type:"1"},
            success: function(data, status) {
                console.info(data);console.info(status);
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