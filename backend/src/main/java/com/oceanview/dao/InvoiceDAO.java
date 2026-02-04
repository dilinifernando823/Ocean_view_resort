package com.oceanview.dao;

import com.google.gson.Gson;
import com.mongodb.client.FindIterable;
import com.mongodb.client.model.Filters;
import com.oceanview.model.Invoice;
import org.bson.Document;
import org.bson.types.ObjectId;

import java.util.ArrayList;
import java.util.List;

public class InvoiceDAO extends BaseDAO<Invoice> {
    private final Gson gson = new Gson();

    public InvoiceDAO() {
        super("invoices");
    }

    public void save(Invoice invoice) {
        Document doc = Document.parse(gson.toJson(invoice));
        if (invoice.getId() != null && !invoice.getId().isEmpty()) {
            collection.replaceOne(Filters.eq("_id", new ObjectId(invoice.getId())), doc);
        } else {
            collection.insertOne(doc);
            invoice.setId(doc.getObjectId("_id").toString());
        }
    }

    public Invoice findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        Invoice invoice = gson.fromJson(doc.toJson(), Invoice.class);
        invoice.setId(doc.getObjectId("_id").toString());
        return invoice;
    }

    public List<Invoice> findAll() {
        List<Invoice> invoices = new ArrayList<>();
        FindIterable<Document> docs = collection.find();
        for (Document doc : docs) {
            Invoice invoice = gson.fromJson(doc.toJson(), Invoice.class);
            invoice.setId(doc.getObjectId("_id").toString());
            invoices.add(invoice);
        }
        return invoices;
    }
}
