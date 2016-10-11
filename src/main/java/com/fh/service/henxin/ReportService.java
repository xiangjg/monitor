package com.fh.service.henxin;

import com.fh.dao.DaoSupport;
import com.fh.entity.henxin.Report;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by 向敬光 on 2016/10/10.
 */
@Service("reportService")
public class ReportService {
    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /*
	 * 通过id获取数据
	 */
    public Report getReportInfo(Report pd) throws Exception {
        return (Report) dao.findForObject("ReportMapper.getReportInfo", pd);
    }
    /*
         * 保存
         */
    public void save(Report pd) throws Exception {
        dao.save("ReportMapper.save", pd);
    }

    public void deleteByPrimaryKey(Integer id) throws Exception {
        dao.delete("ReportMapper.deleteByPrimaryKey", id);
    }

    public void insertSelective(Report pd) throws Exception {
        dao.save("ReportMapper.insertSelective", pd);
    }

    public void updateByPrimaryKeySelective(Report pd) throws Exception {
        dao.save("ReportMapper.updateByPrimaryKeySelective", pd);
    }
    public void updateByPrimaryKey(Report pd) throws Exception {
        dao.save("ReportMapper.updateByPrimaryKey", pd);
    }
}
