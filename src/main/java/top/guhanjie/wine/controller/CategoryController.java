package top.guhanjie.wine.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import top.guhanjie.wine.service.CategoryService;

/**
 * Created by guhanjie on 2017-09-17.
 */
@Controller
public class CategoryController extends BaseController{

    @Autowired
    private CategoryService categoryService;

	@ResponseBody
	@RequestMapping(value="/category", method=RequestMethod.GET)
	public Map<String, Object> category(Model model) {
		return success(categoryService.listCategory());
	}
	
}
