<?php include('connect.php'); ?>
<?php

$device=$_GET['id'];
$portid=$_GET['port'];
$value=$_GET['data'];
   $sql = "INSERT INTO `data`(`deviceid`, `portno`, `data`) VALUES ('$device', '$portid', '$value'";
   if (mysqli_query($link, $sql)) {
    echo "New record created successfully";
 } else {
    echo "Error: " . $sql . "" . mysqli_error($conn);
 }
 $conn->close();

    ?>