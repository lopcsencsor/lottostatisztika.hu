<?php
namespace app\model;
include 'app\_utils\Database.php';
include 'app\model\Szimpla.php';
use app\_utils\Database as Db;

class SzimplaDao{

    public function getAllSzimpla(){
        $dbObj = new Db();
        $conn = $dbObj->getConnection();
        $statement = $conn->prepare("SELECT e.id, e.first_name, e.last_name, e.salary, e.job_start, e.status, ec.name FROM Szimpla");
        $statement->setFetchMode(\PDO::FETCH_OBJ);
        $statement->execute();
        return $statement->fetchAll();
    }

    public function save(){ //A POST tömbben benne vannak az adatok, azokat ki kell venni első lépésben. //Lementjük változóba a POST tömb elemeit
        $lastName = $_POST['Szimpla']['lastName'];  //Vezetéknév kinyerése
        $firstName = $_POST['Szimpla']['firstName']; //Keresztnév kinyerése
        $categoryId = $_POST['Szimpla']['SzimplaCategory']; //Kategória
        $salary = $_POST['Szimpla']['salary']; // ...
        $jobStart = $_POST['Szimpla']['jobStart']; // ...
        $status = isset($_POST['Szimpla']['status']) ? 1 : 0;  //Ha állított rajta, akkor megkapja a TRUE értéket, ha nem állított, akkor NULL érték jönne át, akkor FALSE értéket kapjon.
        $Szimpla = new Szimpla($firstName, $lastName, $categoryId, $salary,$jobStart,$status);
        $dbObj = new Db();
        $conn = $dbObj->getConnection();
        $sql = "INSERT INTO Szimpla (`last_name`, `first_name`,`category_id`,`salary`,`job_start`,`status`) VALUES (:lastName, :firstName, :categoryId,:salary, :jobStart, :status);";
        $statement = $conn->prepare($sql);
        $statement->execute([
            ':lastName'=>$Szimpla->getLastName(),
            ':firstName'=>$Szimpla->getFirstName(),
            ':categoryId'=>$Szimpla->getCategoryId(),
            ':salary'=>$Szimpla->getSalary(),
            ':jobStart'=>$Szimpla->getJobStart(),
            ':status'=>$Szimpla->getStatus(),
        ]);
    }

    public function getSzimplaById(int $id){
        //return SzimplaObj id alapján keressük meg a táblában

    }

    public function update(){
        //ToDo
        //$_POST-ból adatok begyűjtése
        //SQL update prepared Statement-tel


    }




}
?>
