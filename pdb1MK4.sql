DECLARE
    LOCAL_TITLE RENTAL.TITLE_RECORD;
    DESCRIPTION_VARCHAR VARCHAR2(4000) := 'Amers is a collection of poetry 
    by French writer Saint-John Perse, published in 1957. Perse won 
    the Nobel Prize in Literature three years later. The title means 
    "sea marks" (points used to navigate at sea, both manmade and 
    natural); it possibly puns on the French amer(s), "bitter", 
    perhaps meaning "briny" here, and has echoes of mer, "sea".';
    DESCRIPTION_BLOB BLOB;
    RETURNED_ID NUMBER(10);
BEGIN
    DESCRIPTION_BLOB := utl_raw.cast_to_raw(DESCRIPTION_VARCHAR);
    LOCAL_TITLE := RENTAL.TITLE_RECORD('Amers', DATE '1957-01-01', 13, DESCRIPTION_BLOB);
    RETURNED_ID := RENTAL.ADD_TITLE(LOCAL_TITLE);
    DBMS_OUTPUT.PUT_LINE(RETURNED_ID);
END;
/

SELECT * FROM TITLES;

DECLARE
    LOCAL_TITLE RENTAL.TITLE_RECORD;
    DESCRIPTION_VARCHAR VARCHAR2(4000) := 'BLA BLA BLA';
    DESCRIPTION_BLOB BLOB;
    RETURNED_ID NUMBER(10);
BEGIN
    DESCRIPTION_BLOB := utl_raw.cast_to_raw(DESCRIPTION_VARCHAR);
    LOCAL_TITLE := RENTAL.TITLE_RECORD('DLA DZIECI', DATE '1957-01-01', 6, DESCRIPTION_BLOB);
    RETURNED_ID := RENTAL.ADD_TITLE(LOCAL_TITLE);
    DBMS_OUTPUT.PUT_LINE(RETURNED_ID);
END;
/

SELECT * FROM AUTHORS;
SELECT * FROM TITLES;

DECLARE
    LOCAL_RELATION_AUTHORS RENTAL.ID_ARRAY;
    LOCAL_RELATION_TITLE_ID NUMBER := 1;
    RETURNED_AMOUNT_OF_RELATIONS NUMBER;
BEGIN
    LOCAL_RELATION_AUTHORS := RENTAL.ID_ARRAY();
    LOCAL_RELATION_AUTHORS.EXTEND(2);
    LOCAL_RELATION_AUTHORS(1) := 3;
    LOCAL_RELATION_AUTHORS(2) := 41;
    
    RETURNED_AMOUNT_OF_RELATIONS := 
        RENTAL.AUTHORS_TITLES_RELATION(LOCAL_RELATION_AUTHORS, LOCAL_RELATION_TITLE_ID);
        
    DBMS_OUTPUT.PUT_LINE(RETURNED_AMOUNT_OF_RELATIONS);
END;
/

SELECT * FROM AUTHORS_TITLES;
TRUNCATE TABLE AUTHORS_TITLES;
SET SERVEROUTPUT ON;
DELETE FROM AUTHORS_TITLES WHERE AUTHOR_ID = 41 AND TITLE_ID = 1;

BEGIN
    FOR I IN 1..RENTAL.LOCATIONS_CORRIDOR_NUMBER LOOP
        FOR J IN 1..RENTAL.LOCATIONS_RACK_NUMBER LOOP
            FOR K IN 1..RENTAL.LOCATIONS_SHELF_NUMBER LOOP
                INSERT INTO LOCATIONS (CORRIDOR, RACK, SHELF) VALUES (I, J, K);
            END LOOP;
        END LOOP;
    END LOOP;
END;
/

SELECT * FROM LOCATIONS;
SELECT * FROM LOCATIONS ORDER BY LOCATION_ID;
SELECT * FROM LOCATIONS ORDER BY CORRIDOR, RACK, SHELF;
SELECT * FROM TITLES;

SET SERVEROUTPUT ON;

DECLARE
    BOOKS_AMOUNT NUMBER := 19;
    SINGLE_LOCATION_SPOTS RENTAL.LOCATION_SPOTS := RENTAL.LOCATION_SPOTS();
    RETURNED_DICTIONARY RENTAL.LOCATIONS_DICTIONARY := RENTAL.LOCATIONS_DICTIONARY();
    RETURNED_BOOK_IDS RENTAL.ID_ARRAY;
BEGIN
    RETURNED_DICTIONARY := RENTAL.GET_LOCATION_LIST(BOOKS_AMOUNT);
    DBMS_OUTPUT.PUT_LINE('DICTIONARY OF LOCATIONS RETURNED');
    DBMS_OUTPUT.PUT_LINE('');
    FOR I IN 1..RETURNED_DICTIONARY.LAST LOOP
        SINGLE_LOCATION_SPOTS := RETURNED_DICTIONARY(I);
        DBMS_OUTPUT.PUT_LINE(SINGLE_LOCATION_SPOTS.LOCATION_ID || ': ' ||
            SINGLE_LOCATION_SPOTS.NUMBER_OF_EMPTY_SPOTS);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('ADDING BOOKS NOW...');
    RETURNED_BOOK_IDS := RENTAL.ADD_BOOKS(
        1,
        BOOKS_AMOUNT,
        RETURNED_DICTIONARY,
        19.99,
        5,
        DATE '2022-09-08'
    );
    
    
