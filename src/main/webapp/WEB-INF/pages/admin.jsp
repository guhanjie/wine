<%@ page  contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>管理控制台</title>
    <!-- 引入 WeUI -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/weui-1.1.2.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css"/>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-1.11.3.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/weui-1.1.2.js"> </script>
</head>
<body ontouchstart>
<p id="bear"></p>
<div class="weui-tab" id="tab">
    <div class="weui-navbar">
        <div class="weui-navbar__item">商品管理</div>
        <div class="weui-navbar__item">订单管理</div>
        <div class="weui-navbar__item">会员管理</div>
        <div class="weui-navbar__item">其它</div>
    </div>
    <div class="weui-tab__panel">
        <div class="weui-tab__content">
            <div id="item-list">
              <div class="weui-cells__title">管理后台--商品列表</div>
              <div class="weui-grids"></div>
              <a id="add-item" class="weui-footer_fixed-bottom weui-btn weui-btn_primary">添加商品</a>
            </div>
            <div id="item-form">
                <div class="weui-cells__title">管理后台--商品信息</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">商品名称</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="text" name="name" required maxlength="100" placeholder="输入商品名称" emptyTips="请输入商品名称" notMatchTips="商品名称不超过100字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">详情描述</label></div>
                        <div class="weui-cell__bd">
                           <textarea class="weui-textarea" name="detail" required maxlength="200" rows="3" placeholder="请输入商品详情描述"></textarea>
                           <div class="weui-textarea-counter">
                               <span id="detail_count">0</span>/200
                           </div>
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">商品类目</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="text" id="category" name="categoryId" required placeholder="选择商品类目" emptyTips="请选择商品类目" notMatchTips="选择合适的商品类目">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">普通价格</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="normalPrice" required pattern="^\d+(\.\d+)?$" maxlength="10" placeholder="输入普通价格" emptyTips="请输入普通价格" notMatchTips="普通价格只能输入数字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                            <span class="price">元</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">会员价格</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="vipPrice" required pattern="^\d+(\.\d+)?$" maxlength="10" placeholder="输入会员价格" emptyTips="请输入会员价格" notMatchTips="会员价格只能输入数字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                            <span class="price">元</span>
                        </div>
                    </div>
                    <div class="weui-cell">
                        <div class="weui-cell__hd"><label class="weui-label">商品销量</label></div>
                        <div class="weui-cell__bd">
                            <input class="weui-input" type="number" name="sales" pattern="^\d+$" maxlength="10" placeholder="输入商品销量" emptyTips="请输入商品销量" notMatchTips="商品销量只能输入数字">
                        </div>
                        <div class="weui-cell__ft">
                            <i class="weui-icon-warn"></i>
                        </div>
                    </div>
                </div> 
                <div class="weui-cells__title">商品图片</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell" id="icon-uploader">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader">
                                <div class="weui-uploader__hd">
                                    <p class="weui-uploader__title">商品缩略图</p>
                                    <div class="weui-uploader__info"><span id="iconCount">0</span>/1</div>
                                </div>
                                <div class="weui-uploader__bd">
                                    <ul class="weui-uploader__files" id="iconFiles"></ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="icon" class="weui-uploader__input" type="file" accept="image/*" capture="camera"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell" id="title_imgs-uploader">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader">
                                <div class="weui-uploader__hd">
                                    <p class="weui-uploader__title">商品预览图片</p>
                                    <div class="weui-uploader__info"><span id="titleImgsCount">0</span>/6</div>
                                </div>
                                <div class="weui-uploader__bd">
                                    <ul class="weui-uploader__files" id="titleImgsFiles"></ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="titleImgs" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple="multiple"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="weui-cell" id="detail_imgs-uploader">
                        <div class="weui-cell__bd">
                            <div class="weui-uploader">
                                <div class="weui-uploader__hd">
                                    <p class="weui-uploader__title">商品详情图片</p>
                                    <div class="weui-uploader__info"><span id="detailImgsCount">0</span>/20</div>
                                </div>
                                <div class="weui-uploader__bd">
                                    <ul class="weui-uploader__files" id="detailImgsFiles"></ul>
                                    <div class="weui-uploader__input-box">
                                        <input id="detailImgs" class="weui-uploader__input" type="file" accept="image/*" capture="camera" multiple="multiple"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="weui-cells__title">商品状态</div>
                <div class="weui-cells weui-cells_form">
                    <div class="weui-cell weui-cell_switch">
                        <div class="weui-cell__bd">商品上架</div>
                        <div class="weui-cell__ft">
                            <input class="weui-switch" name="state" value="1" checked="" type="checkbox">
                        </div>
                    </div>
                </div>
                <div class="weui-btn-area">
                    <a id="formSubmitBtn" href="javascript:" class="weui-btn weui-btn_primary">提交</a>
                </div>
            </div>
        </div>
        <div class="weui-tab__content">
          <div class="order-list">
            <div class="weui-cells__title">管理后台--订单列表</div>
            <div class="weui-cells weui-cells_access"></div>
            <div class="pagenation"></div>
          </div>
        </div>
        <div class="weui-tab__content">
          <div class="weui-cells__title">管理后台--用户信息</div>
          <div class="weui-search-bar" id="user-searchBar">
              <form class="weui-search-bar__form">
                  <div class="weui-search-bar__box">
                      <i class="weui-icon-search"></i>
                      <input type="search" class="weui-search-bar__input" placeholder="可输入用户名或手机号或用户id" required="">
                      <a href="javascript:" class="weui-icon-clear"></a>
                  </div>
                  <label class="weui-search-bar__label">
                      <i class="weui-icon-search"></i>
                      <span>用户搜索</span>
                  </label>
              </form>
              <a href="javascript:" class="weui-search-bar__search-btn">查询</a>
              <a href="javascript:" class="weui-search-bar__cancel-btn">取消</a>
          </div>
          <div id="user-form">
              <div class="weui-cells weui-cells_form">
                  <div class="weui-cell">
                      <div class="weui-cell__hd"><label class="weui-label">用户名</label></div>
                      <div class="weui-cell__bd">
                          <input class="weui-input" type="text" name="name" disabled>
                      </div>
                      <div class="weui-cell__ft">
                          <i class="weui-icon-warn"></i>
                      </div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__hd"><label class="weui-label">手机号码</label></div>
                      <div class="weui-cell__bd">
                          <input class="weui-input" type="text" name="phone" disabled>
                      </div>
                      <div class="weui-cell__ft">
                          <i class="weui-icon-warn"></i>
                      </div>
                  </div>
                  <div class="weui-cell">
                      <div class="weui-cell__hd"><label class="weui-label">用户积分</label></div>
                      <div class="weui-cell__bd">
                          <input class="weui-input" type="number" name="points" disabled>
                      </div>
                      <div class="weui-cell__ft">
                          <i class="weui-icon-warn"></i>
                      </div>
                  </div>
                  <div class="weui-cell weui-cell_switch">
                      <div class="weui-cell__hd"><label class="weui-label">用户类型</label></div>
                      <div class="weui-cell__bd text-center">
                        <input id="user-normal" class="weui-input" type="text" style="display:none" value="普通用户" disabled>
                        <input id="user-vip" class="weui-input" type="text" style="display:none" value="会员" disabled>
                      </div>
                      <div class="weui-cell__ft">
                          <input id="user-type" class="weui-switch" type="checkbox">
                      </div>
                  </div>
              </div>
          </div>
        </div>
        <div class="weui-tab__content">
            <div class="item">
                <h4 class="item__title">搜索框</h4>
                <div class="weui-search-bar" id="searchBar">
                    <form class="weui-search-bar__form">
                        <div class="weui-search-bar__box">
                            <i class="weui-icon-search"></i>
                            <input type="search" class="weui-search-bar__input" placeholder="搜索" required="">
                            <a href="javascript:" class="weui-icon-clear"></a>
                        </div>
                        <label class="weui-search-bar__label">
                            <i class="weui-icon-search"></i>
                            <span>搜索</span>
                        </label>
                    </form>
                    <a href="javascript:" class="weui-search-bar__cancel-btn">取消</a>
                </div>
            </div>
            <div class="item">
                <h4 class="item__title">滑块</h4>
                <div class="item__ctn">
                    <div class="weui-slider-box">
                        <div id="slider" class="weui-slider">
                            <div class="weui-slider__inner">
                                <div class="weui-slider__track"></div>
                                <div class="weui-slider__handler"></div>
                            </div>
                        </div>
                        <div id="sliderValue" class="weui-slider-box__value"></div>
                    </div>
                </div>
            </div>
            <div class="item">
                <h4 class="item__title">滑块(step=10)</h4>
                <div class="item__ctn">
                    <div class="weui-slider-box">
                        <div id="sliderStep" class="weui-slider">
                            <div class="weui-slider__inner">
                                <div class="weui-slider__track"></div>
                                <div class="weui-slider__handler"></div>
                            </div>
                        </div>
                        <div id="sliderStepValue" class="weui-slider-box__value"></div>
                    </div>
                </div>
            </div>
            <div class="item">
                <h4 class="item__title">滑块(分3步)</h4>
                <div class="item__ctn">
                    <div class="weui-slider-box">
                        <div id="sliderBlock" class="weui-slider">
                            <div class="weui-slider__inner">
                                <div class="weui-slider__track"></div>
                                <div class="weui-slider__handler"></div>
                            </div>
                        </div>
                        <div id="sliderBlockValue" class="weui-slider-box__value"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/admin.js"> </script>
</body>
</html>