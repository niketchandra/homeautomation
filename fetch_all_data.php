
<?php include('connect.php'); ?>
<?php
#  if(isset($_POST['roll']) && $_POST['roll'] != '') {
#    $roll = mysqli_real_escape_string($con, $_POST['roll']);
   $qry = "select * from data";
    $res = mysqli_query($link, $qry);

        $emparr = array();
    while($row =mysqli_fetch_assoc($res))
    {
        $emparr[] = $row;
    }
    echo json_encode($emparr);

    //close the db connection
    mysqli_close($connection);
  
    #    if(mysqli_num_rows($res) >= 1) {
   #   $row = mysqli_fetch_array($res,MYSQLI_ASSOC);
   #   $data['id'] = $row['id'];
   #   $data['data'] = $row['data'];
   # } else {
   #   $data['error'] = 'not_found';
   # }
  #  echo json_encode($data);

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
