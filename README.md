<meta charset="utf-8">
# Library
pdb1MK1.sql - tables and triggers<br>
pdb1MK2.sql - RENTAL package specs<br>
pdb1MK3.sql - RENTAL package body<br>
pdb1MK4.sql - tests<br>

Ad 3. pick_author(author_id, name, ...) return author_id<br>
Jeżeli author_id is null to add_author()<br>
Ad 6. Tak samo jak ad 3.<br>
Ad 8. Rozwiązać problem blokady lokalizacji na poziomie całości zasobu<br>
Nowy czytelnik<br>
Ad 4. search_address() return address_id<br>
Rozpoczęcie wypożyczenia<br>
Ad 2. zwrócić też location_id<br>
------------------------------<br>
[DONE] IDENTITY zamiast sekwencji https://stackoverflow.com/questions/11296361/how-to-create-id-with-auto-increment-on-oracle<br>
[DONE] Przy próbie ręcznej zmiany kolumn audytujących, dodać komunikat<br>
[DONE] LOCATIONS usunąć checki lokalizacji<br>
[DONE] Wielkość liter przy wyszukiwaniu autora i tytułu<br>
[DONE] Porównywanie nulli<br>
obsługa wyjątków, własme treści komunikatów https://docs.oracle.com/cd/B10501_01/appdev.920/a96624/07_errs.htm<br>
AUTHORS_TITLES_RELATION insert into ... where not exists<br>
[DONE] Funkcje przeciążone<br>
=======================================================================<br>
[DONE] Na jednej tabeli trigger z exception;<br>
[DONE] nvl()<br>
[DONE] Sprawdzenie poprawności danych wejściowych<br>
Data zawsze z okresleniem formatu
Indeksy funkcyjne<br>
Rozwiązać problem blokady lokalizacji na poziomie całości zasobu<br>
Blokady: SX, TX<br>
https://jeffkemponoracle.com/2005/10/user-named-locks-with-dbms_lock/<br>