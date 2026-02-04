package com.oceanview.util;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MongoDBConnection {
    private static final Logger logger = LoggerFactory.getLogger(MongoDBConnection.class);
    private static final String CONNECTION_STRING = "mongodb://localhost:27017"; // Change to your Atlas URI if needed
    private static final String DATABASE_NAME = "dilini_ocean_view_resort";
    private static MongoClient mongoClient = null;

    static {
        try {
            mongoClient = MongoClients.create(CONNECTION_STRING);
            logger.info("Successfully connected to MongoDB at {}", CONNECTION_STRING);
        } catch (Exception e) {
            logger.error("Error connecting to MongoDB", e);
        }
    }

    public static MongoDatabase getDatabase() {
        if (mongoClient == null) {
            mongoClient = MongoClients.create(CONNECTION_STRING);
        }
        return mongoClient.getDatabase(DATABASE_NAME);
    }
    
    public static boolean checkConnection() {
        try {
            mongoClient.listDatabaseNames().first();
            return true;
        } catch (Exception e) {
            logger.error("Connection check failed", e);
            return false;
        }
    }

    public static void close() {
        if (mongoClient != null) {
            mongoClient.close();
            logger.info("MongoDB connection closed.");
        }
    }
}
