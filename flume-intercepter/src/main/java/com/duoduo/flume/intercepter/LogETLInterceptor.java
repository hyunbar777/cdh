package com.duoduo.flume.intercepter;


import org.apache.flume.Context;
import org.apache.flume.Event;
import org.apache.flume.interceptor.Interceptor;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

/**
 * Author z
 * Date 2020-04-16 18:19:19
 */
public class LogETLInterceptor implements Interceptor {
    @Override
    public void initialize() {
    
    }
    
    @Override
    public Event intercept(Event event) {
        //1 获取数据
        byte[] body = event.getBody();
        String log = new String(body, Charset.forName("UTF-8"));
        //2 判断数据类型并向Header中赋值
        if (log.contains("start")) {
            if (LogUtils.validateStart(log)) {
                return  event;
            }
        }else {
            if (LogUtils.validateEvent(log)) {
                return  event;
            }
        }
        return null;
    }
    
    @Override
    public List<Event> intercept(List<Event> events) {
        ArrayList<Event> list = new ArrayList<>();
        for (Event event : events) {
            Event intercept = intercept(event);
            if (intercept!=null) {
                list.add(event);
            }
        }
        return list;
    }
    
    @Override
    public void close() {
    
    }
    public static class Builder implements  Interceptor.Builder{
    
        @Override
        public Interceptor build() {
            return new LogETLInterceptor();
        }
    
        @Override
        public void configure(Context context) {
        
        }
    }
}
