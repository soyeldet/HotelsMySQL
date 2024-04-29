drop database hotels;

create database hotels;

use hotels;

create table ciutat(
	ciutat varchar(50),
    pais varchar(50) not null,
    constraint pk_ciutat primary key (ciutat)
);

create table cadenes_hoteleres(
	nom varchar(50) not null,
	id_cadenes int auto_increment,
    cif varchar(50) not null,
    adreca_fiscal varchar(50) not null,
    constraint pk_cadenes_hoteleres primary key (id_cadenes)
);

create table hotels(
    nom varchar(50),
    ciutat varchar(50),
    categoria tinyint not null, -- check
    adreca varchar(50) not null,
    telefon int not null,
    tipus_hotel varchar(50) not null,
    cadena_hotelera int not null,
    constraint pk_hotels primary key (nom, ciutat),
    constraint fk_hotels_ciutat foreign key (ciutat) references ciutat(ciutat),
    constraint fk_cadena foreign key (cadena_hotelera) references cadenes_hoteleres(id_cadenes)
);

create table equivalents(
	nom varchar(50),
    ciutat varchar(50),
    nom_equivalent varchar(50),
    ciutat_equivalent varchar(50),
    constraint pk_equivalents primary key (nom, ciutat, nom_equivalent, ciutat_equivalent),
	constraint fk_equivalents_nom_ciutat foreign key (nom, ciutat) references hotels(nom, ciutat),
	constraint fk_equivalents_nomequivalent_ciutatequivalent foreign key (nom_equivalent, ciutat_equivalent) references hotels(nom, ciutat)
);

create table agencia(
    nom varchar(50) not null,
	id_agencia int auto_increment primary key
);

create table delegacio(
    id_delegacio int auto_increment,
	id_agencia int,
    ciutat varchar(50) not null,
    constraint pk_delegacio primary key (id_delegacio, id_agencia),
    constraint fk_delegacio_agencia foreign key (id_agencia) references agencia(id_agencia),
    constraint fk_delegacio_ciutat foreign key (ciutat) references ciutat(ciutat)
);

create table asignar(
	nom varchar(50),
    ciutat varchar(50),
    id_mes int not null,
    id_agencia int,
    turistes int not null,
    constraint pk_asignar primary key(nom, id_mes, id_agencia, ciutat),
    constraint fk_asignar_agencia foreign key (id_agencia) references agencia(id_agencia),
    constraint fk_asignar_nom foreign key (nom, ciutat) references hotels(nom, ciutat)
);

create table hotel_de_platja(
	nom varchar(50),
    ciutat varchar(50),
    platja_privada boolean not null,
    lloguer_embarcacions boolean not null,
    constraint pk_hotel_de_platja primary key (nom, ciutat),
    constraint fk_hotelplatja_hotels foreign key (nom, ciutat) references hotels(nom, ciutat)
);

create table hotel_de_muntanya(
	nom varchar(50),
	ciutat varchar(50),
    piscina boolean,
	constraint pk_hotel_de_muntanya primary key (nom, ciutat),
    constraint fk_hotelmuntanya_hotels foreign key (nom, ciutat) references hotels(nom, ciutat)
);

create table activitats(
	id_activitat int not null,
    nom_activitat varchar(50) not null,
    constraint pk_activitats primary key (id_activitat)
);


create table empleats(
	nom varchar(50) not null,
    dni char(9) not null,
    constraint pk_empleats primary key (dni)
);

create table contractar(
	id_cadenes int not null,
    dni char(9) not null,
	data_inici date not null,
	data_fi date not null,
	lloc_de_treball varchar(50) not null,
    constraint pk_constractar primary key(dni, data_inici),
    constraint fk_contractar_cadenes foreign key (id_cadenes) references cadenes_hoteleres(id_cadenes),
    constraint fk_contractar_empleats foreign key (dni) references empleats(dni)
);

create table treballar(
	nom varchar(50),
    ciutat varchar(50),
    dni char(9) not null,
    data_inici date not null,
    data_fi date not null,
    lloc_de_treball varchar(50) not null,
    constraint pk_treballar primary key (dni, data_inici),
    constraint fk_treballar_hotels_ciutat foreign key (nom, ciutat) references hotels(nom, ciutat),
    constraint fk_treballar_empleats foreign key (dni) references empleats(dni)
);

create table contenir(
	id int auto_increment primary key,
    activitat int,
    nom varchar(50),
    ciutat varchar(50),
    nivell char(1),
    constraint fk_activitat foreign key (activitat) references activitats(id_activitat),
    constraint fk_contenir_nom_ciutat foreign key (nom, ciutat) references hotels(nom, ciutat)
)