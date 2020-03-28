<?php
$output = shell_exec('ansible-playbook run.yml -vvv');
#$output = shell_exec('whoami');
echo "<pre>$output</pre>";
?>
