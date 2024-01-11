create table category
(
  id number(3,0),
  name VARCHAR2(50) not null,
  constraint category_id_pk primary key(id),
  constraint category_name_unq unique (name)
);
/

create sequence category_id_seq start with 1 INCREMENT by 1;
/

create or replace EDITIONABLE TRIGGER category_id_tgr
  before insert on category
  for each row
begin
  if :new.id is null then
    select category_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger category_id_tgr
enable;
/
  

insert into category(name) values('programming');
/



create table book
(
  id number(10,0),
  isbn VARCHAR2(30),
  title VARCHAR2(100) not null,
  category_id number(3,0) not null,
  publication_date date,
  constraint book_id_pk primary key(id)
);
/

create sequence book_id_seq start with 1 increment by 1;
/

create or replace editionable trigger book_id_tgr 
  before insert on book
  for each row 
begin
  if :new.id is null then
    select book_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger book_id_tgr
enable;
/
insert into book(isbn, title, category_id) values('10', 'plsql inro', 3);
/



create table author
(
  id number(10,0),
  first_name varchar2(50) not null,
  last_name varchar2(50) not null,
  constraint author_id_pk primary key (id)
);
/

create sequence author_id_seq start with 1 increment by 1;
/

create or replace editionable trigger author_id_tgr
  before insert on author
  for each row
begin
  if :new.id is null then 
    select author_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger author_id_tgr
enable;
/

insert into author(first_name, last_name) values('Linda', 'L. Preece');
/


create table book_author
(
  id number(20,0),
  book_id NUMBER(10,0) not null,
  author_id NUMBER(10,0) not null,
  constraint book_author_id_pk primary key (id),
  constraint book_author_book_id_fk 
    foreign key (book_id) references book(id),
  constraint book_author_author_id_fk 
    foreign key (author_id) references author(id)
);
/

create sequence book_author_id_seq start with 1 increment by 1;
/

create or replace editionable trigger book_author_id_tgr
  before insert on book_author
  for each row
begin 
  if :new.id is null then 
    select book_author_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger book_author_id_tgr
enable;
/

insert into book_author(book_id, author_id) values(1, 1);
/




create table member_status
(
  id number(2,0),
  status_value varchar2(20) not null,
  constraint member_status_id_pk primary key (id),
  constraint member_status_status_value_unq unique (status_value)
);
/

create sequence member_status_id_seq start with 1 increment by 1;
/

create or replace editionable trigger member_status_id_tgr
  before insert on member_status
  for each row
begin
  if :new.id is null then 
    select member_status_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger member_status_id_tgr
enable;
/

insert into member_status(status_value) values('active');
insert into member_status(status_value) values('cancelled');
insert into member_status(status_value) values('suspended');
/



create table members
(
  id number(20),
  first_name varchar2(50) not null,
  last_name varchar2(50) not null,
  joined_date date,
  phone_number varchar2(20) not null,
  status_id NUMBER(2,0) not null,
  constraint members_id_pk primary key (id),
  constraint members_phone_number_unq unique (phone_number),
  constraint members_status_id_fk 
    foreign key(status_id) references member_status(id)
);
/

create sequence members_id_seq start with 1 increment by 1;
/

create or replace editionable trigger members_id_tgr
  before insert on members
  for each row
begin 
  if :new.id is null then 
    select members_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger members_id_tgr
enable;
/

create or replace editionable trigger members_joined_date_tgr
  before insert on members
  for each row 
begin
  if :new.joined_date is null then
    select sysdate into :new.joined_date from dual;
  end if;
end;
/

alter trigger members_joined_date_tgr
enable;
/



create table loan
(
  id number(30),
  member_id NUMBER(20,0) not null,
  book_id NUMBER(10,0) not null,
  loan_date date not null,
  returned_date date,
  constraint loan_id_pk primary key (id),
  constraint loan_member_id_fk foreign key (member_id) references members(id),
  constraint loan_book_id_fk foreign key (book_id) references book(id)
);
/

create sequence loan_id_seq start with 1 increment by 1;
/

create or replace editionable trigger loan_id_tgr
  before insert on loan
  for each row
begin
  if :new.id is null then 
    select loan_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger loan_id_tgr
enable;
/



create table fine_price_per_each_day
(
  id number(1),
  price number(15,5) not null,
  constraint fine_price_per_each_day_id_pk primary key (id)
);
/

create sequence fine_price_per_each_day_id_seq start with 1 increment by 1;
/

create or replace editionable trigger fine_price_per_each_day_id_tgr
  before insert on fine_price_per_each_day
  for each row
begin
  if :new.id is null then
    select fine_price_per_each_day_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger fine_price_per_each_day_id_tgr
enable;

insert into fine_price_per_each_day(price) values(100);
/

create table fine
(
  id number(30),
  member_id NUMBER(20,0) not null,
  loan_id NUMBER(30,0) not null,
  fine_date number(10),
  fine_amount number(30,5),
  constraint fine_id_pk primary key (id),
  constraint fine_member_id_fk foreign key (member_id) references members(id),
  constraint fine_loan_id_fk foreign key (loan_id) references loan(id)
);
/

