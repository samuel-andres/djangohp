--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4 (Debian 14.4-1.pgdg110+1)
-- Dumped by pg_dump version 14.4 (Debian 14.4-1.pgdg110+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: inquilinos_cab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_cab (
    id bigint NOT NULL,
    nombre character varying(200) NOT NULL,
    "cantHabitaciones" integer NOT NULL,
    slug character varying(50) NOT NULL,
    "costoPorNoche" double precision
);


ALTER TABLE public.inquilinos_cab OWNER TO postgres;

--
-- Name: inquilinos_cab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_cab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_cab_id_seq OWNER TO postgres;

--
-- Name: inquilinos_cab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_cab_id_seq OWNED BY public.inquilinos_cab.id;


--
-- Name: inquilinos_cambioestado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_cambioestado (
    id bigint NOT NULL,
    "fechaFin" date,
    "fechaInicio" date NOT NULL,
    estado_id bigint NOT NULL,
    reserva_id bigint NOT NULL
);


ALTER TABLE public.inquilinos_cambioestado OWNER TO postgres;

--
-- Name: inquilinos_cambioestado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_cambioestado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_cambioestado_id_seq OWNER TO postgres;

--
-- Name: inquilinos_cambioestado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_cambioestado_id_seq OWNED BY public.inquilinos_cambioestado.id;


--
-- Name: inquilinos_estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_estado (
    id bigint NOT NULL,
    nombre character varying(200) NOT NULL,
    ambito character varying(200) NOT NULL
);


ALTER TABLE public.inquilinos_estado OWNER TO postgres;

--
-- Name: inquilinos_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_estado_id_seq OWNER TO postgres;

--
-- Name: inquilinos_estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_estado_id_seq OWNED BY public.inquilinos_estado.id;


--
-- Name: inquilinos_foto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_foto (
    id bigint NOT NULL,
    foto character varying(100) NOT NULL,
    descripcion character varying(1000) NOT NULL,
    cab_id bigint
);


ALTER TABLE public.inquilinos_foto OWNER TO postgres;

--
-- Name: inquilinos_foto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_foto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_foto_id_seq OWNER TO postgres;

--
-- Name: inquilinos_foto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_foto_id_seq OWNED BY public.inquilinos_foto.id;


--
-- Name: inquilinos_huesped; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_huesped (
    id bigint NOT NULL,
    nombre character varying(200) NOT NULL,
    apellido character varying(200) NOT NULL,
    telefono character varying(13) NOT NULL,
    usuario_id integer NOT NULL
);


ALTER TABLE public.inquilinos_huesped OWNER TO postgres;

--
-- Name: inquilinos_huesped_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_huesped_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_huesped_id_seq OWNER TO postgres;

--
-- Name: inquilinos_huesped_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_huesped_id_seq OWNED BY public.inquilinos_huesped.id;


--
-- Name: inquilinos_instalacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_instalacion (
    id bigint NOT NULL,
    nombre character varying(200) NOT NULL,
    descripcion character varying(500) NOT NULL
);


ALTER TABLE public.inquilinos_instalacion OWNER TO postgres;

--
-- Name: inquilinos_instalacion_cab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_instalacion_cab (
    id bigint NOT NULL,
    instalacion_id bigint NOT NULL,
    cab_id bigint NOT NULL
);


ALTER TABLE public.inquilinos_instalacion_cab OWNER TO postgres;

--
-- Name: inquilinos_instalacion_cab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_instalacion_cab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_instalacion_cab_id_seq OWNER TO postgres;

--
-- Name: inquilinos_instalacion_cab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_instalacion_cab_id_seq OWNED BY public.inquilinos_instalacion_cab.id;


--
-- Name: inquilinos_instalacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_instalacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_instalacion_id_seq OWNER TO postgres;

--
-- Name: inquilinos_instalacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_instalacion_id_seq OWNED BY public.inquilinos_instalacion.id;


--
-- Name: inquilinos_rango; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_rango (
    id bigint NOT NULL,
    "fechaDesde" date NOT NULL,
    "fechaHasta" date NOT NULL,
    cab_id bigint
);


ALTER TABLE public.inquilinos_rango OWNER TO postgres;

--
-- Name: inquilinos_rango_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_rango_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_rango_id_seq OWNER TO postgres;

--
-- Name: inquilinos_rango_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_rango_id_seq OWNED BY public.inquilinos_rango.id;


--
-- Name: inquilinos_reserva; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_reserva (
    id bigint NOT NULL,
    "cantAdultos" smallint NOT NULL,
    cab_id bigint,
    "fechaDesde" date NOT NULL,
    "fechaHasta" date NOT NULL,
    "cantMenores" smallint,
    "precioFinal" double precision,
    "fechaReserva" date NOT NULL,
    huesped_id bigint,
    CONSTRAINT "inquilinos_reserva_cantAdultos_6b504bf7_check" CHECK (("cantAdultos" >= 0)),
    CONSTRAINT "inquilinos_reserva_cantMenores_check" CHECK (("cantMenores" >= 0))
);


ALTER TABLE public.inquilinos_reserva OWNER TO postgres;

--
-- Name: inquilinos_reserva_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_reserva_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_reserva_id_seq OWNER TO postgres;

--
-- Name: inquilinos_reserva_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_reserva_id_seq OWNED BY public.inquilinos_reserva.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: inquilinos_cab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_cab ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_cab_id_seq'::regclass);


--
-- Name: inquilinos_cambioestado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_cambioestado ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_cambioestado_id_seq'::regclass);


--
-- Name: inquilinos_estado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_estado ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_estado_id_seq'::regclass);


--
-- Name: inquilinos_foto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_foto ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_foto_id_seq'::regclass);


--
-- Name: inquilinos_huesped id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_huesped ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_huesped_id_seq'::regclass);


--
-- Name: inquilinos_instalacion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_instalacion ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_instalacion_id_seq'::regclass);


--
-- Name: inquilinos_instalacion_cab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_instalacion_cab ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_instalacion_cab_id_seq'::regclass);


--
-- Name: inquilinos_rango id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_rango ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_rango_id_seq'::regclass);


--
-- Name: inquilinos_reserva id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_reserva ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_reserva_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
1	huesped
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	61
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add cab	7	add_cab
26	Can change cab	7	change_cab
27	Can delete cab	7	delete_cab
28	Can view cab	7	view_cab
29	Can add calendario	8	add_calendario
30	Can change calendario	8	change_calendario
31	Can delete calendario	8	delete_calendario
32	Can view calendario	8	view_calendario
33	Can add estado	9	add_estado
34	Can change estado	9	change_estado
35	Can delete estado	9	delete_estado
36	Can view estado	9	view_estado
37	Can add foto	10	add_foto
38	Can change foto	10	change_foto
39	Can delete foto	10	delete_foto
40	Can view foto	10	view_foto
41	Can add huesped	11	add_huesped
42	Can change huesped	11	change_huesped
43	Can delete huesped	11	delete_huesped
44	Can view huesped	11	view_huesped
45	Can add reserva	12	add_reserva
46	Can change reserva	12	change_reserva
47	Can delete reserva	12	delete_reserva
48	Can view reserva	12	view_reserva
49	Can add detalle calendario	13	add_detallecalendario
50	Can change detalle calendario	13	change_detallecalendario
51	Can delete detalle calendario	13	delete_detallecalendario
52	Can view detalle calendario	13	view_detallecalendario
53	Can add instalacion	14	add_instalacion
54	Can change instalacion	14	change_instalacion
55	Can delete instalacion	14	delete_instalacion
56	Can view instalacion	14	view_instalacion
57	Can add rango	15	add_rango
58	Can change rango	15	change_rango
59	Can delete rango	15	delete_rango
60	Can view rango	15	view_rango
61	Este usuario puede registrar una reserva.	12	puede_registrar_reserva
62	Can add cambio estado	16	add_cambioestado
63	Can change cambio estado	16	change_cambioestado
64	Can delete cambio estado	16	delete_cambioestado
65	Can view cambio estado	16	view_cambioestado
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, email, is_staff, is_active, date_joined) FROM stdin;
14	pbkdf2_sha256$320000$3g6Gox4raKRUas07yEMEa4$W1YVGxauzN66kbN0sg1vbvFdQvscuIhSd8e3NrvjHMM=	2022-07-30 04:16:26.658351+00	f	firminiobr	firminio@brasil.com	f	t	2022-07-30 04:16:12.663941+00
5	pbkdf2_sha256$320000$r0MSGvzF4C03NPxyOLdJnn$CFbbzp3TBDZHmZVU7QqT7ox2k91dTwQXV1hxJyZlQzI=	2022-08-01 01:03:11.049673+00	f	tomcruz	tomcruz@gmail.com	f	t	2022-07-27 21:56:20.83196+00
2	pbkdf2_sha256$320000$oWHhuYahzzKkmH2sonvdGE$N8FN0v+K9lS0JFyJbleRMQOrWdLenDPR1lLO6dw1rfM=	\N	f	boca		f	t	2022-07-27 12:08:06+00
15	pbkdf2_sha256$320000$KJd78hL8SP1dzWoHGs1Wo2$HvQ3QHpmbFLENUAn9uhBm2qf8jPbRw0Nd+brLO84CwY=	2022-08-01 15:45:54.547392+00	f	lucky	samuel5848@gmail.com	f	t	2022-08-01 15:45:48.904073+00
8	pbkdf2_sha256$320000$EFSBYqt9GW84nXKBkhy5TT$bPg+1sgIFQP6TODFcKXMp+qwoGdMWI3KXuc3/idK1z0=	2022-07-28 00:50:34.44709+00	f	sakalaca	saka@laka.com	f	t	2022-07-28 00:50:28.364987+00
7	pbkdf2_sha256$320000$hGDSBR4QKtbhQw3uer1TCi$MfCwzShTAsvy2v5n4KPZMw7y3Ixhh+HbeRqiLdiQca4=	2022-07-29 04:48:44.071752+00	f	mamamia	mamamia@gmail.com	f	t	2022-07-28 00:25:39.747589+00
16	pbkdf2_sha256$320000$K3vUVPrNcnXiruPfCGnZOJ$xeP4KHENlpQBMtiMeozZUr+FElOpuU7/NcwFqX32tuc=	2022-08-01 18:29:25.055106+00	f	winka	samuel5848@gmail.com	f	t	2022-08-01 18:29:20.575055+00
17	pbkdf2_sha256$320000$BEcmS2yFmgo56Fh9nkWcDU$ss/6PA6cchxGYJbgXBzSJHqbTYZbCs53SVZWALvV9No=	2022-08-01 22:59:14.770181+00	f	taytay	samuel5848@gmail.com	f	t	2022-08-01 22:59:09.508003+00
18	pbkdf2_sha256$320000$SPBPDQnXjNaz0KnPC6CATL$MkZAxQcVhnmerS2pJGkSj++AtExMIlhK7dZjD9eTxjo=	2022-08-02 15:03:10.321226+00	f	jorge	jorge@rial.com	f	t	2022-08-02 15:03:04.958575+00
10	pbkdf2_sha256$320000$kVYJT0dkx3P93dZOsFc1Ia$lOZ9d/CaUHI9VbhZwYqGmFbpg+FB6sswqTT2hlvsxaU=	2022-07-29 08:06:55.18169+00	f	giorgiomoroder	giorgio@moroder.com	f	t	2022-07-29 05:53:02.227106+00
4	pbkdf2_sha256$320000$tPnxIvia2Icg2DyEptkkK8$B2ju4byfeWWpgSaBhJc6I7E8Ol+nP9DruF/FaXLP0nY=	2022-07-27 21:50:52.190532+00	f	pepeargento	pepeargento@gmail.com	f	t	2022-07-27 21:50:44.850281+00
11	pbkdf2_sha256$320000$tMsUVSNz31gxsme922otg5$oouWxa0Eg8RMsdf4znrqjHVmnf6d9t7773SSzkVpQls=	2022-07-29 08:07:30.082857+00	f	britney	britney@spears.com	f	t	2022-07-29 08:07:22.207858+00
3	pbkdf2_sha256$320000$qMUH6J23flmSAezVX5myQ6$SnXWeIugzBgQglBaCsEMkwk71UZTLoQM5El+EhR7PN0=	2022-07-27 17:56:53.197348+00	f	pepe	samuel5848@gmail.com	f	t	2022-07-27 17:41:19+00
12	pbkdf2_sha256$320000$Oi8CZK5GXKDQccnSN6xrXy$ZKu/O+iw4rYUp5X269/jgaBd4m9Rz5h9gvxZbyINI6U=	2022-07-29 19:10:02.686563+00	f	djlint	djlint@django.com	f	t	2022-07-29 19:05:23.748755+00
13	pbkdf2_sha256$320000$G96qkhCgqxDqWUP8pTc4nt$ZnzvmaAVJS7vNOJ+u11WuvXpCq8/7dQd0Q0z5pJNqPY=	2022-07-29 20:15:54.39837+00	f	djlint2	samuel5848@gmail.com	f	t	2022-07-29 19:06:01.000476+00
9	pbkdf2_sha256$320000$4H2Rw0s3a1u8745niadZO0$urD8oi75teqz+5LFLCFTHpiQrpAPx0EsLhadFplv8sU=	2022-07-29 21:03:33.140826+00	f	boliviarodrigo	bolivia@rodrigo.com	f	t	2022-07-29 05:44:12.546734+00
1	pbkdf2_sha256$320000$4km0S3xU0o5KaKd5NPSJ1m$dpiZmaSZxXv2+T9mEND+uq970jMhDoQrFe5khxedvdQ=	2022-07-29 22:00:57.792585+00	t	admin	admin@admin.com	t	t	2022-07-20 05:43:39.14489+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
3	7	1
5	8	1
7	9	1
9	10	1
11	1	1
13	13	1
15	5	1
16	14	1
18	15	1
20	16	1
22	17	1
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-07-20 06:11:33.987687+00	1	Vivamus suscipit tortor eget felis porttitor volutpat.	1	[{"added": {}}]	10	1
2	2022-07-20 06:11:54.003012+00	2	Pellentesque in ipsum id orci porta dapibus.	1	[{"added": {}}]	10	1
3	2022-07-20 06:13:02.184656+00	3	Curabitur aliquet quam id dui posuere blandit.	1	[{"added": {}}]	10	1
4	2022-07-20 21:08:09.648053+00	1	Instalacion object (1)	1	[{"added": {}}]	14	1
5	2022-07-20 21:08:33.185379+00	2	Instalacion object (2)	1	[{"added": {}}]	14	1
6	2022-07-20 21:08:54.58271+00	3	Instalacion object (3)	1	[{"added": {}}]	14	1
7	2022-07-20 21:09:33.452907+00	4	Instalacion object (4)	1	[{"added": {}}]	14	1
8	2022-07-20 21:18:06.776086+00	2	Instalacion object (2)	2	[{"changed": {"fields": ["Nombre", "Descripcion"]}}]	14	1
9	2022-07-20 21:39:52.128004+00	1	Calendario object (1)	1	[{"added": {}}]	8	1
10	2022-07-20 21:40:10.392197+00	1	DetalleCalendario object (1)	1	[{"added": {}}]	13	1
11	2022-07-20 21:40:26.96855+00	2	DetalleCalendario object (2)	1	[{"added": {}}]	13	1
12	2022-07-20 21:40:48.297545+00	3	ocupada_cab	1	[{"added": {}}]	9	1
13	2022-07-20 21:40:51.927996+00	2	Calendario object (2)	1	[{"added": {}}]	8	1
14	2022-07-20 21:41:12.670823+00	3	DetalleCalendario object (3)	1	[{"added": {}}]	13	1
15	2022-07-20 21:41:26.352785+00	4	DetalleCalendario object (4)	1	[{"added": {}}]	13	1
16	2022-07-20 22:05:42.079985+00	1	Rango object (1)	1	[{"added": {}}]	15	1
17	2022-07-20 22:05:55.282689+00	2	Rango object (2)	1	[{"added": {}}]	15	1
18	2022-07-20 22:06:08.705114+00	3	Rango object (3)	1	[{"added": {}}]	15	1
19	2022-07-20 22:06:24.373541+00	4	Rango object (4)	1	[{"added": {}}]	15	1
20	2022-07-21 11:21:30.438781+00	4	Bla bla bla bla	1	[{"added": {}}]	10	1
21	2022-07-21 11:21:44.700506+00	5	Ble ble ble ble	1	[{"added": {}}]	10	1
22	2022-07-21 11:21:56.395218+00	6	Bli bli bli bli	1	[{"added": {}}]	10	1
23	2022-07-21 11:22:05.171335+00	7	Kkakakakaka	1	[{"added": {}}]	10	1
24	2022-07-21 11:22:16.129196+00	8	KOKOKO	1	[{"added": {}}]	10	1
25	2022-07-22 03:29:12.992014+00	4	2022-08-09->2022-08-11-None	3		12	1
26	2022-07-22 03:29:13.012011+00	3	2022-07-21->2022-07-23-None	3		12	1
27	2022-07-22 03:29:13.021013+00	2	2022-08-15->2022-08-17-None	3		12	1
28	2022-07-22 03:32:20.636261+00	3	Cabaña Principal	2	[{"changed": {"fields": ["Slug"]}}]	7	1
29	2022-07-22 03:34:09.17877+00	6	Cabañ Pepito	1	[{"added": {}}]	7	1
30	2022-07-22 03:34:15.002376+00	6	Cabañ Pepito	3		7	1
31	2022-07-22 03:35:48.321542+00	4	Cabaña Mediana	2	[{"changed": {"fields": ["Nombre", "CantHabitaciones", "Slug"]}}]	7	1
32	2022-07-22 03:36:04.264613+00	5	Cabaña Chica	2	[{"changed": {"fields": ["Nombre", "CantHabitaciones", "Slug"]}}]	7	1
33	2022-07-22 03:36:58.468219+00	3	Cabaña Principal	2	[{"changed": {"fields": ["CantHabitaciones"]}}]	7	1
34	2022-07-24 02:59:51.521505+00	5	2022-07-23=>2022-08-17	1	[{"added": {}}]	15	1
35	2022-07-24 08:57:57.709013+00	6	2022-09-09=>2022-09-29	1	[{"added": {}}]	15	1
36	2022-07-24 08:58:19.018226+00	7	2022-06-08=>2022-11-17	1	[{"added": {}}]	15	1
37	2022-07-24 08:59:11.398943+00	8	2022-09-15=>2022-10-12	1	[{"added": {}}]	15	1
38	2022-07-25 07:53:12.399604+00	3	Cabaña Principal	2	[{"changed": {"fields": ["CostoPorDia"]}}]	7	1
39	2022-07-25 08:44:25.549408+00	4	Cabaña Mediana	2	[{"changed": {"fields": ["CostoPorNoche"]}}]	7	1
40	2022-07-25 08:44:33.390122+00	5	Cabaña Chica	2	[{"changed": {"fields": ["CostoPorNoche"]}}]	7	1
41	2022-07-27 11:26:31.602274+00	9	2022-12-07=>2022-12-09	1	[{"added": {}}]	15	1
42	2022-07-27 11:26:47.004401+00	10	2022-12-12=>2022-12-15	1	[{"added": {}}]	15	1
43	2022-07-27 12:08:06.468498+00	2	boca	1	[{"added": {}}]	4	1
44	2022-07-27 12:08:15.737877+00	2	boca	2	[]	4	1
45	2022-07-27 17:41:20.074511+00	3	pepe	1	[{"added": {}}]	4	1
46	2022-07-27 17:41:26.55746+00	3	pepe	2	[{"changed": {"fields": ["Email address"]}}]	4	1
47	2022-07-28 00:12:55.571993+00	1	huesped	1	[{"added": {}}]	3	1
48	2022-07-28 00:15:44.088143+00	1	huesped	2	[{"changed": {"fields": ["Permissions"]}}]	3	1
49	2022-07-28 00:22:21.218236+00	6	usuario	3		4	1
50	2022-07-29 07:56:41.633784+00	91	2022-09-16->2022-09-17-Cabaña Chica	3		12	1
51	2022-07-29 07:56:57.825875+00	11	Admin, Admin	3		11	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	inquilinos	cab
8	inquilinos	calendario
9	inquilinos	estado
10	inquilinos	foto
11	inquilinos	huesped
12	inquilinos	reserva
13	inquilinos	detallecalendario
14	inquilinos	instalacion
15	inquilinos	rango
16	inquilinos	cambioestado
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-07-20 05:38:26.675755+00
2	auth	0001_initial	2022-07-20 05:38:27.472607+00
3	admin	0001_initial	2022-07-20 05:38:27.644458+00
4	admin	0002_logentry_remove_auto_add	2022-07-20 05:38:27.675718+00
5	admin	0003_logentry_add_action_flag_choices	2022-07-20 05:38:27.706985+00
6	contenttypes	0002_remove_content_type_name	2022-07-20 05:38:27.722643+00
7	auth	0002_alter_permission_name_max_length	2022-07-20 05:38:27.753842+00
8	auth	0003_alter_user_email_max_length	2022-07-20 05:38:27.769512+00
9	auth	0004_alter_user_username_opts	2022-07-20 05:38:27.785116+00
10	auth	0005_alter_user_last_login_null	2022-07-20 05:38:27.816379+00
11	auth	0006_require_contenttypes_0002	2022-07-20 05:38:27.816379+00
12	auth	0007_alter_validators_add_error_messages	2022-07-20 05:38:27.831968+00
13	auth	0008_alter_user_username_max_length	2022-07-20 05:38:27.894478+00
14	auth	0009_alter_user_last_name_max_length	2022-07-20 05:38:27.925719+00
15	auth	0010_alter_group_name_max_length	2022-07-20 05:38:27.956963+00
16	auth	0011_update_proxy_permissions	2022-07-20 05:38:27.972596+00
17	auth	0012_alter_user_first_name_max_length	2022-07-20 05:38:28.003843+00
18	inquilinos	0001_initial	2022-07-20 05:38:28.772189+00
19	sessions	0001_initial	2022-07-20 05:38:28.928387+00
20	inquilinos	0002_foto_cab	2022-07-20 06:10:18.183604+00
21	inquilinos	0003_instalacion	2022-07-20 21:06:13.521291+00
22	inquilinos	0004_remove_cab_estado_calendario_estado	2022-07-20 21:33:52.609764+00
23	inquilinos	0005_rango_remove_detallecalendario_calendario_and_more	2022-07-20 22:03:50.912495+00
24	inquilinos	0006_rango_estado	2022-07-20 22:05:10.737443+00
25	inquilinos	0007_remove_rango_estado	2022-07-21 02:37:07.812492+00
26	inquilinos	0008_remove_reserva_fechadesde_remove_reserva_fechahasta_and_more	2022-07-21 07:59:50.247708+00
27	inquilinos	0009_alter_reserva_cab_alter_reserva_huesped	2022-07-21 08:40:37.113299+00
28	inquilinos	0010_remove_reserva_fechadesdehasta_reserva_fechadesde_and_more	2022-07-21 09:55:53.875792+00
29	inquilinos	0011_alter_reserva_fechadesde_alter_reserva_fechahasta	2022-07-21 09:56:47.398609+00
30	inquilinos	0012_alter_reserva_cantadultos	2022-07-22 03:19:20.602621+00
31	inquilinos	0013_alter_cab_options_alter_huesped_options_and_more	2022-07-22 07:50:25.707584+00
32	inquilinos	0014_rename_fechhasta_rango_fechahasta	2022-07-24 00:59:11.495409+00
33	inquilinos	0015_reserva_cantmenores_alter_reserva_cantadultos	2022-07-24 06:13:13.639308+00
34	inquilinos	0016_cab_costopordia_cab_costopordia_currency_and_more	2022-07-25 07:52:16.207447+00
35	inquilinos	0017_rename_costopordia_cab_costopornoche_and_more	2022-07-25 07:57:22.052765+00
36	inquilinos	0018_alter_cab_options	2022-07-25 23:46:48.820144+00
37	inquilinos	0019_alter_cab_options	2022-07-25 23:51:35.587723+00
38	inquilinos	0020_reserva_preciofinal_reserva_preciofinal_currency	2022-07-26 01:48:43.275654+00
39	inquilinos	0021_remove_cab_costopornoche_currency_and_more	2022-07-26 04:32:36.72985+00
40	inquilinos	0022_reserva_fechareserva	2022-07-27 10:12:00.908234+00
41	inquilinos	0023_remove_reserva_huesped_delete_huesped	2022-07-27 14:31:44.267585+00
42	inquilinos	0024_huesped	2022-07-27 14:31:44.578924+00
43	inquilinos	0025_reserva_huesped	2022-07-27 14:32:21.395312+00
44	auth	0013_remove_user_first_name_remove_user_last_name	2022-07-27 16:44:52.406109+00
45	inquilinos	0026_remove_huesped_email	2022-07-27 16:46:51.598195+00
46	inquilinos	0027_alter_reserva_options	2022-07-28 00:15:32.15175+00
47	inquilinos	0028_alter_reserva_huesped	2022-07-29 04:42:43.306835+00
48	inquilinos	0029_alter_huesped_usuario_alter_reserva_huesped	2022-07-29 05:08:18.240741+00
49	inquilinos	0030_alter_huesped_usuario	2022-07-29 05:09:22.899243+00
50	inquilinos	0031_remove_reserva_estado_cambioestado	2022-07-29 07:19:12.476952+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
flfzu6zhv724ij54lnjz8woyx3sffdlb	.eJxVjMsOwiAQRf-FtSEdGHm4dN9vIMMAUjU0Ke3K-O_apAvd3nPOfYlA21rD1vMSpiQuAsTpd4vEj9x2kO7UbrPkua3LFOWuyIN2Oc4pP6-H-3dQqddvzQgYnfWsWSU0RltMcdCKHIKPdB6wIGrwvgBFCwbAsPHsigL0SrF4fwC-UTas:1oE2Uq:x2WkY4uuc88dp5XrUXhqd3yyw6f5_bWkDVnAEuIVu0Q	2022-08-03 05:43:44.300209+00
xnrfh6kn7nucscewb8lk19fe0wb9xccv	.eJxVjMsOwiAQRf-FtSEdGHm4dN9vIMMAUjU0Ke3K-O_apAvd3nPOfYlA21rD1vMSpiQuAsTpd4vEj9x2kO7UbrPkua3LFOWuyIN2Oc4pP6-H-3dQqddvzQgYnfWsWSU0RltMcdCKHIKPdB6wIGrwvgBFCwbAsPHsigL0SrF4fwC-UTas:1oEGoj:BOF7svHms-dX9NfFnsCnn7RnabrkS5M78tcQyAgmkpE	2022-08-03 21:01:13.308379+00
2dbf22lljvz1f6bf2ojg89iobx7gghms	.eJxVjMsOwiAQRf-FtSEdGHm4dN9vIMMAUjU0Ke3K-O_apAvd3nPOfYlA21rD1vMSpiQuAsTpd4vEj9x2kO7UbrPkua3LFOWuyIN2Oc4pP6-H-3dQqddvzQgYnfWsWSU0RltMcdCKHIKPdB6wIGrwvgBFCwbAsPHsigL0SrF4fwC-UTas:1oEQCQ:ZzGQxRxhpQQD7AEdnq0W3M1QOUJEyY2hc68wEMT_O-s	2022-08-04 07:02:18.108418+00
5npa5jhzexdi5keiwgcudb4qbh1j68fs	.eJxVjMsOwiAQRf-FtSEdGHm4dN9vIMMAUjU0Ke3K-O_apAvd3nPOfYlA21rD1vMSpiQuAsTpd4vEj9x2kO7UbrPkua3LFOWuyIN2Oc4pP6-H-3dQqddvzQgYnfWsWSU0RltMcdCKHIKPdB6wIGrwvgBFCwbAsPHsigL0SrF4fwC-UTas:1oERo3:Si9JUIvLhdqbyxKeUwSCRTN-DDAxzM114zS4xSWvNrI	2022-08-04 08:45:15.42138+00
i0vfp75fn1eiyjf6i8kjyuhsln48kqci	.eJxVjMsOwiAQRf-FtSEdGHm4dN9vIMMAUjU0Ke3K-O_apAvd3nPOfYlA21rD1vMSpiQuAsTpd4vEj9x2kO7UbrPkua3LFOWuyIN2Oc4pP6-H-3dQqddvzQgYnfWsWSU0RltMcdCKHIKPdB6wIGrwvgBFCwbAsPHsigL0SrF4fwC-UTas:1oGfAz:eIWyTE4BnHCIB9GkwCG5TgRKDpLFOgVPXwCkZzbp5cs	2022-08-10 11:26:05.693232+00
idqco8uzgr86smvdj7d3p1wzpv11c7n8	.eJxVjDkOwjAUBe_iGln5xktMSZ8zWH-xcQAlUpxUiLtDpBTQvpl5L5VwW2vaWl7SKOqinDr9boT8yNMO5I7TbdY8T-sykt4VfdCmh1ny83q4fwcVW_3W1IUi3vYiwZNBY6U_gwHwEEvxzjKDJaAYsBRgx13o2OVsYk8cswP1_gDkQzgD:1oHtOa:0lak6Ue1ydgExfzWDr71aIDwJt6LpYtVg7okBA9Quwg	2022-08-13 20:49:12.746069+00
taun212xoaz3093wfkmmz8unjbwiczye	.eJxVjEEOwiAQRe_C2hAYWkpcuvcMZJgZpGogKe3KeHdt0oVu_3vvv1TEbS1x67LEmdVZ2aBOv2NCekjdCd-x3pqmVtdlTnpX9EG7vjaW5-Vw_w4K9vKtHbhkUPLAAgCTpSAySLImG5ysRwchJMrOJGYP4i1i8DRa4pGcY1DvDxxaOKI:1oItQM:aFbXOckrZ6iwNYQPOmratW2hnI5g8uAw2WTk6NYRPzk	2022-08-16 15:03:10.330228+00
\.


