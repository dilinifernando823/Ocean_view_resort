package com.oceanview.dao;

import com.oceanview.util.MongoDBConnection;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class MongoDBTest {

    @Test
    public void testDatabaseWriteRead() {
        var database = MongoDBConnection.getDatabase();
        var collection = database.getCollection("test_collection");
        
        // Clear existing
        collection.drop();
        
        // Insert a test document
        org.bson.Document doc = new org.bson.Document("name", "Test Entry")
                                    .append("status", "success")
                                    .append("timestamp", System.currentTimeMillis());
        collection.insertOne(doc);
        
        // Verify insertion
        org.bson.Document retrieved = collection.find(new org.bson.Document("name", "Test Entry")).first();
        assertNotNull(retrieved, "Document should be found in database");
        assertEquals("success", retrieved.getString("status"));
        
        // collection.drop();
    }
}
