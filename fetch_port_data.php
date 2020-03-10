<?php include('connect.php'); ?>
<?php

$device=$_GET['id'];
$portid=$_GET['port'];
   $qry = "select * from data where deviceid='$device' AND portno='$portid' LIMIT 1 ORDER BY time desc";
   $res = mysqli_query($link, $qry);

        $emparr = array();
    while($row =mysqli_fetch_assoc($res))
    {
        $emparr[] = $row;
    }
    echo json_encode($emparr);

    mysqli_close($connection);
    
    ?>