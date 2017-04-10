<%--
  Created by IntelliJ IDEA.
  User: 向敬光
  Date: 2017-04-10
  Time: 9:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>"><!-- jsp文件头和头部 -->
    <%@ include file="../../system/admin/top.jsp"%>
</head>
<body>
    <div id="dataCount" style="position: absolute;top: 100px;left: 20px;width: 100%;height: 800px;"></div>
</body>
<script src="static/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
    window.jQuery
    || document
            .write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");
</script>
<script type="text/javascript" src="static/js/echarts3/echarts.min.js"></script>
<script type="text/javascript">
    $(top.hangge());
    $(function () {
        $.ajax({
            url: 'database/getCountData',
            type: 'post',
            dataType: 'json',
            contentType: "application/json; charset=gb2312",
            success: function (data, status) {

                //console.info(data);
                var legends = new Array();
                for (var i = 0; i < data.length; i++) {
                    legends.push(data[i].name);
                }
                var myChart = echarts.init(document.getElementById('dataCount'));
                var option = {
                    title: {text: "2017年数据录入统计", x: 'center'},
                    legend: {data: legends,bottom:0},
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                            type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    toolbox: {
                        show : true,
                        feature : {
                            dataView : {show: true, readOnly: false},
                            saveAsImage : {show: true}
                        }
                    },
                    xAxis: [
                        {
                            name: '月份',
                            type: 'category',
                            data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
                            axisTick: {
                                alignWithLabel: true
                            }
                        }
                    ],
                    yAxis: [
                        {
                            name: '录入量',
                            type: 'value'
                        }
                    ],
                    series: data
                };
                myChart.setOption(option);

            }
        });
    });
</script>
</html>
