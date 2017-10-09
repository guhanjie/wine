package top.guhanjie.wine.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import top.guhanjie.wine.model.User;
import top.guhanjie.wine.service.UserService;
import top.guhanjie.wine.util.DESUtil;

/**
 * Created by guhanjie on 2017-08-27.
 */
@Controller 
public class UserController extends BaseController{
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/user", method=RequestMethod.GET)
	public String getUser(Model model) {
        User user = getSessionUser();
        if(user != null && user instanceof User) {
             Integer userid = ((User)user).getId();
             user = userService.getUserById(userid);
        }
        else {
            String openid = (String)request.getSession().getAttribute(AppConstants.SESSION_KEY_OPEN_ID);
            user = userService.getUserByOpenId(openid);
        }
		model.addAttribute("user", user);
		model.addAttribute("promotees", userService.getPromotees(user.getId()));
		return "user";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/user", method=RequestMethod.GET)
	public Map<String, Object> findUser(@RequestParam("search") String str) {
		return success(userService.findUser(str));
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/user/points", method=RequestMethod.PUT)
	public Map<String, Object> updateUserPoints(@RequestParam("id") Integer userid, @RequestParam("points")Integer points) {
	    LOGGER.info("update user[{}] points[{}]", userid, points);
	    User user = new User();
		user.setId(userid);
		user.setPoints(points);
		userService.updateUserPoint(user);
		LOGGER.debug("refresh session for user[{}]", JSON.toJSONString(user));
		user = userService.getUserById(userid);
		setSessionUser(user);
		return success();
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/user/type", method=RequestMethod.PUT)
	public Map<String, Object> updateUserType(@RequestParam("id") Integer userid, @RequestParam("type")Integer type) {
	    LOGGER.info("update user[{}] type[{}]", userid, type);
	    User user = new User();
		user.setId(userid);
		user.setType(type);
		userService.updateUser(user);
        LOGGER.debug("refresh session for user[{}]", JSON.toJSONString(user));
        user = userService.getUserById(userid);
        setSessionUser(user);
        return success();
	}
	
	@RequestMapping(value="/promote", method=RequestMethod.GET)
	public String promote(Model model) {
        User user = getSessionUser();
		model.addAttribute("user", user);
		model.addAttribute("spm", DESUtil.encrypt(DESUtil.ALGORITHOM_BLOWFISH, String.valueOf(user.getId()), AppConstants.DES_KEY));
		return "promote";
	}
}
