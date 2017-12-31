package top.guhanjie.wine.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.mapper.UserMapper;
import top.guhanjie.wine.model.User;
import top.guhanjie.wine.util.TTLCache;

@Service
public class UserService {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserService.class);

	private static final TTLCache<String, User> CACHE = new TTLCache<String, User>(60 * 20); // 失效时间为20分钟

	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PointService pointService;

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
		if (StringUtils.isNumeric(str)) {
			user = userMapper.selectByPrimaryKey(Integer.parseInt(str));
			if (user == null) {
				user = userMapper.selectByPhone(str);
			}
		}
		if (user == null) {
			user = userMapper.selectLikeName("%" + str + "%");
		}
		return user;
	}

	public int addUser(User user) {
		LOGGER.debug("add user[{}]...", JSON.toJSONString(user));
		if (user.getOpenId() != null) {
			User u = userMapper.selectByOpenId(user.getOpenId());
			if (u != null) {
				LOGGER.warn("user has existed, openid:[{}]", user.getOpenId());
				return 0;
			}
		}
		user.setPoints(0);
		userMapper.insertSelective(user);
		int points = 5; // 会员注册初始送5积分
		return pointService.addPointsforSignup(user.getId(), points);
	}

	public int updateUser(User user) {
		LOGGER.debug("update user[{}]...", JSON.toJSONString(user));
		return userMapper.updateByPrimaryKeySelective(user);
	}

	public void updateToCache(User user) {
		LOGGER.debug("update user cache, user:[{}]...", JSON.toJSONString(user));
		if (user != null && StringUtils.isBlank(user.getOpenId())) {
			CACHE.put(user.getOpenId(), user);
		}
	}

	public User getFromCache(String openid) {
		LOGGER.debug("get user from cache, openid:[{}].", openid);
		return CACHE.get(openid);
	}

	public int updateUserPoint(User user) {
		LOGGER.info("add points to user[{}]...", JSON.toJSONString(user));
		User u = userMapper.selectByPrimaryKey(user.getId());
		int newPoints = user.getPoints();
		int oldPoints = u.getPoints();
		if(newPoints > oldPoints) {
			return pointService.addPointsByAdmin(user.getId(), newPoints-oldPoints);
		}
		else {
			return pointService.subPointsByAdmin(user.getId(), oldPoints-newPoints);
		}
	}
	
	public List<User> listAllNormalUsers() {
        LOGGER.info("get all normal users...");
        return userMapper.selectByType(User.TypeEnum.NORMAL.code());
	}
	
    public List<User> listAllAgentUsers() {
        LOGGER.info("get all agent users...");
        return userMapper.selectByType(User.TypeEnum.AGENT.code());
    }
}
