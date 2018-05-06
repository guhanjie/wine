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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import top.guhanjie.wine.model.Item;
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
    
}