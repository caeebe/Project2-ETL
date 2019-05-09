CREATE DATABASE traffic_etl;
USE traffic_etl;

CREATE TABLE accidents (
  accident_id BIGINT,
  source VARCHAR(30),
  year INT, 
  day INT, 
  month INT, 
  hour varchar(2), 
  weather VARCHAR(30), 
  surface VARCHAR(30), 
  fatality INT, 
  safety_device VARCHAR(30)
);
