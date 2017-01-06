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
		<base href="<%=basePath%>">
		<meta charset="utf-8" />
		<title></title>
		<meta name="description" content="overview & stats" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<%@ include file="../../system/admin/top.jsp"%>

		
	</head>
<body>
	<div id="zhongxin">
		
    <div id="wrapper">
        <div id="container">
			<!--隐藏参数-->
			<input type="text" value="${pd.dbid}" id="dbid" style="display: none">
			<input type="text" value="${pd.docType}" id="docType" style="display: none">

			<div class="widget-body">
				<div class="widget-main no-padding">
					<form id="form1" class="form-horizontal" role="form"  action="#"  method="POST" enctype="multipart/form-data">
						<fieldset>
							<div class="widget-main">
								<input type="file" name="file" id="id-input-file-1" accept=".xls,.xlsx,.doc,.docx"/>
							</div>
						</fieldset>
						<div class="form-actions center">
							<input id="submit" type="button" value="上传" class="btn btn-small btn-success" onclick="fSubmit();"/>
						</div>
					</form>
				</div>
			</div>
		</div>
        </div>
    </div>

		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/ajaxfileupload.js"></script>
		<script type="text/javascript">
		$(top.hangge());

		function fSubmit(){
			$.ajaxFileUpload({
				url: '/monitor/clientarchives/saveImg',
				fileElementId: 'id-input-file-1',
				dataType: 'json',
				data: {dbid:$("#dbid").val(),docType:$("#docType").val()},
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