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

<!-- items -->
<div class="items">
  <div class="container items-sec">
    <h3>国酒典藏</h3>
    <c:forEach var="white" items="${whitewines}" varStatus="status">
      <div class="col-md-3 feature-grid">
        <a href="item/${white.id}"><img src="${pageContext.request.contextPath}/resources/${white.icon}" alt="" />
          <div class="arrival-info">
            <h4>${white.name}</h4>
            <p class="vip">
              <span>会员价 </span> ￥<em>${white.vipPrice}</em>元
            </p>
            <p class="normal">
              <span>原价 </span><span class="pric1"> ￥<del>${white.normalPrice}</del></span> <span class="disc">[<fmt:formatNumber type="percent"
                  maxIntegerDigits="2" value="${white.vipPrice/white.normalPrice}" /> Off]
              </span>
            </p>
          </div> </a>
      </div>
    </c:forEach>
    <div class="clearfix"></div>
  </div>
  <div class="container items-sec">
    <h3>精美红酒系列</h3>
    <c:forEach var="wine" items="${wines}" varStatus="status">
      <div class="col-md-3 feature-grid">
        <a href="item/${wine.id}"><img src="${pageContext.request.contextPath}/resources/${wine.icon}" alt="" />
          <div class="arrival-info">
            <h4>${wine.name}</h4>
            <p class="vip">
              <span>会员价 </span> ￥<em>${wine.vipPrice}</em>元
            </p>
            <p class="normal">
              <span>原价 </span><span class="pric1"> ￥<del>${wine.normalPrice}</del></span> <span class="disc">[<fmt:formatNumber type="percent"
                  maxIntegerDigits="2" value="${wine.vipPrice/wine.normalPrice}" /> Off]
              </span>
            </p>
          </div> </a>
      </div>
    </c:forEach>
    <div class="clearfix"></div>
  </div>
  <div class="container items-sec">
    <h3>沁爽啤酒系列</h3>
    <c:forEach var="beer" items="${beers}" varStatus="status">
      <div class="col-md-3 feature-grid">
        <a href="item/${beer.id}"><img src="${pageContext.request.contextPath}/resources/${beer.icon}" alt="" />
          <div class="arrival-info">
            <h4>${beer.name}</h4>
            <p class="vip">
              <span>会员价 </span> ￥<em>${beer.vipPrice}</em>元
            </p>
            <p class="normal">
              <span>原价 </span><span class="pric1"> ￥<del>${beer.normalPrice}</del></span> <span class="disc">[<fmt:formatNumber type="percent"
                  maxIntegerDigits="2" value="${beer.vipPrice/beer.normalPrice}" /> Off]
              </span>
            </p>
          </div> </a>
      </div>
    </c:forEach>
    <div class="clearfix"></div>
  </div>
</div>
<!---->
<div class="offers">
  <div class="container">
    <h3>『 一 · 元 · 购 』</h3>
    <div class="offer-grids">
      <c:forEach var="rush" items="${rushItems}" varStatus="status">
        <div class="col-md-6">
          <a href="#">
            <div class="offer-grid">
              <div class="ofr-pic">
                <img src="${pageContext.request.contextPath}/resources/${rush.icon}" class="img-responsive center-block" alt="" />
              </div>
              <div class="ofr-pic-info pull-right text-right">
                <h4>一元抢购 · ${rush.name}</h4>
                <p class="status">
                  已抢购 <span>${rush.counts}</span> 份，<span>${rush.buyers}</span> 人参加
                </p>
                <p class="buy">立即抢购</p>
              </div>
              <div class="clearfix"></div>
            </div>
          </a>
        </div>
      </c:forEach>
      <div class="clearfix"></div>
    </div>
  </div>
</div>
<!---->