--
-- Data for Name: inquilinos_cab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_cab (id, nombre, "cantHabitaciones", slug, "costoPorNoche") FROM stdin;
3	Cabaña Principal	4	cabana-principal	2500
4	Cabaña Mediana	3	cabana-mediana	2000
5	Cabaña Chica	1	cabana-chica	1500
\.


--
-- Data for Name: inquilinos_cambioestado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_cambioestado (id, "fechaFin", "fechaInicio", estado_id, reserva_id) FROM stdin;
42	2022-08-02	2022-08-02	4	126
43	\N	2022-08-02	7	126
\.


--
-- Data for Name: inquilinos_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_estado (id, nombre, ambito) FROM stdin;
1	disponible	cab
3	ocupada	cab
4	Pte Confirmacion	res
5	Rechazada	res
6	Confirmada	res
7	Cancelada	res
8	Finalizada	res
\.


--
-- Data for Name: inquilinos_foto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_foto (id, foto, descripcion, cab_id) FROM stdin;
1	cabs/charming-creekside-cabin-california-2.jpg	Vivamus suscipit tortor eget felis porttitor volutpat.	5
2	cabs/The-Wedge-Tiny-Cabin_1.jpg	Pellentesque in ipsum id orci porta dapibus.	4
3	cabs/cabaña.jpg	Curabitur aliquet quam id dui posuere blandit.	3
4	cabs/dc88c81d3a787c5fde05cf48bfc34d61.jpg	Bla bla bla bla	3
5	cabs/foto-2-15.jpg	Ble ble ble ble	3
6	cabs/9e40e825-291c-4e3d-8a74-b00fcbfe30f5.jpg	Bli bli bli bli	3
8	cabs/CTRGaafP5_720x0__1.webp	KOKOKO	3
\.


