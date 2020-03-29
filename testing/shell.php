<?php
$output = shell_exec('ansible-playbook run.yml');
$output1 = shell_exec('whoami');
echo "<pre>$output</pre>";
echo "<pre>$output1</pre>";

?>
