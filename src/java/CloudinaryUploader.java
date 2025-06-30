package utils;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import java.io.File;
import java.util.Map;

public class CloudinaryUploader {
    private static final Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
        "cloud_name", System.getenv("CLOUDINARY_CLOUD_NAME"),
        "api_key", System.getenv("CLOUDINARY_API_KEY"),
        "api_secret", System.getenv("CLOUDINARY_API_SECRET")
    ));

    public static String uploadImage(File imageFile) throws Exception {
        Map uploadResult = cloudinary.uploader().upload(imageFile, ObjectUtils.emptyMap());
        return (String) uploadResult.get("secure_url");
    }

    public static Cloudinary getInstance() {
        return cloudinary;
    }
}
