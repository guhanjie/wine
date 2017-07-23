package top.guhanjie.wine.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import top.guhanjie.wine.service.UserService;


@Controller 
public class HomeController extends BaseController{
	
	@Autowired
	private UserService userService;

//	@RequestMapping(value="/index", method=RequestMethod.GET)
//	public String index() {
//		return "index";
//	}
	
}
