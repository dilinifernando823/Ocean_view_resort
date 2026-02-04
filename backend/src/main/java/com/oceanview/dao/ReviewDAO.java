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
        Review review = gson.fromJson(doc.toJson(), Review.class);
        review.setId(doc.getObjectId("_id").toString());
        return review;
    }

    public List<Review> findAll() {
        List<Review> reviews = new ArrayList<>();
        FindIterable<Document> docs = collection.find();
        for (Document doc : docs) {
            Review review = gson.fromJson(doc.toJson(), Review.class);
            review.setId(doc.getObjectId("_id").toString());
            reviews.add(review);
        }
        return reviews;
    }
}
