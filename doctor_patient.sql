CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    contact_info VARCHAR(200)
    insurance VARCHAR (100)
);

CREATE TABLE DoctorPatient (
    doctor_id INT REFERENCES Doctors(doctor_id),
    patient_id INT REFERENCES Patients(patient_id),
    PRIMARY KEY (doctor_id, patient_id)
);

CREATE TABLE Visits (
    visit_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES Patients(patient_id),
    doctor_id INT REFERENCES Doctors(doctor_id),
    visit_date DATE NOT NULL,
    notes TEXT
);

CREATE TABLE Diseases (
    disease_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE  Diagnoses (
    visit_id INT REFERENCES Visits(visit_id),
    disease_id INT REFERENCES Diseases(disease_id),
    PRIMARY KEY (visit_id, disease_id),
);


INSERT INTO Doctors (name, specialty, email) VALUES
('Dr. John Doe', 'Cardiology', 'johndoe@example.com');

INSERT INTO Patients (name, dob, contact_info) VALUES
('Jane Smith', '1990-06-15', '555-555-1234');

INSERT INTO Visits (patient_id, doctor_id, visit_date, notes) VALUES
(1, 1, '2024-12-10', 'Routine check-up.');

INSERT INTO Diseases (name, description) VALUES
('Hypertension', 'High blood pressure.');

INSERT INTO Diagnoses (visit_id, disease_id) VALUES
(1, 1);
