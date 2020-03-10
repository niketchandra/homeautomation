<?php include('connect.php'); ?>
<?php

$device=$_GET['id'];
<<<<<<< HEAD:device_data.php
   $qry = "select * from data where deviceid='$device' LIMIT 1 ORDER BY time desc";
=======
   $qry = "select * from data where deviceid='$device' ORDER BY time DESC LIMIT 1";
>>>>>>> af5e5a8ee358fd906f331342017e8437cc794dd0:device_last_data.php
   $res = mysqli_query($link, $qry);

        $emparr = array();
    while($row =mysqli_fetch_assoc($res))
    {
        $emparr[] = $row;
    }
    echo json_encode($emparr);

    mysqli_close($connection);
    
    ?>
