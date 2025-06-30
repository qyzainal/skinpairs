package servlet;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import utils.CloudinaryUploader;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/UploadImageServlet")
@MultipartConfig
public class UploadImageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("image"); // from form input
        String fileName = filePart.getSubmittedFileName();

        // Convert filePart to a temp file
        java.io.File tempFile = java.io.File.createTempFile("upload", fileName);
        filePart.write(tempFile.getAbsolutePath());

        Cloudinary cloudinary = CloudinaryUploader.getInstance();

        try {
            Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
            String imageUrl = (String) uploadResult.get("secure_url");

            // Example: Save to DB here, or return response
            response.getWriter().write("Image uploaded: " + imageUrl);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Upload failed: " + e.getMessage());
        } finally {
            tempFile.delete(); // clean up
        }
    }
}
