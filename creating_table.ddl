/*Creating table, sequence and constrain*/

--Actors
CREATE TABLE actors (
    actor_id    NUMBER(10) NOT NULL,
    stage_name  VARCHAR2(40 CHAR) NOT NULL,
    first_name  VARCHAR2(25 CHAR) NOT NULL,
    last_name   VARCHAR2(25 CHAR) NOT NULL,
    birth_date  DATE NOT NULL
);

ALTER TABLE actors ADD CONSTRAINT actors_pk PRIMARY KEY ( actor_id );

ALTER TABLE actors ADD CONSTRAINT actors__un UNIQUE ( actor_id );

CREATE SEQUENCE actor_id_seq
INCREMENT BY 10
START WITH 1001
MAXVALUE 2001
NOCACHE
NOCYCLE;

--Customer
CREATE TABLE costumers (
    costumer_id  NUMBER(10) NOT NULL,
    last_name    VARCHAR2(25 CHAR) NOT NULL,
    first_name   VARCHAR2(25 CHAR) NOT NULL,
    home_phone   VARCHAR2(12 CHAR) NOT NULL,
    address      VARCHAR2(100 CHAR) NOT NULL,
    city         VARCHAR2(30 CHAR) NOT NULL,
    state        VARCHAR2(2 CHAR) NOT NULL,
    email        VARCHAR2(25 CHAR),
    cell_phone   VARCHAR2(12 CHAR)
);

ALTER TABLE costumers ADD CONSTRAINT costumers_pk PRIMARY KEY ( costumer_id );

ALTER TABLE costumers ADD CONSTRAINT costumers__un UNIQUE ( costumer_id );

CREATE SEQUENCE cust_id_seq
INCREMENT BY 10
START WITH 101
MAXVALUE 201
NOCACHE
NOCYCLE;

--Media
CREATE TABLE media (
    media_id         NUMBER(10) NOT NULL,
    format           VARCHAR2(3 CHAR) NOT NULL,
    movies_title_id  NUMBER(10) NOT NULL
);

ALTER TABLE media ADD CONSTRAINT media_pk PRIMARY KEY ( media_id );

ALTER TABLE media ADD CONSTRAINT media__un UNIQUE ( media_id );

CREATE SEQUENCE med_id_seq
INCREMENT BY 1
START WITH 901
MAXVALUE 999
NOCACHE
NOCYCLE;

--Movies
CREATE TABLE movies (
    title_id      NUMBER(10) NOT NULL,
    title         VARCHAR2(60 CHAR) NOT NULL,
    description   VARCHAR2(400 CHAR) NOT NULL,
    rating        VARCHAR2(4 CHAR),
    category      VARCHAR2(20 CHAR) NOT NULL,
    release_date  DATE NOT NULL
);

ALTER TABLE movies ADD CONSTRAINT movies_pk PRIMARY KEY ( title_id );

ALTER TABLE movies ADD CONSTRAINT movies__un UNIQUE ( title_id );

ALTER TABLE movies ADD CONSTRAINT movies_rating_ck CHECK (rating IN ('G','PG','PG13','R'));

ALTER TABLE movies ADD CONSTRAINT movies_category_ck CHECK (category IN ('DRAMA','COMEDY','ACTION','CHILD','SCIFI','DOCUMENTARY'));

CREATE SEQUENCE title_id_seq
INCREMENT BY 10
START WITH 1
MAXVALUE 101
NOCACHE
NOCYCLE;

--Rental_History
CREATE TABLE rental_history (
    rental_date            DATE NOT NULL,
    return_date            DATE,
    costumers_costumer_id  NUMBER(10) NOT NULL,
    media_media_id         NUMBER(10) NOT NULL
);

UPDATE rental_history
SET rental_date = DEFAULT

ALTER TABLE rental_history ADD CONSTRAINT rental_history_pk PRIMARY KEY ( rental_date,
                                                                          media_media_id );
  
ALTER TABLE rental_history ADD CONSTRAINT rental_history__un UNIQUE ( media_media_id );

--Star_Billings
CREATE TABLE star_billings (
    "comment"        VARCHAR2(40 CHAR),
    movies_title_id  NUMBER(10) NOT NULL,
    actors_actor_id  NUMBER(10) NOT NULL
);

ALTER TABLE star_billings ADD CONSTRAINT star_billings_pk PRIMARY KEY ( movies_title_id,
                                                                        actors_actor_id );

ALTER TABLE media
    ADD CONSTRAINT media_movies_fk FOREIGN KEY ( movies_title_id )
        REFERENCES movies ( title_id );

ALTER TABLE rental_history
    ADD CONSTRAINT rental_history_costumers_fk FOREIGN KEY ( costumers_costumer_id )
        REFERENCES costumers ( costumer_id );

ALTER TABLE rental_history
    ADD CONSTRAINT rental_history_media_fk FOREIGN KEY ( media_media_id )
        REFERENCES media ( media_id );

ALTER TABLE star_billings
    ADD CONSTRAINT star_billings_actors_fk FOREIGN KEY ( actors_actor_id )
        REFERENCES actors ( actor_id );

ALTER TABLE star_billings
    ADD CONSTRAINT star_billings_movies_fk FOREIGN KEY ( movies_title_id )
        REFERENCES movies ( title_id );


