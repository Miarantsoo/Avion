CREATE DATABASE avion;

\c avion;

CREATE TABLE avion (
    id varchar(255) primary key,
    modele varchar(50) not null,
    capacite int not null,
    dateMiseEnService date not null
);

CREATE TABLE type_siege (
    id varchar(255) primary key,
    nom varchar(50) not null
);

CREATE TABLE capacite_avion (
    id varchar(255) primary key,
    id_avion varchar(255) not null,
    id_type_siege varchar(255) not null,
    capacite int not null,
    foreign key (id_avion) references avion(id),
    foreign key (id_type_siege) references type_siege(id)
);

CREATE TABLE ville_desservie (
    id varchar(255) primary key,
    nom varchar(50) not null
);

CREATE TABLE vol (
    id varchar(255) primary key,
    id_avion varchar(255) not null,
    id_ville_depart varchar(255) not null,
    id_ville_arrivee varchar(255) not null,
    dateDepart timestamp not null,
    dateArrivee timestamp not null,
    foreign key (id_avion) references avion(id),
    foreign key (id_ville_depart) references ville_desservie(id),
    foreign key (id_ville_arrivee) references ville_desservie(id)
);

CREATE TABLE prix_vol (
    id varchar(255) primary key,
    id_vol varchar(255) not null,
    id_type_siege varchar(255) not null,
    prix int not null,
    foreign key (id_vol) references vol(id),
    foreign key (id_type_siege) references type_siege(id)
);

CREATE TABLE promotion_vol (
    id varchar(255) primary key,
    id_vol varchar(255) not null,
    id_type_siege varchar(255) not null,
    nbr_place int not null,
    taux_reduction int not null,
    foreign key (id_vol) references vol(id),
    foreign key (id_type_siege) references type_siege(id)
);

CREATE TABLE configuration (
    id      varchar(255) primary key,
    desce   varchar(255) not null,
    val     int not null
);

CREATE TABLE utilisateur (
    id varchar(255) primary key,
    nom varchar(50) not null,
    prenom varchar(50) not null,
    email varchar(50) not null,
    password varchar(100) not null,
    role integer
);

CREATE TABLE reservation (
    id varchar(255) primary key,
    id_vol varchar(255) not null,
    id_type_siege varchar(255) not null,
    date_reservation timestamp not null,
    foreign key (id_vol) references vol(id),
    foreign key (id_type_siege) references type_siege(id)
);

CREATE SEQUENCE seq_avion START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_capacite_avion START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_prix_vol START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_promotion_vol START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reservation START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_type_siege START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ville_desservie START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_utilisateur START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_vol START 1 INCREMENT BY 1;
CREATE SEQUENCE seq_configuration START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE VIEW v_nbr_place_restant AS
SELECT
    ca_business.capacite - COALESCE((
                                        SELECT COUNT(r.id_type_siege)
                                        FROM reservation r
                                        WHERE r.id_vol = v.id AND r.id_type_siege = 'TSIEGE002'
                                    ), 0) AS business,
    ca_economique.capacite - COALESCE((
                                          SELECT COUNT(r.id_type_siege)
                                          FROM reservation r
                                          WHERE r.id_vol = v.id AND r.id_type_siege = 'TSIEGE001'
                                      ), 0) AS economique,
    v.id AS id_vol
FROM vol v
         JOIN avion a ON v.id_avion = a.id
         JOIN capacite_avion ca_business
              ON a.id = ca_business.id_avion AND ca_business.id_type_siege = 'TSIEGE002'
         JOIN capacite_avion ca_economique
              ON a.id = ca_economique.id_avion AND ca_economique.id_type_siege = 'TSIEGE001'
GROUP BY v.id, ca_business.capacite, ca_economique.capacite;

