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
<div class="product-model container">
  <h2>商品列表</h2>
  <div class="col-sm-12 product-model-sec">
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
        <div data-id="${item.id}" data-price="${item.vipPrice}" class="product-info simpleCart_shelfItem product-item">
          <div class="product-info-cust prt_name">
            <h4>${item.name}</h4>
            <span class="hidden item_itemid">${item.id}</span> <span class="hidden item_name">${item.name}</span> <span class="hidden item_img">${pageContext.request.contextPath}/resources/${item.icon}</span>
            <c:if test="${not user.agent}">
              <span class="item_price">￥${item.normalPrice}</span>
              <span class="hide item_normalprice">${item.normalPrice}</span>
            </c:if>
            <p class="item_sales"><span>已销售 </span> <em>${item.sales}</em> 件</p>
            <c:if test="${user.agent}">
              <span class="item_price">￥${item.vipPrice}</span>
              <div class="ofr">
                <p class="pric1">
                  原价 <strong class="item_normalprice">${item.normalPrice}</strong>
                </p>
                <span class="disc">[<fmt:formatNumber type="percent" maxIntegerDigits="2" value="${item.vipPrice/item.normalPrice}" /> Off]
                </span>
              </div>
            </c:if>
            <input type="text" class="item_quantity" value="1"> <input type="button" class="add-cart item_add" value="立即下单">
            <div class="clearfix"></div>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>
</div>
<!---->