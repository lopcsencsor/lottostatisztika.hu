<?php
namespace app\_utils;

    class Database{

        public function getConnection(){
            try {
                $dsn = "mysql:host=127.0.0.1;dbname=lotto;charset=utf8;port:3306";  /* adatbázis kapcsolat részletei */
                $user = "root";                             /* felhasználó */
                $password = "";                             /* jelszó */
                $conn = new \PDO($dsn, $user,$password);    /* kapcsolati objektum */
            } catch (\PDOException $ex) {                   /* kapcsolódási hiba kezelése */
                var_dump($ex);  
            }
            return $conn;                                   /* létrehozom a kapcsolódás objektumot és viszaadja */
        }
    }
?>