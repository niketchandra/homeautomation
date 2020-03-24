<?php
shell_exec('sh register.sh');
$output = shell_exec('whoami');
echo "<pre>$output</pre>";
?>
