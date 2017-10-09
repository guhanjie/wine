<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container main">
  <ol class="breadcrumb">
    <li><a href="${pageContext.request.contextPath}/index.html">首页</a></li>
    <li class="active">订单中心</li>
  </ol>
  <div class="container order-list">
    <div class="weui_cells_title">您的订单列表</div>
    <div class="weui_cells weui_cells_access">
      <c:if test="${orders==null or empty orders}">
        <div class="weui_cell empty-list">
          <div class="weui_cell_hd">
            <i class="icon-info-sign text-blue"> </i>
          </div>
          <div class="weui_cell_bd weui_cell_primary">
            <p>您还没有创建任何订单哦~</p>
          </div>
          <div class="weui_cell_ft">
            <a class="text-primary" href="${pageContext.request.contextPath}/index">去逛逛~</a>
          </div>
        </div>
      </c:if>
      <c:if test="${not empty orders}">
        <c:forEach items="${orders}" var="order">
          <a class="weui_cell order-item" data-id="${order.id}" href="#pay">
            <div class="weui_cell_hd">
              <!-- <i class="icon-double-angle-down text-primary"> </i> -->
            </div>
            <div class="weui_cell_bd weui_cell_primary">
              <div class="weui_uploader">
                <div class="weui_uploader_hd weui_cell">
                </div>
                <div class="weui_uploader_bd">
                  <ul class="weui_uploader_files">
                    <c:forEach var="item" items="${order.itemList}">
                      <li class="weui_uploader_file" 
                        style="background-image: url(${pageContext.request.contextPath}/resources/${item.icon})">
                        <div class="item_count">${item.count}</div>
                      </li>
                    </c:forEach>
                  </ul>
                </div>
              </div>
              <p>
                订单ID： <span class="text-blue" id="start_time"> ${order.id}</span>
              </p>
              <p>
                订单金额：<span id="amount" class="text-red">${order.payAmount} 元</span>
              </p>
              <div class="order-detail">
                <p>
                创建时间： 
                  <span class="text-blue" id="start_time"> 
                    <fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss" />
                  </span>
                </p>
                <p>收货地址：${order.address}</p>
                <p>联系人：${order.contactor}</p>
                <p>联系电话：${order.phone}</p>
              </div>
            </div>
            <div class="weui_cell_ft">
              <c:choose>
                <c:when test="${order.status == 29}">
                  <span class="btn_status text-primary">已支付</span>
                </c:when>
                <c:when test="${item.status == 05}">
                    <span class="btn_status text-success">正在送货</span>
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
  <div class="weui_msg weixin_pay" style="display: none;">
    <div class="weui_icon_area">
      <i class="weui_icon_safe weui_icon_safe_success"></i>
    </div>
    <div class="weui_text_area">
      <h2 class="weui_msg_title">订单支付</h2>
      <p class="weui_msg_desc">请您完成支付，如果茶酒商城给您最好的商品和服务！</p>
      <div class="weui_cells order-item">
        <div class="weui_cell">
          <div class="weui_cell_hd">
            <p>
              <i class="weui_icon_success_circle"></i>订单金额：
            </p>
          </div>
          <div class="weui_cell_bd weui_cell_primary">
            <span id="res_amount" class="text-red"></span>
          </div>
        </div>
      </div>
    </div>
    <div class="weui_opr_area">
      <p class="weui_btn_area">
        <a href="javascript:;" class="weui_btn weui_btn_primary order-pay">微信支付</a>
      </p>
      <a class="btn_back" href="#">返回订单列表</a>
    </div>
    <div class="weui_extra_area">
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/pay.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/order_search.js"></script>