<div class="row">
    <div class="jumbotron bg-info text-white pt-3 pb-3">
        <h1 class="display3 text-center">Kvadruplák</h1>
    </div>
</div>

<div class="container">
    <table class="table table-hover mt-5 text-center">
        <tr>
            <th>1. nyerőszám</th>
            <th>2. nyerőszám</th>
            <th>3. nyerőszám</th>
            <th>4. nyerőszám</th>
            <th>Legelső sorsolása</th>
            <th>Legutolsó sorsolása</th>
            <th>Kisorsolva db</th>
            <th>Ismétlődött</th>
            <th>Háromszor ismétlődött</th>
            <th>Négyszer ismétlődött</th>
            <th>Ötször ismétlődött</th>
        </tr>
        <?php
        foreach ($Kvadruplas as $kvadrupla) {
            echo "<tr>";
            echo "<td>" . $kvadrupla->nyeroszam1 . "</td>";
            echo "<td>" . $kvadrupla->nyeroszam2 . "</td>";
            echo "<td>" . $kvadrupla->nyeroszam3 . "</td>";
            echo "<td>" . $kvadrupla->nyeroszam4 . "</td>";
            echo "<td>" . $kvadrupla->elsohuzas . "</td>";
            echo "<td>" . $kvadrupla->utolsohuzas . "</td>";
            echo "<td>" . $kvadrupla->huzasdb . "</td>";
            echo "<td>" . $kvadrupla->ismetlodes1 . "</td>";
            echo "<td>" . $kvadrupla->ismetlodes2 . "</td>";
            echo "<td>" . $kvadrupla->ismetlodes3 . "</td>";
            echo "<td>" . $kvadrupla->ismetlodes3 . "</td>";
            echo "</tr>";
        }
        ?>
    </table>

    <a class="btn btn-info text-white" href="index"> Vissza a nyitó oldalra <i class="far fa-plus-square"></i></a>
    
</div>
