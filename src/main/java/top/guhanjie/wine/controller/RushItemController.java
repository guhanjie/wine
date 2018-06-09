/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.controller 
 * File Name:				ItemController.java 
 * Create Date:			2017年8月20日 下午3:06:34 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import top.guhanjie.wine.model.RushItem;
import top.guhanjie.wine.service.BannarService;
import top.guhanjie.wine.service.CategoryService;
import top.guhanjie.wine.service.RushItemService;

@Controller 
public class RushItemController extends BaseController{

    @Autowired
    private BannarService bannarService;
    
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private RushItemService rushItemService;
    
    @RequestMapping(value="/rush_item/{itemId}", method=RequestMethod.GET)
    public String item(Model model, @PathVariable("itemId") Integer itemId) {
        model.addAttribute("bannars", bannarService.listBannar());
        model.addAttribute("categories", categoryService.listCategory());
        RushItem item = rushItemService.getItem(itemId);
        model.addAttribute("item", item);
        return "rush_item";
    }

	@ResponseBody
	@RequestMapping(value="/admin/rush_item/all", method=RequestMethod.GET)
	public Map<String, Object> listAllItems(Model model) {
		return success(rushItemService.listAllItems());
	}

	@ResponseBody
	@RequestMapping(value="/admin/rush_item/add", method=RequestMethod.POST, consumes="application/json")
	public Map<String, Object> addItem(@RequestBody RushItem item) {
		rushItemService.addItem(item);
		return success();
	}

	@ResponseBody
	@RequestMapping(value="/admin/rush_item/modify", method=RequestMethod.PUT, consumes="application/json")
	public Map<String, Object> modifyItem(@RequestBody RushItem item) {
		rushItemService.updateItem(item);
		return success();
	}

	@ResponseBody
	@RequestMapping(value="/admin/rush_item/delete", method=RequestMethod.DELETE, consumes="application/json")
	public Map<String, Object> deleteItem(@RequestBody RushItem item) {
		rushItemService.deleteItem(item);
		return success();
	}
}
