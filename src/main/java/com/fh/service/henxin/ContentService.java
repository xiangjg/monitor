package com.fh.service.henxin;

import com.fh.dao.DaoSupport;
import com.fh.entity.henxin.Content;
import com.fh.entity.henxin.Report;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by 向敬光 on 2016/10/10.
 */
@Service("contentService")
public class ContentService {
    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /*
	 * 通过id获取数据
	 */
    public Report getReportInfo(Content pd) throws Exception {
        return (Report) dao.findForObject("ContentMapper.getContentInfo", pd);
    }
    /*
         * 保存
         */
    public void save(Content pd) throws Exception {
        dao.save("ContentMapper.save", pd);
    }
}
