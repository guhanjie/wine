<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="${pageContext.request.contextPath}/resources/js/responsiveslides.min.js"></script>
<script>
    $(function() {
        $("#slider").responsiveSlides({
            auto : true,
            nav : true,
            speed : 500,
            namespace : "callbacks",
            pager : false,
        });
    });
</script>
<!-- search bar -->
<div class="weui-search-bar" id="item-searchBar">
    <form class="weui-search-bar__form">
        <div class="weui-search-bar__box">
            <i class="weui-icon-search"></i>
            <input type="search" class="weui-search-bar__input" placeholder="搜索想要的商品" required="">
            <a href="javascript:" class="weui-icon-clear"></a>
        </div>
        <label class="weui-search-bar__label">
            <i class="weui-icon-search"></i>
            <span>搜索</span>
        </label>
    </form>
    <a href="javascript:" class="weui-search-bar__search-btn">查询</a>
    <a href="javascript:" class="weui-search-bar__cancel-btn">取消</a>
</div>
<!-- <div class="weui-cells weui-cells_access search_show" id="item-search_show">
    <div class="weui-cell">
        <div class="weui-cell__hd">
            <p>实时搜索文本</p>
        </div>
    </div>
    ...
</div> -->
<!-- //search bar -->
<!-- slider bar -->
<div class="slider">
  <div class="callbacks_container">
    <ul class="rslides" id="slider">
      <c:forEach var="bannar" items="${bannars}" varStatus="status">
        <li>
          <div class="banner" style="background-image:url(${pageContext.request.contextPath}/resources/${bannar.img});">
            <div class="banner-info">
              <h3>${bannar.title}</h3>
              <p>${bannar.description}</p>
            </div>
          </div>
        </li>
      </c:forEach>
    </ul>
  </div>
</div>
<!-- //slider bar -->
<div class="navbar container-fluid">
  <div class="row">
    <div class="col-xs-3">
      <a class="navbar-info" href="/wine/items/1">
        <div class="navbar-img color-1">
          <span class="navbar-icon">酒</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">酒水饮料</span>
      </a>
    </div>
    <div class="col-xs-3">
      <a class="navbar-info" href="/wine/items/2">
        <div class="navbar-img color-2">
          <span class="navbar-icon">茶</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">茶叶礼品</span>
      </a>
    </div>
    <div class="col-xs-3">
      <a class="navbar-info" href="/wine/items/3">
        <div class="navbar-img color-3">
          <span class="navbar-icon">吃</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">吃货天堂</span>
      </a>
    </div>
    <div class="col-xs-3">
      <a class="navbar-info" href="/wine/items/4">
        <div class="navbar-img color-4">
          <span class="navbar-icon">家</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">家居百货</span>
      </a>
    </div>
    <div class="col-xs-3">
      <a class="navbar-info" href="/wine/items/5">
        <div class="navbar-img color-5">
          <span class="navbar-icon">数</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">手机数码</span>
      </a>
    </div>
    <div class="col-xs-3">
      <a class="navbar-info" href="/wine/items/6">
        <div class="navbar-img color-6">
          <span class="navbar-icon">电</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">电脑办公</span>
      </a>
    </div>
    <div class="col-xs-3">
      <a class="navbar-info" href="/wine/items/7">
        <div class="navbar-img color-7">
          <span class="navbar-icon">妆</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">美妆护理</span>
      </a>
    </div>
    <div class="col-xs-3">
      <a class="navbar-info" href="#">
        <div class="navbar-img color-8">
          <span class="navbar-icon">杂</span>
        </div>
        <!-- <img src="..." class="img-responsive" alt="Responsive image"> -->
        <span class="nav-title">其他</span>
      </a>
    </div>
  </div>
</div>
<!-- items -->
<div class="container-fluid items">
  <c:forEach var="category" items="${indexCategories}" varStatus="status">
    <div class="row items-sec">
      <h3><a href="${pageContext.request.contextPath}/items/${category.id}" >${category.name}</a></h3>
      <c:forEach var="item" items="${indexItems[status.index]}" varStatus="status">
        <div class="col-xs-4 feature-grid">
          <a href="item/${item.id}"><img src="${pageContext.request.contextPath}/resources/${item.icon}" alt="" />
            <div class="arrival-info">
              <h4>${item.name}</h4>
              <p class="normal_price">
                <span>会员价 </span> ￥<em>${item.normalPrice}</em>元
              </p>
              <c:if test="${user.agent}">
                <p class="agent_price">
                  <span>代理价 </span>
                  <span> ￥<em>${item.vipPrice}</em></span>
                  <span class="disc">[<fmt:formatNumber type="percent"
                      maxIntegerDigits="2" value="${item.vipPrice/item.normalPrice}" /> Off]
                  </span>
                </p>
              </c:if>
              <p class="item_sales">
                <span>已销售 </span> <em>${item.sales}</em> 件
              </p>
            </div> </a>
        </div>
      </c:forEach>
      <div class="clearfix"></div>
    </div>
  </c:forEach>
</div>
<!-- //items -->