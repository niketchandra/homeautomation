<?php include('connect.php'); ?>
<?php

$device=$_GET['id'];
   $sql = "UPDATE `devicestatus` SET `status`= '0' WHERE `deviceid`= '$device'";
   if (mysqli_query($link, $sql)) {
    echo "Device is not available";
 } else {
    echo "Error: " . $sql . "" . mysqli_error($conn);
 }
 $conn->close();

    ?>