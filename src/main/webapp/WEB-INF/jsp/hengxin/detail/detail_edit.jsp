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
			if($("#QUERY_DATE").val()==""){
			$("#QUERY_DATE").tips({
				side:3,
	            msg:'请输入查勘日期',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#QUERY_DATE").focus();
			return false;
		}
		if($("#DITCH").val()==""){
			$("#DITCH").tips({
				side:3,
	            msg:'请输入渠道',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#DITCH").focus();
			return false;
		}
		if($("#ENTRUST").val()==""){
			$("#ENTRUST").tips({
				side:3,
	            msg:'请输入委托方',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ENTRUST").focus();
			return false;
		}
		if($("#PHONE").val()==""){
			$("#PHONE").tips({
				side:3,
	            msg:'请输入客户联系方式',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PHONE").focus();
			return false;
		}
		if($("#LOCATION").val()==""){
			$("#LOCATION").tips({
				side:3,
	            msg:'请输入估价对象位置',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#LOCATION").focus();
			return false;
		}
		if($("#STATUS").val()==""){
			$("#STATUS").tips({
				side:3,
	            msg:'请输入状态(报价，预评估函，正式报告）',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#STATUS").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="detail/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="DETAIL_ID" id="DETAIL_ID" value="${pd.DETAIL_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">查勘日期:</td>
				<td><input type="text" name="QUERY_DATE" id="QUERY_DATE" value="${pd.QUERY_DATE}" maxlength="32" placeholder="这里输入查勘日期" title="查勘日期"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">渠道:</td>
				<td><input type="text" name="DITCH" id="DITCH" value="${pd.DITCH}" maxlength="32" placeholder="这里输入渠道" title="渠道"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">委托方:</td>
				<td><input type="text" name="ENTRUST" id="ENTRUST" value="${pd.ENTRUST}" maxlength="32" placeholder="这里输入委托方" title="委托方"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">客户联系方式:</td>
				<td><input type="text" name="PHONE" id="PHONE" value="${pd.PHONE}" maxlength="32" placeholder="这里输入客户联系方式" title="客户联系方式"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">估价对象位置:</td>
				<td><input type="text" name="LOCATION" id="LOCATION" value="${pd.LOCATION}" maxlength="32" placeholder="这里输入估价对象位置" title="估价对象位置"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">状态(报价，预评估函，正式报告）:</td>
				<td><input type="text" name="STATUS" id="STATUS" value="${pd.STATUS}" maxlength="32" placeholder="这里输入状态(报价，预评估函，正式报告）" title="状态(报价，预评估函，正式报告）"/></td>
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