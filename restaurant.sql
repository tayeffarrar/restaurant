DROP DATABASE restaurant;
CREATE DATABASE restaurant;

\c restaurant

CREATE TABLE foods(
	id										SERIAL			PRIMARY KEY,
	name									TEXT				NOT NULL,	
	cuisine								TEXT				NOT NULL,	
	price									INT					NOT NULL,	
	created_at						TIMESTAMP,
	updated_at						TIMESTAMP
);

CREATE TABLE parties(
	id										SERIAL			PRIMARY KEY,
	table_name						TEXT				NOT NULL,	
	guests								INTEGER			NOT NULL,	
	created_at						TIMESTAMP,
	updated_at						TIMESTAMP
);


CREATE TABLE orders(
	id										SERIAL			PRIMARY KEY,
	food_id								INTEGER			NOT NULL,	
	party_id							INTEGER			NOT NULL,	
	created_at						TIMESTAMP,
	updated_at						TIMESTAMP
);


CREATE TABLE waiters(
	id										SERIAL			PRIMARY KEY,
	name									TEXT				NOT NULL,
	password_digest				TEXT 				NOT NULL,
	authorization_token		TEXT	
); 
