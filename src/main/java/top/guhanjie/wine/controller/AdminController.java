package top.guhanjie.wine.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import top.guhanjie.wine.service.CategoryService;

/**
 * Created by guhanjie on 2017-09-17.
 */
@Controller 
@RequestMapping("/admin")
public class AdminController extends BaseController{

    @Autowired
    private CategoryService categoryService;
    
	@RequestMapping(value="", method=RequestMethod.GET)
	public String admin(Model model) {
		return "admin";
	}
	
}
