--
-- PostgreSQL database dump
--

\restrict a8Y4Lfaab4o8m81d5uzM4wxY4bOgfTxW1Olvg0HWtWw5toCbFNCubJAj0NYjh2e

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-24 23:47:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 252 (class 1255 OID 16684)
-- Name: fn_auditoria(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.fn_auditoria() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_usuario TEXT;
    v_pagina TEXT;
    v_ip TEXT;
BEGIN
    v_usuario := current_user;

    BEGIN
        v_ip := inet_client_addr();
    EXCEPTION WHEN OTHERS THEN
        v_ip := '0.0.0.0';
    END;

    v_pagina := current_setting('audit.page', true);

    IF (TG_OP = 'INSERT') THEN
        INSERT INTO tb_auditoria(tabla_aud, operacion_aud, new_data, usuario_aud, ip_aud, pagina_aud)
        VALUES (TG_TABLE_NAME, TG_OP, to_jsonb(NEW), v_usuario, v_ip, v_pagina);
        RETURN NEW;

    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO tb_auditoria(tabla_aud, operacion_aud, old_data, new_data, usuario_aud, ip_aud, pagina_aud)
        VALUES (TG_TABLE_NAME, TG_OP, to_jsonb(OLD), to_jsonb(NEW), v_usuario, v_ip, v_pagina);
        RETURN NEW;

    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO tb_auditoria(tabla_aud, operacion_aud, old_data, usuario_aud, ip_aud, pagina_aud)
        VALUES (TG_TABLE_NAME, TG_OP, to_jsonb(OLD), v_usuario, v_ip, v_pagina);
        RETURN OLD;
    END IF;
END;
$$;


ALTER FUNCTION public.fn_auditoria() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 238 (class 1259 OID 16700)
-- Name: tb_apoyos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_apoyos (
    id_apoyo integer NOT NULL,
    id_usuario integer,
    id_galeria integer NOT NULL,
    monto numeric(10,2) NOT NULL,
    fecha timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tb_apoyos OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16699)
-- Name: tb_apoyos_id_apoyo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_apoyos_id_apoyo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_apoyos_id_apoyo_seq OWNER TO postgres;

--
-- TOC entry 5034 (class 0 OID 0)
-- Dependencies: 237
-- Name: tb_apoyos_id_apoyo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_apoyos_id_apoyo_seq OWNED BY public.tb_apoyos.id_apoyo;


--
-- TOC entry 236 (class 1259 OID 16674)
-- Name: tb_auditoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_auditoria (
    id_aud integer NOT NULL,
    fecha_aud timestamp without time zone DEFAULT now(),
    usuario_aud character varying(120),
    tabla_aud character varying(80),
    operacion_aud character varying(20),
    old_data jsonb,
    new_data jsonb,
    ip_aud character varying(50),
    pagina_aud character varying(150)
);


ALTER TABLE public.tb_auditoria OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16673)
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_auditoria_id_aud_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_auditoria_id_aud_seq OWNER TO postgres;

--
-- TOC entry 5035 (class 0 OID 0)
-- Dependencies: 235
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_auditoria_id_aud_seq OWNED BY public.tb_auditoria.id_aud;


--
-- TOC entry 240 (class 1259 OID 16722)
-- Name: tb_categoria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_categoria (
    id_categoria integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text
);


ALTER TABLE public.tb_categoria OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16721)
-- Name: tb_categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_categoria_id_categoria_seq OWNER TO postgres;

--
-- TOC entry 5036 (class 0 OID 0)
-- Dependencies: 239
-- Name: tb_categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_categoria_id_categoria_seq OWNED BY public.tb_categoria.id_categoria;


--
-- TOC entry 222 (class 1259 OID 16551)
-- Name: tb_estadocivil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_estadocivil (
    id_estadocivil integer NOT NULL,
    descripcion character varying(50)
);


