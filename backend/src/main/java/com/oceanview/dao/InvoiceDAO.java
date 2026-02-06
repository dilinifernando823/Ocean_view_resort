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
            doc.remove("id");
            collection.replaceOne(Filters.eq("_id", new ObjectId(invoice.getId())), doc);
        } else {
            doc.remove("id");
            doc.remove("_id");
            collection.insertOne(doc);
            invoice.setId(doc.getObjectId("_id").toString());
        }
    }

    public Invoice findById(String id) {
        Document doc = collection.find(Filters.eq("_id", new ObjectId(id))).first();
        if (doc == null) return null;
        return mapDocumentToInvoice(doc);
    }

    public Invoice findByReservationId(String reservationId) {
        Document doc = collection.find(Filters.eq("reservationId", reservationId)).first();
        if (doc == null) return null;
        return mapDocumentToInvoice(doc);
    }

    public List<Invoice> findAll() {
        List<Invoice> invoices = new ArrayList<>();
        FindIterable<Document> docs = collection.find().sort(new Document("createdAt", -1));
        for (Document doc : docs) {
            invoices.add(mapDocumentToInvoice(doc));
        }
        return invoices;
    }

    private Invoice mapDocumentToInvoice(Document doc) {
        Invoice inv = new Invoice();
        inv.setId(doc.getObjectId("_id").toString());
        inv.setReservationId(doc.getString("reservationId"));
        inv.setGuestId(doc.getString("guestId"));
        inv.setInvoiceNumber(doc.getString("invoiceNumber"));
        inv.setAmount(doc.getDouble("amount"));
        inv.setInvoicedAt(doc.getDate("invoicedAt"));
        inv.setCreatedAt(doc.getDate("createdAt"));
        inv.setUpdatedAt(doc.getDate("updatedAt"));
        return inv;
    }
}