--
-- Data for Name: inquilinos_huesped; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_huesped (id, nombre, apellido, telefono, usuario_id) FROM stdin;
5	tomas	cruz	353698774	5
7	mama	mia	12345	7
8	saka	laka	356487556	8
9	Bolivia	Rodrigo	4567854223	9
10	Giorgio	Moroder	12378945	10
12	djlint	djformatter	12345	13
14	firminio	jr	5435342152522	14
15	lucky	lucky	123456789	15
16	santi	giordano	356465785	16
17	tay	tay	3534237553	17
\.


--
-- Data for Name: inquilinos_instalacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_instalacion (id, nombre, descripcion) FROM stdin;
1	cc	Cocina comedor
3	asador	Asador
4	cochsc	Cochera semicubierta
2	byab	Baño y ante baño
\.


--
-- Data for Name: inquilinos_instalacion_cab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_instalacion_cab (id, instalacion_id, cab_id) FROM stdin;
1	1	3
2	1	4
3	1	5
4	2	3
5	3	3
6	3	5
7	4	3
8	4	4
9	4	5
\.


--
-- Data for Name: inquilinos_rango; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_rango (id, "fechaDesde", "fechaHasta", cab_id) FROM stdin;
5	2022-07-23	2022-08-17	3
6	2022-09-09	2022-09-29	5
7	2022-06-08	2022-11-17	4
8	2022-09-15	2022-10-12	3
9	2022-12-07	2022-12-09	4
10	2022-12-12	2022-12-15	4
\.


