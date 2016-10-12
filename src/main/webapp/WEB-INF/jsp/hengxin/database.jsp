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
    <!-- jsp文件头和头部 -->
    <%@ include file="top.jsp"%>
</head>
<body>

<div class="container-fluid" id="main-container">


    <div id="page-content" class="clearfix">

        <div class="row-fluid">


            <div class="row-fluid">

                <!-- 检索  -->
                <form action="database.do" method="post" name="userForm" id="userForm">
                    <table>
                        <tr>
                            <td>
                                <span class="input-icon">
                                    <input autocomplete="off" id="nav-search-input" type="text" name="keyword" value="${pd.keyword }" placeholder="这里输入关键词" />
                                    <i id="nav-search-icon" class="icon-search"></i>
                                </span>
                            </td>
                            <td style="vertical-align:top;"><button class="btn btn-mini btn-light" onclick="search();" title="检索"><i id="nav-search-icon" class="icon-search"></i></button></td>
                            <td style="vertical-align:top;"><a class="btn btn-mini btn-light" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="icon-download-alt"></i></a></td>
                        </tr>
                    </table>
                    <!-- 检索  -->


                    <table id="table_report" class="table table-striped table-bordered table-hover">

                        <thead>
                        <tr>
                            <th class="center">
                                <label><input type="checkbox" id="zcheckbox" /><span class="lbl"></span></label>
                            </th>
                            <th>序号</th>
                            <th>地址</th>
                            <th>用途</th>
                            <th>面积</th>
                            <th>户型</th>
                            <th>楼层</th>
                            <th>建成年代</th>
                            <th class="center">操作</th>
                        </tr>
                        </thead>

                        <tbody>

                        <!-- 开始循环 -->
                        <c:choose>
                            <c:when test="${not empty dbList}">
                                    <c:forEach items="${dbList}" var="db" varStatus="vs">

                                        <tr>
                                            <td class='center' style="width: 30px;">
                                                <label><input type='checkbox' name='ids' value="${db.db_id }" alt="${db.db_id }"/><span class="lbl"></span></label>
                                            </td>
                                            <td class='center' style="width: 30px;">${vs.index+1}</td>
                                            <td>${db.address }</td>
                                            <td>${db.purpose }</td>
                                            <td>${db.area }</td>
                                            <td>${db.house_type }</td>
                                            <td>${db.floor }</td>
                                            <td>${db.build_year }</td>
                                            <td style="width: 60px;">
                                                <div class='hidden-phone visible-desktop btn-group'>
                                                    <a class='btn btn-mini btn-info' title="编辑" onclick="editDb('${db.db_id }');"><i class='icon-edit'></i></a>
                                                    <a class='btn btn-mini btn-danger' title="删除" onclick="delDb('${db.db_id }');"><i class='icon-trash'></i></a>
                                                </div>
                                            </td>
                                        </tr>

                                    </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr class="main_info">
                                    <td colspan="10" class="center">没有相关数据</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>


                        </tbody>
                    </table>

                    <div class="page-header position-relative">
                        <table style="width:100%;">
                            <tr>
                                <td style="vertical-align:top;">
                                    <a class="btn btn-small btn-success" onclick="add();">新增</a>
                                    <a title="批量删除" class="btn btn-small btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='icon-trash'></i></a>
                                </td>
                                <td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
                            </tr>
                        </table>
                    </div>
                </form>
            </div>




            <!-- PAGE CONTENT ENDS HERE -->
        </div><!--/row-->

    </div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->

<!-- 返回顶部  -->
<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse">
    <i class="icon-double-angle-up icon-only"></i>
</a>

<!-- 引入 -->
<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");</script>
<script src="static/js/bootstrap.min.js"></script>
<script src="static/js/ace-elements.min.js"></script>
<script src="static/js/ace.min.js"></script>

<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script><!-- 下拉框 -->
<script type="text/javascript" src="static/js/bootstrap-datepicker.min.js"></script><!-- 日期框 -->
<script type="text/javascript" src="static/js/bootbox.min.js"></script><!-- 确认窗口 -->
<!-- 引入 -->


