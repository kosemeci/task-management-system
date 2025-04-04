--
-- PostgreSQL database dump
--

-- Dumped from database version 14.15
-- Dumped by pg_dump version 14.15

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: TASK-MANAGER; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "TASK-MANAGER";


ALTER SCHEMA "TASK-MANAGER" OWNER TO postgres;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: project; Type: TABLE; Schema: TASK-MANAGER; Owner: postgres
--

CREATE TABLE "TASK-MANAGER".project (
    id integer NOT NULL,
    description character varying(255),
    project_name character varying(255) NOT NULL,
    completion_percentage double precision,
    created_date date,
    name character varying(255)
);


ALTER TABLE "TASK-MANAGER".project OWNER TO postgres;

--
-- Name: project_id_seq; Type: SEQUENCE; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE "TASK-MANAGER".project ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "TASK-MANAGER".project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: task; Type: TABLE; Schema: TASK-MANAGER; Owner: postgres
--

CREATE TABLE "TASK-MANAGER".task (
    assigned_date date,
    completion_date date,
    id integer NOT NULL,
    task_title character varying(255),
    description character varying(255),
    status character varying(255),
    priority character varying(255),
    deadline date,
    user_id integer,
    project_id integer,
    created_date date
);


ALTER TABLE "TASK-MANAGER".task OWNER TO postgres;

--
-- Name: task_id_seq; Type: SEQUENCE; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE "TASK-MANAGER".task ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "TASK-MANAGER".task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user; Type: TABLE; Schema: TASK-MANAGER; Owner: postgres
--

CREATE TABLE "TASK-MANAGER"."user" (
    id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    mail_adress character varying(255) NOT NULL,
    "position" character varying(255) NOT NULL,
    tel_number character varying(255),
    birth_of_date date,
    password character varying(255),
    role character varying(255),
    CONSTRAINT user_role_check CHECK (((role)::text = ANY ((ARRAY['USER'::character varying, 'ADMIN'::character varying])::text[])))
);


ALTER TABLE "TASK-MANAGER"."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE "TASK-MANAGER"."user" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "TASK-MANAGER".user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: project; Type: TABLE DATA; Schema: TASK-MANAGER; Owner: postgres
--

COPY "TASK-MANAGER".project (id, description, project_name, completion_percentage, created_date, name) FROM stdin;
2	React.js eğitim videosu izlenecek ve bu projeye entegre edilecek.	React.js Yolculuğu	0	2025-01-23	\N
3	Lets go Learning English	English Learning Path	0	2025-01-23	\N
1	Kullanıcıların proje içerisinde görev takibi yapılması sağlanacaktır.	Task Management System	72.22	2024-12-31	\N
\.


--
-- Data for Name: task; Type: TABLE DATA; Schema: TASK-MANAGER; Owner: postgres
--

COPY "TASK-MANAGER".task (assigned_date, completion_date, id, task_title, description, status, priority, deadline, user_id, project_id, created_date) FROM stdin;
2025-01-03	2024-01-04	1	Postman kurulumu	http isteklerini kolay yönetmek adına postman kullanılacak.	COMPLETED	MEDIUM	2025-01-31	1	1	2025-01-01
2025-01-03	2024-01-08	3	DTO kavramı öğrenilcek	Dto videoları izlenilerek daha iyi anlaşılacak ve projeye entegre edilecek	COMPLETED	HIGH	2025-01-31	4	1	2025-01-01
2025-01-05	2024-01-08	14	Yeni entityler eklenecek	Projenin entity gereksinimleri incelenecek, uygun bulunursa yeni entityler eklenecek	COMPLETED	HIGH	2025-01-25	4	1	2025-01-01
2025-01-16	2025-01-18	19	Kullanıcıya task seçimi yaptırılması	Kullanıcı daha önce herhangi bir kullanıcıya atanmamış taski kendisine atama işlemini yapıcak.	COMPLETED	HIGH	2025-01-19	18	1	2025-01-01
2025-01-17	2025-01-29	30	Proje İstatistiği	Proje içerisinde bulunan tasklerin durumuna göre projenin tamamlanma oranı eklenecek.	COMPLETED	HIGH	2025-01-29	18	1	2025-01-16
2025-01-06	2025-01-18	16	Spring Security Eklenecek	Projeye girişin güvenle sağlanabilmesi çin Spring Security bağımlılığı eklenecek ve user entity sine gerekli alanlar eklenecek	COMPLETED	HIGH	2025-01-31	5	1	2025-01-01
2025-01-02	2024-01-03	2	Postgresql kurulumu	Veri tabanı için postgresql kullanılacak	COMPLETED	MEDIUM	2025-01-31	2	1	2025-01-01
2025-01-06	2024-01-07	15	Validation İşlemlerinin Kontrolü	Kullanıcı tablosu için yapılan validasyon işlemlerinin diğer tablolar içinde yapılması ve test edilmesi gerekiyor.	COMPLETED	HIGH	2025-01-21	18	1	2025-01-01
2025-01-06	\N	17	Coment Entity eklenebilir	Projeye katkısını sorgulayarak ileriki aşamalarda düşünülecek	IN_PROGRESS	LOW	2025-03-31	18	1	2025-01-01
2025-02-01	2025-02-06	28	Bildirim Sistemi	Kullanıcılar sisteme üye olduğunda yada bir task seçtiklerinde maillerine bu tasklerle alakalı bilgi yazısısı iletilebilir. Tamamen mail işlemlerini öğrenme amaçlı.	COMPLETED	MEDIUM	2025-02-15	18	1	2025-01-16
2025-01-17	2025-01-18	32	Task Bitirildiğine Dair Güncelleme	Task bitirildiğine dair sisteme completed ve tarihi ataması yapılması gerekiyor	COMPLETED	HIGH	2025-01-17	18	1	2025-01-16
2025-01-11	2025-01-18	18	Exception ların kontrolü	Fırlatılan exceptionların kullanıcıya temiz bir şekilde uyarı vermesi.	COMPLETED	HIGH	2025-01-31	18	1	2025-01-01
2025-01-16	\N	22	Status özelliği enum yapısına alınacak	Status enum yapısına alınıcak kontrolü kullanıcda değil tamamen sistemde olacak	FAILED	HIGH	2025-01-18	1	1	2025-01-01
2025-02-03	\N	29	Yorum Sistemi	Kullanıcılar tasklerle alakalı yorum yapabilir, bilgilendirme ekleyebilir özelliği hakkında düşünülüyor	FAILED	LOW	2025-02-15	20	1	2025-01-16
2025-01-18	2025-01-29	26	Proje Yönetimi	Projenin içerisine taskların atanması ve yeni projeler açılması sadece adminlere erişebilir olacak	COMPLETED	HIGH	2025-02-01	18	1	2025-01-16
2025-02-03	\N	27	Arayüz Tasarlanması	Hangi araçlarla yapılacağına henüz karar verilmedi	FAILED	LOW	2025-02-15	20	1	2025-01-16
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: TASK-MANAGER; Owner: postgres
--

