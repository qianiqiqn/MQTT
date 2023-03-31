package org.example.service;

import lombok.extern.slf4j.Slf4j;
import org.example.config.comsumer.MqttConsumerConfig;
import org.example.config.provider.MqttProviderConfig;
import org.example.pojo.SendRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * @author wenqianqian
 */
@Service
@Slf4j
public class SendService {

    @Autowired
    private MqttProviderConfig providerClient;

    @Autowired
    private MqttConsumerConfig client;

    @Value("${spring.mqtt.client.id}")
    private String clientId;

    public String sendMessage(SendRequest sendRequest){
        try {
            providerClient.publish(sendRequest.getQos(),
                    sendRequest.isRetained(),
                    sendRequest.getTopic(),
                    sendRequest.getMessage());
            return "发送成功";
        } catch (Exception e) {
            e.printStackTrace();
            return "发送失败";
        }
    }


    public String connect(){
        client.connect();
        return clientId + "连接到服务器";
    }

    public String disConnect(){
        client.disConnect();
        return clientId + "与服务器断开连接";
    }

}
