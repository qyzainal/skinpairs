<!DOCTYPE html>
<html>
<head><title>Upload Image Test</title></head>
<body>

<h2>Upload Image to Cloudinary</h2>
<form action="UploadImageServlet" method="post" enctype="multipart/form-data">
    Select Image: <input type="file" name="image" accept="image/*" required><br><br>
    <input type="submit" value="Upload">
</form>

</body>
</html>
