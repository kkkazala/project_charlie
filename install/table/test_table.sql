--liquibase formatted sql
--changeset kkazala:users failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:false
--rollback drop table test;
create table test
(
    id number generated always as identity (start with 1 increment by 1) primary key ,
    apex_login varchar2(255) not null,
    email varchar2(255)
);


--changeset kkazala:userstest2 failOnError:true stripComments:false splitStatements:true rollbackSplitStatements:true runOnChange:false
--rollback drop table test;
create table test2
(
    id number generated always as identity (start with 1 increment by 1) primary key ,
    apex_login varchar2(255) not null,
    email varchar2(255)
);