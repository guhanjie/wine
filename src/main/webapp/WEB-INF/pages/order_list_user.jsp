<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="main">
  <ol class="breadcrumb">
    <li><a href="${pageContext.request.contextPath}/index.html">首页</a></li>
    <li class="active">订单中心</li>
  </ol>
  <div class="order-list">
    <div class="weui-cells__title">您的订单列表</div>
    <div class="weui-cells weui-cell_access">
      <c:if test="${orders==null or empty orders}">
        <div class="weui-cell empty-list">
          <div class="weui-cell__hd">
            <i class="icon-info-sign text-blue"> </i>
          </div>
          <div class="weui-cell__bd weui-cell_primary">
            <p>您还没有创建任何订单哦~</p>
          </div>
          <div class="weui-cell__ft">
            <a class="text-primary" href="${pageContext.request.contextPath}/index">去逛逛~</a>
          </div>
        </div>
      </c:if>
      <c:if test="${not empty orders}">
        <c:forEach items="${orders}" var="order">
          <a class="weui-cell order-item" data-id="${order.id}" href="#pay">
            <div class="weui-cell__hd">
              <!-- <i class="icon-double-angle-down text-primary"> </i> -->
            </div>
            <div class="weui-cell__bd weui-cell_primary">
              <div class="weui-uploader">
                <div class="weui-uploader__hd weui-cell">
                </div>
                <div class="weui-uploader__bd">
                  <ul class="weui-uploader__files">
                    <c:forEach var="item" items="${order.itemList}">
                      <li class="weui-uploader__file" 
                        style="background-image: url(${pageContext.request.contextPath}/resources/${item.icon})">
                        <div class="item_count">${item.count}</div>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
              <p>订单ID： <span id="start_time" class="text-blue"> ${order.id}</span></p>
              <p>支付金额：<span id="amount" class="text-red">${order.payAmount}</span> 元</p>
              <div class="order-detail">
                <p>使用积分：<span id="coupons" class="text-blue">${order.coupons}</span> 分</p>
                <p>配送方式：
                  <c:choose>
                    <c:when test="${order.shipType == 1}">
                      <span>快递</span>
                    </c:when>
                    <c:when test="${order.shipType == 2}">
                      <span>同城配送</span>
                    </c:when>
                    <c:otherwise>
                      <span>快递</span>
                    </c:otherwise>
                  </c:choose>
                </p>
                <p>联系人：${order.contactor}</p>
                <p>联系电话：<span>${order.phone}</span></p>
                <p>收货地址：${order.address}</p>
                <c:if test="${order.address!=null}">
                <%-- <p class="text-red">快递单号：<span class="text-red">${order.address}</span></p> --%>
                </c:if>
                <p>创建时间： 
                  <span id="start_time"> 
                    <fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                  </span>
                </p>
              </div>
            </div>
            <div class="weui-cell__ft">
              <c:choose>
                <c:when test="${order.status == 29}">
                  <span class="btn_status text-primary">已支付</span>
                </c:when>
                <c:when test="${order.status == 13}">
                  <span class="btn_status text-success">已送达</span>
                </c:when>
                <c:when test="${order.status == 05}">
                  <span class="btn_status text-success">正在配送</span>
                </c:when>
                <c:when test="${order.status == 03}">
                  <span class="btn_status text-bold">已取消</span>
                </c:when>
                <c:when test="${order.status == 01}">
                  <span class="btn_cancel">取消</span><span>  </span>
                  <span class="btn_pay gloming">去支付</span>
                </c:when>
                <c:otherwise>
                  <span class="btn_pay gloming">去支付</span>
                </c:otherwise>
              </c:choose>
            </div>
          </a>
        </c:forEach>
      </c:if>
    </div>
  </div>
  <div class="order weui-msg weixin_pay" style="display: none;">
    <div class="weui-icon__area">
      <i class="weui-icon-success weui-icon_msg"></i>
    </div>
    <div class="weui-msg__text-area">
      <h2 class="weui-msg__title">订单支付</h2>
      <p class="weui-msg__desc">请您完成支付，如果商城给您最好的商品和服务！</p>
      <div class="weui-cells order-item">
        <div class="weui-cell">
          <div class="weui-cell__hd">
            <p>
              <i class="weui-icon-success-circle"></i>订单金额：
            </p>
          </div>
          <div class="weui-cell__bd weui-cell_primary">
            <span id="res_amount" class="text-red"></span>
          </div>
        </div>
      </div>
    </div>
    <div class="weui-msg__opr-area">
      <p class="weui-btn-area">
        <a href="javascript:;" class="weui-btn weui-btn_primary order-pay">微信支付</a>
      </p>
      <a class="btn_back" href="#">返回订单列表</a>
    </div>
    <div class="weui-msg__extra-area">
    </div>
  </div>
</div>