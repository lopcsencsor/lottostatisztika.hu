<?php
namespace app\model;
include 'app\_utils\Database.php';
include 'app\model\Kvadrupla.php';
use app\_utils\Database as Db;
use controller\Kvadrupla as ControllerKvadruplas;

class KvadruplaDao{

    public function getAllKvadruplas(){
        $dbObj = new Db();
        $conn = $dbObj->getConnection();
        $statement = $conn->prepare("SELECT nyeroszam1,nyeroszam2,nyeroszam3,nyeroszam4,nyeroszam5,elsohuzas,utolsohuzas,huzasdb,ismetlodes1,ismetlodes2,ismetlodes3,ismetlodes4 FROM otoskvadruplastat;");
        $statement->setFetchMode(\PDO::FETCH_OBJ);
        $statement->execute();
        return $statement->fetchAll();
    }
}
?>
