<?php
namespace app\controller; //Meghatározzuk a kontroller namespace-ét.
include 'app\model\SingleDao.php'; //Ezzel már látja a DAO-t.
use app\model\SingleDao;  //Ezzel már látja ezt az osztályt a későbbi műveletek során.

class SingleController {
        //Általános betöltő funció. A megjelenítési réteghez továbbítja az adatokat
    public function load($view, $data = []){    //a view meghatározza mi szerint kérdezünk le.
        extract($data); // Szétdarabolja a tömbben kapott adatokat
        ob_start();     // Puffer beállítás az OB_START-tal
        include("app/view/Single/{$view}.php");   //Beincludoljuk azt a műveletnek megfelelőt amivel hívtuk. Dupla aposzrófnál a PHP tudja értelmezni, hogy középen változó van.
        return $data; // Visszatér az adattal.
    }

    public function listAllSingles(){ // Összes adat összeszedése listázáshoz
        $SingleDaoObj = new SingleDao(); // AZ Single DAO-ból létrehozunk egy objektum példányt. Az indexben include-oltuk ezt ez SingleDao.php-t
        $Singles = $SingleDaoObj->getAllSingle(); //Ezzel lekérdeztük az összes alkalmazott adatot.
        return $this->load('index', [       //A 11 sori view-ba behelyettesítjük az index-et. Employoee kontroller objektum példánnyal visszatérünk. Visszatérő adat a
            'Singles' => $Singles,  //Az adatokat betöltjuk ez Singles - kulccsal. a sor végén maradhat a vessző következő elem nélkül is. PHP elfogadja.
        ]);
    }

    public function saveSingle(){   //Sok-sok CRUD művelet kerülhet ide ...

    }
}
?>
