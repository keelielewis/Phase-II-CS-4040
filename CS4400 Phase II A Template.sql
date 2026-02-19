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
CREATE TABLE `user` (
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
  Unique (username),
  foreign key (AccountID)
      references `user`(AccountID)
      on update cascade
      on delete cascade,
  foreign key (subscriptionID)
      references subscription(SubscriptionID)
      on update cascade
      on delete restrict);

-- Creator
create table creator (
  AccountID int not null,
  stage_name varchar(100) not null,
  biography varchar(1000),
  pinnedContentID int,
  primary key (AccountID),
  foreign key (AccountID)
    references `user`(AccountID)
    on update cascade
    on delete cascade,
  foreign key (pinnedContentID)
    references content(ContentID)
    on update cascade
    on delete set null);

-- Socials 
  create table socials (
    AccountID int not null,
    handle varchar(100) not null,
    platform varchar(50) not null,
    primary key (AccountID, platform, handle), 
    foreign key (AccountID)
      references creator(AccountID)
      on update cascade
      on delete cascade);

-- Playlist
create table playlist (
  PlaylistID int not null,
  name varchar(200) not null,
  listenerID int not null,
  primary key (PlaylistID),
  foreign key (listenerID)
    references listener(AccountID)
    on update cascade
    on delete cascade);

-- Friends
create table friends (
  listener1_id int not null,
  listener2_id int not null,
  primary key (listener1_id, listener2_id),
  check (listener1_id <> listener2_id),
  foreign key (listener1_id)
    references listener(AccountID)
    on update cascade
    on delete cascade,
  foreign key (listener2_id)
    references listener(AccountID)
    on update cascade
    on delete cascade);

-- creator_creates
create table creator_creates (
  creatorID int not null,
  ContentID int not null,
  primary key (creatorID, ContentID),
  foreign key (creatorID)
    references creator(AccountID)
    on update cascade
    on delete cascade,
  foreign key (ContentID)
    references content(ContentID)
    on update cascade
    on delete cascade);

-- streams
create table streams (
  listenerID int not null,
  ContentID int not null,
  stream_timestamp datetime not null,
  primary key (listenerID, ContentID, stream_timestamp),
  foreign key (listenerID)
    references listener(AccountID)
    on update cascade
    on delete cascade,
  foreign key (ContentID)
    references content(AccountID)
    on update cascade
    on delete cascade,

-- podcast series
create table podcast_series (
  PodcastID int not null,
  title varchar(200) not null,
  description varchar(1000),
  primary key (PodcastID));

-- podcast episode
create table podcast_episode (
  ContentID int not null,
  topic varchar(200) not null,
  podcastID int not null,
  episode_number int not null,
  primary key (ContentID),
  Unique (podcastID, episode_number),
  foreign key (ContentID)
    references content(AccountID)
    on update cascade
    on delete cascade,
  foreign key (podcastID)
    references podcast_series(PodcastID)
    on update cascade
    on delete restrict,

-- album
create table album (
  creatorID int not null,
  name varchar(200) not null,
  primary key (creatorID, name),
  foreign key (creatorID)
    references creator(AccountID)
    on update cascade
    on delete cascade);

-- song
create table song (
  ContentID int not null,
  album_creator_id int,
  album_name varchar(200),
  primary key (ContentID),
  foreign key (ContentID)
    references content(AccountID)
    on update cascade
    on delete cascade,
  foreign key (album_creator_id, album_name)
    references album(creatorID, name)
    on update cascade
    on delete set null;

-- genres
create table genres (
  ContentID int not null,
  genre varchar(50) not null,
  primary key (ContentID, genre),
  foreign key (ContentID)
    references song(ContentID)
    on update cascade
    on delete cascade);

-- makes_up
create table makes_up (
  PlaylistID int not null,
  ContentID int not null,
  track_order int not null,
  primary key (PlaylistID, track_order),
  foreign key (PlaylistID)
    references playlist(PlaylistID)
    on update cascade
    on delete cascade,
  foreign key (ContentID)
    references song(ContentID)
    on update cascade
    on delete cascade);

  


  
  
  
  
    

  
    
    
  



