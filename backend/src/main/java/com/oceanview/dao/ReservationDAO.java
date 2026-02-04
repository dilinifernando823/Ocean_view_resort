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
        return mapDocumentToReservation(doc);
    }

    public List<Reservation> findAll() {
        List<Reservation> reservations = new ArrayList<>();
        FindIterable<Document> docs = collection.find().sort(new Document("createdAt", -1));
        for (Document doc : docs) {
            reservations.add(mapDocumentToReservation(doc));
        }
        return reservations;
    }

    private Reservation mapDocumentToReservation(Document doc) {
        Reservation res = new Reservation();
        res.setId(doc.getObjectId("_id").toString());
        res.setGuestId(doc.getString("guestId"));
        res.setRoomId(doc.getString("roomId"));
        res.setCheckInDate(doc.getDate("checkInDate"));
        res.setCheckOutDate(doc.getDate("checkOutDate"));
        res.setTotalAmount(doc.getDouble("totalAmount"));
        res.setStatus(doc.getString("status")); // pending, accepted, rejected, cancelled
        res.setPaymentStatus(doc.getString("paymentStatus")); // unpaid, paid
        res.setCreatedAt(doc.getDate("createdAt"));
        res.setUpdatedAt(doc.getDate("updatedAt"));
        return res;
    }

    public void delete(String id) {
        collection.deleteOne(Filters.eq("_id", new ObjectId(id)));
    }
}
