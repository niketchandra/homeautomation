<!----API only for Hardware----->
<!---- Send the data every minute --- in db the table get update and log will be auromatcallt created -->
<?php include('connect.php'); ?>
<?php

$device=$_GET['id'];
   $sql = "UPDATE `devicestatus` SET `status`= '1' WHERE `deviceid`= '$device'";
   if (mysqli_query($link, $sql)) {
    echo "Device working";
 } else {
    echo "Error: " . $sql . "" . mysqli_error($conn);
 }
 $conn->close();

    ?>