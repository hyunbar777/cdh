package com.duoduo.flume.intercepter;

import org.apache.flume.Context;
import org.apache.flume.Event;
import org.apache.flume.Source;
import org.apache.flume.interceptor.Interceptor;

import java.io.Console;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Author z
 * Date 2020-04-17 10:05:11
 */
public class LogTypeInterceptor implements Interceptor {
    @Override
    public void initialize() {
    
    }
    
    @Override
    public Event intercept(Event event) {
        byte[] body = event.getBody();
        String log = new String(body, Charset.forName("UTF-8"));
        
        // 2 获取header
        Map<String, String> headers = event.getHeaders();
        
        if (log.contains("start")) {
            headers.put("topic", "topic_start");
        } else {
            headers.put("topic", "topic_event");
        }
        return event;
    }
    
    @Override
    public List<Event> intercept(List<Event> events) {
        ArrayList<Event> list = new ArrayList<>();
        for (Event event : events) {
            Event intercept = intercept(event);
                list.add(intercept);
        }
        return list;
    }
    
    @Override
    public void close() {
    
    }
    
    public static class Builder implements Interceptor.Builder {
        
        @Override
        public Interceptor build() {
            return new LogTypeInterceptor();
        }
        
        @Override
        public void configure(Context context) {
        
        }
    }
}
