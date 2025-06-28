CREATE DATABASE locovelo;
USE locovelo;
CREATE TABLE client(
id_client INT PRIMARY KEY AUTO_INCREMENT;
prenom VARCHAR(255) NOT NULL;
nom VARCHAR(255) NOT NULL;
email VARCHAR(255) NOT NULL;
dateInscription DATE;
);
CREATE TABLE Velo (
    id_velo INT AUTO_INCREMENT PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    type ENUM('ville', 'route', 'tout terrain', 'course') NOT NULL,
    taille ENUM('S', 'M', 'L', 'XL') NOT NULL,
    tarifHoraire DECIMAL(10, 2) NOT NULL,
    etat ENUM('neuf', 'bon', 'usé') NOT NULL,
    disponible ENUM('oui', 'non') NOT NULL
);
CREATE TABLE Location (
    id_location INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT NOT NULL,
    id_velo INT NOT NULL,
    date_heure_debut DATETIME NOT NULL,
    date_heure_fin DATETIME NOT NULL,
    montantTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Client(id_client),
    FOREIGN KEY (id_velo) REFERENCES Velo(id_velo),
    CHECK (date_heure_fin > date_heure_debut),
    CHECK (montantTotal > 0)
);
-------------------------------------------------------------telechargement des csv------------------------------------------------------------
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/client.csv'
INTO TABLE Client
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/velo.csv'
INTO TABLE Velo
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.4/Uploads/location.csv'
INTO TABLE Location
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


--*********************************    Merci beau coups 'Natasha' pour votre precieuse aide.*****************************************************--

-- les correction pour empecher les valeurs negatives ou les doublons --

ALTER TABLE Client
ADD CONSTRAINT uc_email UNIQUE (email);

ALTER TABLE Velo
ADD CONSTRAINT chk_tarifHoraire_non_negatif CHECK (tarifHoraire >= 0);

ALTER TABLE Velo
ALTER disponible SET DEFAULT 'oui';

-------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------apres correction faites avec alter, le shema.sql est :----------------------------------------------

CREATE TABLE Client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    prenom VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dateInscription DATE NOT NULL
);


CREATE TABLE Velo (
    id_velo INT AUTO_INCREMENT PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    type ENUM('ville', 'route', 'tout terrain', 'course') NOT NULL,
    taille ENUM('S', 'M', 'L', 'XL') NOT NULL,
    tarifHoraire DECIMAL(10, 2) NOT NULL CHECK (tarifHoraire >= 0),
    etat ENUM('neuf', 'bon', 'usé') NOT NULL,
    disponible ENUM('oui', 'non') NOT NULL DEFAULT 'oui'
);


CREATE TABLE Location (
    id_location INT AUTO_INCREMENT PRIMARY KEY,
    id_client INT NOT NULL,
    id_velo INT NOT NULL,
    date_heure_debut DATETIME NOT NULL,
    date_heure_fin DATETIME NOT NULL,
    montantTotal DECIMAL(10, 2) NOT NULL CHECK (montantTotal >= 0),
    FOREIGN KEY (id_client) REFERENCES Client(id_client),
    FOREIGN KEY (id_velo) REFERENCES Velo(id_velo)
);
