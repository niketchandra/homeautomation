<!---------API to chcek the the status of the hardware-------------->
<?php include('connect.php');
$device=$_GET['id']; 
?>
<?php

   $qry = "select * from devicestatus where deviceid='$device' ORDER BY time DESC LIMIT 1";
   $res = mysqli_query($link, $qry);
    $emparr = array();
    while($row =mysqli_fetch_assoc($res))
    {
        $emparr[] = $row;
    }
    echo json_encode($emparr);
    mysqli_close($connection);
    
    ?>
