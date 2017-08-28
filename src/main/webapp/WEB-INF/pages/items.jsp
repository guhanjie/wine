<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- item -->
<ol class="breadcrumb">
  <li><a href="${pageContext.request.contextPath}/index">首页</a></li>
  <c:forEach var="category" items="${categorySeq}" varStatus="status">
    <c:if test="${status.index < fn:length(categorySeq)-1}">
      <li>${category.name}</li>
    </c:if>
    <c:if test="${status.index == fn:length(categorySeq)-1}">
      <li class="active">${category.name}</li>
    </c:if>
  </c:forEach>
</ol>
<!--breadcrumb//-->
<div class="product-model">
  <div class="container">
    <h2>商品列表</h2>
    <div class="col-md-12 product-model-sec">
      <c:forEach var="item" items="${items}" varStatus="status">
        <div class="product-grid">
          <a href="${pageContext.request.contextPath}/item/${item.id}">
            <div class="more-product">
              <span> </span>
            </div>
            <div class="product-img b-link-stripe b-animate-go  thickbox">
              <img src="${pageContext.request.contextPath}/resources/${item.icon}" class="img-responsive" alt="">
            </div>
          </a>
          <div class="product-info simpleCart_shelfItem">
            <div class="product-info-cust prt_name">
              <h4>${item.name}</h4>
              <span class="item_price">￥${item.vipPrice}</span>
              <div class="ofr">
                <p class="pric1">
                  原价
                  <del>${item.normalPrice}</del>
                </p>
                <p class="disc">[12% Off]</p>
              </div>
              <input type="text" class="item_quantity" value="1"> 
              <input id="showToast" type="button" class="item_add" value="立即下单">
              <div class="clearfix"></div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
<!---->