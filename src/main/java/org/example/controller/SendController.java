package org.example.controller;

import com.sutpc.software.common.api.CommonResult;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.example.pojo.SendRequest;
import org.example.service.SendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author wenqianqian
 */

@RestController
@Slf4j
@Api(tags = "MQTT测试")
@RequestMapping(value = "/mqtt")
public class SendController {

    @Autowired
    private SendService sendService;

    @PostMapping("/sendMessage")
    @ApiOperation("消息发送")
    public CommonResult<String> sendMessage(@RequestBody SendRequest sendRequest){
        return CommonResult.success(sendService.sendMessage(sendRequest));

    }

    @PostMapping("/connect")
    @ApiOperation("连接服务器")
    public CommonResult<String> connect(){
        return CommonResult.success(sendService.connect());

    }

    @PostMapping("/disConnect")
    @ApiOperation("断开连接")
    public CommonResult<String> disConnect(){
        return CommonResult.success(sendService.disConnect());

    }

}
