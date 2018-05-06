package top.guhanjie.wine.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import top.guhanjie.wine.model.Category;
import top.guhanjie.wine.model.Item;
import top.guhanjie.wine.model.RushItem;
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
	    List<Category> leafC = categoryService.listLeafCategory();
	    List<Category> indexCategories = new ArrayList<Category>();
	    List<List<Item>> indexItems = new ArrayList<List<Item>>();
	    for(Category c : leafC) {
	        List<Item> list = itemService.listIndexItems(c.getId());
	        if(list!=null && !list.isEmpty()) {
	            List<Item> items = new ArrayList<Item>();
	            //只截取前3个
	            for(int i=0; i<3&&i<list.size(); i++) {
	                items.add(list.get(i));
	            }
	            indexCategories.add(c);
	            indexItems.add(items);
	        }
	    }
	    model.addAttribute("indexCategories", indexCategories);
	    model.addAttribute("indexItems", indexItems);
	    //活动商品
	    List<RushItem> ris = rushItemService.listItems();
	    model.addAttribute("rushItems", ris);
//	    List<Category> citemList = new ArrayList<Category>();
//	    Map<String, List<Item>> items = new HashMap<String, List<Item>>();
//	    Map<Integer, List<Item>> itemMaps = itemService.listIndexItems();
//	    for(Category c : cl) {
//	        if(itemMaps.containsKey(c.getId())) {
//	            citemList.add(c);
//	            items.put("cid-"+c.getId(), itemMaps.get(c.getId()));
//	        }
//	    }
//	    model.addAttribute("indexCategors", citemList);
//	    model.addAttribute("indexItems", items);
	    //model.addAttribute("whitewines", itemService.listWhiteWine());
	    //model.addAttribute("wines", itemService.listWine());
	    //model.addAttribute("beers", itemService.listBeer());
	    //model.addAttribute("rushItems", rushItemService.listRushItems());
		return "index";
	}
	
}
