package com.github.miyashy;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    private static final Logger log = LoggerFactory.getLogger(HelloController.class);
    public static class HelloResponse {
        private final String message;
        public HelloResponse(String message) {
            this.message = message;
        }
        public String getMessage() {
            return message;
        }
    }

    @GetMapping("/hello")
    public HelloResponse getHello() {
        log.info("/hello called.");
        return new HelloResponse("hello");
    }
}

