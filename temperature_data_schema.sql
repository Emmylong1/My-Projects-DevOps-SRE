CREATE SCHEMA IF NOT EXISTS temperature_schema;

-- Create Locations Table
CREATE TABLE IF NOT EXISTS my_schema.locations (
  location_id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  latitude DECIMAL(10, 8) NOT NULL,
  longitude DECIMAL(11, 8) NOT NULL
);

-- Create Sensors Table
CREATE TABLE IF NOT EXISTS my_schema.sensors (
  sensor_id BIGSERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  type VARCHAR(100) NOT NULL,
  location_id BIGINT NOT NULL, 
  installation_date DATE NOT NULL,
  CONSTRAINT fk_location
    FOREIGN KEY (location_id)
    REFERENCES my_schema.locations (location_id)
    ON DELETE CASCADE
);

-- Create Temperature Readings Table
CREATE TABLE IF NOT EXISTS my_schema.temperature_readings (
  reading_id BIGSERIAL PRIMARY KEY,
  sensor_id BIGINT NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  temperature_value DECIMAL(5, 2) NOT NULL,
  CONSTRAINT fk_sensor
    FOREIGN KEY (sensor_id)
    REFERENCES my_schema.sensors (sensor_id)
    ON DELETE CASCADE
);
