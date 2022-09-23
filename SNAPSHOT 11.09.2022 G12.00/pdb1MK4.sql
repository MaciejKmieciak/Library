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