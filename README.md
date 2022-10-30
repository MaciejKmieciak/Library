<meta charset="utf-8">
# Library<br>
pdb1MK1.sql - tables and triggers<br>
pdb1MK2.sql - RENTAL package specs<br>
pdb1MK3.sql - RENTAL package body<br>
pdb1MK4.sql - tests<br>
<br>

1. Lock dla kazdej lokalizcji przed okresleniem ilosci wolnych miejsc
2. Obsluga bledow, savepoint, rollback to savepoint
3. Testy wszystkiego

12.10.2022:<br>
Dodano funkcje LOCK_LOCATION, RELEASE_LOCK_LOCATION oraz DELIVERY<br>
Test dzialania jest w pdb1MK4.sql<br>
<br>

29.09.2022:<br>
[ZROBIONE] nvl()<br>
[ZROBIONE] Sprawdzenie poprawnosci danych wejsciowych w funkcjach<br>
Probowalem uzyc dbms_lock (funkcje GET_LOCATION_LOCKHANDLE, LOCK_LOCATION, RELEASE_LOCATION)<br>
ale nie rozumiem, czy blokuja one cala baze czy jak to dziala, <br>
bo nie widze sposobu, zeby zablokowac w ten sposob konkretne rekordy.<br>
https://www.oreilly.com/library/view/oracle-built-in-packages/1565923758/ch04.html<BR>
<br>

29.09.2022: <br>
[ZROBIONE] 1. Triggery przerobic<br>
[ZROBIONE] 2. Exception przerobic<br>