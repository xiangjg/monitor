package com.fh.task;
import com.fh.util.PropertiesUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by 向敬光 on 2017-01-11.
 */
@Component
public class TaskJob {

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    private SimpleDateFormat sdfDay = new SimpleDateFormat("yyyy-MM-dd");

    public void job1() {
        System.out.println(sdf.format(new Date())+":任务进行中。。。");
    }

    public void jobBackupData(){
        PropertiesUtil pr = new PropertiesUtil("dbconfig.properties");
        String username = pr.readProperty("username");
        String password = pr.readProperty("password");
        String database = pr.readProperty("jdbc.database");
        String backupPath = pr.readProperty("jdbc.backupPath");
        String serverIp = pr.readProperty("server.ip");
        String mysqkBin = pr.readProperty("mysql.bin");
        setBackupPath(backupPath);

        //验证备份文件路径
        File backFilePath = new File(backupPath);
        if(!backFilePath.exists()  && !backFilePath.isDirectory())
            backFilePath.mkdir();

        backupPath = backupPath+ File.separator+database+"_"+sdfDay.format(new Date())+".sql";

        File file = new File(backupPath);
        if(file.exists())
            file.delete();
        try{
            file.createNewFile();
        }catch (Exception e){
            writeBacklog("创建备份文件失败");
        }

        //备份mysql数据库
        Runtime runtime = Runtime.getRuntime();
        writeBacklog("备份数据库任务开始");

        String cmd = "cmd /c "+mysqkBin+"\\mysqldump -h "+serverIp+" -u"+username+" -p"+password+" --default-character-set=utf8 --single-transaction --databases "+database+" >"+backupPath;//一定要加-h localhost(或是服务器IP地址)
        try {
            writeBacklog("excute cmd:"+cmd);
            Process process = runtime.exec(cmd);

            InputStreamReader inputStreamReader = new InputStreamReader(process.getErrorStream());
            LineNumberReader lineNumberReader = new LineNumberReader(inputStreamReader);
            String line;
            while((line = lineNumberReader.readLine()) != null){
                writeBacklog("excute error message : "+line);
            }
            writeBacklog("备份成功");
        } catch (IOException e) {
            writeBacklog("备份失败");
            e.printStackTrace();
        }
        writeBacklog("备份数据库任务结束");
    }

    private void writeBacklog(String msg){
        try{
            String backLogFile = getBackupPath() + File.separator + "backlog"+File.separator+sdfDay.format(new Date())+".log";
            File file = new File(backLogFile);

            msg = sdf.format(new Date())+" : " + msg;
            FileUtils.writeByteArrayToFile(file,msg.getBytes());
        }catch (IOException ioe){
            System.out.println("写备份日志失败");
        }
    }

    private String backupPath;

    public String getBackupPath() {
        return backupPath;
    }

    public void setBackupPath(String backupPath) {
        this.backupPath = backupPath;
    }
}
