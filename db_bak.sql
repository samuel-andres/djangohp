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
-- Name: accounts_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    is_admin boolean NOT NULL,
    email character varying(255) NOT NULL,
    is_staff boolean NOT NULL
);


ALTER TABLE public.accounts_user OWNER TO postgres;

--
-- Name: accounts_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_groups (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.accounts_user_groups OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_groups_id_seq OWNER TO postgres;

--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_groups_id_seq OWNED BY public.accounts_user_groups.id;


--
-- Name: accounts_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_id_seq OWNER TO postgres;

--
-- Name: accounts_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_id_seq OWNED BY public.accounts_user.id;


--
-- Name: accounts_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts_user_user_permissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.accounts_user_user_permissions OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_user_user_permissions_id_seq OWNED BY public.accounts_user_user_permissions.id;


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
    user_id bigint NOT NULL,
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
    "costoPorNoche" double precision,
    slug character varying(50) NOT NULL
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
    usuario_id bigint NOT NULL
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
    "fechaDesde" date NOT NULL,
    "fechaHasta" date NOT NULL,
    "fechaReserva" date NOT NULL,
    "precioFinal" double precision,
    "cantAdultos" smallint NOT NULL,
    "cantMenores" smallint,
    cab_id bigint,
    huesped_id bigint,
    CONSTRAINT "inquilinos_reserva_cantAdultos_check" CHECK (("cantAdultos" >= 0)),
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
-- Name: accounts_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_id_seq'::regclass);


--
-- Name: accounts_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_groups_id_seq'::regclass);


--
-- Name: accounts_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.accounts_user_user_permissions_id_seq'::regclass);


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
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, is_active, is_admin, email, is_staff) FROM stdin;
2	pbkdf2_sha256$320000$QCLAgEYAoCgyWgf65fy6IM$WIeA34N0T82dcGVc0/j74GzuN11bRd9qqEqDrL89DeA=	\N	f	admin	t	f	admin@example.com	f
3	pbkdf2_sha256$320000$IZ6ImyFPt3hUtYW9N3e9jR$gUjMPmr/a5XLb+0RuxYt/zgHURWOdM+/oo3rAbIjljI=	\N	f	admin2	t	f	admin2@example.com	f
4	pbkdf2_sha256$320000$UFybpzpQjWZr0Yw4HjVSUj$u1pPcTG8V5rL5KRAU6bKpTxNI5Spjou3S6fQfpfVRzk=	\N	f	admin3	t	f	admin3@example.com	f
1	pbkdf2_sha256$320000$yJwoItxVFZkW4DNyvAQ9jC$hf0fWL8jIGTFp8qsOGysAx+7gM3gy5GXNVnbOttgxDY=	2022-08-17 10:46:35.41858+00	f	taylor	t	f		f
5	pbkdf2_sha256$320000$IGPAtsETUUKMBKCAIYtCbV$1md76kfxAx101ifZwqJLmdoDnQRAiqFQeNLfJ5eBGBQ=	2022-08-17 11:29:35.638728+00	t	admin5	t	t	admin5@example.com	t
8	pbkdf2_sha256$320000$8HxLAZVhGC82tuNbOZhkWq$7CV7W33Rltc0Pj+Tapiu1saYImMxXbrtKwnGHbEamas=	2022-08-17 11:30:07.224539+00	f	usuario	t	f	usuario@mail.com	f
9	pbkdf2_sha256$320000$WyRRCcpz60ZkPJnf0rNFvf$+geNMlwVBJye+WnYCPzR1UEqprDBGm6hiFwM0zZW3+s=	2022-08-17 11:30:58.184093+00	f	unisoft	t	f	unisoft@mail.com	f
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
1	1	1
3	8	1
5	9	1
\.


