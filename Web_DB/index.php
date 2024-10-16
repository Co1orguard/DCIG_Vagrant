<?php

$db = new SQLite3('usersdb.sqlite');

if (isset($_POST['login'])) {
	$username = $_POST['username'];
	$password = $_POST['password'];

	$query = "SELECT * FROM tblUsers WHERE username = '$username' AND password = '$password'";
	$result = $db->query($query);

	if ($row = $result->fetchArray()) {
		echo "Welcome, " . $row['username'] . "!";
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
<html>
<head>
	<title> Vulnerable PHP App</title>
<head>
<body>
	<h1>Vulnerable PHP Web Application</h1>

	<h2>Login</h2>
	<form method="POST">
		Username: <input type="text" name="username"><br>
		Password: <input type="text" name="password"><br>
		<input type="submit" name="login" value="Login">
	<form>


	<h2>Upload File</h2>
	<form enctype="multipart/form-data" method="POST">
		<input type="file" name="file">
		<input type="submit" value="Upload">
	</form>
</body>
</html>