ALTER TABLE public.tb_estadocivil OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16550)
-- Name: tb_estadocivil_id_estadocivil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_estadocivil_id_estadocivil_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_estadocivil_id_estadocivil_seq OWNER TO postgres;

--
-- TOC entry 5037 (class 0 OID 0)
-- Dependencies: 221
-- Name: tb_estadocivil_id_estadocivil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_estadocivil_id_estadocivil_seq OWNED BY public.tb_estadocivil.id_estadocivil;


--
-- TOC entry 230 (class 1259 OID 16612)
-- Name: tb_galeria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_galeria (
    id_galeria integer NOT NULL,
    carrera character varying(100) NOT NULL,
    descripcion text NOT NULL,
    imagen character varying(200) NOT NULL,
    id_categoria integer
);


ALTER TABLE public.tb_galeria OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16611)
-- Name: tb_galeria_id_galeria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_galeria_id_galeria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_galeria_id_galeria_seq OWNER TO postgres;

--
-- TOC entry 5038 (class 0 OID 0)
-- Dependencies: 229
-- Name: tb_galeria_id_galeria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_galeria_id_galeria_seq OWNED BY public.tb_galeria.id_galeria;


--
-- TOC entry 232 (class 1259 OID 16625)
-- Name: tb_novenas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_novenas (
    id_novena integer NOT NULL,
    dia integer NOT NULL,
    fecha date NOT NULL,
    organiza character varying(120) NOT NULL,
    lugar character varying(120) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.tb_novenas OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16624)
-- Name: tb_novenas_id_novena_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_novenas_id_novena_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_novenas_id_novena_seq OWNER TO postgres;

--
-- TOC entry 5039 (class 0 OID 0)
-- Dependencies: 231
-- Name: tb_novenas_id_novena_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_novenas_id_novena_seq OWNED BY public.tb_novenas.id_novena;


--
-- TOC entry 226 (class 1259 OID 16584)
-- Name: tb_pagina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_pagina (
    id_pagina integer NOT NULL,
    nombre character varying(80),
    url character varying(200)
);


ALTER TABLE public.tb_pagina OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16583)
-- Name: tb_pagina_id_pagina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_pagina_id_pagina_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_pagina_id_pagina_seq OWNER TO postgres;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 225
-- Name: tb_pagina_id_pagina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_pagina_id_pagina_seq OWNED BY public.tb_pagina.id_pagina;


--
-- TOC entry 220 (class 1259 OID 16542)
-- Name: tb_perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_perfil (
    id_perfil integer NOT NULL,
    nombre character varying(30) NOT NULL
);


ALTER TABLE public.tb_perfil OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16541)
-- Name: tb_perfil_id_perfil_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_perfil_id_perfil_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_perfil_id_perfil_seq OWNER TO postgres;

--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 219
-- Name: tb_perfil_id_perfil_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_perfil_id_perfil_seq OWNED BY public.tb_perfil.id_perfil;


--
-- TOC entry 228 (class 1259 OID 16592)
-- Name: tb_perfilpagina; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_perfilpagina (
    id_perfilpagina integer NOT NULL,
    id_perfil integer NOT NULL,
    id_pagina integer NOT NULL
);


ALTER TABLE public.tb_perfilpagina OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16591)
-- Name: tb_perfilpagina_id_perfilpagina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_perfilpagina_id_perfilpagina_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_perfilpagina_id_perfilpagina_seq OWNER TO postgres;

--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 227
-- Name: tb_perfilpagina_id_perfilpagina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_perfilpagina_id_perfilpagina_seq OWNED BY public.tb_perfilpagina.id_perfilpagina;


--
-- TOC entry 224 (class 1259 OID 16559)
-- Name: tb_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_usuario (
    id_usuario integer NOT NULL,
    nombre character varying(80) NOT NULL,
    apellido character varying(80) NOT NULL,
    correo character varying(120) NOT NULL,
    contrasena character varying(200) NOT NULL,
    id_estadocivil integer,
    id_perfil integer NOT NULL,
    bloqueado boolean DEFAULT false
);


