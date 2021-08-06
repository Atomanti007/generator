--liquibase formatted sql

--changeset zsolt:1596478175445-1
create table EXAMPLE
(
    ID     bigint auto_increment
        primary key,
    STATUS varchar(255) not null
);
