<?php
$servername = "localhost";
$username = "root";
$password = ""; // Update if you have a password
$dbname = "InventoryManagement4"; // Updated database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