COPY "TASK-MANAGER"."user" (id, first_name, last_name, mail_adress, "position", tel_number, birth_of_date, password, role) FROM stdin;
4	Salih	Demirayak	S_demirayak@tms.com	Öğretmen	05324563124	2000-11-20	\N	USER
5	Ilker	Uslu	I_uslu@tms.com	Hemşir	05396784521	2000-12-07	\N	USER
27	Emrah	Kose	E_kose@tms.com	Developer	05394898952	1997-03-15	$2a$10$.QTX0akEs2GpZzUOE0g21OAPa9ga8H5tzeXPZy9YJJXky2y0b4EcC	USER
1	Alperen	Kosemeci	kosemeci@gmail.com	Jr Java Developer	05380209916	2000-03-15	$2a$10$natbLn9ps.5aCBA0xV2opeh.8rwJyRZ2DGdQLMqVDgksfzH0OXyjm	ADMIN
17	Mauro	İcardi	mauro@gmail.com	Baller	05364895784	1905-05-05	$2a$10$E2HE3TLStPonLlewx4KQ0eGt/9hht25XLPGpFDkKvcSXafMacuN6e	ADMIN
18	Victor	Osimhen	osimhen@gmail.com	Top Baller	05498965748	1905-05-05	$2a$10$eYbkqsF7GNm7rrv3wGyY6.jaD76pOKp1abGxBQrBAFwH/AHhk/LaW	USER
20	Yusuf	Kutukcuoglu	alpiren1905@gmail.com	Baller	05364891784	1905-05-05	$2a$10$MxYCUQ5lR6xUiHudIl03Pe3C5Y56Yj.yTusRkcMWlpoNGEAOYEQN.	USER
25	Bayram Alperen	Kosemeci	B_kosemeci@tms.com	Developer	05380209916	2025-02-07	$2a$10$h9W.a2UkDg2VEwTu6i5qDeLGuEyndb9FgFnhI7bIIb1lxMSMN40sC	USER
26	Emin Cihat	Kosemeci	E_kosemeci@tms.com	Team Lead	05394898959	1996-07-16	$2a$10$MgjapfqgRXUci27g5NtbVuH7ZaDt8ivSZJVzceGdKqdYsC6czJUoW	USER
2	Engin	Dere	E_dere@tms.com	Fizyoterapist	05380209578	1999-08-08	\N	USER
\.


--
-- Name: project_id_seq; Type: SEQUENCE SET; Schema: TASK-MANAGER; Owner: postgres
--

SELECT pg_catalog.setval('"TASK-MANAGER".project_id_seq', 16, true);


--
-- Name: task_id_seq; Type: SEQUENCE SET; Schema: TASK-MANAGER; Owner: postgres
--

SELECT pg_catalog.setval('"TASK-MANAGER".task_id_seq', 86, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: TASK-MANAGER; Owner: postgres
--

SELECT pg_catalog.setval('"TASK-MANAGER".user_id_seq', 27, true);


--
-- Name: project project_pkey; Type: CONSTRAINT; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE ONLY "TASK-MANAGER".project
    ADD CONSTRAINT project_pkey PRIMARY KEY (id);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE ONLY "TASK-MANAGER".task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- Name: user user_mail_adress_key; Type: CONSTRAINT; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE ONLY "TASK-MANAGER"."user"
    ADD CONSTRAINT user_mail_adress_key UNIQUE (mail_adress);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE ONLY "TASK-MANAGER"."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: task fk2hsytmxysatfvt0p1992cw449; Type: FK CONSTRAINT; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE ONLY "TASK-MANAGER".task
    ADD CONSTRAINT fk2hsytmxysatfvt0p1992cw449 FOREIGN KEY (user_id) REFERENCES "TASK-MANAGER"."user"(id);


--
-- Name: task fkk8qrwowg31kx7hp93sru1pdqa; Type: FK CONSTRAINT; Schema: TASK-MANAGER; Owner: postgres
--

ALTER TABLE ONLY "TASK-MANAGER".task
    ADD CONSTRAINT fkk8qrwowg31kx7hp93sru1pdqa FOREIGN KEY (project_id) REFERENCES "TASK-MANAGER".project(id);


--
-- PostgreSQL database dump complete
--