ALTER TABLE public.tb_usuario OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16558)
-- Name: tb_usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_usuario_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 223
-- Name: tb_usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_usuario_id_usuario_seq OWNED BY public.tb_usuario.id_usuario;


--
-- TOC entry 234 (class 1259 OID 16640)
-- Name: tb_voto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_voto (
    id_voto integer NOT NULL,
    id_usuario integer NOT NULL,
    id_galeria integer NOT NULL,
    fecha_voto timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tb_voto OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16639)
-- Name: tb_voto_id_voto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_voto_id_voto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_voto_id_voto_seq OWNER TO postgres;

--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 233
-- Name: tb_voto_id_voto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_voto_id_voto_seq OWNED BY public.tb_voto.id_voto;


--
-- TOC entry 4818 (class 2604 OID 16703)
-- Name: tb_apoyos id_apoyo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_apoyos ALTER COLUMN id_apoyo SET DEFAULT nextval('public.tb_apoyos_id_apoyo_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 16677)
-- Name: tb_auditoria id_aud; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_auditoria ALTER COLUMN id_aud SET DEFAULT nextval('public.tb_auditoria_id_aud_seq'::regclass);


--
-- TOC entry 4820 (class 2604 OID 16725)
-- Name: tb_categoria id_categoria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.tb_categoria_id_categoria_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 16554)
-- Name: tb_estadocivil id_estadocivil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_estadocivil ALTER COLUMN id_estadocivil SET DEFAULT nextval('public.tb_estadocivil_id_estadocivil_seq'::regclass);


--
-- TOC entry 4812 (class 2604 OID 16615)
-- Name: tb_galeria id_galeria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_galeria ALTER COLUMN id_galeria SET DEFAULT nextval('public.tb_galeria_id_galeria_seq'::regclass);


--
-- TOC entry 4813 (class 2604 OID 16628)
-- Name: tb_novenas id_novena; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_novenas ALTER COLUMN id_novena SET DEFAULT nextval('public.tb_novenas_id_novena_seq'::regclass);