END;
/
rollback;
select * from books;
select * from authors;
set serveroutput on;

SELECT COUNT(*) FROM BOOKS WHERE LOCATION_ID = 2;
SELECT * FROM BOOKS WHERE LOCATION_ID = 2;
SELECT * FROM BOOKS;
SELECT * FROM LOCATIONS;
SELECT DISTINCT WHEN_ADDED FROM BOOKS WHERE LOCATION_ID = 2;
TRUNCATE TABLE BOOKS;
select * from authors;

DECLARE
    AUTHOR_TO_ADD RENTAL.AUTHOR_RECORD;
    RETURNED_ID NUMBER;
BEGIN
    AUTHOR_TO_ADD := RENTAL.AUTHOR_RECORD('a', 'B', NULL, NULL);
    RETURNED_ID := RENTAL.SEARCH_AUTHOR(AUTHOR_TO_ADD);
    DBMS_OUTPUT.PUT_LINE(RETURNED_ID);
END;
/

select * from locations;
UPDATE LOCATIONS SET EMPTY_SPOTS_LEFT = 12;
SELECT * FROM AUTHORS;
SELECT * FROM BOOKS;
TRUNCATE TABLE BOOKS;
INSERT INTO AUTHORS (FIRST_NAME, LAST_NAME, WHO_ADDED) VALUES ('GARGAMEL', 'SMERF', 'INTRUZ');
DELETE FROM AUTHORS WHERE AUTHOR_ID = 42;
    SET SERVEROUTPUT ON;

DECLARE
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(RENTAL.SEARCH_AUTHOR('Malcolm', 'Lowry', to_date('28.07.1909', 'dd.mm.yyyy'), to_date('26.06.1957', 'dd.mm.yyyy')));
    DBMS_OUTPUT.PUT_LINE(RENTAL.SEARCH_AUTHOR('Malcolm', null, null, null) || '< NULL');
    DBMS_OUTPUT.PUT_LINE(RENTAL.SEARCH_AUTHOR('Saint-John', 'Franquin', null, null) || '< NULL');
    DBMS_OUTPUT.PUT_LINE(RENTAL.SEARCH_AUTHOR('Saint-John', 'Perse', null, null));
END;
/

select sysdate from dual;
select to_char(sysdate, 'dd.mm.yyyy') from dual;
select to_date('15.09.2021', 'dd.mm.yyyy') from dual;
select to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss') from dual;
select sysdate-trunc(sysdate) from dual;
alter session set nls_date_format = 'dd.mm.yyyy';
alter system set nls_date_format='dd.mm.yyyy' scope=both;

SELECT AUTHOR_ID FROM AUTHORS WHERE 
            (UPPER(NVL(FIRST_NAME, '9438H45TG45')) = UPPER(NVL(AUTHOR_TO_SEARCH.FIRST_NAME, '9438H45TG45')))
        AND 
            (UPPER(LAST_NAME) = UPPER(AUTHOR_TO_SEARCH.LAST_NAME))
        AND 
            (NVL(BIRTH_DATE, SYSDATE) = NVL(AUTHOR_TO_SEARCH.BIRTH_DATE, SYSDATE))
        AND 
            (NVL(DEATH_DATE, SYSDATE) = NVL(AUTHOR_TO_SEARCH.DEATH_DATE, SYSDATE));
            
select count(*) from dba_objects;
select * from V$LOCK;
select * from V$SESSION;
commit;

select * from dba_triggers where table_name='LOCATIONS';

insert into locations (corridor, rack, shelf) values (99, 99, 99);
insert into locations (corridor, rack, shelf, who_added) values (93, 99, 99, 'xy');
select * from locations where location_id=1202;
select * from locations order by location_id desc;
update locations set who_last_mod = 'xy' where location_id = 1202;
update locations set rack = 92 where location_id = 1212;
update locations set who_last_mod = 'xy' where location_id = 1212;

declare
    returned number;
begin
    returned := rental.pick_title(1, null, null, null, null);
end;
/

declare
return_code integer;
temp_LOCKHANDLE varchar2(128);
begin
            DBMS_LOCK.ALLOCATE_UNIQUE(
            LOCKNAME => 'blablabla',
            LOCKHANDLE => temp_LOCKHANDLE);
        RETURN_CODE := DBMS_LOCK.REQUEST(
                        LOCKHANDLE => temp_LOCKHANDLE,
                        LOCKMODE => DBMS_LOCK.X_MODE,
                        TIMEOUT => 60,
                        RELEASE_ON_COMMIT => TRUE);
                        dbms_output.put_line(temp_LOCKHANDLE);
                    dbms_output.put_line(return_code);
end;
/
rollback;
commit;