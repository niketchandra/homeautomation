<?php include('./connect.php'); ?>
<?php

$device=$_GET['id'];
   $qry = "select * from devicestatus where deviceid=001 ORDER BY time DESC LIMIT 1";

   $res = mysqli_query($link, $qry);

        $emparr = array();
    while($row =mysqli_fetch_assoc($res))
    {
        $emparr[] = $row;
    }
    echo json_encode($emparr);

    mysqli_close($connection);
    
    ?>
