package com.gbhat.kobes;

import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

import static spark.Spark.*;

public class App {
    private static Logger log = LoggerFactory.getLogger(App.class);

    public static void main(String[] args) {

        // load config
        Config baseConf = ConfigFactory.load();
        Config conf = ConfigFactory.parseFile(new File("/etc/config/application.properties")).withFallback(baseConf);

        log.info("{} : {}", "prop1", conf.getString("prop1"));
        log.info("{} : {}", "prop2", conf.getString("prop2"));
        log.info("{} : {}", "prop3", conf.getString("prop3"));

        // api
        get("/hello", (req, res) -> "Hello World");
    }
}