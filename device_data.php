<?php include('connect.php'); ?>
<?php

$deviceid=$_GET['id'];
   $qry = "select * from data where deviceid='$device'";
   $res = mysqli_query($link, $qry);

        $emparr = array();
    while($row =mysqli_fetch_assoc($res))
    {
        $emparr[] = $row;
    }
    echo json_encode($emparr);

    mysqli_close($connection);
    
    ?>