--
-- Data for Name: inquilinos_reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_reserva (id, "cantAdultos", cab_id, "fechaDesde", "fechaHasta", "cantMenores", "precioFinal", "fechaReserva", huesped_id) FROM stdin;
126	1	4	2022-09-07	2022-09-30	4	46000	2022-08-02	17
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 65, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 23, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 18, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 51, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 16, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 50, true);


--
-- Name: inquilinos_cab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_cab_id_seq', 6, true);


--
-- Name: inquilinos_cambioestado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_cambioestado_id_seq', 43, true);


--
-- Name: inquilinos_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_estado_id_seq', 8, true);


--
-- Name: inquilinos_foto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_foto_id_seq', 8, true);


--
-- Name: inquilinos_huesped_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_huesped_id_seq', 17, true);


--
-- Name: inquilinos_instalacion_cab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_instalacion_cab_id_seq', 9, true);


--
-- Name: inquilinos_instalacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_instalacion_id_seq', 4, true);


--
-- Name: inquilinos_rango_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_rango_id_seq', 10, true);


--
-- Name: inquilinos_reserva_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_reserva_id_seq', 126, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: inquilinos_cab inquilinos_cab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_cab
    ADD CONSTRAINT inquilinos_cab_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_cab inquilinos_cab_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_cab
    ADD CONSTRAINT inquilinos_cab_slug_key UNIQUE (slug);


