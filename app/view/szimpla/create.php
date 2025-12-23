
<form action="" method="POST">
    <label for="lastName">Vezezéknév*</label><br>
    <input type="text" name="employee[lastName]" id="lastName" required><br>
    <label for="firstName">Keresztnév*</label><br>
    <input type="text" name="employee[firstName]" id="firstName" required><br>
    <label for="employeeCategory">Beosztás*</label><br>
    <select name="employee[employeeCategory]" id="employeeCategory"><br>
        <option value="1">Programozó</option>
        <option value="2">Grafikus</option>
        <option value="3">Ügyintéző</option>
    </select><br><br>
    <label for="salary">Fizetés</label><br>
    <input type="number" name="employee[salary]" id="salary"><br>
    <label for="jobStart">Munkavégzés kezdete*</label><br>
    <input type="date" name="employee[jobStart]" id="jobStart" required><br>
    <label for="status">Aktív*</label><br>
    <input type="checkbox" name="employee[status]" id="status"><br><br>
    <input type="submit" name="save" value="MENTÉS">
</form>




