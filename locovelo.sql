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
CREATE INDEX idx_client_nom ON Client(nom);
CREATE INDEX idx_client_email ON Client(email);
CREATE INDEX idx_velo_type ON Velo(type);
CREATE INDEX idx_velo_taille ON Velo(taille);
CREATE INDEX idx_velo_etat ON Velo(etat);
CREATE INDEX idx_velo_disponible ON Velo(disponible);
CREATE INDEX idx_location_id_client ON Location(id_client);
CREATE INDEX idx_location_id_velo ON Location(id_velo);
CREATE INDEX idx_location_date_debut ON Location(date_heure_debut);
CREATE INDEX idx_location_date_fin ON Location(date_heure_fin);

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
Merci beau coups Natasha pour votre precieuse aide.