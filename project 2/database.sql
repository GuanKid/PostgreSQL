-- Create tables
CREATE TABLE profession (
    prof_id SERIAL PRIMARY KEY,
    profession VARCHAR(255) UNIQUE
);

CREATE TABLE status (
    status_id SERIAL PRIMARY KEY,
    status VARCHAR(255)
);

CREATE TABLE zip_code (
    zip_code VARCHAR(4) PRIMARY KEY CHECK (length(zip_code) <= 4),
    city VARCHAR(255),
    province VARCHAR(255)
);

CREATE TABLE interests (
    interest_id SERIAL PRIMARY KEY,
    interest VARCHAR(255)
);

CREATE TABLE seeking (
    seeking_id SERIAL PRIMARY KEY,
    seeking VARCHAR(255)
);

CREATE TABLE my_contacts (
    contact_id SERIAL PRIMARY KEY,
    last_name VARCHAR(255),
    first_name VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    gender VARCHAR(10),
    birthday DATE,
    prof_id INTEGER REFERENCES profession(prof_id),
    zip_code VARCHAR(4) REFERENCES zip_code(zip_code),
    status_id INTEGER REFERENCES status(status_id)
);

CREATE TABLE contact_interest (
    contact_id INTEGER REFERENCES my_contacts(contact_id),
    interest_id INTEGER REFERENCES interests(interest_id),
    PRIMARY KEY (contact_id, interest_id)
);

CREATE TABLE contact_seeking (
    contact_id INTEGER REFERENCES my_contacts(contact_id),
    seeking_id INTEGER REFERENCES seeking(seeking_id),
    PRIMARY KEY (contact_id, seeking_id)
);

-- Populate tables
INSERT INTO profession (profession) VALUES ('Engineer'), ('Doctor'), ('Artist'), ('Teacher');


-- Add status
INSERT INTO status (status) VALUES ('Single'), ('Married'), ('Divorced');


-- Add provinces
INSERT INTO zip_code (zip_code, city, province) VALUES 
('1234', 'City1', 'Province1'), ('1235', 'City2', 'Province1'),
('2234', 'City1', 'Province2'), ('2235', 'City2', 'Province2'),
('3234', 'City1', 'Province3'), ('3235', 'City2', 'Province3'),
('4234', 'City1', 'Province4'), ('4235', 'City2', 'Province4'),
('5234', 'City1', 'Province5'), ('5235', 'City2', 'Province5'),
('6234', 'City1', 'Province6'), ('6235', 'City2', 'Province6'),
('7234', 'City1', 'Province7'), ('7235', 'City2', 'Province7'),
('8234', 'City1', 'Province8'), ('8235', 'City2', 'Province8'),
('9234', 'City1', 'Province9'), ('9235', 'City2', 'Province9');



-- Add interests and seeking data
INSERT INTO interests (interest) VALUES ('Music'), ('Sports'), ('Art'), ('Technology');
INSERT INTO seeking (seeking) VALUES ('Friendship'), ('Relationship');

-- Add contacts to my_contacts table
INSERT INTO my_contacts (last_name, first_name, phone, email, gender, birthday, prof_id, zip_code, status_id)
VALUES 
('Doe', 'John', '555-1234', 'john.doe@example.com', 'Male', '1985-01-15', 1, '1234', 1),
('Smith', 'Jane', '555-5678', 'jane.smith@example.com', 'Female', '1990-04-22', 2, '2234', 2),
('Brown', 'Charlie', '555-8765', 'charlie.brown@example.com', 'Male', '1978-09-10', 3, '3234', 3),
('Johnson', 'Emily', '555-4321', 'emily.johnson@example.com', 'Female', '1992-07-05', 4, '4234', 1),
('Williams', 'David', '555-9876', 'david.williams@example.com', 'Male', '1980-11-30', 1, '5234', 2),
('Jones', 'Laura', '555-2345', 'laura.jones@example.com', 'Female', '1983-03-19', 2, '6234', 3),
('Miller', 'Michael', '555-3456', 'michael.miller@example.com', 'Male', '1987-08-25', 3, '7234', 1),
('Davis', 'Sophia', '555-4567', 'sophia.davis@example.com', 'Female', '1995-05-17', 4, '8234', 2),
('Garcia', 'Carlos', '555-5678', 'carlos.garcia@example.com', 'Male', '1979-12-01', 1, '9234', 3),
('Martinez', 'Maria', '555-6789', 'maria.martinez@example.com', 'Female', '1984-02-20', 2, '1235', 1),
('Hernandez', 'Luis', '555-7890', 'luis.hernandez@example.com', 'Male', '1991-10-13', 3, '2235', 2),
('Lopez', 'Isabella', '555-8901', 'isabella.lopez@example.com', 'Female', '1988-06-09', 4, '3235', 3),
('Gonzalez', 'Jose', '555-9012', 'jose.gonzalez@example.com', 'Male', '1986-12-24', 1, '4235', 1),
('Perez', 'Ana', '555-0123', 'ana.perez@example.com', 'Female', '1993-09-03', 2, '5235', 2),
('Rodriguez', 'Jorge', '555-3456', 'jorge.rodriguez@example.com', 'Male', '1981-11-08', 3, '6235', 3);

-- Assign interests to each contact
INSERT INTO contact_interest (contact_id, interest_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 3), (2, 4),
(3, 2), (3, 3), (3, 4),
(4, 1), (4, 2), (4, 4),
(5, 1), (5, 3), (5, 4),
(6, 2), (6, 3), (6, 4),
(7, 1), (7, 2), (7, 3),
(8, 1), (8, 3), (8, 4),
(9, 2), (9, 3), (9, 4),
(10, 1), (10, 2), (10, 3),
(11, 2), (11, 3), (11, 4),
(12, 1), (12, 3), (12, 4),
(13, 1), (13, 2), (13, 3),
(14, 2), (14, 3), (14, 4),
(15, 1), (15, 3), (15, 4);

-- Assign seeking data to each contact
INSERT INTO contact_seeking (contact_id, seeking_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 2),
(3, 1), (3, 2),
(4, 1), (4, 2),
(5, 1), (5, 2),
(6, 1), (6, 2),
(7, 1), (7, 2),
(8, 1), (8, 2),
(9, 1), (9, 2),
(10, 1), (10, 2),
(11, 1), (11, 2),
(12, 1), (12, 2),
(13, 1), (13, 2),
(14, 1), (14, 2),
(15, 1), (15, 2);



-- LEFT JOIN query
SELECT c.first_name, c.last_name, p.profession, z.zip_code, z.city, z.province, s.status, i.interest, se.seeking
FROM my_contacts c
LEFT JOIN profession p ON c.prof_id = p.prof_id
LEFT JOIN zip_code z ON c.zip_code = z.zip_code
LEFT JOIN status s ON c.status_id = s.status_id
LEFT JOIN contact_interest ci ON c.contact_id = ci.contact_id
LEFT JOIN interests i ON ci.interest_id = i.interest_id
LEFT JOIN contact_seeking cs ON c.contact_id = cs.contact_id
LEFT JOIN seeking se ON cs.seeking_id = se.seeking_id;
