<?php include('connect.php'); ?>
<?php
#$device=$_GET['id'];
   $qry = "SELECT portid FROM `devicestatus` LIMIT 1";
$res = mysqli_query($link, $qry);
$data = mysqli_fetch_array($res);
	echo $data['portid'];
#        $emparr = array();
#    while($row =mysqli_fetch_assoc($res))
#    {
#        $emparr[] = $row;
#    }
#    echo json_encode($emparr);

#    mysqli_close($connection);

?>

