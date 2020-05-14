<?php
include "conn.php";
if ($_POST) {
    $name = $_POST['user'];
    $pass = $_POST['pass'];
    $role = $_POST['role'];
    
    $sql = "INSERT INTO recomquestion (req_service_type, req_location, description) VALUES ('$name', '$pass', '$role' )";
 
    if (mysqli_query($connect, $sql)) {
        echo "successfully";
    } else {
        echo "Error";
    }
}
?>
