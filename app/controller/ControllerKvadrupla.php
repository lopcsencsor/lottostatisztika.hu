<?php
namespace app\controller;               // Meghatározzuk a kontroller namespace-ét.
include '..\model\KvadruplaDao.php';    // Ezzel már látja a DAO-t.
use app\model\KvadruplaDao;             // Ezzel már látja ezt az osztályt a későbbi műveletek során.

class KvadruplaController {
    //Általános betöltő funció. A megjelenítési réteghez továbbítja az adatokat
    public function load($view, $data = []){    //a view meghatározza mi szerint kérdezünk le.
        extract($data); // Szétdarabolja a tömbben kapott adatokat
        ob_start();     // Puffer beállítás az OB_START-tal
        include("app/view/Kvadrupla/{$view}.php");  //Betöltjük azt a műveletnek megfelelő nézetet (oldalt), amivel hívtuk. Dupla aposzrófnál a PHP tudja értelmezni, hogy középen változó van.
                                                    // Mivel a lotto csak megjeleníti ezeket az adatokat, így csak index.php lesz amit feldobunk.
        return $data; // Visszatér az adattal.
    }

    public function listAllKvadruplas(){ // Összes adat összeszedése listázáshoz
        $KvadruplaDaoObj = new KvadruplaDao(); // AZ Kvadrupla DAO-ból létrehozunk egy objektum példányt. Az indexben include-oltuk ezt ez KvadruplaDao.php-t
        $Kvadruplas = $KvadruplaDaoObj->getAllKvadruplas(); //Ezzel lekérdeztük az összes alkalmazott adatot.
        return $this->load('index', [       //A 11 sori view-ba behelyettesítjük az index-et. Employoee kontroller objektum példánnyal visszatérünk. Visszatérő adat a
            'Kvadruplas' => $Kvadruplas,  //Az adatokat betöltjuk ez Kvadruplas - kulccsal. a sor végén maradhat a vessző következő elem nélkül is. PHP elfogadja.
        ]);
    }

    public function saveKvadrupla(){   // Nézettel dolgozom, ezért nem lesz SAVE művelet
    }
}
?>
