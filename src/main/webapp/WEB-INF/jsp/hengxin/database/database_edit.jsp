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
			if($("#ADDRESS").val()==""){
			$("#ADDRESS").tips({
				side:3,
	            msg:'请输入地址',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#ADDRESS").focus();
			return false;
		}
		if($("#PURPOSE").val()==""){
			$("#PURPOSE").tips({
				side:3,
	            msg:'请输入用途',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#PURPOSE").focus();
			return false;
		}
		if($("#AREA").val()==""){
			$("#AREA").tips({
				side:3,
	            msg:'请输入面积',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#AREA").focus();
			return false;
		}
		if($("#HOUSE_TYPE").val()==""){
			$("#HOUSE_TYPE").tips({
				side:3,
	            msg:'请输入户型',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#HOUSE_TYPE").focus();
			return false;
		}
		if($("#FLOOR").val()==""){
			$("#FLOOR").tips({
				side:3,
	            msg:'请输入楼层',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#FLOOR").focus();
			return false;
		}
		if($("#BUILD_YEAR").val()==""){
			$("#BUILD_YEAR").tips({
				side:3,
	            msg:'请输入建成年代',
	            bg:'#AE81FF',
	            time:2
	        });
			$("#BUILD_YEAR").focus();
			return false;
		}
		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
	
</script>
	</head>
<body>
	<form action="database/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="DATABASE_ID" id="DATABASE_ID" value="${pd.DATABASE_ID}"/>
		<div id="zhongxin">
		<table id="table_report" class="table table-striped table-bordered table-hover">
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">地址:</td>
				<td><input type="text" name="ADDRESS" id="ADDRESS" value="${pd.ADDRESS}" maxlength="32" placeholder="这里输入地址" title="地址"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">用途:</td>
				<td><input type="text" name="PURPOSE" id="PURPOSE" value="${pd.PURPOSE}" maxlength="32" placeholder="这里输入用途" title="用途"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">面积:</td>
				<td><input type="text" name="AREA" id="AREA" value="${pd.AREA}" maxlength="32" placeholder="这里输入面积" title="面积"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">户型:</td>
				<td><input type="text" name="HOUSE_TYPE" id="HOUSE_TYPE" value="${pd.HOUSE_TYPE}" maxlength="32" placeholder="这里输入户型" title="户型"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">楼层:</td>
				<td><input type="text" name="FLOOR" id="FLOOR" value="${pd.FLOOR}" maxlength="32" placeholder="这里输入楼层" title="楼层"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">建成年代:</td>
				<td><input type="text" name="BUILD_YEAR" id="BUILD_YEAR" value="${pd.BUILD_YEAR}" maxlength="32" placeholder="这里输入建成年代" title="建成年代"/></td>
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