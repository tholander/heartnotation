DROP DATABASE IF EXISTS heartnotation;
DROP ROLE IF EXISTS heart;

CREATE USER heart createdb createrole password 'cardiologs';

CREATE DATABASE heartnotation OWNER heart;

\connect heartnotation

-- TABLES INIT

DROP TABLE IF EXISTS ORGANIZATION CASCADE;
CREATE TABLE ORGANIZATION (
	id SERIAL PRIMARY KEY,
	name varchar(30) UNIQUE,
	is_active boolean NOT NULL
);

DROP TABLE IF EXISTS STATUS CASCADE;
CREATE TABLE STATUS (
	id SERIAL PRIMARY KEY,
	name varchar(30),
	is_active boolean NOT NULL
);

DROP TABLE IF EXISTS USERROLE CASCADE;
CREATE TABLE USERROLE (
	id SERIAL PRIMARY KEY,
	name varchar(30),
	is_active boolean NOT NULL
);

DROP TABLE IF EXISTS USERPROFILE CASCADE;
CREATE TABLE USERPROFILE (
	id SERIAL PRIMARY KEY,
	role_id bigint REFERENCES USERROLE(id) ON DELETE CASCADE ON UPDATE CASCADE,
	mail varchar(30),
	is_active boolean NOT NULL,
	UNIQUE(mail)
);