--
-- Name: inquilinos_cambioestado inquilinos_cambioestado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_cambioestado
    ADD CONSTRAINT inquilinos_cambioestado_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_estado inquilinos_estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_estado
    ADD CONSTRAINT inquilinos_estado_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_foto inquilinos_foto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_foto
    ADD CONSTRAINT inquilinos_foto_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_huesped inquilinos_huesped_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_huesped
    ADD CONSTRAINT inquilinos_huesped_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_huesped inquilinos_huesped_usuario_id_9f515a0a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_huesped
    ADD CONSTRAINT inquilinos_huesped_usuario_id_9f515a0a_uniq UNIQUE (usuario_id);


--
-- Name: inquilinos_instalacion_cab inquilinos_instalacion_cab_instalacion_id_cab_id_238f6e8c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_instalacion_cab
    ADD CONSTRAINT inquilinos_instalacion_cab_instalacion_id_cab_id_238f6e8c_uniq UNIQUE (instalacion_id, cab_id);


--
-- Name: inquilinos_instalacion_cab inquilinos_instalacion_cab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_instalacion_cab
    ADD CONSTRAINT inquilinos_instalacion_cab_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_instalacion inquilinos_instalacion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_instalacion
    ADD CONSTRAINT inquilinos_instalacion_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_rango inquilinos_rango_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_rango
    ADD CONSTRAINT inquilinos_rango_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_reserva inquilinos_reserva_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_reserva
    ADD CONSTRAINT inquilinos_reserva_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: inquilinos_cab_slug_6dccc3b8_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_cab_slug_6dccc3b8_like ON public.inquilinos_cab USING btree (slug varchar_pattern_ops);


