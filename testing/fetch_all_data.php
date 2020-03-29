<?php include('connect.php'); ?>
<?php

   $qry = "select * from data";
    $res = mysqli_query($link, $qry);

        $emparr = array();
    while($row =mysqli_fetch_assoc($res))
    {
        $emparr[] = $row;
    }
    echo json_encode($emparr);

    mysqli_close($connection);
  
##--------------part 2---------------------
   /*  $sql = "SELECT * FROM data";
   $result = mysqli_query($link,$sql);
   $row = mysqli_fetch_array($result,MYSQLI_NUM);
   
   print $row[0];
   print "\n";
   print $row[2];
   
   $row = mysqli_fetch_array($result,MYSQLI_ASSOC);
   print $row["device_id"];
   print "\n";
   print $row["data"];
   
   mysqli_free_result($result);
   mysqli_close($connection_mysql);

    */
?>
