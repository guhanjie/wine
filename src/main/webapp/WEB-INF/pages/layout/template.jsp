<%@ page  contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	if("/".equals(path)){
		path = "";
	}
    request.setAttribute("rootPath", path);
	request.setAttribute("resourcePath", path+"/resources");
    /* 等价于JSP中使用如下EL表达式：${pageContext.request.contextPath} */
%>
<!DOCTYPE html>
<html lang="zh-CN">
    <head>
    	<meta charset="utf-8"/>
    	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    	<meta name="keywords" content="如东，如果茶酒，商城，微信商城" />
    	<meta name="description" content="如东，如果茶酒，商城，微信商城"/>
        <title>如果茶酒商城</title>
    	<link rel="shortcut icon" type="image/x-icon" href="${resourcePath}/images/favicon.ico">
        <!--theme style-->
        <link rel="stylesheet" href="${resourcePath}/css/bootstrap.css" media="all">
        <link rel="stylesheet" href="${resourcePath}/css/style.css" media="all">
        <link rel="stylesheet" href="${resourcePath}/css/weui.min.css"/>
    	
        <!--//theme style-->
        <script src="${resourcePath}/js/jquery-1.11.3.js"></script>
        <script type="application/x-javascript">
          addEventListener("load", function() { 
              setTimeout(hideURLbar, 0); 
            }, false);
          function hideURLbar() {
              window.scrollTo(0,1); 
          } 
        </script>
        <!-- start menu -->
        <script src="${resourcePath}/js/simpleCart.min.js"> </script>
        <link rel="stylesheet" href="${resourcePath}/css/memenu.css" media="all" />
        <script src="${resourcePath}/js/memenu.js"></script>
        <script>$(document).ready(function(){$(".memenu").memenu();});</script>
        <script src="${resourcePath}/js/bootstrap.js"></script>
        <!--//start menu-->
    </head>
    <body ontouchstart>
        <t:insertAttribute name="header" />
		<t:insertAttribute name="main" />
        <t:insertAttribute name="footer" />
    </body>
</html>