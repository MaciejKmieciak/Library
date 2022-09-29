<meta charset="utf-8">
# Library<br>
pdb1MK1.sql - tables and triggers<br>
pdb1MK2.sql - RENTAL package specs<br>
pdb1MK3.sql - RENTAL package body<br>
pdb1MK4.sql - tests<br><br>

Lista zmian:<br>
[ZROBIONE] nvl()<br>
[ZROBIONE] Sprawdzenie poprawnosci danych wejsciowych w funkcjach<br>
Probowalem uzyc dbms_lock (funkcje GET_LOCATION_LOCKHANDLE, LOCK_LOCATION, RELEASE_LOCATION)<br>
ale nie rozumiem, czy blokuja one cala baze czy jak to dziala, <br>
bo nie widze sposobu, zeby zablokowac w ten sposob konkretne rekordy.<br>
https://www.oreilly.com/library/view/oracle-built-in-packages/1565923758/ch04.html<BR>

1. TRiggery przerobić
2. Exception przerobić