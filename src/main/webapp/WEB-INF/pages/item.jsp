<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link href="${pageContext.request.contextPath}/resources/css/form.css" rel="stylesheet" type="text/css" media="all" />
<link href="${pageContext.request.contextPath}/resources/css/flexslider.css" rel="stylesheet" type="text/css" media="screen" />

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
<div class="product">
  <div class="container">
    <div class="product-price1">
      <h4>${item.name}</h4>
      <div class="top-sing">
        <div class="col-md-12 single-top">
          <div class="flexslider">
            <ul class="slides">
              <c:forTokens items="${item.titleImgs}" delims="," var="titleImg">
                <li data-thumb="${pageContext.request.contextPath}/resources/${titleImg}">
                  <div class="thumb-image">
                    <img src="${pageContext.request.contextPath}/resources/${titleImg}" data-imagezoom="true" class="img-responsive" alt="" />
                  </div>
                </li>
              </c:forTokens>
            </ul>
          </div>
          <script src="${pageContext.request.contextPath}/resources/js/imagezoom.js"></script>
          <script defer src="${pageContext.request.contextPath}/resources/js/jquery.flexslider.js"></script>
          <script>
  			// Can also be used with $(document).ready()
  			$(window).load(function() {
  				$('.flexslider').flexslider({
  					animation : "slide",
  					controlNav : "thumbnails"
  				});
  			});
  		  </script>
        </div>
        <div class="col-md-5 single-top-in simpleCart_shelfItem">
          <div class="single-para">
            <div class="relative">
              <h5 class="item_price">￥ ${item.normalPrice}</h5>
              <a href="#" class="add-cart item_add">立即购买</a>
            </div>
            <div class="clear-fix"></div>
            <p class="para">${item.detail}</p>
            <div class="prdt-info-grid">
              <ul>
                <li>- 品牌 : 洋河</li>
                <li>- 商品编号 : PX3247</li>
                <li>- 生产日期 : 2017年07月12日</li>
                <li>- 度数 : 46度</li>
                <li>- 商品毛重 : 1.08kg</li>
              </ul>
            </div>
            <!-- <div class="check">
    		 <p><span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>Enter pin code for delivery &amp; availability</p>
    		 <form class="navbar-form">
    			  <div class="form-group">
    				<input type="text" class="form-control" placeholder="Enter Pin code">
    			  </div>
    			  <button type="submit" class="btn btn-default">Verify</button>
    		 </form>
    	    </div> -->
          </div>
        </div>
        <div class="clearfix"></div>
      </div>
      <section>
        <c:forTokens items="${item.detailImgs}" delims="," var="detailImg">
          <img src="${pageContext.request.contextPath}/resources/${detailImg}" class="img-responsive" alt="">
        </c:forTokens>
      </section>
    </div>
    <div class="bottom-prdt">
      <div class="btm-grid-sec">
        <h3>相关商品</h3>
        <c:forEach var="r" items="${relatives}" varStatus="status">
          <div class="col-md-2 btm-grid">
            <a href="${pageContext.request.contextPath}/item/${r.id}"> <img src="${pageContext.request.contextPath}/resources/${r.icon}"
              class="img-responsive" alt="" />
              <h4>${r.name}</h4>
              <p class="vip">
                <span>会员价 </span> ￥<em>${r.vipPrice}</em>元
              </p>
              <p class="normal">
                <span>原价 </span><span class="pric1"> ￥<del>${r.normalPrice}</del></span> <span class="disc">[<fmt:formatNumber type="percent"
                    maxIntegerDigits="2" value="${r.vipPrice/r.normalPrice}" /> Off]
                </span>
              </p>
            </a>
          </div>
        </c:forEach>
        <div class="clearfix"></div>
      </div>
    </div>
  </div>
</div>
<!---->