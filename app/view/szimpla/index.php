<?php //Ez a view szolgál arra,h kilistázzuk az adatokat ?>

<table border="1">  <?php //Kikerül a border, és bekerül egy bootstrap-es class ?>
    <tr>
        <th>Id</th>
        <th>Név</th>
        <th>Beosztás</th>
        <th>Fizetés</th>
        <th>Munkavégzés kezdete</th>
        <th>Állapot</th>
        <th>Műveletek</th>
    </tr>
    <?php
    foreach ($employees as $employee) {
        echo "<tr>";
        echo "<td>". $employee->id ."</td>";
        echo "<td>". $employee->last_name ." ".$employee->first_name."</td>";
        echo "<td>". $employee->name."</td>"; //Beosztás neve jelenik meg az ID helyett.
        echo "<td>". $employee->salary."</td>";
        echo "<td>". $employee->job_start."</td>";
        echo "<td>";
            $employee->status ? print "Aktív" : print "Inaktív"; //Státusz kiírása rövid függvénnyel. Az echo ebben nem működik.
        echo "</td>";
        echo "<td><a href='index.php?controller=employee&action=edit&id=$employee->id'> Módosít </a></td>";
        echo "</tr>";
    }
    ?>
</table>
<a href="index.php?controller=employee&action=create">Új dolgozó</a>  <?php //ANGKOR horgonypont <a> az új dolgozó felvitelre. Ezzel kezdeményezzük a dolgozó létrehozását. ?>
<h1>Code Challange</h1>
<ol>
    <li>Update</li>
    <li>Delete</li>
    <li>Bootstrap-esítés + font awesome</li>
    <li>Beosztások hardcode kiszedés</li>
</ol>
