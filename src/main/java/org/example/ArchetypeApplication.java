package org.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.context.annotation.ComponentScan;

/**
 * @author wenqianqian
 */
@SpringBootApplication
@ComponentScan(basePackages = "org.example.*")
//@MapperScan(basePackages = "org.example.mapper")
public class ArchetypeApplication {

    public static void main(String[] args) {
        SpringApplication.run(ArchetypeApplication.class, args);
    }

}
