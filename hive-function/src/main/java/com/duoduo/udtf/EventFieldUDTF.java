package com.duoduo.udtf;

import org.apache.avro.data.Json;
import org.apache.commons.lang.StringUtils;
import org.apache.hadoop.hive.ql.exec.UDFArgumentException;
import org.apache.hadoop.hive.ql.metadata.HiveException;
import org.apache.hadoop.hive.ql.udf.generic.GenericUDTF;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.objectinspector.StructObjectInspector;
import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.json.JSONArray;
import org.json.JSONException;

import java.util.ArrayList;

/**
 * Author z
 * Date 2020-04-24 11:09:39
 */
public class EventFieldUDTF extends GenericUDTF {
    @Override
    public StructObjectInspector initialize(StructObjectInspector argOIs) throws UDFArgumentException {
        ArrayList<String> fieldNames = new ArrayList<>();
        ArrayList<ObjectInspector> objectInspectors = new ArrayList<>();
        
        fieldNames.add("event_name");
        objectInspectors.add(PrimitiveObjectInspectorFactory.javaStringObjectInspector);
        
        fieldNames.add("event_json");
        objectInspectors.add(PrimitiveObjectInspectorFactory.javaStringObjectInspector);
        
        return ObjectInspectorFactory.getStandardStructObjectInspector(fieldNames
                , objectInspectors);
    }
    
    @Override
    public void process(Object[] objects) throws HiveException {
        
        java.lang.String s = objects[0].toString();
        if (StringUtils.isBlank(s)) {
            return;
        } else {
            try {
                JSONArray jsonArray = new JSONArray(s);
                if (jsonArray == null) {
                    return;
                }
                for (int i = 0; i < jsonArray.length(); i++) {
                    String[] result = new String[2];
                    try {
                        result[0] = jsonArray.getJSONObject(i).getString("en");
                        result[1] = jsonArray.getString(i);
                    } catch (JSONException e) {
                        continue;
                    }
                    forward(result);
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }
    
    @Override
    public void close() throws HiveException {
    
    }
}
