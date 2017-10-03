<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container">
  <div class="page-header">
    <h1 class="text-success">
      推荐送积分！<small></small>
    </h1>
  </div>
  <div class="promotion">
    <div class="jumbotron">
      <h4 class="text-info">推荐好友成为会员，即可返送积分</h4>
      <p class="bg-warning"></p>
      <div class="alert alert-warning" role="alert">
        <strong>活动规则如下：</strong>
        <ol>
          <li>进入微信公众号，点击左下角“推广会员”，获取推广二维码</li>
          <li>手机长按该二维码，在弹出菜单中，选择“发送给好友”</li>
          <li>好友收到消息，长按扫描推广码，并关注该微信公众号，即可显示推荐成功</li>
          <li>推荐人可以在自己的“个人中心”菜单中看到自己推荐成功的会员</li>
          <li>如果您成为代理商后，会员每一笔消费，您都将获得对应的代理提成，以积分返送到您账户</li>
          <li>积分兑换比率是1积分=1元，您可以直接使用推广得到的积分消费抵现</li>
        </ol>
      </div>
      <span class="label label-warning">您的专属推广链接：</span>
      <p></p>
      <h5 class="text-success">http://www.guhanjie.top/wine/s/${spm}</h5>
    </div>
  </div>
</div>