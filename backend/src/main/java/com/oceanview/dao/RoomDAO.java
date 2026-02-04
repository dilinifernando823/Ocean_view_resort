package com.oceanview.dao;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.oceanview.model.Room;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class RoomDAO extends BaseDAO<Room> {
    private final Gson gson = new Gson();

    public RoomDAO() {
        super("rooms");
    }

    public void save(Room room) {
        Document doc = Document.parse(gson.toJson(room));
        if (room.getId() != null && !room.getId().isEmpty()) {
            collection.replaceOne(Filters.eq("_id", new ObjectId(room.getId())), doc);
        } else {
            collection.insertOne(doc);
            room.setId(doc.getObjectId("_id").toString());
        }
    }

    public Room findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        Room room = gson.fromJson(doc.toJson(), Room.class);
        room.setId(doc.getObjectId("_id").toString());
        return room;
    }

    public List<Room> findAll() {
        List<Room> rooms = new ArrayList<>();
        FindIterable<Document> docs = collection.find();
        for (Document doc : docs) {
            Room room = gson.fromJson(doc.toJson(), Room.class);
            room.setId(doc.getObjectId("_id").toString());
            rooms.add(room);
        }
        return rooms;
    }
}