--
-- Name: inquilinos_cambioestado_estado_id_e5c03c2a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_cambioestado_estado_id_e5c03c2a ON public.inquilinos_cambioestado USING btree (estado_id);


--
-- Name: inquilinos_cambioestado_reserva_id_9dcea929; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_cambioestado_reserva_id_9dcea929 ON public.inquilinos_cambioestado USING btree (reserva_id);


--
-- Name: inquilinos_foto_cab_id_ce7c3d44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_foto_cab_id_ce7c3d44 ON public.inquilinos_foto USING btree (cab_id);


--
-- Name: inquilinos_instalacion_cab_cab_id_a0f75913; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_instalacion_cab_cab_id_a0f75913 ON public.inquilinos_instalacion_cab USING btree (cab_id);


--
-- Name: inquilinos_instalacion_cab_instalacion_id_6ab2240b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_instalacion_cab_instalacion_id_6ab2240b ON public.inquilinos_instalacion_cab USING btree (instalacion_id);


--
-- Name: inquilinos_rango_cab_id_88ded58b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_rango_cab_id_88ded58b ON public.inquilinos_rango USING btree (cab_id);


--
-- Name: inquilinos_reserva_cab_id_6d18a96a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_reserva_cab_id_6d18a96a ON public.inquilinos_reserva USING btree (cab_id);


