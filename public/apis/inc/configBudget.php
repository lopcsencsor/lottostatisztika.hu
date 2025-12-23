<?php
ini_set('memory_limit', '-1');
ini_set('max_execution_time', 6000);

//define('MYSQL_HOST', 'localhost');
//define('MYSQL_DATABASE', 'budget');
//define('MYSQL_USERNAME', 'root');
//define('MYSQL_PASSWORD', 'password');
//define('MYSQL_CHARSET', 'utf8');
define('MYSQL_HOST', 'localhost');
define('MYSQL_DATABASE', 'budget');
define('MYSQL_USERNAME', 'root');
define('MYSQL_PASSWORD', 'password');
define('MYSQL_CHARSET', 'utf8');



define('PATH_MODEL', dirname(__DIR__, 2) . '/apis/model');
define('PATH_INC', dirname(__DIR__, 2) . '/apis/inc');
define('PATH_FILES', dirname(__DIR__, 2) . '/apis/files');
define('PATH_MODELS', dirname(__DIR__, 3) . '/app/Models/');

define('VALIDFROM', date('Y-m-d H:i:s', strtotime('midnight')));
define('DATE_NOW', date('Y-m-d H:i:s', strtotime('now')));


