package com.oceanview.util;

import com.google.gson.JsonDeserializer;
import com.google.gson.JsonSerializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonParseException;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Custom GSON adapter for handling Date objects with format: "MMM d, yyyy, h:mm:ss a"
 * (e.g., "Feb 6, 2026, 7:19:40 PM")
 * Handles various whitespace characters and encoding issues
 */
public class GsonDateAdapter implements JsonDeserializer<Date>, JsonSerializer<Date> {
    
    private static final String[] DATE_FORMATS = {
        "MMM d, yyyy, h:mm:ss a",     // Feb 6, 2026, 7:19:40 PM
        "yyyy-MM-dd'T'HH:mm:ss'Z'",   // ISO8601 format for compatibility
        "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" // ISO8601 with milliseconds
    };
    
    // Pattern to extract date components: "Month day, year, time AM/PM"
    private static final Pattern DATE_PATTERN = Pattern.compile(
        "(\\w+)\\s+(\\d+)\\s*,\\s*(\\d{4})\\s*,\\s*(\\d{1,2}):(\\d{2}):(\\d{2})\\s*([AP]M)",
        Pattern.CASE_INSENSITIVE
    );

    @Override
    public Date deserialize(JsonElement json, Type typeOfT, JsonDeserializationContext context) 
            throws JsonParseException {
        String dateStr = json.getAsString();
        
        // Try standard parsing first
        Date result = tryStandardParsing(dateStr);
        if (result != null) {
            return result;
        }
        
        // If standard parsing fails, try regex-based parsing
        result = tryRegexParsing(dateStr);
        if (result != null) {
            return result;
        }
        
        // If everything fails, throw an exception
        throw new JsonParseException("Failed to parse date: '" + dateStr + 
            "'. Expected format: 'MMM d, yyyy, h:mm:ss a' (e.g., 'Feb 6, 2026, 7:19:40 PM')");
    }
    
    private Date tryStandardParsing(String dateStr) {
        // Normalize various types of whitespace to regular spaces
        String normalized = dateStr.replaceAll("[\\p{Z}\\s\u00A0]+", " ").trim();
        
        for (String format : DATE_FORMATS) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat(format, Locale.ENGLISH);
                sdf.setLenient(false);
                return sdf.parse(normalized);
            } catch (ParseException e) {
                // Try next format
            }
        }
        
        // Try lenient parsing as last resort
        try {
            SimpleDateFormat lenient = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a", Locale.ENGLISH);
            lenient.setLenient(true);
            return lenient.parse(normalized);
        } catch (ParseException e) {
            return null;
        }
    }
    
    private Date tryRegexParsing(String dateStr) {
        Matcher matcher = DATE_PATTERN.matcher(dateStr);
        if (!matcher.find()) {
            return null;
        }
        
        try {
            String month = matcher.group(1);
            String day = matcher.group(2);
            String year = matcher.group(3);
            String hour = matcher.group(4);
            String minute = matcher.group(5);
            String second = matcher.group(6);
            String ampm = matcher.group(7).toUpperCase();
            
            // Reconstruct the date string with regular spaces
            String reconstructed = month + " " + day + ", " + year + ", " + hour + ":" + minute + ":" + second + " " + ampm;
            
            SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a", Locale.ENGLISH);
            sdf.setLenient(false);
            return sdf.parse(reconstructed);
        } catch (ParseException e) {
            return null;
        }
    }

    @Override
    public JsonElement serialize(Date src, Type typeOfT, JsonSerializationContext context) {
        SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy, h:mm:ss a", Locale.ENGLISH);
        return new JsonPrimitive(sdf.format(src));
    }
}
