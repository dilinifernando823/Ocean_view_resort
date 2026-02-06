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
        
        // Remove _id from document if we are inserting, to let Mongo generate it
        if (reservation.getId() == null || reservation.getId().isEmpty()) {
            doc.remove("id"); // Remove Java generic 'id' field if present
            doc.remove("_id");
            collection.insertOne(doc);
            reservation.setId(doc.getObjectId("_id").toString());
        } else {
             // For update, we need to handle _id carefully
             doc.remove("id");
             collection.replaceOne(Filters.eq("_id", new ObjectId(reservation.getId())), doc);
        }
    }

    public Reservation findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        return mapDocumentToReservation(doc);
    }

    public List<Reservation> findByGuestId(String guestId) {
        List<Reservation> reservations = new ArrayList<>();
        FindIterable<Document> docs = collection.find(Filters.eq("guestId", guestId)).sort(new Document("createdAt", -1));
        for (Document doc : docs) {
            reservations.add(mapDocumentToReservation(doc));
        }
        return reservations;
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
        res.setCheckInDate(getDateSafely(doc, "checkInDate"));
        res.setCheckOutDate(getDateSafely(doc, "checkOutDate"));
        res.setTotalAmount(doc.getDouble("totalAmount"));
        res.setStatus(doc.getString("status")); // pending, accepted, rejected, cancelled
        res.setPaymentStatus(doc.getString("paymentStatus")); // unpaid, paid
        res.setOccupancy(doc.getInteger("occupancy", 0));
        res.setNotes(doc.getString("notes"));
        res.setCreatedAt(getDateSafely(doc, "createdAt"));
        res.setUpdatedAt(getDateSafely(doc, "updatedAt"));
        return res;
    }

    private java.util.Date getDateSafely(Document doc, String key) {
        Object val = doc.get(key);
        if (val == null) return null;
        if (val instanceof java.util.Date) {
            return (java.util.Date) val;
        }
        if (val instanceof String) {
            String dateStr = (String) val;
            
            // Clean up the date string
            // Replace non-breaking spaces (\u00A0), narrow non-breaking spaces (\u202F), and other invisible chars
            dateStr = dateStr.replaceAll("[\\h\\v]", " "); 
            // Replace literal '?' which might be a placeholder for unprintable chars in some DBs/Logs
            dateStr = dateStr.replace("?", " ");
            // Normalize multiple spaces to single space
            dateStr = dateStr.replaceAll("\\s+", " ").trim();

            String[] formats = {
                "yyyy-MM-dd'T'HH:mm:ss.SSSX",
                "MMM d, yyyy h:mm:ss a",
                "MMM d, yyyy, h:mm:ss a",
                "MMM dd, yyyy, h:mm:ss a",
                "yyyy-MM-dd",
                "yyyy-MM-dd HH:mm:ss"
            };
            
            for (String fmt : formats) {
                try {
                    // Use Locale.US to ensure month names like "Mar" are parsed correctly
                    return new java.text.SimpleDateFormat(fmt, java.util.Locale.US).parse(dateStr);
                } catch (java.text.ParseException e) {
                    // continue
                }
            }
            // If we get here, parsing failed for all formats
            System.out.println("ReservationDAO: Failed to parse date string: '" + val + "' (cleaned: '" + dateStr + "') for key: " + key);
        }
        return null;
    }

    public void delete(String id) {
        collection.deleteOne(Filters.eq("_id", new ObjectId(id)));
    }
}