--
-- Data for Name: accounts_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


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
1	1	37
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
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Cabaña	6	add_cab
22	Can change Cabaña	6	change_cab
23	Can delete Cabaña	6	delete_cab
24	Can view Cabaña	6	view_cab
25	Can add estado	7	add_estado
26	Can change estado	7	change_estado
27	Can delete estado	7	delete_estado
28	Can view estado	7	view_estado
29	Can add huesped	8	add_huesped
30	Can change huesped	8	change_huesped
31	Can delete huesped	8	delete_huesped
32	Can view huesped	8	view_huesped
33	Can add reserva	9	add_reserva
34	Can change reserva	9	change_reserva
35	Can delete reserva	9	delete_reserva
36	Can view reserva	9	view_reserva
37	Este usuario puede registrar una reserva.	9	puede_registrar_reserva
38	Can add rango	10	add_rango
39	Can change rango	10	change_rango
40	Can delete rango	10	delete_rango
41	Can view rango	10	view_rango
42	Can add instalacion	11	add_instalacion
43	Can change instalacion	11	change_instalacion
44	Can delete instalacion	11	delete_instalacion
45	Can view instalacion	11	view_instalacion
46	Can add foto	12	add_foto
47	Can change foto	12	change_foto
48	Can delete foto	12	delete_foto
49	Can view foto	12	view_foto
50	Can add cambio estado	13	add_cambioestado
51	Can change cambio estado	13	change_cambioestado
52	Can delete cambio estado	13	delete_cambioestado
53	Can view cambio estado	13	view_cambioestado
54	Can add user	14	add_user
55	Can change user	14	change_user
56	Can delete user	14	delete_user
57	Can view user	14	view_user
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-08-17 02:49:48.764469+00	1	huesped	1	[{"added": {}}]	3	5
2	2022-08-17 02:53:48.310048+00	1	Cabaña Principal	1	[{"added": {}}, {"added": {"name": "foto", "object": "Descripcion de la foto de la caba\\u00f1a"}}]	6	5
3	2022-08-17 02:54:02.949301+00	1	Asador para hacer asados	1	[{"added": {}}]	11	5
4	2022-08-17 02:54:24.844581+00	2	Cabaña Mediana	1	[{"added": {}}, {"added": {"name": "foto", "object": "Descripcion de la foto de la caba\\u00f1a"}}]	6	5
5	2022-08-17 02:54:45.149339+00	3	Cabaña Chica	1	[{"added": {}}, {"added": {"name": "foto", "object": "Descripcion de la foto de la caba\\u00f1a"}}]	6	5
6	2022-08-17 02:56:15.61827+00	1	Cabaña Principal	2	[{"added": {"name": "rango", "object": "2022-08-09=>2022-09-15"}}]	6	5
7	2022-08-17 02:57:20.597175+00	1	Cabaña Disponible	1	[{"added": {}}]	7	5
8	2022-08-17 02:57:27.51751+00	2	Cabaña Ocupada	1	[{"added": {}}]	7	5
9	2022-08-17 02:57:36.949133+00	3	Reserva Pte confirmacion	1	[{"added": {}}]	7	5
10	2022-08-17 02:57:45.597291+00	4	Reserva Rechazada	1	[{"added": {}}]	7	5
11	2022-08-17 02:57:53.259069+00	5	Reserva Confirmada	1	[{"added": {}}]	7	5
12	2022-08-17 02:58:00.447185+00	6	Reserva Cancelada	1	[{"added": {}}]	7	5
13	2022-08-17 02:58:06.686781+00	7	Reserva Finalizada	1	[{"added": {}}]	7	5
14	2022-08-17 10:40:51.886011+00	3	Cabaña Chica	2	[{"changed": {"name": "foto", "object": "Descripcion de la foto de la caba\\u00f1a", "fields": ["Foto"]}}]	6	5
15	2022-08-17 10:41:57.41464+00	1	Asador con parrilla	2	[{"changed": {"fields": ["Descripcion"]}}]	11	5
16	2022-08-17 10:42:14.538432+00	2	Cochera techada	1	[{"added": {}}]	11	5
17	2022-08-17 10:42:36.343138+00	3	Pileta	1	[{"added": {}}]	11	5
18	2022-08-17 10:45:04.008711+00	1	Cabaña Principal	2	[{"added": {"name": "foto", "object": "Descripcion de otra foto de la caba\\u00f1a"}}]	6	5
19	2022-08-17 10:45:38.409342+00	2	Cabaña Mediana	2	[{"added": {"name": "foto", "object": "Descripcion de otra foto etc etc"}}]	6	5
20	2022-08-17 10:45:53.545212+00	3	Cabaña Chica	2	[{"added": {"name": "foto", "object": "Descripcion de otra foto etc etc"}}]	6	5
21	2022-08-17 11:29:49.226819+00	1	huesped	2	[{"changed": {"fields": ["Permissions"]}}]	3	5
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	inquilinos	cab
7	inquilinos	estado
8	inquilinos	huesped
9	inquilinos	reserva
10	inquilinos	rango
11	inquilinos	instalacion
12	inquilinos	foto
13	inquilinos	cambioestado
14	accounts	user
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-08-17 02:16:22.274292+00
2	contenttypes	0002_remove_content_type_name	2022-08-17 02:16:22.304521+00
3	auth	0001_initial	2022-08-17 02:16:22.6445+00
4	auth	0002_alter_permission_name_max_length	2022-08-17 02:16:22.674573+00
5	auth	0003_alter_user_email_max_length	2022-08-17 02:16:22.704047+00
6	auth	0004_alter_user_username_opts	2022-08-17 02:16:22.724339+00
7	auth	0005_alter_user_last_login_null	2022-08-17 02:16:22.739399+00
8	auth	0006_require_contenttypes_0002	2022-08-17 02:16:22.744558+00
9	auth	0007_alter_validators_add_error_messages	2022-08-17 02:16:22.764256+00
10	auth	0008_alter_user_username_max_length	2022-08-17 02:16:22.78435+00
11	auth	0009_alter_user_last_name_max_length	2022-08-17 02:16:22.794388+00
12	auth	0010_alter_group_name_max_length	2022-08-17 02:16:22.814243+00
13	auth	0011_update_proxy_permissions	2022-08-17 02:16:22.832673+00
14	auth	0012_alter_user_first_name_max_length	2022-08-17 02:16:22.848418+00
15	auth	0013_remove_user_first_name_remove_user_last_name	2022-08-17 02:16:22.869494+00
16	accounts	0001_initial	2022-08-17 02:16:23.248689+00
17	admin	0001_initial	2022-08-17 02:16:23.400577+00
18	admin	0002_logentry_remove_auto_add	2022-08-17 02:16:23.416705+00
19	admin	0003_logentry_add_action_flag_choices	2022-08-17 02:16:23.432891+00
20	inquilinos	0001_initial	2022-08-17 02:16:24.185194+00
21	sessions	0001_initial	2022-08-17 02:16:24.355018+00
22	accounts	0002_user_email	2022-08-17 02:31:23.164715+00
23	accounts	0003_user_is_staff	2022-08-17 02:45:42.79516+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
aidu1uszvri244vwrptqfmg2pj2h6wqu	.eJxVjEEOwiAQRe_C2hAKpYBL956BzMCMVA0kpV0Z765NutDtf-_9l4iwrSVunZY4Z3EWVpx-N4T0oLqDfId6azK1ui4zyl2RB-3y2jI9L4f7d1Cgl2_tVR4YjAI9oE5kR2smQJgACLxBSkoheq2Ddc5xAg6BkBgzah5Zs3h_AAYOOW8:1oOHDH:YobEo3AO57eibjWNUUHpulmtS97xzfUElx8Ey8W6o9Y	2022-08-31 11:27:55.29583+00
0cjmc6aercefkewvyign6kd4h6e68y4f	.eJxVjMEOwiAQRP-FsyFAC7IevfsNhF0WqRqalPZk_Hdp0oNmTjNvZt4ixG0tYWu8hCmJiwBx-s0w0pPrDtIj1vssaa7rMqHcK_KgTd7mxK_r0f07KLGVvsZsWBkD5MmPA3gEIIXkNGrtfTfJKQKGaMecztlyosGDs1YBU5f4fAHqOjhj:1oOHGE:P_EXIDvkzm0IjL7ut2nXBS2nWswR-sSbucs5dA3nO5Q	2022-08-31 11:30:58.192826+00
\.


