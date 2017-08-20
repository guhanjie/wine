package top.guhanjie.wine.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import top.guhanjie.wine.service.BannarService;
import top.guhanjie.wine.service.CategoryService;
import top.guhanjie.wine.service.ItemService;
import top.guhanjie.wine.service.RushItemService;

@Controller 
public class IndexController extends BaseController{
	
	@Autowired
	private BannarService bannarService;
	
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ItemService itemService;
    
    @Autowired
    private RushItemService rushItemService;

	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String index(Model model) {
	    model.addAttribute("bannars", bannarService.listBannar());
	    model.addAttribute("categories", categoryService.listCategory());
	    model.addAttribute("whitewines", itemService.listWhiteWine());
	    model.addAttribute("wines", itemService.listWine());
	    model.addAttribute("beers", itemService.listBeer());
	    model.addAttribute("rushItems", rushItemService.listRushItems());
		return "index";
	}
	
}
