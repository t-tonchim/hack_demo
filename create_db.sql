DROP DATABASE IF EXISTS hack_demo;

CREATE DATABASE hack_demo;

USE hack_demo;

CREATE TABLE users(
    id serial primary key,
  name varchar(255),
   age integer
);
