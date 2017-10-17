package com.fh.task;
import com.fh.util.PropertiesUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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

            //为了避免备份文件过多，删除前一个月以前的数据，前提：存在最新数据
            if(file.exists()&&file.isFile()&&file.length()>0){
                File[] allBackFile = backFilePath.listFiles();
                Calendar c = Calendar.getInstance();
                Calendar now = Calendar.getInstance();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String logDir = "";
                for(int i=0;i<allBackFile.length;i++){
                    File bFile = allBackFile[i];
                    String name = bFile.getName();
                    if(name.indexOf("numysql_")>-1){
                        name = name.replaceAll("numysql_","").replaceAll(".sql","");
                        c.setTime(sdf.parse(name));
                        if(c.get(Calendar.MONTH)!=now.get(Calendar.MONTH)){
                            writeBacklog("清理历史备份文件："+bFile.getPath());
                            //bFile.delete();
                            File bLogFile = new File(logDir+File.separator+bFile.getName().replaceAll("numysql_","").replaceAll("sql","log"));
                            writeBacklog("清理历史备份日志文件："+bLogFile.getPath());
                            //bLogFile.delete();
                        }
                    }else{
                        logDir = bFile.getPath();
                    }
                }
            }
        } catch (Exception e) {
            writeBacklog("备份失败");
            e.printStackTrace();
        }
        writeBacklog("备份数据库任务结束");
        writeBacklog("------------------");
    }

    private void writeBacklog(String msg){
        try{
            String backLogFile = getBackupPath() + File.separator + "backlog"+File.separator+sdfDay.format(new Date())+".log";
            File file = new File(backLogFile);
            List<String> lines=new ArrayList<>();
            msg = sdf.format(new Date())+" : " + msg;
            lines.add(msg);
            FileUtils.writeLines(file,null,lines,true);
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