--
-- Data for Name: inquilinos_cab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_cab (id, nombre, "cantHabitaciones", "costoPorNoche", slug) FROM stdin;
1	Cabaña Principal	4	2500	cabana-principal
2	Cabaña Mediana	3	2000	cabana-mediana
3	Cabaña Chica	1	1500	cabana-chica
\.


--
-- Data for Name: inquilinos_cambioestado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_cambioestado (id, "fechaFin", "fechaInicio", estado_id, reserva_id) FROM stdin;
1	2022-08-17	2022-08-16	3	2
2	\N	2022-08-17	6	2
3	\N	2022-08-17	3	3
\.


--
-- Data for Name: inquilinos_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_estado (id, nombre, ambito) FROM stdin;
1	disponible	cab
2	ocupada	cab
3	Pte Confirmacion	res
4	Rechazada	res
5	Confirmada	res
6	Cancelada	res
7	Finalizada	res
\.


--
-- Data for Name: inquilinos_foto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_foto (id, foto, descripcion, cab_id) FROM stdin;
1	cabs/cabaña_J5Z4Lbb.jpg	Descripcion de la foto de la cabaña	1
2	cabs/charming-creekside-cabin-california-2_JIjC66y.jpg	Descripcion de la foto de la cabaña	2
3	cabs/The-Wedge-Tiny-Cabin_1_BDyNvpF.jpg	Descripcion de la foto de la cabaña	3
4	cabs/Modern-vacation-house-just3ds.com-1.jpg	Descripcion de otra foto de la cabaña	1
5	cabs/vacation-house-17.jpg	Descripcion de otra foto etc etc	2
6	cabs/image.jpg	Descripcion de otra foto etc etc	3
\.


--
-- Data for Name: inquilinos_huesped; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_huesped (id, nombre, apellido, telefono, usuario_id) FROM stdin;
1	Taylor	Swift	3534237553	1
2	Usuario	Prueba	123456	8
3	Unisoft	Grupo	3534261778	9
\.


