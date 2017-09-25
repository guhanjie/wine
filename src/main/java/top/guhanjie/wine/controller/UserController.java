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
		//User user = userService.getUserById(1);
        User user = getSessionUser();
		model.addAttribute("user", user);
		model.addAttribute("promotees", userService.getPromotees(user.getId()));
		return "user";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/user", method=RequestMethod.GET)
	public Map<String, Object> findUser(@RequestParam("search") String str) {
		return success(userService.findUser(str));
	}
	
	@RequestMapping(value="/promote", method=RequestMethod.GET)
	public String promote(Model model) {
		//User user = userService.getUserById(1);
        User user = getSessionUser();
		model.addAttribute("user", user);
		model.addAttribute("spm", DESUtil.encrypt(DESUtil.ALGORITHOM_BLOWFISH, String.valueOf(user.getId()), AppConstants.DES_KEY));
		return "promote";
	}
}
