package com.oceanview.dao;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.oceanview.util.MongoDBConnection;
import org.bson.Document;

public abstract class BaseDAO<T> {
    protected final MongoDatabase database;
    protected final MongoCollection<Document> collection;

    public BaseDAO(String collectionName) {
        this.database = MongoDBConnection.getDatabase();
        this.collection = database.getCollection(collectionName);
    }
}
