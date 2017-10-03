<%@ page  contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ page import="top.guhanjie.wine.model.User" %> --%>
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
    	<link rel="shortcut icon" type="image/x-icon" href="${resourcePath}/images/favicon.ico"/>
        <!--theme style-->
        <link rel="stylesheet" href="${resourcePath}/css/bootstrap.css" media="all"/>
        <link rel="stylesheet" href="${resourcePath}/css/style.css" media="all"/>
        <link rel="stylesheet" href="${resourcePath}/css/font-awesome.css" media="all"/>
        <link rel="stylesheet" href="${resourcePath}/css/weui-0.4.3.min.css" media="all"/>
        <link rel="stylesheet" href="${resourcePath}/css/memenu.css" media="all" />
        <link rel="stylesheet" href="${resourcePath}/css/order.css">
        <!--//theme style-->
        <script type="text/javascript">
          //Globals
          ships = 6;
        </script>
        <script src="${resourcePath}/js/jquery-1.11.3.js"></script>
        <script type="application/x-javascript">
          addEventListener("load", function() { 
              setTimeout(hideURLbar, 0); 
            }, false);
          function hideURLbar() {
              window.scrollTo(0,1); 
          } 
        </script>
        <script src="${resourcePath}/js/simpleCart.min.js"> </script>
        <script type="text/javascript">
        simpleCart({
            cartColumns: [
                /* { attr: "name" , label: "Name" } ,
                { attr: "price" , label: "Price", view: 'currency' } ,
                { view: "decrement" , label: false , text: "-" } ,
                { attr: "quantity" , label: "Qty" } ,
                { view: "increment" , label: false , text: "+" } ,
                { attr: "total" , label: "SubTotal", view: 'currency' } , */
                { view: function(item, column){
                    return  '<div class="cart-header" data-id="'+item.name()+'">'+
                              '<div class="cart-sec simpleCart_shelfItem">'+
                                '<div class="cart-item cyc">'+
                                  '<img src="'+item.get("img")+'" class="img-responsive" alt="" />'+
                                '</div>'+
                                '<div class="cart-item-info">'+
                                  '<h3>'+
                                    '<a href="../item/'+item.itemid()+'">'+item.name()+'</a>'+
                                    '<span> </span>'+
                                  '</h3>'+
                                  '<ul class="qty">'+
                                    '<li>'+
                                      '<p>单价 : <span>'+item.price()+'</span>元</p>'+
                                    '</li>'+
                                    '<li>'+
                                      '<div class="item-decrement"><a href="javascript:;" class="simpleCart_decrement">-</a></div>'+
                                    '</li>'+
                                    '<li>'+
                                      '<p>数量 : <span>'+item.quantity()+'</span></p>'+
                                    '</li>'+
                                    '<li>'+
                                      '<div class="item-increment"><a href="javascript:;" class="simpleCart_increment">+</a></div>'+
                                    '</li>'+
                                  '</ul>'+
                                '</div>'+
                                '<div class="simpleCart_remove item-remove">'+
                                  '<a href="javascript:;" class="simpleCart_remove"></a>'+
                                '</div>'+
                                '<div class="clearfix"></div>'+
                              '</div>'+
                            '</div>'
                    } , 
                    attr: "custom" }
            ]
        });
        </script>
        <!-- start menu -->
        <script src="${resourcePath}/js/memenu.js"></script>
        <script>$(document).ready(function(){$(".memenu").memenu();});</script>
        <!--//start menu-->
        <script src="${resourcePath}/js/bootstrap.js"></script>
        <script src="${resourcePath}/js/weui-0.3.0.js"></script>
    </head>
    <body ontouchstart>
        <t:insertAttribute name="header" />
		<t:insertAttribute name="main" />
        <t:insertAttribute name="footer" />
        <script src="${resourcePath}/js/order.js"></script>
        <script src="${resourcePath}/js/pay.js"></script>
    </body>
</html>