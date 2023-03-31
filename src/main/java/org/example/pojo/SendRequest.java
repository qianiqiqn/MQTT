package org.example.pojo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author wenqianqian
 */

@Data
@ApiModel(description = "发送数据请求参数")
public class SendRequest {

    @ApiModelProperty(value = "qos")
    private Integer qos;

    @ApiModelProperty(value = "retained")
    private boolean retained;

    @ApiModelProperty(value = "主题")
    private String topic;

    @ApiModelProperty(value = "信息")
    private String message;
}