--
-- Data for Name: inquilinos_instalacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_instalacion (id, nombre, descripcion) FROM stdin;
1	Asador	Asador con parrilla
2	Cochera	Cochera techada
3	Pileta	Pileta
\.


--
-- Data for Name: inquilinos_instalacion_cab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_instalacion_cab (id, instalacion_id, cab_id) FROM stdin;
1	1	1
2	2	1
3	2	2
4	3	1
5	3	2
\.


--
-- Data for Name: inquilinos_rango; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_rango (id, "fechaDesde", "fechaHasta", cab_id) FROM stdin;
1	2022-08-09	2022-09-15	1
\.


--
-- Data for Name: inquilinos_reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_reserva (id, "fechaDesde", "fechaHasta", "fechaReserva", "precioFinal", "cantAdultos", "cantMenores", cab_id, huesped_id) FROM stdin;
1	2022-08-16	2022-08-18	2022-08-16	5000	3	1	1	1
2	2022-08-26	2022-08-28	2022-08-16	5000	2	2	1	1
3	2022-09-08	2022-09-09	2022-08-17	2500	1	0	1	3
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 6, true);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 9, true);


--
-- Name: accounts_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_user_permissions_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.auth_permission_id_seq', 57, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 21, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);


--
-- Name: inquilinos_cab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_cab_id_seq', 3, true);


--
-- Name: inquilinos_cambioestado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_cambioestado_id_seq', 3, true);


--
-- Name: inquilinos_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_estado_id_seq', 7, true);


--
-- Name: inquilinos_foto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_foto_id_seq', 6, true);


--
-- Name: inquilinos_huesped_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_huesped_id_seq', 3, true);


--
-- Name: inquilinos_instalacion_cab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_instalacion_cab_id_seq', 5, true);


--
-- Name: inquilinos_instalacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_instalacion_id_seq', 3, true);


--
-- Name: inquilinos_rango_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_rango_id_seq', 1, true);


--
-- Name: inquilinos_reserva_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_reserva_id_seq', 3, true);


--
-- Name: accounts_user accounts_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_email_key UNIQUE (email);


--
-- Name: accounts_user_groups accounts_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_groups accounts_user_groups_user_id_group_id_59c0b32f_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_group_id_59c0b32f_uniq UNIQUE (user_id, group_id);


--
-- Name: accounts_user accounts_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_pkey PRIMARY KEY (id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq UNIQUE (user_id, permission_id);


--
-- Name: accounts_user_user_permissions accounts_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: accounts_user accounts_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user
    ADD CONSTRAINT accounts_user_username_key UNIQUE (username);


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
-- Name: inquilinos_huesped inquilinos_huesped_usuario_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_huesped
    ADD CONSTRAINT inquilinos_huesped_usuario_id_key UNIQUE (usuario_id);


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
-- Name: accounts_user_email_b2644a56_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_email_b2644a56_like ON public.accounts_user USING btree (email varchar_pattern_ops);


--
-- Name: accounts_user_groups_group_id_bd11a704; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_group_id_bd11a704 ON public.accounts_user_groups USING btree (group_id);


--
-- Name: accounts_user_groups_user_id_52b62117; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_groups_user_id_52b62117 ON public.accounts_user_groups USING btree (user_id);


--
-- Name: accounts_user_user_permissions_permission_id_113bb443; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_permission_id_113bb443 ON public.accounts_user_user_permissions USING btree (permission_id);


--
-- Name: accounts_user_user_permissions_user_id_e4f0a161; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_user_permissions_user_id_e4f0a161 ON public.accounts_user_user_permissions USING btree (user_id);


--
-- Name: accounts_user_username_6088629e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX accounts_user_username_6088629e_like ON public.accounts_user USING btree (username varchar_pattern_ops);


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
-- Name: accounts_user_groups accounts_user_groups_group_id_bd11a704_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_group_id_bd11a704_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_groups accounts_user_groups_user_id_52b62117_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_groups
    ADD CONSTRAINT accounts_user_groups_user_id_52b62117_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_permission_id_113bb443_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_permission_id_113bb443_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: accounts_user_user_permissions accounts_user_user_p_user_id_e4f0a161_fk_accounts_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts_user_user_permissions
    ADD CONSTRAINT accounts_user_user_p_user_id_e4f0a161_fk_accounts_ FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_accounts_user_id FOREIGN KEY (user_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: inquilinos_huesped inquilinos_huesped_usuario_id_9f515a0a_fk_accounts_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_huesped
    ADD CONSTRAINT inquilinos_huesped_usuario_id_9f515a0a_fk_accounts_user_id FOREIGN KEY (usuario_id) REFERENCES public.accounts_user(id) DEFERRABLE INITIALLY DEFERRED;


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

