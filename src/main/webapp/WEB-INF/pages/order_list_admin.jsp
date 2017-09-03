<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="keywords" content="搬家,货运,上门,服务,上海,市内搬家,同城搬家" />
<meta name="description" content="尊涵搬家服务，拉货、搬家按公里数计费，快速安全将货物送达。让用户以最经济的方式获得高质量、高性价比的同城货物运输体验。咨询热线：18916840930">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/fontawesome/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/weui/weui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order/order.css">
<title>尊涵搬家服务-订单列表</title>
</head>
<body ontouchstart>
  <div class="container order-list">
    <div class="weui_cells_title">管理后台--订单列表</div>
    <div class="weui_cells weui_cells_access">
      <c:if test="${orders==null or empty orders}">
        <div class="weui_cell">
          <div class="weui_cell_hd">
            <i class="icon-info-sign text-blue"> </i>
          </div>
          <div class="weui_cell_bd weui_cell_primary">
            <p> 您还没有创建任何订单哦~ </p>
          </div>
          <div class="weui_cell_ft">
            <a class="text-primary" href="../order">立刻去下单</a>
          </div>
        </div>
      </c:if>
      <c:if test="${not empty orders}">
        <c:forEach items="${orders}" var="item">
          <a class="weui_cell order-item" data-id="${item.id}" href="#pay">
            <div class="weui_cell_hd">
              <!-- <i class="icon-double-angle-down text-primary"> </i> -->
            </div>
            <div class="weui_cell_bd weui_cell_primary">
              <p>
                服务时间： <span class="text-blue" id="start_time"> <fmt:formatDate value="${item.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
              </p>
              <p>
                <i class="icon icon-circle-blank text-red"></i><span id="from-address">${item.from.address}</span>
                <br /> 
                <i class="icon icon-circle text-blue"></i><span id="to-address">${item.to.address}</span>
              </p>
              <div class="order-detail">
                <p>金额：<span id="amount" class="text-red">${item.amount} 元</span></p>
                <p>路程：<span id="distance">${item.distance}公里</span></p>
                <p>车型：<span id="vehicle">${item.vehicle==1?'小面车型':(item.vehicle==2)?'金杯车型':'全顺/依维柯'}</span></p>
                <p>搬家师傅：${item.workers}人</p>
                <p>联系人：${item.contactor}</p>
                <p>电话：${item.phone}</p>
              </div>
            </div>
            <div class="weui_cell_ft">
              <c:choose>
                <c:when test="${item.status == 29}">
                  <span class="btn_status text-primary">已支付</span>
                </c:when>
                <%-- <c:when test="${item.status == 05}">
                  <span class="btn_status text-success">正在送货</span>
                </c:when> --%>
                <c:when test="${item.status == 03}">
                  <span class="btn_status text-bold">已取消</span>
                </c:when>
                <c:when test="${item.status == 01}">
                  <span class="btn_success gloming">待支付</span>
                  <%-- <c:if test="${item.startTime.time - now.time > 4*60*60*1000}"> --%>
                    <span class="btn_cancel">取消</span>
                  <%-- </c:if> --%>
                </c:when>
                <c:otherwise>
                  <span class="btn_success gloming">待支付</span>
                </c:otherwise>
              </c:choose>
            </div>
          </a>
        </c:forEach>
      </c:if>
    </div>
    <div class="pagenation">
      <c:if test="${current > 0}"><a href="list?page=${current-1}"><i  class="icon-chevron-left"></i></a></c:if>      
       ${current+1} / ${pages} 
      <c:if test="${current < pages-1}"><a href="list?page=${current+1}"><i  class="icon-chevron-right"></i></a></c:if>
    </div>
  </div>
  <script src="${pageContext.request.contextPath}/resources/js/zepto/zepto-1.1.6.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/weui/weui.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/order/pay.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/order/order_search.js"></script>
</body>
</html>