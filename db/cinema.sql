DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE films (
  id SERIAL8 primary key,
  title VARCHAR(255),
  price INT2
);

CREATE TABLE customers (
  id SERIAL8 primary key,
  name VARCHAR(255),
  funds INT2
);

CREATE TABLE tickets (
  customer_id INT8 references customers(id),
  film_id INT8 references films(id)
);