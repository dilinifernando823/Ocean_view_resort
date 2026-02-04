package com.oceanview.dao;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.oceanview.model.User;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class UserDAO extends BaseDAO<User> {
    private final Gson gson = new Gson();

    public UserDAO() {
        super("users");
    }

    public void save(User user) {
        Document doc = Document.parse(gson.toJson(user));
        if (user.getId() != null && !user.getId().isEmpty()) {
            collection.replaceOne(Filters.eq("_id", new ObjectId(user.getId())), doc);
        } else {
            collection.insertOne(doc);
            user.setId(doc.getObjectId("_id").toString());
        }
    }

    public User findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        User user = gson.fromJson(doc.toJson(), User.class);
        user.setId(doc.getObjectId("_id").toString());
        return user;
    }

    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        FindIterable<Document> docs = collection.find();
        for (Document doc : docs) {
            User user = gson.fromJson(doc.toJson(), User.class);
            user.setId(doc.getObjectId("_id").toString());
            users.add(user);
        }
        return users;
    }
}
