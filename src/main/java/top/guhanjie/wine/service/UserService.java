package top.guhanjie.wine.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.mapper.PointDetailMapper;
import top.guhanjie.wine.mapper.UserMapper;
import top.guhanjie.wine.model.Order;
import top.guhanjie.wine.model.PointDetail;
import top.guhanjie.wine.model.User;
import top.guhanjie.wine.util.TTLCache;

@Service
public class UserService {	

	private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);
	
	private static final TTLCache<String, User> CACHE = new TTLCache<String, User>(60 * 20); //失效时间为20分钟
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PointDetailMapper pointDetailMapper;
	
	public List<User> getPromotees(int id) {
		LOGGER.debug("get users promoted by user id[{}]...", id);
		return userMapper.selectBySourceId(id);
	}
	
	public User getUserById(int id) {
		LOGGER.debug("get user by id[{}]...", id);
		return userMapper.selectByPrimaryKey(id);
	}
	
	public User getUserByOpenId(String openid) {
		LOGGER.debug("get user by open id[{}]...", openid);
		return userMapper.selectByOpenId(openid);
	}
	
   public User getUserByPhone(String phone) {
        LOGGER.debug("get user by phone[{}]...", phone);
        return userMapper.selectByPhone(phone);
    }
	
   /**
    * 查找用户（按id、名字、手机号码）
    */
   public User findUser(String str) {
	   User user = null;
	   if(StringUtils.isNumeric(str)) {
		   user = userMapper.selectByPrimaryKey(Integer.parseInt(str));
		   if(user == null) {
			   user = userMapper.selectByPhone(str);
		   }
	   }
	   if(user == null) {
		   user = userMapper.selectLikeName("%"+str+"%");
	   }
	   return user;
   }
   
	public int addUser(User user) {
		LOGGER.debug("add user[{}]...", JSON.toJSONString(user));
	    if(user.getOpenId() != null) {
	        User u = userMapper.selectByOpenId(user.getOpenId());
	        if(u != null) {
	            LOGGER.warn("user has existed, openid:[{}]", user.getOpenId());
	            return 0;
	        }
	    }
		return userMapper.insertSelective(user);
	}

    public int updateUser(User user) {
		LOGGER.debug("update user[{}]...", JSON.toJSONString(user));
        return userMapper.updateByPrimaryKeySelective(user);
    }
    
    public void updateToCache(User user) {
		LOGGER.debug("update user cache, user:[{}]...", JSON.toJSONString(user));
        if(user != null && StringUtils.isBlank(user.getOpenId())) {
            CACHE.put(user.getOpenId(), user);
        }            
    }
    
    public User getFromCache(String openid) {
		LOGGER.debug("get user from cache, openid:[{}].", openid);
        return CACHE.get(openid);
    }
    
    @Transactional
    public int addPoints(Integer userid, Integer points, Integer promoteeid) {
		LOGGER.debug("starting to add points[{}] to user[{}] for promoteeid[{}].", points, userid, promoteeid);
		if(points != null && points == 0) {
			return 0;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setPromoteeId(promoteeid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.ADD.code());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.addPoints(userid, points);
		if(0 == res) {
			throw new RuntimeException("add points["+points+"] to user["+userid+"] failed, transaction rollback....");
		}
		LOGGER.info("success to consume points[{}] to user[{}] for promoteeid[{}].", points, userid, promoteeid);
		return res;
    }
    
    @Transactional
    public int consumePoints(Integer userid, Integer points, Integer orderid) {
		LOGGER.debug("starting to sub points[{}] to user[{}] in order[{}]...", points, userid, orderid);
		if(userid == null || points == null || orderid == null) {
			LOGGER.warn("can not consume point, params is null");
		}
		if(points == 0) {
			LOGGER.info("points = 0, skip consume points");
			return 1;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setOrderId(orderid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.SUB.code());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.subPoints(userid, points);
		if(0 == res) {
			throw new RuntimeException("sub user["+userid+"] points["+points+"] failed, transaction rollback....");
		}
		LOGGER.info("success to consume points[{}] to user[{}] in order[{}]", points, userid, orderid);
		return res;
    }
    
    public int refundPoints(Integer userid, Integer points, Integer orderid) {
    	LOGGER.info("starting to refund points[{}] to user[{}] in order[{}].", points, userid, orderid);
		if(userid == null || points == null || orderid == null) {
			LOGGER.warn("can not refund point, params is null");
		}
		if(points == 0) {
			LOGGER.info("points = 0, skip refund points");
			return 1;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setOrderId(orderid);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.ADD.code());
		pd.setRemark("refund");
		pointDetailMapper.insertSelective(pd);
    	int res = userMapper.addPoints(userid, points);
    	if(0 == res) {
			throw new RuntimeException("refund points["+points+"] to user["+userid+"] failed, transaction rollback....");
		}
		LOGGER.info("success to refund points[{}] to user[{}] for orderid[{}].", points, userid, orderid);
		return res;
    }
}
