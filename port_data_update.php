<?php include('connect.php'); ?>
<?php

$device=$_GET['id'];
$value=$_GET['data'];
   $sql = "INSERT INTO `portdata`(`deviceid`, `status`) VALUES ('$device', '$portid', '$value')";
   if (mysqli_query($link, $sql)) {
    echo "record updated";
 } else {
    echo "Error: " . $sql . "" . mysqli_error($conn);
 }

 $conn->close();

    ?>