package com.fh.service.hengxin;

import com.fh.dao.DaoSupport;
import com.fh.entity.henxin.Content;
import com.fh.entity.henxin.Report;
import com.fh.util.PageData;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;

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
    public Content getContentInfo(Content pd) throws Exception {
        return (Content) dao.findForObject("ContentMapper.getContentInfo", pd);
    }
    public List<Content> getContent(Content pd) throws Exception {
        return (List<Content>) dao.findForList("ContentMapper.getContent", pd);
    }
    /*
         * 保存
         */
    public void save(Content pd) throws Exception {
        dao.save("ContentMapper.save", pd);
    }

    /*
        * 保存
        */
    public void saveFile(Content pd,byte[] file) throws Exception {
        FileUtils.writeByteArrayToFile(new File(pd.getPath()), file);
        dao.save("ContentMapper.save", pd);
    }
}