--
-- TOC entry 4810 (class 2604 OID 16587)
-- Name: tb_pagina id_pagina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_pagina ALTER COLUMN id_pagina SET DEFAULT nextval('public.tb_pagina_id_pagina_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 16545)
-- Name: tb_perfil id_perfil; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfil ALTER COLUMN id_perfil SET DEFAULT nextval('public.tb_perfil_id_perfil_seq'::regclass);


--
-- TOC entry 4811 (class 2604 OID 16595)
-- Name: tb_perfilpagina id_perfilpagina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfilpagina ALTER COLUMN id_perfilpagina SET DEFAULT nextval('public.tb_perfilpagina_id_perfilpagina_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 16562)
-- Name: tb_usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.tb_usuario_id_usuario_seq'::regclass);


--
-- TOC entry 4814 (class 2604 OID 16643)
-- Name: tb_voto id_voto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_voto ALTER COLUMN id_voto SET DEFAULT nextval('public.tb_voto_id_voto_seq'::regclass);


--
-- TOC entry 5026 (class 0 OID 16700)
-- Dependencies: 238
-- Data for Name: tb_apoyos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_apoyos (id_apoyo, id_usuario, id_galeria, monto, fecha) FROM stdin;
2	\N	3	123.00	2025-11-24 18:30:23.583743
\.


--
-- TOC entry 5024 (class 0 OID 16674)
-- Dependencies: 236
-- Data for Name: tb_auditoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_auditoria (id_aud, fecha_aud, usuario_aud, tabla_aud, operacion_aud, old_data, new_data, ip_aud, pagina_aud) FROM stdin;
1	2025-11-24 17:12:43.315431	postgres	tb_usuario	UPDATE	{"correo": "d@gmail.com", "nombre": "hola", "apellido": "11", "bloqueado": false, "id_perfil": 2, "contrasena": "1234", "id_usuario": 1, "id_estadocivil": 2}	{"correo": "d@gmail.com", "nombre": "hola", "apellido": "11", "bloqueado": true, "id_perfil": 2, "contrasena": "1234", "id_usuario": 1, "id_estadocivil": 2}	127.0.0.1/32	\N
2	2025-11-24 17:12:44.971542	postgres	tb_usuario	UPDATE	{"correo": "d@gmail.com", "nombre": "hola", "apellido": "11", "bloqueado": true, "id_perfil": 2, "contrasena": "1234", "id_usuario": 1, "id_estadocivil": 2}	{"correo": "d@gmail.com", "nombre": "hola", "apellido": "11", "bloqueado": false, "id_perfil": 2, "contrasena": "1234", "id_usuario": 1, "id_estadocivil": 2}	127.0.0.1/32	\N
3	2025-11-24 17:16:21.220193	postgres	tb_usuario	INSERT	\N	{"correo": "d11@gmail.com", "nombre": "david", "apellido": "castillo", "bloqueado": false, "id_perfil": 2, "contrasena": "123456", "id_usuario": 4, "id_estadocivil": 2}	127.0.0.1/32	\N
4	2025-11-24 17:18:51.644391	postgres	tb_pagina	INSERT	\N	{"url": "http://localhost:8080/pesebre/visitante/apoya.jsp", "nombre": "Apoya tu Pesebre", "id_pagina": 12}	::1/128	\N
5	2025-11-24 17:19:00.657196	postgres	tb_perfilpagina	INSERT	\N	{"id_pagina": 12, "id_perfil": 2, "id_perfilpagina": 13}	::1/128	\N
6	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Electricidad", "id_galeria": 2, "descripcion": "Ingenieros que trabajan en sistemas eléctricos y energía. Su pesebre resalta luz y esperanza.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Electricidad", "id_galeria": 2, "descripcion": "Ingenieros que trabajan en sistemas eléctricos y energía. Su pesebre resalta luz y esperanza.", "id_categoria": 1}	::1/128	\N
7	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Electrónica y Automatización", "id_galeria": 3, "descripcion": "Automatización y tecnología avanzada para la industria. Un pesebre lleno de detalles técnicos.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Electrónica y Automatización", "id_galeria": 3, "descripcion": "Automatización y tecnología avanzada para la industria. Un pesebre lleno de detalles técnicos.", "id_categoria": 1}	::1/128	\N
8	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Ambiental", "id_galeria": 4, "descripcion": "Protección del planeta y sostenibilidad. El pesebre simboliza naturaleza y vida.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Ambiental", "id_galeria": 4, "descripcion": "Protección del planeta y sostenibilidad. El pesebre simboliza naturaleza y vida.", "id_categoria": 1}	::1/128	\N
9	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Automotriz", "id_galeria": 5, "descripcion": "Expertos en vehículos y motores. Un pesebre con engranajes y movimiento navideño.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Automotriz", "id_galeria": 5, "descripcion": "Expertos en vehículos y motores. Un pesebre con engranajes y movimiento navideño.", "id_categoria": 1}	::1/128	\N
10	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Civil", "id_galeria": 6, "descripcion": "Constructores de infraestructura y obras. Su pesebre muestra estabilidad y paz.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Civil", "id_galeria": 6, "descripcion": "Constructores de infraestructura y obras. Su pesebre muestra estabilidad y paz.", "id_categoria": 1}	::1/128	\N
11	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Mecánica", "id_galeria": 7, "descripcion": "Diseño de mecanismos y sistemas industriales. Pesebre con engranajes y armonía.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Mecánica", "id_galeria": 7, "descripcion": "Diseño de mecanismos y sistemas industriales. Pesebre con engranajes y armonía.", "id_categoria": 1}	::1/128	\N
12	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Mecatrónica", "id_galeria": 8, "descripcion": "Robótica e integración tecnológica. Pesebre con precisión e ingenio festivo.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Ingeniería Mecatrónica", "id_galeria": 8, "descripcion": "Robótica e integración tecnológica. Pesebre con precisión e ingenio festivo.", "id_categoria": 1}	::1/128	\N
13	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Telecomunicaciones", "id_galeria": 9, "descripcion": "Comunicaciones y redes. Su pesebre representa conexión entre personas y fe.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Telecomunicaciones", "id_galeria": 9, "descripcion": "Comunicaciones y redes. Su pesebre representa conexión entre personas y fe.", "id_categoria": 1}	::1/128	\N
14	2025-11-24 18:53:13.574354	postgres	tb_galeria	UPDATE	{"imagen": "images/pesebreda.png", "carrera": "Computación", "id_galeria": 1, "descripcion": "Profesionales que crean software y soluciones tecnológicas. Este pesebre representa creatividad e innovación.", "id_categoria": null}	{"imagen": "images/pesebreda.png", "carrera": "Computación", "id_galeria": 1, "descripcion": "Profesionales que crean software y soluciones tecnológicas. Este pesebre representa creatividad e innovación.", "id_categoria": 1}	::1/128	\N
\.


--
-- TOC entry 5028 (class 0 OID 16722)
-- Dependencies: 240
-- Data for Name: tb_categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_categoria (id_categoria, nombre, descripcion) FROM stdin;
1	Pesebre Tradicional	Representación clásica del nacimiento de Jesús.
2	Villancicos y Música	Audios navideños y villancicos.
3	Arte Navideño 3D	Modelos 3D y objetos navideños interactivos.
\.


--
-- TOC entry 5010 (class 0 OID 16551)
-- Dependencies: 222
-- Data for Name: tb_estadocivil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_estadocivil (id_estadocivil, descripcion) FROM stdin;
1	Soltero
2	Casado
3	Viudo
\.


--
-- TOC entry 5018 (class 0 OID 16612)
-- Dependencies: 230
-- Data for Name: tb_galeria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_galeria (id_galeria, carrera, descripcion, imagen, id_categoria) FROM stdin;
2	Electricidad	Ingenieros que trabajan en sistemas eléctricos y energía. Su pesebre resalta luz y esperanza.	images/pesebreda.png	1
3	Electrónica y Automatización	Automatización y tecnología avanzada para la industria. Un pesebre lleno de detalles técnicos.	images/pesebreda.png	1
4	Ingeniería Ambiental	Protección del planeta y sostenibilidad. El pesebre simboliza naturaleza y vida.	images/pesebreda.png	1
5	Ingeniería Automotriz	Expertos en vehículos y motores. Un pesebre con engranajes y movimiento navideño.	images/pesebreda.png	1
6	Ingeniería Civil	Constructores de infraestructura y obras. Su pesebre muestra estabilidad y paz.	images/pesebreda.png	1
7	Ingeniería Mecánica	Diseño de mecanismos y sistemas industriales. Pesebre con engranajes y armonía.	images/pesebreda.png	1
8	Ingeniería Mecatrónica	Robótica e integración tecnológica. Pesebre con precisión e ingenio festivo.	images/pesebreda.png	1
9	Telecomunicaciones	Comunicaciones y redes. Su pesebre representa conexión entre personas y fe.	images/pesebreda.png	1
1	Computación	Profesionales que crean software y soluciones tecnológicas. Este pesebre representa creatividad e innovación.	images/pesebreda.png	1
\.


--
-- TOC entry 5020 (class 0 OID 16625)
-- Dependencies: 232
-- Data for Name: tb_novenas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_novenas (id_novena, dia, fecha, organiza, lugar, descripcion) FROM stdin;
1	1	2024-12-15	Bloque A – Computación	Auditorio Principal	Apertura del novenario con cantos, oración y presentación temática navideña.
2	2	2024-12-16	Bloque B – Electricidad	Iglesia UPS	Reflexión iluminada, villancicos y ambientación preparada por el bloque.
3	3	2024-12-17	Bloque C – Electrónica y Automatización	Patio Central	Presentación creativa con luces, adornos electrónicos y oración comunitaria.
4	4	2024-12-18	Bloque D – Ingeniería Ambiental	Árbol Central	Novenas ecológicas con mensajes de cuidado ambiental y paz.
5	5	2024-12-19	Bloque E – Ingeniería Civil	Zona de Aulas 2	Representación simbólica del pesebre utilizando estructuras y creatividad.
6	6	2024-12-20	Bloque F – Mecánica y Mecatrónica	Auditorio de Ingeniería	Novenas con elementos mecánicos decorativos y mensaje navideño.
7	7	2024-12-21	Pastoral Universitaria	Capilla	Oración especial, villancicos tradicionales y reflexión espiritual.
8	8	2024-12-22	Iglesia UPS	Iglesia	Celebra la víspera final del novenario antes del cierre académico.
9	9	2024-12-23	Coordinación UPS	Patio Central	Clausura oficial del novenario con mensaje de esperanza y despedida navideña.
\.


--
-- TOC entry 5014 (class 0 OID 16584)
-- Dependencies: 226
-- Data for Name: tb_pagina; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_pagina (id_pagina, nombre, url) FROM stdin;
2	Trivia Navideña	http://localhost:8080/pesebre/visitante/trivia.jsp
5	Votar Mejor Pesebre	http://localhost:8080/pesebre/visitante/votar.jsp
6	Cerrar Sesión	http://localhost:8080/pesebre/visitante/logout.jsp
7	Panel Administrador	http://localhost:8080/pesebre/admin/admin.jsp
8	Gestión de Usuarios	http://localhost:8080/pesebre/admin/adminUsuarios.jsp
9	Gestión de Pesebres del Campus	http://localhost:8080/pesebre/admin/adminPesebres.jsp
10	Gestión de Novenas	http://localhost:8080/pesebre/admin/adminNovenas.jsp
11	Bitácora del Sistema	http://localhost:8080/pesebre/admin/bitacora.jsp
3	Videojuego Navideño	http://localhost:8080/pesebre/visitante/juego.jsp
4	Curiosidades	http://localhost:8080/pesebre/visitante/curiosidades.jsp
12	Apoya tu Pesebre	http://localhost:8080/pesebre/visitante/apoya.jsp
\.


--
-- TOC entry 5008 (class 0 OID 16542)
-- Dependencies: 220
-- Data for Name: tb_perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_perfil (id_perfil, nombre) FROM stdin;
1	ADMIN
2	VISITANTE
\.


--
-- TOC entry 5016 (class 0 OID 16592)
-- Dependencies: 228
-- Data for Name: tb_perfilpagina; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_perfilpagina (id_perfilpagina, id_perfil, id_pagina) FROM stdin;
2	2	2
3	2	3
4	2	4
5	2	5
6	2	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	6
13	2	12
\.


--
-- TOC entry 5012 (class 0 OID 16559)
-- Dependencies: 224
-- Data for Name: tb_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_usuario (id_usuario, nombre, apellido, correo, contrasena, id_estadocivil, id_perfil, bloqueado) FROM stdin;
2	a	a	a@gmail.com	1234	1	1	f
3	2	2	2@gmail.com	2	1	1	f
1	hola	11	d@gmail.com	1234	2	2	f
4	david	castillo	d11@gmail.com	123456	2	2	f
\.


--
-- TOC entry 5022 (class 0 OID 16640)
-- Dependencies: 234
-- Data for Name: tb_voto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_voto (id_voto, id_usuario, id_galeria, fecha_voto) FROM stdin;
3	1	4	2025-11-21 21:53:04.85986
\.


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 237
-- Name: tb_apoyos_id_apoyo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_apoyos_id_apoyo_seq', 2, true);


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 235
-- Name: tb_auditoria_id_aud_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_auditoria_id_aud_seq', 14, true);


--
-- TOC entry 5047 (class 0 OID 0)
-- Dependencies: 239
-- Name: tb_categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_categoria_id_categoria_seq', 3, true);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 221
-- Name: tb_estadocivil_id_estadocivil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_estadocivil_id_estadocivil_seq', 3, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 229
-- Name: tb_galeria_id_galeria_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_galeria_id_galeria_seq', 9, true);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 231
-- Name: tb_novenas_id_novena_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_novenas_id_novena_seq', 9, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 225
-- Name: tb_pagina_id_pagina_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_pagina_id_pagina_seq', 12, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 219
-- Name: tb_perfil_id_perfil_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_perfil_id_perfil_seq', 2, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 227
-- Name: tb_perfilpagina_id_perfilpagina_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_perfilpagina_id_perfilpagina_seq', 13, true);


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 223
-- Name: tb_usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_usuario_id_usuario_seq', 4, true);


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 233
-- Name: tb_voto_id_voto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_voto_id_voto_seq', 3, true);


--
-- TOC entry 4842 (class 2606 OID 16710)
-- Name: tb_apoyos tb_apoyos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_apoyos
    ADD CONSTRAINT tb_apoyos_pkey PRIMARY KEY (id_apoyo);


--
-- TOC entry 4840 (class 2606 OID 16683)
-- Name: tb_auditoria tb_auditoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_auditoria
    ADD CONSTRAINT tb_auditoria_pkey PRIMARY KEY (id_aud);


--
-- TOC entry 4844 (class 2606 OID 16731)
-- Name: tb_categoria tb_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_categoria
    ADD CONSTRAINT tb_categoria_pkey PRIMARY KEY (id_categoria);


--
-- TOC entry 4824 (class 2606 OID 16557)
-- Name: tb_estadocivil tb_estadocivil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_estadocivil
    ADD CONSTRAINT tb_estadocivil_pkey PRIMARY KEY (id_estadocivil);


--
-- TOC entry 4834 (class 2606 OID 16623)
-- Name: tb_galeria tb_galeria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_galeria
    ADD CONSTRAINT tb_galeria_pkey PRIMARY KEY (id_galeria);


--
-- TOC entry 4836 (class 2606 OID 16638)
-- Name: tb_novenas tb_novenas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_novenas
    ADD CONSTRAINT tb_novenas_pkey PRIMARY KEY (id_novena);


--
-- TOC entry 4830 (class 2606 OID 16590)
-- Name: tb_pagina tb_pagina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_pagina
    ADD CONSTRAINT tb_pagina_pkey PRIMARY KEY (id_pagina);


--
-- TOC entry 4822 (class 2606 OID 16549)
-- Name: tb_perfil tb_perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfil
    ADD CONSTRAINT tb_perfil_pkey PRIMARY KEY (id_perfil);


--
-- TOC entry 4832 (class 2606 OID 16600)
-- Name: tb_perfilpagina tb_perfilpagina_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfilpagina
    ADD CONSTRAINT tb_perfilpagina_pkey PRIMARY KEY (id_perfilpagina);


--
-- TOC entry 4826 (class 2606 OID 16572)
-- Name: tb_usuario tb_usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_correo_key UNIQUE (correo);


--
-- TOC entry 4828 (class 2606 OID 16570)
-- Name: tb_usuario tb_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4838 (class 2606 OID 16649)
-- Name: tb_voto tb_voto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_voto
    ADD CONSTRAINT tb_voto_pkey PRIMARY KEY (id_voto);


--
-- TOC entry 4854 (class 2620 OID 16693)
-- Name: tb_estadocivil trg_aud_estadocivil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_estadocivil AFTER INSERT OR DELETE OR UPDATE ON public.tb_estadocivil FOR EACH ROW EXECUTE FUNCTION public.fn_auditoria();


--
-- TOC entry 4858 (class 2620 OID 16697)
-- Name: tb_galeria trg_aud_galeria; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_galeria AFTER INSERT OR DELETE OR UPDATE ON public.tb_galeria FOR EACH ROW EXECUTE FUNCTION public.fn_auditoria();


--
-- TOC entry 4859 (class 2620 OID 16698)
-- Name: tb_novenas trg_aud_novenas; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_novenas AFTER INSERT OR DELETE OR UPDATE ON public.tb_novenas FOR EACH ROW EXECUTE FUNCTION public.fn_auditoria();


--
-- TOC entry 4856 (class 2620 OID 16695)
-- Name: tb_pagina trg_aud_pagina; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_pagina AFTER INSERT OR DELETE OR UPDATE ON public.tb_pagina FOR EACH ROW EXECUTE FUNCTION public.fn_auditoria();


--
-- TOC entry 4853 (class 2620 OID 16694)
-- Name: tb_perfil trg_aud_perfil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_perfil AFTER INSERT OR DELETE OR UPDATE ON public.tb_perfil FOR EACH ROW EXECUTE FUNCTION public.fn_auditoria();


--
-- TOC entry 4857 (class 2620 OID 16696)
-- Name: tb_perfilpagina trg_aud_perfilpagina; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_perfilpagina AFTER INSERT OR DELETE OR UPDATE ON public.tb_perfilpagina FOR EACH ROW EXECUTE FUNCTION public.fn_auditoria();


--
-- TOC entry 4855 (class 2620 OID 16692)
-- Name: tb_usuario trg_aud_usuario; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_usuario AFTER INSERT OR DELETE OR UPDATE ON public.tb_usuario FOR EACH ROW EXECUTE FUNCTION public.fn_auditoria();


--
-- TOC entry 4852 (class 2606 OID 16716)
-- Name: tb_apoyos tb_apoyos_id_galeria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_apoyos
    ADD CONSTRAINT tb_apoyos_id_galeria_fkey FOREIGN KEY (id_galeria) REFERENCES public.tb_galeria(id_galeria);


--
-- TOC entry 4849 (class 2606 OID 16732)
-- Name: tb_galeria tb_galeria_id_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_galeria
    ADD CONSTRAINT tb_galeria_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES public.tb_categoria(id_categoria);


--
-- TOC entry 4847 (class 2606 OID 16606)
-- Name: tb_perfilpagina tb_perfilpagina_id_pagina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfilpagina
    ADD CONSTRAINT tb_perfilpagina_id_pagina_fkey FOREIGN KEY (id_pagina) REFERENCES public.tb_pagina(id_pagina);


--
-- TOC entry 4848 (class 2606 OID 16601)
-- Name: tb_perfilpagina tb_perfilpagina_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_perfilpagina
    ADD CONSTRAINT tb_perfilpagina_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES public.tb_perfil(id_perfil);


--
-- TOC entry 4845 (class 2606 OID 16573)
-- Name: tb_usuario tb_usuario_id_estadocivil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_id_estadocivil_fkey FOREIGN KEY (id_estadocivil) REFERENCES public.tb_estadocivil(id_estadocivil);


--
-- TOC entry 4846 (class 2606 OID 16578)
-- Name: tb_usuario tb_usuario_id_perfil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_usuario
    ADD CONSTRAINT tb_usuario_id_perfil_fkey FOREIGN KEY (id_perfil) REFERENCES public.tb_perfil(id_perfil);


--
-- TOC entry 4850 (class 2606 OID 16655)
-- Name: tb_voto tb_voto_id_galeria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_voto
    ADD CONSTRAINT tb_voto_id_galeria_fkey FOREIGN KEY (id_galeria) REFERENCES public.tb_galeria(id_galeria);


--
-- TOC entry 4851 (class 2606 OID 16650)
-- Name: tb_voto tb_voto_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_voto
    ADD CONSTRAINT tb_voto_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.tb_usuario(id_usuario);


-- Completed on 2025-11-24 23:47:45

--
-- PostgreSQL database dump complete
--

\unrestrict a8Y4Lfaab4o8m81d5uzM4wxY4bOgfTxW1Olvg0HWtWw5toCbFNCubJAj0NYjh2e

