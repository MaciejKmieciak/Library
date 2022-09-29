CREATE TABLE AUTHORS(
    AUTHOR_ID NUMBER(10) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1), 
    FIRST_NAME VARCHAR2(100) NULL,
    LAST_NAME VARCHAR2(100) NOT NULL,
    BIRTH_DATE DATE NULL,
    DEATH_DATE DATE NULL,
    WHO_ADDED VARCHAR2(70) DEFAULT USER NOT NULL,
    WHEN_ADDED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    WHO_LAST_MOD VARCHAR2(70) NULL,
    WHEN_LAST_MOD TIMESTAMP NULL,
    CONSTRAINT AUTHORS_PK PRIMARY KEY (AUTHOR_ID),
    CONSTRAINT AUTHORS_CK_1 CHECK (BIRTH_DATE < DEATH_DATE)
);

CREATE OR REPLACE TRIGGER AUTHORS_TRIG
BEFORE INSERT OR UPDATE ON AUTHORS FOR EACH ROW
BEGIN
    /*IF 
        :NEW.WHO_ADDED IS NOT NULL OR 
        :NEW.WHEN_ADDED IS NOT NULL OR
        :NEW.WHO_LAST_MOD IS NOT NULL OR
        :NEW.WHEN_LAST_MOD IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('AUTHORS TABLE: AN ATTEMPT TO INTERFERE WITH AN AUDIT COLUMN WAS MADE');
    END IF;*/
    
    IF INSERTING THEN 
        :NEW.WHO_ADDED := USER;
        :NEW.WHEN_ADDED := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.WHO_ADDED := :OLD.WHO_ADDED;
        :NEW.WHEN_ADDED := :OLD.WHEN_ADDED;
        :NEW.WHO_LAST_MOD := USER;
        :NEW.WHEN_LAST_MOD := SYSDATE;
    END IF;
END;
/

-- =======================================================================

CREATE TABLE TITLES(
    TITLE_ID NUMBER(10) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
    TITLE VARCHAR2(250) NOT NULL,
    PUB_DATE DATE NULL,
    AGE_LIMIT NUMBER(2) DEFAULT 7 NOT NULL,
    TITLE_DESCRIPTION BLOB NULL,
    WHO_ADDED VARCHAR2(70) DEFAULT USER NOT NULL,
    WHEN_ADDED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    WHO_LAST_MOD VARCHAR2(70) NULL,
    WHEN_LAST_MOD TIMESTAMP NULL,
    CONSTRAINT TITLES_PK PRIMARY KEY (TITLE_ID),
    CONSTRAINT TITLES_CK_1 CHECK (AGE_LIMIT BETWEEN 7 AND 18)
);

CREATE OR REPLACE TRIGGER TITLES_TRIG
BEFORE INSERT OR UPDATE ON TITLES FOR EACH ROW
BEGIN
    /*IF 
        :NEW.WHO_ADDED IS NOT NULL OR 
        :NEW.WHEN_ADDED IS NOT NULL OR
        :NEW.WHO_LAST_MOD IS NOT NULL OR
        :NEW.WHEN_LAST_MOD IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('TITLES TABLE: AN ATTEMPT TO INTERFERE WITH AN AUDIT COLUMN WAS MADE');
    END IF;*/
    
    IF INSERTING THEN 
        :NEW.WHO_ADDED := USER;
        :NEW.WHEN_ADDED := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.WHO_ADDED := :OLD.WHO_ADDED;
        :NEW.WHEN_ADDED := :OLD.WHEN_ADDED;
        :NEW.WHO_LAST_MOD := USER;
        :NEW.WHEN_LAST_MOD := SYSDATE;
    END IF;
END;
/

-- =======================================================================

CREATE TABLE AUTHORS_TITLES(
    AUTHOR_ID NUMBER(10) NOT NULL,
    TITLE_ID NUMBER(10) NOT NULL,
    WHO_ADDED VARCHAR2(70) DEFAULT USER NOT NULL,
    WHEN_ADDED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    WHO_LAST_MOD VARCHAR2(70) NULL,
    WHEN_LAST_MOD TIMESTAMP NULL,
    CONSTRAINT AUTHORS_TITLES_PK PRIMARY KEY (AUTHOR_ID, TITLE_ID),
    CONSTRAINT AUTHORS_TITLES_FK_1 FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHORS(AUTHOR_ID),
    CONSTRAINT AUTHORS_TITLES_FK_2 FOREIGN KEY (TITLE_ID) REFERENCES TITLES(TITLE_ID)
);

CREATE OR REPLACE TRIGGER AUTHORS_TITLES_TRIG
BEFORE INSERT OR UPDATE ON AUTHORS_TITLES FOR EACH ROW
DECLARE
    AUDIT_COL_INTERFERE EXCEPTION;
BEGIN
    /*IF 
        :NEW.WHO_ADDED IS NOT NULL OR 
        :NEW.WHEN_ADDED IS NOT NULL OR
        :NEW.WHO_LAST_MOD IS NOT NULL OR
        :NEW.WHEN_LAST_MOD IS NOT NULL THEN
            RAISE AUDIT_COL_INTERFERE;
    END IF;*/
    
    IF INSERTING THEN 
        :NEW.WHO_ADDED := USER;
        :NEW.WHEN_ADDED := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.WHO_ADDED := :OLD.WHO_ADDED;
        :NEW.WHEN_ADDED := :OLD.WHEN_ADDED;
        :NEW.WHO_LAST_MOD := USER;
        :NEW.WHEN_LAST_MOD := SYSDATE;
    END IF;