DROP TABLE IF EXISTS ORGANIZATION_USER CASCADE;
CREATE TABLE ORGANIZATION_USER (
	organization_id bigint,
	user_id bigint,
	PRIMARY KEY(organization_id, user_id),
	CONSTRAINT FK_orga FOREIGN KEY (organization_id) REFERENCES ORGANIZATION(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_user FOREIGN KEY (user_id) REFERENCES USERPROFILE(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS ANNOTATION CASCADE;
CREATE TABLE ANNOTATION (
	id SERIAL PRIMARY KEY,
	name varchar(30),
	parent_id bigint REFERENCES ANNOTATION(id) ON DELETE CASCADE ON UPDATE CASCADE,
	organization_id bigint REFERENCES ORGANIZATION(id) ON DELETE CASCADE ON UPDATE CASCADE,
	status_id bigint REFERENCES STATUS(id) ON DELETE CASCADE ON UPDATE CASCADE,
	signal_id bigint NOT NULL,
	annotation_comment varchar(180),
	creation_date timestamp NOT NULL,
	edit_date timestamp NOT NULL,
	is_active boolean NOT NULL,
	is_editable boolean NOT NULL
);

DROP TABLE IF EXISTS INTERVAL CASCADE;
CREATE TABLE INTERVAL (
	id SERIAL PRIMARY KEY,
	timestamp_start int NOT NULL,
	timestamp_end bigint NOT NULL
);

DROP TABLE IF EXISTS ANNOTATION_INTERVAL_USER CASCADE;
CREATE TABLE ANNOTATION_INTERVAL_USER (
	id SERIAL PRIMARY KEY,
	annotation_id bigint REFERENCES ANNOTATION(id) ON DELETE CASCADE ON UPDATE CASCADE,
	interval_id bigint REFERENCES INTERVAL(id) ON DELETE CASCADE ON UPDATE CASCADE,
	user_id bigint REFERENCES USERPROFILE(id) ON DELETE CASCADE ON UPDATE CASCADE,
	comment varchar(180),
	date timestamp NOT NULL
);

DROP TABLE IF EXISTS TAG CASCADE;
CREATE TABLE TAG (
	id SERIAL PRIMARY KEY,
	parent_id bigint REFERENCES TAG(id) ON DELETE CASCADE ON UPDATE CASCADE,
	name varchar(30) NOT NULL,
	color varchar(30) NOT NULL,
	is_active boolean NOT NULL
);

DROP TABLE IF EXISTS ANNOTATION_TAG CASCADE;
CREATE TABLE ANNOTATION_TAG (
	id SERIAL PRIMARY KEY,
	annotation_id bigint REFERENCES ANNOTATION(id) ON DELETE CASCADE ON UPDATE CASCADE,
	tag_id bigint REFERENCES TAG(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS INTERVAL_TAG CASCADE;
CREATE TABLE INTERVAL_TAG (
	id SERIAL PRIMARY KEY,
	interval_id bigint REFERENCES INTERVAL(id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	tag_id bigint REFERENCES TAG(id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL
);

DROP TABLE IF EXISTS OPERATOR_OF CASCADE;
CREATE TABLE OPERATOR_OF (
	id SERIAL PRIMARY KEY,
	user_id bigint REFERENCES USERPROFILE(id) ON DELETE CASCADE ON UPDATE CASCADE,
	status_id bigint REFERENCES STATUS(id) ON DELETE CASCADE ON UPDATE CASCADE,
	annotation_id bigint REFERENCES ANNOTATION(id) ON DELETE CASCADE ON UPDATE CASCADE,
	operation_time timestamp
);

DROP TABLE IF EXISTS ANNOTATION_USER;
CREATE TABLE ANNOTATION_USER (
	id SERIAL PRIMARY KEY,
	user_id bigint REFERENCES USERPROFILE(id) ON DELETE CASCADE ON UPDATE CASCADE,
	annotation_id bigint REFERENCES ANNOTATION(id) ON DELETE CASCADE ON UPDATE CASCADE,
	comment varchar(360),
	date timestamp NOT NULL
);

ALTER TABLE ORGANIZATION OWNER TO heart;
ALTER TABLE STATUS OWNER TO heart;
ALTER TABLE USERROLE OWNER TO heart;
ALTER TABLE USERPROFILE OWNER TO heart;
ALTER TABLE ORGANIZATION_USER OWNER TO heart;
ALTER TABLE ANNOTATION OWNER TO heart;
ALTER TABLE INTERVAL OWNER TO heart;
ALTER TABLE ANNOTATION_INTERVAL_USER OWNER TO heart;
ALTER TABLE TAG OWNER TO heart;
ALTER TABLE INTERVAL_TAG OWNER TO heart;
ALTER TABLE OPERATOR_OF OWNER TO heart;
ALTER TABLE ANNOTATION_TAG OWNER TO heart;
ALTER TABLE ANNOTATION_USER OWNER TO heart;


-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------

-- DATAS INIT

-- ORGANIZATION

INSERT INTO ORGANIZATION (name, is_active) 
	VALUES ('Cardiologs', TRUE);

INSERT INTO ORGANIZATION (name, is_active) 
	VALUES ('Podologs', TRUE);

INSERT INTO ORGANIZATION (name, is_active) 
	VALUES ('Heartnotalogs', TRUE);

INSERT INTO ORGANIZATION (name, is_active) 
	VALUES ('Gynecologs', TRUE);

-- USERROLE

INSERT INTO USERROLE (name, is_active) 
	VALUES ('Annotateur', TRUE);

INSERT INTO USERROLE (name, is_active) 
	VALUES ('Gestionnaire', TRUE);

INSERT INTO USERROLE (name, is_active) 
	VALUES ('Admin', TRUE);

--  USERPROFILE
INSERT INTO USERPROFILE (role_id, mail, is_active)  
	VALUES (3, 'holandertheo@gmail.com', TRUE);

INSERT INTO USERPROFILE (role_id, mail, is_active) 
	VALUES (3, 'rolex.taing@gmail.com', TRUE);

INSERT INTO USERPROFILE (role_id, mail, is_active) 
	VALUES (2, 'marvin.leclerc31@gmail.com', TRUE);

INSERT INTO USERPROFILE (role_id, mail, is_active)  
	VALUES (1, 'socarboni@gmail.com', TRUE);

INSERT INTO USERPROFILE (role_id, mail, is_active)  
	VALUES (1, 'romain.phet@gmail.com', TRUE);

INSERT INTO USERPROFILE (role_id, mail, is_active)  
	VALUES (2, 'alex.pliez@gmail.com', TRUE);

INSERT INTO USERPROFILE (role_id, mail, is_active)  
	VALUES (1, 'Saidkhalid@gmail.com', TRUE);

-- STATUS

INSERT INTO STATUS (name, is_active) 
	VALUES ('CREATED', TRUE);

INSERT INTO STATUS (name, is_active)  
	VALUES ('ASSIGNED', TRUE);

INSERT INTO STATUS (name, is_active)  
	VALUES ('IN_PROCESS', TRUE);

INSERT INTO STATUS (name, is_active) 
	VALUES ('COMPLETED', TRUE);

INSERT INTO STATUS (name, is_active) 
	VALUES ('VALIDATED', TRUE);

INSERT INTO STATUS (name, is_active) 
	VALUES ('CANCELED', TRUE);

-- ORGANIZATION USER
-- Marvin
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (1, 3);
-- Marvin
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (2, 3);
-- Marvin
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (3, 3);
-- Théo
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (3, 1);
-- Rolex
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (2, 2);
-- Sophie	
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (2, 4);
-- Romain
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (4, 5);
-- Alex
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (4, 6);
-- Said
INSERT INTO ORGANIZATION_USER (organization_id, user_id) 
	VALUES (4, 7);
-- ANNOTATION

INSERT INTO ANNOTATION (parent_id, name, organization_id, status_id, signal_id, annotation_comment, creation_date, edit_date, is_active, is_editable) 
	VALUES (NULL, 'Annotation 1', 1, 1, 1, 'Première annotation', '2004-10-19 10:23:54', '2012-12-29 17:19:54', TRUE, TRUE);

INSERT INTO ANNOTATION (parent_id, name, organization_id, status_id, signal_id, annotation_comment, creation_date, edit_date, is_active, is_editable)  
	VALUES (NULL, 'Annotation 2', 2, 2, 1, 'Seconde annotation', '2004-10-19 10:23:54', '2012-12-29 17:19:54', TRUE, TRUE);

INSERT INTO ANNOTATION (parent_id, name, organization_id, status_id, signal_id, annotation_comment, creation_date, edit_date, is_active, is_editable) 
	VALUES (2, 'Annotation 3',  3, 3, 1, 'Troisième annotation qui se base sur la deuxième', '2004-10-19 10:23:54', '2012-12-29 17:19:54', TRUE, TRUE);

-- INTERVAL

INSERT INTO INTERVAL (timestamp_start, timestamp_end) 
	VALUES (3, 4);

INSERT INTO INTERVAL (timestamp_start, timestamp_end)
	VALUES (7, 9);

INSERT INTO INTERVAL (timestamp_start, timestamp_end) 
	VALUES (11, 29);

-- ANNOTATION_INTERVAL_USER

INSERT INTO ANNOTATION_INTERVAL_USER (annotation_id, interval_id, user_id, comment, date) 
	VALUES (1, 1, 1, 'HOLLY', '2004-10-19 10:23:54');

INSERT INTO ANNOTATION_INTERVAL_USER (annotation_id, interval_id, user_id, comment, date) 
	VALUES (1, 2, 1, 'MOLLY', '2004-10-19 10:23:54');

INSERT INTO ANNOTATION_INTERVAL_USER (annotation_id, interval_id, user_id, comment, date) 
	VALUES (1, 3, 1, 'gOdsAkE', '2004-10-19 10:23:54');

-- TAG

INSERT INTO TAG (parent_id, name, color, is_active) 
	VALUES (NULL, 'Lungs on fire', 'red', TRUE);

INSERT INTO TAG (parent_id, name, color, is_active) 
	VALUES (NULL, 'Lungs on water', 'blue', TRUE);

INSERT INTO TAG (parent_id, name, color, is_active) 
	VALUES (2, 'Weird lungs', 'green', TRUE);

-- ANNOTATION_TAG

INSERT INTO ANNOTATION_TAG(annotation_id, tag_id)
	VALUES (1, 1);
INSERT INTO ANNOTATION_TAG(annotation_id, tag_id)
	VALUES (1, 2);
INSERT INTO ANNOTATION_TAG(annotation_id, tag_id)
	VALUES (1, 3);
INSERT INTO ANNOTATION_TAG(annotation_id, tag_id)
	VALUES (2, 1);
INSERT INTO ANNOTATION_TAG(annotation_id, tag_id)
	VALUES (2, 2);
INSERT INTO ANNOTATION_TAG(annotation_id, tag_id)
	VALUES (3, 1);

-- INTERVAL_TAG

INSERT INTO INTERVAL_TAG (interval_id, tag_id) 
	VALUES (1, 1);

INSERT INTO INTERVAL_TAG (interval_id, tag_id) 
	VALUES (1, 2);

INSERT INTO INTERVAL_TAG (interval_id, tag_id) 
	VALUES (1, 3);

-- OPERATOR_OF

INSERT INTO OPERATOR_OF (user_id, status_id, annotation_id, operation_time) 
	VALUES (1, 2, 1, '2004-10-19 10:23:54');

INSERT INTO OPERATOR_OF (user_id, status_id, annotation_id, operation_time) 
	VALUES (1, 3, 1, '2004-10-19 10:23:54');

INSERT INTO OPERATOR_OF (user_id, status_id, annotation_id, operation_time) 
	VALUES (1, 1, 1, '2004-10-19 10:23:54');

-- ANNOTATION_USER

INSERT INTO ANNOTATION_USER (annotation_id, user_id, comment, date) 
	VALUES (1, 2, 'The lungs are presenting an incredible amount of water which is coming from an unresolved source', '2004-10-19 10:23:54');

INSERT INTO ANNOTATION_USER (annotation_id, user_id, comment, date) 
	VALUES (1, 3, 'Lungs are actually defectuous due to drugs injections and too much inhale of smoke', '2004-10-19 10:23:54');

INSERT INTO ANNOTATION_USER (annotation_id, user_id, comment, date) 
	VALUES (1, 1, '80% of the cause is daily smoke and sniffing white rails', '2004-10-19 10:23:54');



