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

    /**
     * Safely get a double value from a document, handling both Double and Integer types
     * @param doc the BSON document
     * @param key the field key
     * @return the double value, or 0.0 if not found
     */
    protected double getDoubleSafely(Document doc, String key) {
        return getDoubleSafely(doc, key, 0.0);
    }

    /**
     * Safely get a double value from a document, handling both Double and Integer types
     * @param doc the BSON document
     * @param key the field key
     * @param defaultValue the default value if not found
     * @return the double value, or defaultValue if not found
     */
    protected double getDoubleSafely(Document doc, String key, double defaultValue) {
        Object value = doc.get(key);
        if (value == null) {
            return defaultValue;
        }
        if (value instanceof Double) {
            return (Double) value;
        }
        if (value instanceof Integer) {
            return ((Integer) value).doubleValue();
        }
        if (value instanceof Long) {
            return ((Long) value).doubleValue();
        }
        if (value instanceof String) {
            try {
                return Double.parseDouble((String) value);
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }

    /**
     * Safely get an integer value from a document, handling multiple numeric types
     * @param doc the BSON document
     * @param key the field key
     * @return the integer value, or 0 if not found
     */
    protected int getIntegerSafely(Document doc, String key) {
        return getIntegerSafely(doc, key, 0);
    }

    /**
     * Safely get an integer value from a document, handling multiple numeric types
     * @param doc the BSON document
     * @param key the field key
     * @param defaultValue the default value if not found
     * @return the integer value, or defaultValue if not found
     */
    protected int getIntegerSafely(Document doc, String key, int defaultValue) {
        Object value = doc.get(key);
        if (value == null) {
            return defaultValue;
        }
        if (value instanceof Integer) {
            return (Integer) value;
        }
        if (value instanceof Double) {
            return ((Double) value).intValue();
        }
        if (value instanceof Long) {
            return ((Long) value).intValue();
        }
        if (value instanceof String) {
            try {
                return Integer.parseInt((String) value);
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }
}
