package com.oceanview.dao;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.oceanview.model.Review;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class ReviewDAO extends BaseDAO<Review> {
    private final Gson gson = new Gson();

    public ReviewDAO() {
        super("reviews");
    }

    public void save(Review review) {
        Document doc = Document.parse(gson.toJson(review));
        if (review.getId() != null && !review.getId().isEmpty()) {
            collection.replaceOne(Filters.eq("_id", new ObjectId(review.getId())), doc);
        } else {
            collection.insertOne(doc);
            review.setId(doc.getObjectId("_id").toString());
        }
    }

    public Review findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        return mapDocumentToReview(doc);
    }

    public List<Review> findAll() {
        List<Review> reviews = new ArrayList<>();
        FindIterable<Document> docs = collection.find();
        for (Document doc : docs) {
            reviews.add(mapDocumentToReview(doc));
        }
        return reviews;
    }

    public Review findByReservationId(String reservationId) {
        Document doc = collection.find(Filters.eq("reservationId", reservationId)).first();
        if (doc == null) return null;
        return mapDocumentToReview(doc);
    }

    private Review mapDocumentToReview(Document doc) {
        Review review = new Review();
        review.setId(doc.getObjectId("_id").toString());
        review.setReservationId(doc.getString("reservationId"));
        review.setGuestId(doc.getString("guestId"));
        review.setRoomId(doc.getString("roomId"));
        review.setRating(doc.getInteger("rating", 0));
        review.setFeedback(doc.getString("feedback"));
        review.setIsActive(doc.getInteger("isActive", 1));
        review.setCreatedAt(getDateSafely(doc, "createdAt"));
        review.setUpdatedAt(getDateSafely(doc, "updatedAt"));
        return review;
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
            dateStr = dateStr.replaceAll("[\\h\\v]", " "); 
            dateStr = dateStr.replace("?", " ");
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
                    return new java.text.SimpleDateFormat(fmt, java.util.Locale.US).parse(dateStr);
                } catch (java.text.ParseException e) {
                    // continue
                }
            }
        }
        return null;
    }

    public void delete(String id) {
        collection.deleteOne(Filters.eq("_id", new ObjectId(id)));
    }
}
