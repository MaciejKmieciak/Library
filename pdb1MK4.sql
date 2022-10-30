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

 -- ----------------------------------------------------------------------------------
 -- TEST FUNKCJI DELIVERY()
 -- ----------------------------------------------------------------------------------

SET SERVEROUTPUT ON;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT * FROM SYS.dbms_lock_allocated;

DECLARE
    T_DELIVERY_PART1 RENTAL.DELIVERY_PART;
    T_DELIVERY_PART2 RENTAL.DELIVERY_PART;
    
    T_DELIVERY_DICTIONARY RENTAL.DELIVERY_DICTIONARY;
    
    T_AUTHORS RENTAL.AUTHORS := RENTAL.AUTHORS();
    T_AUTHOR RENTAL.AUTHOR_RECORD;
    T_TITLE RENTAL.TITLE_RECORD;
    T_AMOUNT NUMBER := 23;
    T_ADDED_BOOKS_VALUE NUMBER := 10.5;
    T_ADDED_BOOKS_CONDITION NUMBER := 4;
    T_ADDED_BOOKS_BUY_DATE DATE := NULL;
    
    RETURNED_ID_ARRAY RENTAL.ID_ARRAY;
BEGIN

    T_AUTHOR := RENTAL.AUTHOR_RECORD('Maciej', 'Kmieciak', to_date('3021-01-01', 'yyyy-mm-dd'), null);
    T_AUTHORS.EXTEND(1);
    T_AUTHORS(1) := T_AUTHOR;
    T_TITLE := RENTAL.TITLE_RECORD('Tytul testowy', to_date('2009-01-04', 'yyyy-mm-dd'), 13, null);
    
    T_DELIVERY_PART1 := RENTAL.DELIVERY_PART(
                                            T_AUTHORS
                                           ,T_TITLE
                                           ,T_AMOUNT
                                           ,T_ADDED_BOOKS_VALUE
                                           ,T_ADDED_BOOKS_CONDITION
                                           ,T_ADDED_BOOKS_BUY_DATE);
                                           
                                           
    T_AUTHOR := RENTAL.AUTHOR_RECORD('Maciej2', 'Kmieciak2', to_date('2001-12-12', 'yyyy-mm-dd'), null);
    T_AUTHORS(1) := T_AUTHOR;
    T_TITLE := RENTAL.TITLE_RECORD('Tytul testowy2', to_date('2011-01-04', 'yyyy-mm-dd'), 16, null);
    
    T_DELIVERY_PART2 := RENTAL.DELIVERY_PART(
                                            T_AUTHORS
                                           ,T_TITLE
                                           ,T_AMOUNT
                                           ,T_ADDED_BOOKS_VALUE
                                           ,T_ADDED_BOOKS_CONDITION
                                           ,T_ADDED_BOOKS_BUY_DATE);
                                           
    T_DELIVERY_DICTIONARY := RENTAL.DELIVERY_DICTIONARY();
    T_DELIVERY_DICTIONARY.EXTEND(2);
    T_DELIVERY_DICTIONARY(1) := T_DELIVERY_PART1;
    T_DELIVERY_DICTIONARY(2) := T_DELIVERY_PART2; 
    
    --    T_DELIVERY_DICTIONARY := RENTAL.DELIVERY_DICTIONARY();
    --    T_DELIVERY_DICTIONARY.EXTEND(1);
    --    T_DELIVERY_DICTIONARY(1) := T_DELIVERY_PART1;
    
    RETURNED_ID_ARRAY := RENTAL.DELIVERY(T_DELIVERY_DICTIONARY);
    
    FOR I IN 1..RETURNED_ID_ARRAY.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(RETURNED_ID_ARRAY(I));
    END LOOP;
END;
/
 -- ----------------------------------------------------------------------------------
 -- ----------------------------------------------------------------------------------

SELECT * FROM AUTHORS;
SELECT * FROM TITLES;
SELECT * FROM BOOKS;
SELECT COUNT(BOOK_ID) FROM BOOKS;
SELECT * FROM LOCATIONS ORDER BY CORRIDOR, RACK, SHELF;
TRUNCATE TABLE BOOKS;
BEGIN
    RENTAL.INITIATE_LOCATIONS;
END;
/
DECLARE
    RET INTEGER;
BEGIN
    RET := RENTAL.LOCK_LOCATION(4824);
    DBMS_OUTPUT.PUT_LINE(RET);
END;
/

commit;