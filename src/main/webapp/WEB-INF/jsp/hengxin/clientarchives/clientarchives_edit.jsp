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
		<link href="static/css/bootstrap.min.css" rel="stylesheet" />
		<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="static/css/font-awesome.min.css" />
		<!-- 下拉框 -->
		<link rel="stylesheet" href="static/css/chosen.css" />
		
		<link rel="stylesheet" href="static/css/ace.min.css" />
		<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
		<link rel="stylesheet" href="static/css/ace-skins.min.css" />
		
		<link rel="stylesheet" href="static/css/datepicker.css" /><!-- 日期框 -->
		<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		
<script type="text/javascript">
	
	
	//保存
	function save(){
			if($("#CLIENTNAME").val()==""){
			$("#CLIENTNAME").tips({
				side:3,
	            msg:'请输入客户名称',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CLIENTNAME").focus();
			return false;
		}
		if($("#PHONE").val()==""){
			$("#PHONE").tips({
				side:3,
	            msg:'请输入联系电话',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PHONE").focus();
			return false;
		}
		if($("#ADDRESS").val()==""){
			$("#ADDRESS").tips({
				side:3,
	            msg:'请输入估价对象地址',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ADDRESS").focus();
			return false;
		}
		if($("#CLIENT").val()==""){
			$("#CLIENT").tips({
				side:3,
	            msg:'请输入委托方',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#CLIENT").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="clientarchives/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="CLIENTARCHIVES_ID" id="CLIENTARCHIVES_ID" value="${pd.CLIENTARCHIVES_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">客户名称:</td>
				<td><input type="text" name="CLIENTNAME" id="CLIENTNAME" value="${pd.CLIENTNAME}" maxlength="32" placeholder="这里输入客户名称" title="客户名称"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">联系电话:</td>
				<td><input type="text" name="PHONE" id="PHONE" value="${pd.PHONE}" maxlength="32" placeholder="这里输入联系电话" title="联系电话"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">估价对象地址:</td>
				<td><input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="32" placeholder="这里输入估价对象地址" title="估价对象地址"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">委托方:</td>
				<td><input type="text" name="CLIENT" id="CLIENT" value="${pd.CLIENT}" maxlength="32" placeholder="这里输入委托方" title="委托方"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">客户信息介绍:</td>
				<td><input type="text" name="MESSAGE" id="MESSAGE" value="${pd.MESSAGE}" maxlength="200" placeholder="这里输入客户信息" title="客户信息介绍"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">备注:</td>
				<td><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="50" placeholder="这里输入备注" title="备注"/></td>
			</tr>
			<tr>
				<td style="text-align: center;" colspan="10">
					<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
					<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</tr>
		</table>
		</div>
		
		<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
		
	</form>
	
	
		<!-- 引入 -->
		<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
		<script src="static/js/bootstrap.min.js"></script>
		<script src="static/js/ace-elements.min.js"></script>
		<script src="static/js/ace.min.js"></script>
		<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
		<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
		<script type="text/javascript">
		$(top.hangge());
		$(function() {
			
			//单选框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
		});
		
		</script>
</body>
</html>