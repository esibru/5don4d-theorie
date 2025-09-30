-- Suppression si existant (utile pour relancer le script)
DROP TABLE IF EXISTS Troncon;
DROP TABLE IF EXISTS Ville;

-- Table Ville
CREATE TABLE Ville (
    idVille      INT PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL,
    pays         VARCHAR(100) NOT NULL,
    CONSTRAINT uq_ville UNIQUE (nom, pays)
);

-- Table Troncon
CREATE TABLE Troncon (
    idTroncon    INT PRIMARY KEY,
    villeDepart  INT NOT NULL,
    villeArrivee INT NOT NULL,
    longueurKm   DECIMAL(6,2) NOT NULL CHECK (longueurKm > 0),
    
    CONSTRAINT fk_depart FOREIGN KEY (villeDepart) REFERENCES Ville(idVille),
    CONSTRAINT fk_arrivee FOREIGN KEY (villeArrivee) REFERENCES Ville(idVille),
    CONSTRAINT chk_diff CHECK (villeDepart <> villeArrivee),
    CONSTRAINT uq_troncon UNIQUE (villeDepart, villeArrivee)
);

-- Villes
INSERT INTO Ville (idVille, nom, pays) VALUES
(1, 'Bruxelles', 'Belgique'),
(2, 'Paris', 'France'),
(3, 'Lille', 'France'),
(4, 'Amsterdam', 'Pays-Bas'),
(5, 'Cologne', 'Allemagne'),
(6, 'Lyon', 'France'),
(7, 'Francfort', 'Allemagne');

-- Tronçons
INSERT INTO Troncon (idTroncon, villeDepart, villeArrivee, longueurKm) VALUES
(1, 1, 2, 310.0),  -- Bruxelles -> Paris
(2, 1, 3, 110.0),  -- Bruxelles -> Lille
(3, 1, 4, 200.0),  -- Bruxelles -> Amsterdam
(4, 3, 2, 220.0),  -- Lille -> Paris
(5, 3, 5, 300.0),  -- Lille -> Cologne
(6, 4, 5, 270.0),  -- Amsterdam -> Cologne
(7, 2, 6, 460.0),  -- Paris -> Lyon
(8, 2, 5, 500.0),  -- Paris -> Cologne
(9, 5, 1, 220.0),  -- Cologne -> Bruxelles
(10, 5, 7, 190.0); -- Cologne -> Francfort

-- 1 Tronçon
SELECT DISTINCT v2.nom, v2.pays
FROM Ville v1
JOIN Troncon t ON v1.idVille = t.villeDepart
JOIN Ville v2 ON t.villeArrivee = v2.idVille
WHERE v1.nom = 'Bruxelles';

-- 2 Tronçons
SELECT DISTINCT v2.nom, v2.pays
FROM Ville v1
JOIN Troncon t1 ON v1.idVille = t1.villeDepart
JOIN Troncon t2 ON t1.villeArrivee = t2.villeDepart
JOIN Ville v2 ON t2.villeArrivee = v2.idVille
WHERE v1.nom = 'Bruxelles';

-- 3 Tronçons
SELECT DISTINCT v4.nom, v4.pays
FROM Ville v1
JOIN Troncon t1 ON v1.idVille = t1.villeDepart
JOIN Ville v2 ON t1.villeArrivee = v2.idVille
JOIN Troncon t2 ON v2.idVille = t2.villeDepart
JOIN Ville v3 ON t2.villeArrivee = v3.idVille
JOIN Troncon t3 ON v3.idVille = t3.villeDepart
JOIN Ville v4 ON t3.villeArrivee = v4.idVille
WHERE v1.nom = 'Bruxelles';

-- récursive
WITH RECURSIVE chemins AS (
    -- Point de départ : Bruxelles
    SELECT v.idVille, v.nom, v.pays
    FROM Ville v
    WHERE v.nom = 'Bruxelles'
    
    UNION
    
    -- Extension du chemin : on ajoute un tronçon à chaque étape
    SELECT v2.idVille, v2.nom, v2.pays
    FROM chemins c
    JOIN Troncon t ON c.idVille = t.villeDepart
    JOIN Ville v2 ON t.villeArrivee = v2.idVille
)

SELECT DISTINCT nom, pays
FROM chemins
WHERE nom <> 'Bruxelles';