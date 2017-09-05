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
    public int addPoints(Integer userid, Integer points, Integer promoteeId) {
		LOGGER.debug("add points[{}] to user[{}].", points, userid);
		if(points != null && points == 0) {
			return 0;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setPromoteeId(promoteeId);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.ADD.code());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.addPoints(userid, points);
		if(0 == res) {
			throw new RuntimeException("add user["+userid+"] points["+points+"] failed, transaction rollback....");
		}
		return res;
    }
    
    @Transactional
    public int consumePoints(Integer userid, Integer points, Integer orderId) {
		LOGGER.debug("sub points[{}] to user[{}].", points, userid);
		if(points != null && points == 0) {
			return 0;
		}
		PointDetail pd = new PointDetail();
		pd.setUserId(userid);
		pd.setOrderId(orderId);
		pd.setPoints(points);
		pd.setType(PointDetail.TypeEnum.SUB.code());
		pointDetailMapper.insertSelective(pd);
		int res = userMapper.subPoints(userid, points);
		if(0 == res) {
			throw new RuntimeException("sub user["+userid+"] points["+points+"] failed, transaction rollback....");
		}
		return res;
    }
}
