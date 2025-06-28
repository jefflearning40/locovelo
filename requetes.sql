--REQUETES 1--

SELECT COUNT(*) FROM Velo;

--REQUETE 2 --

SELECT
    id_location,
    id_velo,
    date_heure_debut,
    date_heure_fin,
    montantTotal
FROM
    Location
WHERE
    id_client = 1;

--REQUETE 3--

SELECT COUNT(*) AS nombre_total_de_locations
FROM Location;

--REQUETE 3--

SELECT SUM(montantTotal) AS revenus_totaux
FROM Location;

--REQUETE 3--

SELECT
    DATE_FORMAT(date_heure_debut, '%Y-%m') AS mois,
    SUM(montantTotal) AS revenus_totaux
FROM
    Location
GROUP BY
    DATE_FORMAT(date_heure_debut, '%Y-%m')
ORDER BY
    mois;

