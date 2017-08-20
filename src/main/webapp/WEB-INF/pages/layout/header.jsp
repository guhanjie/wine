<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header-top">
	 <div class="header-bottom">			
		<div class="logo">
			<h1><a href="index.html">如东茶酒商城</a></h1>					
		</div>
		 <!-- top nav bar -->		 
		 <div class="top-nav">
			<ul class="memenu skyblue">
            <li class="active"><a href="index.html">首页</a></li>
            <c:forEach  var="c1" items="${categories}" varStatus="status1">
                <li class="grid">
                  <a href="#">${c1.name}</a>
                  <div class="mepanel">
                    <div class="row">
                    <c:forEach  var="c2" items="${c1.subItems}" varStatus="status2">
                        <div class="col1 me-one">
                          <h4>${c2.name}</h4>
                          <ul>
                          <c:forEach  var="c3" items="${c2.subItems}" varStatus="status3">
                            <li><a href="product.html">${c3.name}</a></li>
                          </c:forEach>  
                          </ul>
                        </div>
                    </c:forEach>    
                    </div>
                  </div>
                </li>
            </c:forEach>			
			</ul>				
		 </div>
		 <!-- top nar bar -->
		 <div class="cart box_1">
			 <a href="checkout.html">
				<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
				<div class="total">
				<span class="simpleCart_total"></span> (<span id="simpleCart_quantity" class="simpleCart_quantity"></span>)</div>
			</a>
		 	<div class="clearfix"> </div>
		 </div>
		 <div class="clearfix"> </div>
		 <!---->			 
	 </div>
	<div class="clearfix"> </div>
</div>
<!--header-->