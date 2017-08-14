package top.guhanjie.wine.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import top.guhanjie.wine.service.BannarService;

@Controller 
public class IndexController extends BaseController{
	
	@Autowired
	private BannarService bannarService;

	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String index(Model model) {
	    model.addAttribute("bannars", bannarService.listBannar());
		return "index";
	}
	
}
