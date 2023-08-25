<?php
echo 'hello world\n';

$configFile = readfile('/etc/test-config/config.ini');

echo 'Content of config file: ' . $configFile . '\n';
?>