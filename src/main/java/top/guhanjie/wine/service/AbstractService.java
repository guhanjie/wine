package top.guhanjie.wine.service;

import org.springframework.beans.factory.annotation.Autowired;

public abstract class AbstractService {

    @Autowired
    protected CategoryService categoryService;

    public void setCategoryService(CategoryService categoryService) {
        System.err.println("=======setCategoryService");
        this.categoryService = categoryService;
    }
}
