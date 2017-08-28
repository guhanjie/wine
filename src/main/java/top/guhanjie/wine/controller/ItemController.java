/** 
 * Project Name:			wine 
 * Package Name:		top.guhanjie.wine.controller 
 * File Name:				ItemController.java 
 * Create Date:			2017年8月20日 下午3:06:34 
 * Author:					Administrator
 * Copyright (c) 2014-2017, guhanjie All Rights Reserved.
 */  
package top.guhanjie.wine.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.service.BannarService;
import top.guhanjie.wine.service.CategoryService;
import top.guhanjie.wine.service.ItemService;

@Controller 
public class ItemController extends BaseController{

    @Autowired
    private BannarService bannarService;
    
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ItemService itemService;
    
    @RequestMapping(value="/item/{itemId}", method=RequestMethod.GET)
    public String item(Model model, @PathVariable("itemId") Integer itemId) {
        model.addAttribute("bannars", bannarService.listBannar());
        model.addAttribute("categories", categoryService.listCategory());
        Item item = itemService.getItem(itemId);
        model.addAttribute("categorySeq", categoryService.getCategorySequence(item.getCategoryId()));
        model.addAttribute("item", item);
        model.addAttribute("relatives", itemService.getRelativeItems(item.getCategoryId()));
        return "item";
    }
    
    @RequestMapping(value="/items/{categoryId}", method=RequestMethod.GET)
    public String items(Model model, @PathVariable("categoryId") Integer categoryId) {
        model.addAttribute("bannars", bannarService.listBannar());
        model.addAttribute("categories", categoryService.listCategory());
        model.addAttribute("categorySeq", categoryService.getCategorySequence(categoryId));
        model.addAttribute("items", itemService.getRelativeItems(categoryId));
        return "items";
    }
}
