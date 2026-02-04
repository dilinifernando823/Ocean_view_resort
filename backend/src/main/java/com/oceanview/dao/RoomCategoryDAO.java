package com.oceanview.dao;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.oceanview.model.RoomCategory;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class RoomCategoryDAO extends BaseDAO<RoomCategory> {
    private final Gson gson = new Gson();

    public RoomCategoryDAO() {
        super("room_categories");
    }

    public void save(RoomCategory category) {
        Document doc = Document.parse(gson.toJson(category));
        if (category.getId() != null && !category.getId().isEmpty()) {
            collection.replaceOne(Filters.eq("_id", new ObjectId(category.getId())), doc);
        } else {
            collection.insertOne(doc);
            category.setId(doc.getObjectId("_id").toString());
        }
    }

    public RoomCategory findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        RoomCategory category = gson.fromJson(doc.toJson(), RoomCategory.class);
        category.setId(doc.getObjectId("_id").toString());
        return category;
    }

    public List<RoomCategory> findAll() {
        List<RoomCategory> categories = new ArrayList<>();
        FindIterable<Document> docs = collection.find();
        for (Document doc : docs) {
            RoomCategory category = gson.fromJson(doc.toJson(), RoomCategory.class);
            category.setId(doc.getObjectId("_id").toString());
            categories.add(category);
        }
        return categories;
    }

    public void delete(String id) {
        collection.deleteOne(Filters.eq("_id", new ObjectId(id)));
    }
}
