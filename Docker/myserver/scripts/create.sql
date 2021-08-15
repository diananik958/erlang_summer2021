CREATE DATABASE IF NOT EXISTS testserver1;

USE testserver1;

CREATE TABLE IF NOT EXISTS server (

IP VARCHAR(255),

Port INT, 

Date DATE, 

Time TIME, 

Path VARCHAR(255), 

Method VARCHAR(255)

);
