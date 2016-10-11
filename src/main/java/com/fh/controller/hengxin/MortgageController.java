package com.fh.controller.hengxin;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by 向敬光 on 2016/10/11.
 */
@Controller
@RequestMapping(value = "/department")
public class MortgageController extends BaseController {

    @RequestMapping(value = "/one")
    public ModelAndView one(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("hengxin/department");
        return mv;
    }
    @RequestMapping(value = "/two")
    public ModelAndView two(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("hengxin/department");
        return mv;
    }
    @RequestMapping(value = "/three")
    public ModelAndView three(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("hengxin/department");
        return mv;
    }
}