create sequence fine_id_seq start with 1 increment by 1;
/

create or replace editionable trigger fine_id_tgr
  before insert on fine
  for each row 
begin
  if :new.id is null then
    select fine_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger fine_id_tgr
enable;
/

create or replace trigger fine_calculator
  after update of returned_date on loan
  for each row
DECLARE
  tmp_fine_date NUMBER;
  date_duration NUMBER;
  fine_amt NUMBER;
  const_price_per_day NUMBER;
  loan_exists NUMBER;

begin
  date_duration := :new.returned_date - :old.loan_date;
  
  SELECT price
  INTO const_price_per_day
  FROM fine_price_per_each_day;
  
  if date_duration > 7 then
    tmp_fine_date := date_duration - 7;
    fine_amt := tmp_fine_date * const_price_per_day;
    
  SELECT COUNT(*) INTO loan_exists
    FROM fine
    WHERE loan_id = :NEW.id;
    
    IF loan_exists > 0 THEN
      update fine
      set fine_date = tmp_fine_date, fine_amount = fine_amt
      where loan_id = :New.id;
    else
      INSERT INTO fine (loan_id, member_id, fine_date, fine_amount)
      VALUES (:new.id, :new.member_id, tmp_fine_date, fine_amt);
    end if;
  end if;
end;
/

alter trigger fine_calculator
enable;
/


create table reservation_status
(
  id number(2,0),
  status_value varchar2(30) not null,
  constraint reservation_status_id_pk primary key (id),
  constraint reservation_status_status_value_unq
    unique (status_value)
);
/

create sequence reservation_status_id_seq start with 1 increment by 1;
/

insert into reservation_status(STATUS_VALUE) values('wainting');
insert into reservation_status(STATUS_VALUE) values('fulfilled');
insert into reservation_status(STATUS_VALUE) values('cancelled');
  

create table reservation 
(
  id number(30),
  book_id NUMBER(10,0) not null,
  member_id NUMBER(20,0) not null,
  reservation_date date not null,
  reservation_status_id NUMBER(2,0) not null,
  
  constraint reservation_id_pk primary key (id),
  
  constraint reservation_book_id_fk 
    foreign key (book_id) references book(id),
  
  constraint reservation_member_id_fk 
    foreign key (member_id) references members(id),
    
  constraint reservation_reservation_status_id_fk
    foreign key (reservation_status_id) references reservation_status(id)
);
/

create sequence reservation_id_seq start with 1 increment by 1;
/

create or replace editionable trigger reservation_id_tgr
  before insert on reservation
  for each row
begin 
  if :new.id is null then
    select reservation_id_seq.nextval into :new.id from dual;
  end if;
end;
/

alter trigger reservation_id_tgr
enable;
/


CREATE OR REPLACE TRIGGER reservation_auto_status_trigger
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
  :NEW.reservation_status_id := 1;
END;
/


create or replace TRIGGER reservation_update_status_to_fulfilled_trigger
FOR UPDATE OF reservation_status_id ON reservation
COMPOUND TRIGGER

  TYPE t_reservation_info IS RECORD (
    book_id             reservation.book_id%TYPE,
    member_id           reservation.member_id%TYPE,
    reservation_date    reservation.reservation_date%TYPE
  );

  TYPE t_reservation_info_table IS TABLE OF t_reservation_info;
  reservation_data  t_reservation_info_table;

  BEFORE STATEMENT IS
  BEGIN
    reservation_data := t_reservation_info_table();
  END BEFORE STATEMENT;

  BEFORE EACH ROW IS
  BEGIN
    IF :NEW.reservation_status_id = 2 THEN
      reservation_data.EXTEND;
      reservation_data(reservation_data.LAST).book_id := :NEW.book_id;
      reservation_data(reservation_data.LAST).member_id := :NEW.member_id;
      reservation_data(reservation_data.LAST).reservation_date := :NEW.reservation_date;
    END IF;
  END BEFORE EACH ROW;

  AFTER STATEMENT IS
  BEGIN
    IF reservation_data.COUNT > 0 THEN
      FORALL i IN 1..reservation_data.COUNT
        INSERT INTO loan (member_id, book_id,  loan_date)
        VALUES (reservation_data(i).member_id, reservation_data(i).book_id, reservation_data(i).reservation_date);
    END IF;
  END AFTER STATEMENT;

END reservation_update_status_to_fulfilled_trigger;
/

create or replace trigger reservation_status_id_tgr
  before insert on reservation_status
  for each row
begin 
  if :new.id is null then
    select reservation_status_id_seq.nextval into :new.id from dual;
  end if;
end;
/

create or replace TRIGGER members_auto_status_trigger
BEFORE INSERT ON members
FOR EACH ROW
BEGIN
  :NEW.STATUS_ID := 1;
END;
