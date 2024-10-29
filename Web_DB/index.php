<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

session_start();

$db = new SQLite3('usersdb.sqlite');

if (isset($_POST['login'])) {
	$username = $_POST['username'];
	$password = $_POST['password'];

	$query = "SELECT * FROM tblUsers WHERE username = '$username' AND password = '$password'";
	$result = $db->query($query);

	if ($result && $row = $result->fetchArray(SQLITE3_ASSOC)) {
		$_SESSION['user'] = $row;
		echo "Login successful, redirecting";

		header("Location: profile.php");
		exit();
	} else {
		echo "Invalid creds!";
	}
}

if (isset($_FILES['file'])) {
	$upload_dir = './uploads/';
	if (!is_dir($upload_dir)) {
		mkdir($upload_dir);
	}

	$uploaded_file = $upload_dir . basename($_FILES['file']['name']);

	if (move_uploaded_file($_FILES['file']['tmp_name'], $uploaded_file)) {
		echo "File uploaed successfully: $uploaded_file";
		include($uploaded_file);
	} else {
		echo "File upload failed!";
	}
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title> Vulnerable PHP App</title>
<head>
<body>
	<h1>Vulnerable PHP Web Application</h1>

	<h2>Login</h2>
	<form method="POST" action="index.php">
		<label for="username">Username:</label>
		<input type="text" name="username" id="username" required><br>

		<label for="password">Password:</label>
		<input type="password" name="password" id="password" required><br>


		<input type="submit" name="login" value="Login">
	<form>


	<h2>Upload File</h2>
	<form enctype="multipart/form-data" method="POST">
		<input type="file" name="file">
		<input type="submit" value="Upload">
	</form>
</body>
</html>



