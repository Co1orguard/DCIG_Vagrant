<?php
session_start();

if (isset($_SESSION['user'])) {
    $user = $_SESSION['user'];
} else {
    header("Location: index.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>User Profile</title>
<head>
<body>
	<h1>Welcome, <?php echo $user['username']; ?>!</h1>

	<p><strong>User ID:</strong> <?php echo $user['user_id']; ?></p>
    <p><strong>First Name:</strong> <?php echo $user['first_name']; ?></p>
    <p><strong>Last Name:</strong> <?php echo $user['last_name']; ?></p>
    <p><strong>Password:</strong> <?php echo $user['password']; ?></p>
    <p><strong>Address:</strong> <?php echo $user['address']; ?></p>

    <a href="logout.php">Logout</a>
</body>
</html>