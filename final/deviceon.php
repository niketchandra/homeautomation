<!----API only for Hardware----->
<?php include('connect.php'); ?>
<?php

$device=$_GET['id'];
   $sql = "UPDATE `devicestatus` SET `status`= '1' WHERE `deviceid`= '$device'";
   if (mysqli_query($link, $sql)) {
    echo "Device is Successfully Started";
 } else {
    echo "Error: " . $sql . "" . mysqli_error($conn);
 }
 $conn->close();

    ?>