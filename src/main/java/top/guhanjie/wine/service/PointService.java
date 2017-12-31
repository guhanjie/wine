package top.guhanjie.wine.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import top.guhanjie.wine.mapper.PointDetailMapper;
import top.guhanjie.wine.mapper.UserMapper;
import top.guhanjie.wine.model.PointDetail;
import top.guhanjie.wine.model.User;

/**
 * Created by guhanjie on 2017-09-28.
 */
@Service
public class PointService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(PointService.class);
	
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private PointDetailMapper pointDetailMapper;

	/**
	 * 会员注册，初始奖励5积分
	 */
	@Transactional
	public int addPointsforSignup(int userid, int points) {
		LOGGER.info("starting to add points[{}] to user[{}] for signup.", points, userid);
		User user = userMapper.selectByPrimaryKey(userid);
		if(user == null) {
			LOGGER.error("failed to add points to user[{}], user not exists", userid);
			return 0;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.ADD.code());
		pd.setRemark(PointDetail.RemarkEnum.USER_SIGN_UP.remark());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.addPoints(userid, points);
		if (0 == res) {
			throw new RuntimeException(
					"add points[" + points + "] to user[" + userid + "] failed, transaction rollback....");
		}
		LOGGER.info("success to add points[{}] to user[{}] for signup.", points, userid);
		return res;
	}
	
	/**
	 * 后台管理员给用户加分
	 */
	@Transactional
	public int addPointsByAdmin(int userid, int points) {
		LOGGER.info("starting to add points[{}] to user[{}] by admin.", points, userid);
		User user = userMapper.selectByPrimaryKey(userid);
		if(user == null) {
			LOGGER.error("failed to add points to user[{}], user not exists", userid);
			return 0;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.ADD.code());
		pd.setRemark(PointDetail.RemarkEnum.ADD_BY_ADMIN.remark());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.addPoints(userid, points);
		if (0 == res) {
			throw new RuntimeException(
					"add points[" + points + "] to user[" + userid + "] failed, transaction rollback....");
		}
		LOGGER.info("success to add points[{}] to user[{}] for signup.", points, userid);
		return res;
	}
	
	/**
	 * 后台管理员给用户减分
	 */
	@Transactional
	public int subPointsByAdmin(int userid, int points) {
		LOGGER.info("starting to sub points[{}] to user[{}] by admin.", points, userid);
		User user = userMapper.selectByPrimaryKey(userid);
		if(user == null) {
			LOGGER.error("failed to sub points to user[{}], user not exists", userid);
			return 0;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.SUB.code());
		pd.setRemark(PointDetail.RemarkEnum.SUB_BY_ADMIN.remark());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.subPoints(userid, points);
		if (0 == res) {
			throw new RuntimeException(
					"sub points[" + points + "] to user[" + userid + "] failed, transaction rollback....");
		}
		LOGGER.info("success to sub points[{}] to user[{}] by admin.", points, userid);
		return res;
	}
	
	/**
	 * 用户购买商品，给代理商提成加分
	 */
	@Transactional
	public int addPointsForAgent(int agentid, Integer points, int userid, int orderid, String remark) {
		LOGGER.info("starting to add points[{}] to agent[{}], promotee[{}] in order[{}].", 
		        points, agentid, userid, orderid);
		if (points != null && points == 0) {
			return 0;
		}
		User user = userMapper.selectByPrimaryKey(userid);
		if(user!=null && agentid != user.getSourceId()) {
			LOGGER.error("failed to add points, user[{}] not belog to agent[{}]", userid, agentid);
			return 0;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(agentid);
		pd.setOrderId(orderid);
		pd.setPromoteeId(userid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.ADD.code());
		pd.setRemark(remark);
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.addPoints(agentid, points);
		if (0 == res) {
			throw new RuntimeException(
					"add points[" + points + "] to user[" + agentid + "] failed, transaction rollback....");
		}
		LOGGER.info("success to add points[{}] to agent[{}], promotee[{}] in order[{}].", 
		        points, agentid, userid, orderid);
		return res;
	}

	/**
	 * 用户消费积分
	 */
	@Transactional
	public int consumePoints(Integer userid, Integer points, Integer orderid) {
		LOGGER.debug("starting to sub points[{}] to user[{}] in order[{}]...", points, userid, orderid);
		if (userid == null || points == null || orderid == null) {
			LOGGER.warn("failed to consume point, userid[{}] or orderid[{}] is null", userid, orderid);
		}
		if (points == 0) {
			LOGGER.info("points = 0, skip consume points");
			return 1;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setOrderId(orderid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.SUB.code());
		pd.setRemark(PointDetail.RemarkEnum.CONSUME.remark());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.subPoints(userid, points);
		if (0 == res) {
			throw new RuntimeException(
					"sub user[" + userid + "] points[" + points + "] failed, transaction rollback....");
		}
		LOGGER.info("success to consume points[{}] for user[{}] in order[{}]", points, userid, orderid);
		return res;
	}

	/**
	 * 订单撤销后，返还积分
	 */
	@Transactional
	public int refundPoints(Integer userid, Integer points, Integer orderid) {
		LOGGER.info("starting to refund points[{}] to user[{}] in order[{}].", points, userid, orderid);
		if (userid == null || points == null || orderid == null) {
			LOGGER.warn("failed to refund point, userid[{}] or orderid[{}] is null", userid, orderid);
		}
		if (points == 0) {
			LOGGER.info("points = 0, skip refund points");
			return 1;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setOrderId(orderid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.ADD.code());
		pd.setRemark(PointDetail.RemarkEnum.REFUND.remark());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.addPoints(userid, points);
		if (0 == res) {
			throw new RuntimeException(
					"refund points[" + points + "] to user[" + userid + "] failed, transaction rollback....");
		}
		LOGGER.info("success to refund points[{}] to user[{}] for orderid[{}].", points, userid, orderid);
		return res;
	}
}
