package com.duoduo.bean;

/**
 * Author z
 * Date 2020-04-15 17:44:44
 */
public class AppErrorLog {
    private String errorBrief;    //错误摘要
    private String errorDetail;   //错误详情
    
    public String getErrorBrief() {
        return errorBrief;
    }
    
    public void setErrorBrief(String errorBrief) {
        this.errorBrief = errorBrief;
    }
    
    public String getErrorDetail() {
        return errorDetail;
    }
    
    public void setErrorDetail(String errorDetail) {
        this.errorDetail = errorDetail;
    }
    
}