--
-- Name: inquilinos_reserva_huesped_id_7406da95; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_reserva_huesped_id_7406da95 ON public.inquilinos_reserva USING btree (huesped_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_cambioestado inquilinos_cambioest_estado_id_e5c03c2a_fk_inquilino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_cambioestado
    ADD CONSTRAINT inquilinos_cambioest_estado_id_e5c03c2a_fk_inquilino FOREIGN KEY (estado_id) REFERENCES public.inquilinos_estado(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_cambioestado inquilinos_cambioest_reserva_id_9dcea929_fk_inquilino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_cambioestado
    ADD CONSTRAINT inquilinos_cambioest_reserva_id_9dcea929_fk_inquilino FOREIGN KEY (reserva_id) REFERENCES public.inquilinos_reserva(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_foto inquilinos_foto_cab_id_ce7c3d44_fk_inquilinos_cab_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_foto
    ADD CONSTRAINT inquilinos_foto_cab_id_ce7c3d44_fk_inquilinos_cab_id FOREIGN KEY (cab_id) REFERENCES public.inquilinos_cab(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_huesped inquilinos_huesped_usuario_id_9f515a0a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_huesped
    ADD CONSTRAINT inquilinos_huesped_usuario_id_9f515a0a_fk_auth_user_id FOREIGN KEY (usuario_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_instalacion_cab inquilinos_instalaci_instalacion_id_6ab2240b_fk_inquilino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_instalacion_cab
    ADD CONSTRAINT inquilinos_instalaci_instalacion_id_6ab2240b_fk_inquilino FOREIGN KEY (instalacion_id) REFERENCES public.inquilinos_instalacion(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_instalacion_cab inquilinos_instalacion_cab_cab_id_a0f75913_fk_inquilinos_cab_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_instalacion_cab
    ADD CONSTRAINT inquilinos_instalacion_cab_cab_id_a0f75913_fk_inquilinos_cab_id FOREIGN KEY (cab_id) REFERENCES public.inquilinos_cab(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_rango inquilinos_rango_cab_id_88ded58b_fk_inquilinos_cab_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_rango
    ADD CONSTRAINT inquilinos_rango_cab_id_88ded58b_fk_inquilinos_cab_id FOREIGN KEY (cab_id) REFERENCES public.inquilinos_cab(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_reserva inquilinos_reserva_cab_id_6d18a96a_fk_inquilinos_cab_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_reserva
    ADD CONSTRAINT inquilinos_reserva_cab_id_6d18a96a_fk_inquilinos_cab_id FOREIGN KEY (cab_id) REFERENCES public.inquilinos_cab(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_reserva inquilinos_reserva_huesped_id_7406da95_fk_inquilinos_huesped_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_reserva
    ADD CONSTRAINT inquilinos_reserva_huesped_id_7406da95_fk_inquilinos_huesped_id FOREIGN KEY (huesped_id) REFERENCES public.inquilinos_huesped(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