<script type="text/javascript" src="static/js/jquery.tips.js"></script><!--提示框-->
<script type="text/javascript">

    $(top.hangge());

    //检索
    function search(){
        top.jzts();
        $("#userForm").submit();
    }

    //新增
    function add(){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="新增";
        diag.URL = '<%=basePath%>user/goAddU.do';
        diag.Width = 225;
        diag.Height = 415;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

    //修改
    function editDb(db_id){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="资料";
        diag.URL = '<%=basePath%>/database/goEdit.do?db_id='+db_id;
        diag.Width = 225;
        diag.Height = 300;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                nextPage(${page.currentPage});
            }
            diag.close();
        };
        diag.show();
    }

    //删除
    function delDb(userId,msg){
        bootbox.confirm("确定要删除["+msg+"]吗?", function(result) {
            if(result) {
                top.jzts();
                var url = "<%=basePath%>user/deleteU.do?USER_ID="+userId+"&tm="+new Date().getTime();
                $.get(url,function(data){
                    nextPage(${page.currentPage});
                });
            }
        });
    }

    //批量操作
    function makeAll(msg){
        bootbox.confirm(msg, function(result) {
            if(result) {
                var str = '';
                var emstr = '';
                var phones = '';
                for(var i=0;i < document.getElementsByName('ids').length;i++)
                {
                    if(document.getElementsByName('ids')[i].checked){
                        if(str=='') str += document.getElementsByName('ids')[i].value;
                        else str += ',' + document.getElementsByName('ids')[i].value;

                        if(emstr=='') emstr += document.getElementsByName('ids')[i].id;
                        else emstr += ';' + document.getElementsByName('ids')[i].id;

                        if(phones=='') phones += document.getElementsByName('ids')[i].alt;
                        else phones += ';' + document.getElementsByName('ids')[i].alt;
                    }
                }
                if(str==''){
                    bootbox.dialog("您没有选择任何内容!",
                            [
                                {
                                    "label" : "关闭",
                                    "class" : "btn-small btn-success",
                                    "callback": function() {
                                        //Example.show("great success");
                                    }
                                }
                            ]
                    );

                    $("#zcheckbox").tips({
                        side:3,
                        msg:'点这里全选',
                        bg:'#AE81FF',
                        time:8
                    });

                    return;
                }else{
                    if(msg == '确定要删除选中的数据吗?'){
                        top.jzts();
                        $.ajax({
                            type: "POST",
                            url: '<%=basePath%>user/deleteAllU.do?tm='+new Date().getTime(),
                            data: {USER_IDS:str},
                            dataType:'json',
                            //beforeSend: validateData,
                            cache: false,
                            success: function(data){
                                $.each(data.list, function(i, list){
                                    nextPage(${page.currentPage});
                                });
                            }
                        });
                    }else if(msg == '确定要给选中的用户发送邮件吗?'){
                        sendEmail(emstr);
                    }else if(msg == '确定要给选中的用户发送短信吗?'){
                        sendSms(phones);
                    }


                }
            }
        });
    }

</script>

<script type="text/javascript">

    $(function() {

        //日期框
        $('.date-picker').datepicker();

        //下拉框
        $(".chzn-select").chosen();
        $(".chzn-select-deselect").chosen({allow_single_deselect:true});

        //复选框
        $('table th input:checkbox').on('click' , function(){
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
                    .each(function(){
                        this.checked = that.checked;
                        $(this).closest('tr').toggleClass('selected');
                    });

        });

    });

    //导出excel
    function toExcel(){
        var USERNAME = $("#nav-search-input").val();
        var lastLoginStart = $("#lastLoginStart").val();
        var lastLoginEnd = $("#lastLoginEnd").val();
        var ROLE_ID = $("#role_id").val();
        window.location.href='<%=basePath%>user/excel.do?USERNAME='+USERNAME+'&lastLoginStart='+lastLoginStart+'&lastLoginEnd='+lastLoginEnd+'&ROLE_ID='+ROLE_ID;
    }

    //打开上传excel页面
    function fromExcel(){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="EXCEL 导入到数据库";
        diag.URL = '<%=basePath%>user/goUploadExcel.do';
        diag.Width = 300;
        diag.Height = 150;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location.reload()",100);
                }else{
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

</script>

</body>
</html>

