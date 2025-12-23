<?php
require __DIR__ . "/inc/bootstrapBudget.php";
require PATH_MODEL . "/mySQLDatabase.php";
require PATH_MODEL . "/invoice.php";

$invoice = new Invoice();
echo json_encode($invoice->getAll());
