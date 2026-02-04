package com.oceanview.dao;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.oceanview.model.Reservation;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class ReservationDAO extends BaseDAO<Reservation> {
    private final Gson gson = new Gson();

    public ReservationDAO() {
        super("reservations");
    }

    public void save(Reservation reservation) {
        Document doc = Document.parse(gson.toJson(reservation));
        if (reservation.getId() != null && !reservation.getId().isEmpty()) {
            collection.replaceOne(Filters.eq("_id", new ObjectId(reservation.getId())), doc);
        } else {
            collection.insertOne(doc);
            reservation.setId(doc.getObjectId("_id").toString());
        }
    }

    public Reservation findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        Reservation reservation = gson.fromJson(doc.toJson(), Reservation.class);
        reservation.setId(doc.getObjectId("_id").toString());
        return reservation;
    }

    public List<Reservation> findAll() {
        List<Reservation> reservations = new ArrayList<>();
        FindIterable<Document> docs = collection.find();
        for (Document doc : docs) {
            Reservation reservation = gson.fromJson(doc.toJson(), Reservation.class);
            reservation.setId(doc.getObjectId("_id").toString());
            reservations.add(reservation);
        }
        return reservations;
    }
}
