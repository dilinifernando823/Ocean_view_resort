package com.oceanview.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.util.Date;

/**
 * Utility class to create a Gson instance with custom date serialization/deserialization
 * This handles the date format: "MMM d, yyyy, h:mm:ss a" (e.g., "Feb 6, 2026, 7:19:40 PM")
 */
public class GsonUtil {
    private static final Gson GSON = new GsonBuilder()
        .registerTypeAdapter(Date.class, new GsonDateAdapter())
        .setPrettyPrinting()
        .create();

    /**
     * Returns a Gson instance configured to handle custom date formats
     */
    public static Gson getGson() {
        return GSON;
    }
}
