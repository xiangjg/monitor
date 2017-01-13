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
		var a = /^(\d{4})-(\d{2})-(\d{2})$/
		if (!a.test($("#QUERY_DATE").val())) {
			alert("查勘日期格式不正确!应为YYYY-MM-DD格式");
			$("#QUERY_DATE").focus();
			return false;
		}
		if ($("#EXP_TIME").val()!=""&&!a.test($("#EXP_TIME").val())) {
			alert("出报告时间日期格式不正确!应为YYYY-MM-DD格式");
			$("#EXP_TIME").focus();
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
				<td><input class="span10 date-picker" name="QUERY_DATE" id="QUERY_DATE" value="${pd.QUERY_DATE}" type="text" data-date-format="yyyy-mm-dd" placeholder="这里输入查勘日期" title="查勘日期"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">渠道:</td>
				<td>
					<select name="DITCH" id="DITCH" value="${pd.DITCH}">
						<option value=""></option>
						<option value="工商银行">工商银行</option>
						<option value="农业银行">农业银行</option>
						<option value="建设银行">建设银行</option>
						<option value="贵阳农商银行">贵阳农商银行</option>
						<option value="贵阳银行">贵阳银行</option>
						<option value="贵州银行">贵州银行</option>
						<option value="南充银行">南充银行</option>
						<option value="民生银行">民生银行</option>
						<option value="兴业银行">兴业银行</option>
						<option value="重庆银行">重庆银行</option>
						<option value="浦发银行">浦发银行</option>
						<option value="其他">其他</option>
					</select>
				</td>
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
				<td><input type="text" name="LOCATION" id="LOCATION" value="${pd.LOCATION}" maxlength="150" placeholder="这里输入估价对象位置" title="估价对象位置"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">状态:</td>
				<td>
					<select name="STATUS" id="STATUS" value="${pd.STATUS}">
						<option value=""></option>
						<option value="报价">报价</option>
						<option value="预评估">预评估</option>
						<option value="出电子档报告">出电子档报告</option>
						<option value="已出正式报告">已出正式报告</option>
					</select>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">评估总价:</td>
				<td><input type="text" name="SUMPRICE" id="SUMPRICE" value="${pd.SUMPRICE}" maxlength="32" placeholder="这里输入评估总价" title="评估总价"/></td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">出报告时间:</td>
				<td>
					<input class="span10 date-picker" name="EXP_TIME" id="EXP_TIME" value="${pd.EXP_TIME}" type="text" data-date-format="yyyy-mm-dd" placeholder="这里输入出报告时间" title="出报告时间"/>
				</td>
			</tr>
			<tr>
				<td style="width:70px;text-align: right;padding-top: 13px;">备注:</td>
				<td><input type="text" name="REMARK" id="REMARK" value="${pd.REMARK}" maxlength="150" placeholder="这里输入备注" title="备注"/></td>
			</tr>
			<tr style="display: none">
				<td style="width:70px;text-align: right;padding-top: 13px;">部门</td>
				<td><input type="text" name="DEPARTMENT" id="DEPARTMENT" value="${pd.DEPARTMENT}" maxlength="32" placeholder="" title=""/></td>
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