CREATE OR REPLACE VIEW v_vol AS
SELECT v.id, a.modele, a.capacite, vd1.nom as villeDepart, vd2.nom as villeArrivee, v.dateDepart, v.dateArrivee, vnp.economique, vnp.business, coalesce(pr.nbr_place, 0) as nbrEco, coalesce(pr.taux_reduction, 0) as promEco, coalesce(pr2.nbr_place, 0) as nbrBusi, coalesce(pr2.taux_reduction, 0) as promBusi
    FROM vol v
        JOIN avion a ON v.id_avion = a.id
        JOIN ville_desservie vd1 ON v.id_ville_depart = vd1.id
        JOIN ville_desservie vd2 ON v.id_ville_arrivee = vd2.id
        LEFT JOIN promotion_vol pr ON pr.id_vol = v.id AND pr.id_type_siege = 'TSIEGE001'
        LEFT JOIN promotion_vol pr2 ON pr2.id_vol = v.id AND pr2.id_type_siege = 'TSIEGE002'
        JOIN v_nbr_place_restant vnp ON v.id = vnp.id_vol;

SELECT * FROM v_vol;

INSERT INTO avion (id, modele, capacite, dateMiseEnService) VALUES ('AVION00'||nextval('seq_avion'), 'Boeing 737', 180, '2020-01-15');
INSERT INTO avion (id, modele, capacite, dateMiseEnService) VALUES ('AVION00'||nextval('seq_avion'), 'Airbus A320', 150, '2019-05-20');
INSERT INTO avion (id, modele, capacite, dateMiseEnService) VALUES ('AVION00'||nextval('seq_avion'), 'Boeing 777', 300, '2018-11-30');
INSERT INTO avion (id, modele, capacite, dateMiseEnService) VALUES ('AVION00'||nextval('seq_avion'), 'Airbus A380', 500, '2017-07-10');
INSERT INTO avion (id, modele, capacite, dateMiseEnService) VALUES ('AVION00'||nextval('seq_avion'), 'Embraer E190', 100, '2021-03-25');

INSERT INTO type_siege (id, nom) VALUES ('TSIEGE00'||nextval('seq_type_siege'), 'Economique');
INSERT INTO type_siege (id, nom) VALUES ('TSIEGE00'||nextval('seq_type_siege'), 'Business');

INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION001', 'TSIEGE001', 150);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION001', 'TSIEGE002', 30);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION002', 'TSIEGE001', 120);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION002', 'TSIEGE002', 30);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION003', 'TSIEGE001', 250);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION003', 'TSIEGE002', 50);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION004', 'TSIEGE001', 450);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION004', 'TSIEGE002', 50);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION005', 'TSIEGE001', 80);
INSERT INTO capacite_avion (id, id_avion, id_type_siege, capacite) VALUES ('CAPAVN00'||nextval('seq_capacite_avion'), 'AVION005', 'TSIEGE002', 20);

INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Antananarivo');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Toamasina');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Antsiranana');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Mahajanga');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Toliara');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Maurice');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Paris');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'New York');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Johannesburg');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Bangkok');
INSERT INTO ville_desservie (id, nom) VALUES ('VILD00'||nextval('seq_ville_desservie'), 'Dubai');

INSERT INTO vol (id, id_avion, id_ville_depart, id_ville_arrivee, dateDepart, dateArrivee) VALUES ('VOL00'||nextval('seq_vol'), 'AVION001', 'VILD007', 'VILD001', '2023-12-01 08:00:00', '2023-12-01 12:00:00');
INSERT INTO vol (id, id_avion, id_ville_depart, id_ville_arrivee, dateDepart, dateArrivee) VALUES ('VOL00'||nextval('seq_vol'), 'AVION002', 'VILD008', 'VILD002', '2023-12-02 09:00:00', '2023-12-02 13:00:00');
INSERT INTO vol (id, id_avion, id_ville_depart, id_ville_arrivee, dateDepart, dateArrivee) VALUES ('VOL00'||nextval('seq_vol'), 'AVION003', 'VILD009', 'VILD003', '2023-12-03 10:00:00', '2023-12-03 14:00:00');
INSERT INTO vol (id, id_avion, id_ville_depart, id_ville_arrivee, dateDepart, dateArrivee) VALUES ('VOL00'||nextval('seq_vol'), 'AVION004', 'VILD0010', 'VILD004', '2023-12-04 11:00:00', '2023-12-04 15:00:00');
INSERT INTO vol (id, id_avion, id_ville_depart, id_ville_arrivee, dateDepart, dateArrivee) VALUES ('VOL00'||nextval('seq_vol'), 'AVION005', 'VILD0011', 'VILD005', '2023-12-05 12:00:00', '2023-12-05 16:00:00');

INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL001', 'TSIEGE001', 500);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL001', 'TSIEGE002', 1000);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL002', 'TSIEGE001', 600);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL002', 'TSIEGE002', 1200);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL003', 'TSIEGE001', 700);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL003', 'TSIEGE002', 1400);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL004', 'TSIEGE001', 800);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL004', 'TSIEGE002', 1600);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL005', 'TSIEGE001', 900);
INSERT INTO prix_vol (id, id_vol, id_type_siege, prix) VALUES ('PVOL00'||nextval('seq_prix_vol'), 'VOL005', 'TSIEGE002', 1800);

INSERT INTO promotion_vol (id, id_vol, id_type_siege, nbr_place, taux_reduction) VALUES ('PRVOL00'||nextval('seq_promotion_vol'), 'VOL001', 'TSIEGE001', 10, 20);
INSERT INTO promotion_vol (id, id_vol, id_type_siege, nbr_place, taux_reduction) VALUES ('PRVOL00'||nextval('seq_promotion_vol'), 'VOL002', 'TSIEGE002', 5, 15);
INSERT INTO promotion_vol (id, id_vol, id_type_siege, nbr_place, taux_reduction) VALUES ('PRVOL00'||nextval('seq_promotion_vol'), 'VOL003', 'TSIEGE001', 8, 10);
INSERT INTO promotion_vol (id, id_vol, id_type_siege, nbr_place, taux_reduction) VALUES ('PRVOL00'||nextval('seq_promotion_vol'), 'VOL004', 'TSIEGE002', 6, 25);
INSERT INTO promotion_vol (id, id_vol, id_type_siege, nbr_place, taux_reduction) VALUES ('PRVOL00'||nextval('seq_promotion_vol'), 'VOL005', 'TSIEGE001', 12, 30);

INSERT INTO configuration (id, desce, val) VALUES ('CONF00'||nextval('seq_configuration'), 'reservation', 6);
INSERT INTO configuration (id, desce, val) VALUES ('CONF00'||nextval('seq_configuration'), 'annulation', 12);

INSERT INTO utilisateur (id, nom, prenom, email, password, role) VALUES ('USER00'||nextval('seq_utilisateur'), 'Rakoto', 'Jean', 'jean@avion.mg', sha256('admin'), 1);
INSERT INTO utilisateur (id, nom, prenom, email, password, role) VALUES ('USER00'||nextval('seq_utilisateur'), 'Rasoamanana', 'Marie', 'marie@avion.mg', sha256('admin'), 1);
INSERT INTO utilisateur (id, nom, prenom, email, password, role) VALUES ('USER00'||nextval('seq_utilisateur'), 'Randria', 'Paul', 'paul@avion.mg', sha256('admin'), 1);
INSERT INTO utilisateur (id, nom, prenom, email, password, role) VALUES ('USER00'||nextval('seq_utilisateur'), 'Ravelo', 'Lucie', 'lucie@avion.mg', sha256('admin'), 1);
INSERT INTO utilisateur (id, nom, prenom, email, password, role) VALUES ('USER00'||nextval('seq_utilisateur'), 'Rajaonarivelo', 'Hery', 'hery@avion.mg', sha256('admin'), 1);
INSERT INTO utilisateur (id, nom, prenom, email, password, role) VALUES ('USER00'||nextval('seq_utilisateur'), 'Rajaonarivelo', 'Hery', 'hery2@avion.mg', 'admin', 2);

INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (1, 1, '2023-12-01 07:00:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (1, 2, '2023-12-01 08:00:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (2, 1, '2023-12-02 07:30:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (2, 2, '2023-12-02 08:45:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (3, 1, '2023-12-03 09:15:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (4, 1, '2023-12-04 10:30:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (4, 2, '2023-12-04 11:00:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (5, 1, '2023-12-05 13:00:00');
INSERT INTO reservation (id_vol, id_type_siege, date_reservation) VALUES (5, 2, '2023-12-05 13:30:00');