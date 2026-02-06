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
        inv.setInvoicedAt(getDateSafely(doc, "invoicedAt"));
        inv.setCreatedAt(getDateSafely(doc, "createdAt"));
        inv.setUpdatedAt(getDateSafely(doc, "updatedAt"));
        return inv;
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
            System.out.println("InvoiceDAO: Failed to parse date string: '" + val + "' (cleaned: '" + dateStr + "') for key: " + key);
        }
        return null;
    }
}
