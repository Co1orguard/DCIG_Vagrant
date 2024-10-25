<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();

$db = new SQLite3('usersdb.sqlite');

if (isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Use a prepared statement to prevent SQL injection
    $stmt = $db->prepare("SELECT * FROM tblUsers WHERE username = :username AND password = :password");
    $stmt->bindValue(':username', $username, SQLITE3_TEXT);
    $stmt->bindValue(':password', $password, SQLITE3_TEXT);
    $result = $stmt->execute();

    if ($result && $row = $result->fetchArray(SQLITE3_ASSOC)) {
        $_SESSION['user'] = $row;
        echo "Login successful, redirecting";

        header("Location: profile.php");
        exit();
    } else {
        echo "Invalid credentials!";
    }
}

if (isset($_FILES['file'])) {
    $upload_dir = './uploads/';

    $file_type = mime_content_type($_FILES['file']['tmp_name']);
    $file_ext = pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION);

    // Validate that the file is a JPEG
    if ($file_type === 'image/jpeg' || $file_type === 'image/pjpeg' || strtolower($file_ext) === 'jpg' || strtolower($file_ext) === 'jpeg') {
        $uploaded_file = $upload_dir . basename($_FILES['file']['name']);

        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploaded_file)) {
            echo "File uploaded successfully: $uploaded_file";
            // Avoid including user-uploaded files directly
            // include($uploaded_file);
        } else {
            echo "File upload failed!";
        }
    } else {
        echo "Invalid file type! Only JPEG files are allowed.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vulnerable PHP App</title>
</head>
<body>
    <h1>Vulnerable PHP Web Application</h1>

    <h2>Login</h2>
    <form method="POST" action="index.php">
        <label for="username">Username:</label>
        <input type="text" name="username" id="username" required><br>

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required><br>

        <input type="submit" name="login" value="Login">
    </form>

    <h2>Upload File</h2>
    <form enctype="multipart/form-data" method="POST">
        <input type="file" name="file" required>
        <input type="submit" value="Upload">
    </form>
</body>
</html>

