-- CS4400: Introduction to Database Systems (Spring 2026)
-- Phase II A: Create Table Statements [v0] [February 9th, 2026]

-- Team 111
-- Keelie Lewis (klewis302@gatech.edu)
-- Joanna Kim
-- Sarah Grace Pfanstiel (GT username)

-- Directions:
-- Please follow all instructions for Phase II A as listed in the instructions document.
-- Fill in the team number and names and GT usernames for all members above.
-- Create Table statements must be manually written, not taken from a SQL Dump file.
-- This file must run without error for credit.

/* This is a standard preamble for most of our scripts.  The intent is to establish
a consistent environment for the database behavior. */
set global transaction isolation level serializable;
set global SQL_MODE = 'ANSI,TRADITIONAL';
set names utf8mb4;
set SQL_SAFE_UPDATES = 0;

set @thisDatabase = 'media_streaming_service';
drop database if exists media_streaming_service;
create database if not exists media_streaming_service;
use media_streaming_service;

-- Define the database structures
/* You must enter your tables definitions (with primary, unique, and foreign key declarations,
data types, and check constraints) here.  You may sequence them in any order that 

works for you (and runs successfully). */
-- User
CREATE TABLE user (
  AccountID INT NOT NULL,
  name Varchar(100) not null, 
  bdate date not null,
  email varchar(255) not null,
  primary key (AccountId),
  Unique (email));

-- Subscription
Create table subscription (
  SubscriptionID INT not null,
  start_date Date not null,
  end_date date not null,
  cost decimal(10,2) not null,
  primary key (SubscriptionID));

-- Individual
CREATE TABLE individual (
  SubscriptionID int not null,
  tier varchar(50) not null,
  primary key (SubscriptionID),
  foreign key (SubscriptionID)
      references subscription(SubscriptionID)
      on update cascade
      on delete cascade);

-- Family
create table family (
  SubscriptionID int not null,
  max_family_size int not null,
  primary key (SubscriptionID),
  Foreign key (SubscriptionID)
      references subscription(SubscriptionID)
      on update cascade
      on delete cascade);

-- Content
create table content (
  ContentID int not null,
  title varchar(200) not null,
  release_date date not null,
  language varchar(50) not null,
  length int not null,
  maturity varchar(30) not null,
  primary key (ContentID));

-- Listener 
create table listener (
  AccountID int not null,
  username Varchar(50) not null,
  subscriptionID int not null,
  primary key (AccountID),
  Unique (username)
  foreign key (AccountID)
      references user(AccountID)
      on update cascade
      on delete cascade
  foreign key (subscriptionID)
      references subscription(SubscriptionID)
      on update cascade
      on delete cascade);

-- creator
  
    
  