EXCEPTION
    WHEN AUDIT_COL_INTERFERE THEN 
        DBMS_OUTPUT.PUT_LINE('AUTHORS_TITLES TABLE: AN ATTEMPT TO INTERFERE WITH AN AUDIT COLUMN WAS MADE');
END;
/

-- =======================================================================

CREATE TABLE LOCATIONS(
    LOCATION_ID NUMBER(10) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
    CORRIDOR NUMBER(2) NOT NULL,
    RACK NUMBER(2) NOT NULL,
    SHELF NUMBER(2) NOT NULL,
    EMPTY_SPOTS_LEFT NUMBER(10) DEFAULT 12 NOT NULL,
    WHO_ADDED VARCHAR2(70) DEFAULT USER NOT NULL,
    WHEN_ADDED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    WHO_LAST_MOD VARCHAR2(70) NULL,
    WHEN_LAST_MOD TIMESTAMP NULL,
    CONSTRAINT LOCATIONS_PK PRIMARY KEY (LOCATION_ID)
);

CREATE OR REPLACE TRIGGER LOCATIONS_TRIG
BEFORE INSERT OR UPDATE ON LOCATIONS FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:old.when_added);
    DBMS_OUTPUT.PUT_LINE(:old.when_last_mod);
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE(:new.when_added);
    DBMS_OUTPUT.PUT_LINE(:new.when_last_mod);
    
    IF 
        :NEW.WHO_ADDED != nvl(:OLD.WHO_ADDED, USER) OR 
        :NEW.WHEN_ADDED != nvl(:OLD.WHEN_ADDED, SYSDATE) OR
        :NEW.WHO_LAST_MOD != nvl(:OLD.WHO_LAST_MOD, '234234234') OR
        :NEW.WHEN_LAST_MOD != nvl(:OLD.WHEN_LAST_MOD, sysdate-1)
        THEN
            DBMS_OUTPUT.PUT_LINE('LOCATIONS TABLE: AN ATTEMPT TO INTERFERE WITH AN AUDIT COLUMN WAS MADE');
            raise value_error; --exception i komunikat
    END IF;
    
    IF INSERTING THEN 
        :NEW.WHO_ADDED := USER;
        :NEW.WHEN_ADDED := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.WHO_ADDED := :OLD.WHO_ADDED;
        :NEW.WHEN_ADDED := :OLD.WHEN_ADDED;
        :NEW.WHO_LAST_MOD := USER;
        :NEW.WHEN_LAST_MOD := SYSDATE;
    END IF;
END;
/

-- =======================================================================

CREATE TABLE BOOKS(
    BOOK_ID NUMBER(10) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1),
    TITLE_ID NUMBER(10) NOT NULL,
    BORROW_STATE VARCHAR2(70) NOT NULL,
    LOCATION_ID NUMBER(10) NULL,
    BOOK_VALUE NUMBER(10, 2) NOT NULL,
    CONDITION NUMBER(1) NOT NULL,
    BUY_DATE DATE NOT NULL,
    WHO_ADDED VARCHAR2(70) DEFAULT USER NOT NULL,
    WHEN_ADDED TIMESTAMP DEFAULT SYSDATE NOT NULL,
    WHO_LAST_MOD VARCHAR2(70) NULL,
    WHEN_LAST_MOD TIMESTAMP NULL,
    CONSTRAINT BOOKS_PK PRIMARY KEY (BOOK_ID),
    CONSTRAINT BOOKS_FK_1 FOREIGN KEY (TITLE_ID) REFERENCES TITLES(TITLE_ID),
    CONSTRAINT BOOKS_FK_2 FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID),
    CONSTRAINT BOOKS_CK_1 CHECK (BORROW_STATE IN ('IN BORROW', 'IN STORAGE', 'LOST OR DESTROYED', 'STORAGE QUEUE')),
    CONSTRAINT BOOKS_CK_2 CHECK (BOOK_VALUE > 0),
    CONSTRAINT BOOKS_CK_3 CHECK (CONDITION BETWEEN 1 AND 5),
    CONSTRAINT BOOKS_CK_4 CHECK (BUY_DATE >= DATE '2022-09-01')
);

CREATE OR REPLACE TRIGGER BOOKS_TRIG
BEFORE INSERT OR UPDATE ON BOOKS FOR EACH ROW
BEGIN
    /*IF 
        :NEW.WHO_ADDED IS NOT NULL OR 
        :NEW.WHEN_ADDED IS NOT NULL OR
        :NEW.WHO_LAST_MOD IS NOT NULL OR
        :NEW.WHEN_LAST_MOD IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('BOOKS TABLE: AN ATTEMPT TO INTERFERE WITH AN AUDIT COLUMN WAS MADE');
    END IF;*/
    
    IF INSERTING THEN 
        :NEW.WHO_ADDED := USER;
        :NEW.WHEN_ADDED := SYSDATE;
    ELSIF UPDATING THEN
        :NEW.WHO_ADDED := :OLD.WHO_ADDED;
        :NEW.WHEN_ADDED := :OLD.WHEN_ADDED;
        :NEW.WHO_LAST_MOD := USER;
        :NEW.WHEN_LAST_MOD := SYSDATE;
    END IF;
END;
/