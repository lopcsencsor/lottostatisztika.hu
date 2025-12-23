<?php
require __DIR__ . "/inc/bootstrap.php";
require PATH_MODEL . "/mySQLDatabase.php";
require PATH_MODEL . "/numbers.php";

$numbers = new Numbers();
echo json_encode($numbers->getAll());
