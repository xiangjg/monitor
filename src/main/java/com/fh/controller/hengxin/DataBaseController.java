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
public class DataBaseController extends BaseController {

    @RequestMapping(value = "/database")
    public ModelAndView database(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        mv.setViewName("hengxin/database");
        return mv;
    }


}
