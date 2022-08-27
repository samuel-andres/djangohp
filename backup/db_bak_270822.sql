--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.5

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
    email character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    is_admin boolean NOT NULL,
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
    slug character varying(50) NOT NULL,
    descripcion text,
    "costoPorAdulto" double precision,
    "costoPorMenor" double precision,
    "cantMaxPersonas" integer
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
-- Name: inquilinos_comentario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_comentario (
    id bigint NOT NULL,
    comentario text NOT NULL,
    calificacion integer,
    "fechaPublicacion" date NOT NULL,
    huesped_id bigint,
    reserva_id bigint,
    cab_id bigint NOT NULL
);


ALTER TABLE public.inquilinos_comentario OWNER TO postgres;

--
-- Name: inquilinos_comentario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_comentario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_comentario_id_seq OWNER TO postgres;

--
-- Name: inquilinos_comentario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_comentario_id_seq OWNED BY public.inquilinos_comentario.id;


--
-- Name: inquilinos_estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_estado (
    id bigint NOT NULL,
    nombre character varying(200) NOT NULL
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
    nombre character varying(255) NOT NULL,
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
    "motivoCancelacion" text,
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
-- Name: inquilinos_servicio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_servicio (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    descripcion character varying(500) NOT NULL
);


ALTER TABLE public.inquilinos_servicio OWNER TO postgres;

--
-- Name: inquilinos_servicio_cab; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquilinos_servicio_cab (
    id bigint NOT NULL,
    servicio_id bigint NOT NULL,
    cab_id bigint NOT NULL
);


ALTER TABLE public.inquilinos_servicio_cab OWNER TO postgres;

--
-- Name: inquilinos_servicio_cab_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_servicio_cab_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_servicio_cab_id_seq OWNER TO postgres;

--
-- Name: inquilinos_servicio_cab_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_servicio_cab_id_seq OWNED BY public.inquilinos_servicio_cab.id;


--
-- Name: inquilinos_servicio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inquilinos_servicio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inquilinos_servicio_id_seq OWNER TO postgres;

--
-- Name: inquilinos_servicio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inquilinos_servicio_id_seq OWNED BY public.inquilinos_servicio.id;


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
-- Name: inquilinos_comentario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_comentario ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_comentario_id_seq'::regclass);


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
-- Name: inquilinos_servicio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_servicio ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_servicio_id_seq'::regclass);


--
-- Name: inquilinos_servicio_cab id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_servicio_cab ALTER COLUMN id SET DEFAULT nextval('public.inquilinos_servicio_cab_id_seq'::regclass);


--
-- Data for Name: accounts_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user (id, password, last_login, is_superuser, username, email, is_active, is_admin, is_staff) FROM stdin;
11	pbkdf2_sha256$320000$J2kgcOu5WgIKgiG61Zgth4$AvrMsD9xOqrVkjfpeQjelGwnHQAaAPeeHEeNs/hc9nQ=	2022-08-25 20:32:50.156248-03	f	mati	matiasarias384@gmail.com	t	f	f
2	pbkdf2_sha256$320000$2STfTq2Fqror5fOQrCtfxm$jx93J7POqWsekMySqdesR/hXQtoOwxJNCKurLj1hz9g=	2022-08-26 17:11:09.255039-03	f	taylor	taylor@mail.com	t	f	f
1	pbkdf2_sha256$320000$KfcNh5zSAdP3plRgzT04v6$kTGFG273idWbAku6+lFmz/ut15xM+99tAztdI2LiIBM=	2022-08-26 21:58:09.917482-03	t	admin	admin@example.com	t	t	t
12	pbkdf2_sha256$320000$pauiQ11zwGpO5RpcRjayNM$+2snZooPgUOXbIYiexha1u8rvkdXvr4LpPIcB9gwUko=	2022-08-27 00:13:34.631716-03	f	samucad3	samuel.andres@d3sistemas.com.ar	t	f	f
5	pbkdf2_sha256$320000$3Metc3oWptxyOKqySuGsN2$4Ir/33TWq+qhM6LLWJN2Kwwm6lR/LCS6Sdyzur2E4c0=	2022-08-24 09:25:43.632117-03	f	joaquin	joaquin@gmail.com	t	f	f
7	pbkdf2_sha256$320000$HxC8FyMu70U3QAI5ayVMF5$UfG3e6ulVFTV+WoYd1k6t0hQkeIpH3N+6xAmdqiVF4M=	2022-08-24 09:31:56.912357-03	f	eder	eder@gmail.com	t	f	f
8	pbkdf2_sha256$320000$rHW4guBG2rYr1TqgMmUULt$ORR3xGIOUkVyOfTcBo058iu6Y9FT+aE+tZEzOx6XQU4=	2022-08-24 09:33:49.490594-03	f	valeria	vale@gmail.com	t	f	f
9	pbkdf2_sha256$320000$02E2IJtiMAnuKaq8F6MOye$FkJJ71bW0EcCXJ3E1iFUBKIMddVw4/p9EeQYSKu7Cvk=	2022-08-24 09:35:53.354637-03	f	franca	franca@gmail.com	t	f	f
6	pbkdf2_sha256$320000$oiDkJAuEhahodkUQ1fD8xo$L9Tfv/0JeUaDdIj1ytsd0mCkvigQ8b/BwURFHSiCilQ=	2022-08-24 17:42:50.040097-03	f	samuca	samuel5848@gmail.com	t	f	f
10	pbkdf2_sha256$320000$Fyea0BRiana5Bb9bIZ9sZt$T/zKG1p0eLSsbZvr4RH66Z7Jd45bCsP4SnRltaDkGZw=	2022-08-25 17:30:18.284931-03	f	anibal	anibal@gmail.com	t	f	f
\.


--
-- Data for Name: accounts_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts_user_groups (id, user_id, group_id) FROM stdin;
1	2	1
11	5	1
13	6	1
15	7	1
17	8	1
19	9	1
21	10	1
23	11	1
25	12	1
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
50	Can add comentario	13	add_comentario
51	Can change comentario	13	change_comentario
52	Can delete comentario	13	delete_comentario
53	Can view comentario	13	view_comentario
54	Can add cambio estado	14	add_cambioestado
55	Can change cambio estado	14	change_cambioestado
56	Can delete cambio estado	14	delete_cambioestado
57	Can view cambio estado	14	view_cambioestado
58	Can add user	15	add_user
59	Can change user	15	change_user
60	Can delete user	15	delete_user
61	Can view user	15	view_user
62	Can add servicio	16	add_servicio
63	Can change servicio	16	change_servicio
64	Can delete servicio	16	delete_servicio
65	Can view servicio	16	view_servicio
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-08-23 11:10:53.690717-03	1	Cabaña Principal	1	[{"added": {}}, {"added": {"name": "foto", "object": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec in quam cursus, lobortis turpis id, scelerisque orci. Sed quis libero sem. Ut eu eros dolor."}}]	6	1
2	2022-08-23 11:11:24.128388-03	2	Cabaña Mediana	1	[{"added": {}}, {"added": {"name": "foto", "object": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec in quam cursus, lobortis turpis id, scelerisque orci. Sed quis libero sem. Ut eu eros dolor."}}]	6	1
3	2022-08-23 11:12:02.282435-03	3	Cabaña Chica	1	[{"added": {}}, {"added": {"name": "foto", "object": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec in quam cursus, lobortis turpis id, scelerisque orci. Sed quis libero sem. Ut eu eros dolor."}}]	6	1
4	2022-08-23 11:12:56.314601-03	3	Lorem ipsum dolor sit amet.	2	[{"changed": {"fields": ["Descripcion"]}}]	12	1
5	2022-08-23 11:13:02.908463-03	2	Lorem ipsum dolor sit amet.	2	[{"changed": {"fields": ["Descripcion"]}}]	12	1
6	2022-08-23 11:13:09.594396-03	1	Lorem ipsum dolor sit amet.	2	[{"changed": {"fields": ["Descripcion"]}}]	12	1
7	2022-08-23 11:13:40.571523-03	1	Cabaña Principal	2	[{"added": {"name": "foto", "object": "Lorem ipsum dolor sit amet."}}]	6	1
8	2022-08-23 11:13:51.298762-03	2	Cabaña Mediana	2	[{"added": {"name": "foto", "object": "Lorem ipsum dolor sit amet."}}]	6	1
9	2022-08-23 11:14:57.565006-03	1	Asador con parrilla	1	[{"added": {}}]	11	1
10	2022-08-23 11:15:14.924702-03	2	Cochera techada	1	[{"added": {}}]	11	1
11	2022-08-23 11:15:34.951243-03	3	Pileta grande	1	[{"added": {}}]	11	1
12	2022-08-23 11:19:55.614606-03	1	Pte Confirmacion	1	[{"added": {}}]	7	1
13	2022-08-23 11:20:01.584276-03	2	Rechazada	1	[{"added": {}}]	7	1
14	2022-08-23 11:20:08.904544-03	3	Confirmada	1	[{"added": {}}]	7	1
15	2022-08-23 11:20:16.544406-03	4	Cancelada	1	[{"added": {}}]	7	1
16	2022-08-23 11:20:24.534212-03	5	Finalizada	1	[{"added": {}}]	7	1
17	2022-08-23 11:24:02.2054-03	1	huesped	1	[{"added": {}}]	3	1
18	2022-08-23 11:24:22.874723-03	1	huesped	2	[{"changed": {"fields": ["Permissions"]}}]	3	1
19	2022-08-23 11:25:10.774346-03	1	2022-08-09=>2022-08-26	1	[{"added": {}}]	10	1
20	2022-08-23 11:25:21.814259-03	2	2022-08-28=>2022-09-15	1	[{"added": {}}]	10	1
21	2022-08-23 11:37:57.225148-03	1	Comentario object (1)	1	[{"added": {}}]	13	1
22	2022-08-23 11:54:32.14378-03	2	3/5	1	[{"added": {}}]	13	1
23	2022-08-23 11:54:38.815759-03	3	2/5	1	[{"added": {}}]	13	1
24	2022-08-23 11:54:47.443875-03	4	5/5	1	[{"added": {}}]	13	1
25	2022-08-23 11:54:53.994555-03	5	4/5	1	[{"added": {}}]	13	1
26	2022-08-23 15:15:04.815451-03	1	Hernandez, Javier	2	[{"changed": {"fields": ["Nombre", "Apellido"]}}]	8	1
27	2022-08-23 15:15:41.787636-03	6	5/5	1	[{"added": {}}]	13	1
28	2022-08-23 15:48:04.304474-03	3	2/5	2	[{"changed": {"fields": ["Comentario"]}}]	13	1
29	2022-08-23 15:48:22.609147-03	3	2/5	2	[{"changed": {"fields": ["Comentario"]}}]	13	1
30	2022-08-23 15:48:33.874114-03	3	2/5	2	[{"changed": {"fields": ["Comentario"]}}]	13	1
31	2022-08-23 15:48:46.26436-03	3	2/5	2	[{"changed": {"fields": ["Comentario"]}}]	13	1
32	2022-08-23 15:49:01.115089-03	3	2/5	2	[{"changed": {"fields": ["Comentario"]}}]	13	1
33	2022-08-23 17:50:31.143978-03	1	CambioEstado object (1)	2	[{"changed": {"fields": ["Estado"]}}]	14	1
34	2022-08-23 17:50:59.100947-03	3	CambioEstado object (3)	2	[{"changed": {"fields": ["Estado", "FechaFin"]}}]	14	1
35	2022-08-23 17:51:25.595339-03	3	CambioEstado object (3)	3		14	1
36	2022-08-23 17:51:25.597355-03	2	CambioEstado object (2)	3		14	1
37	2022-08-23 17:51:25.598338-03	1	CambioEstado object (1)	3		14	1
38	2022-08-23 17:54:03.43831-03	2	2022-08-23->2022-08-25-Cabaña Principal	3		9	1
39	2022-08-23 17:54:03.440325-03	1	2022-08-23->2022-08-25-Cabaña Principal	3		9	1
40	2022-08-23 17:54:48.814653-03	4	CambioEstado object (4)	2	[{"changed": {"fields": ["FechaFin"]}}]	14	1
41	2022-08-23 17:55:44.408063-03	5	CambioEstado object (5)	1	[{"added": {}}]	14	1
42	2022-08-23 18:05:47.418901-03	2	None/5	2	[{"changed": {"fields": ["Calificacion"]}}]	13	1
43	2022-08-23 18:06:17.420001-03	2	None/5	2	[{"changed": {"fields": ["Comentario"]}}]	13	1
44	2022-08-23 18:59:25.654837-03	11	4/5	3		13	1
45	2022-08-23 18:59:25.657875-03	10	4/5	3		13	1
46	2022-08-23 18:59:25.658837-03	9	3/5	3		13	1
47	2022-08-23 18:59:25.659836-03	8	4/5	3		13	1
48	2022-08-23 22:38:15.36185-03	12	1/5	3		13	1
49	2022-08-23 22:38:15.367489-03	6	5/5	3		13	1
50	2022-08-23 22:38:15.367489-03	5	4/5	3		13	1
51	2022-08-23 22:38:15.371587-03	4	5/5	3		13	1
52	2022-08-23 22:38:15.371587-03	3	2/5	3		13	1
53	2022-08-23 22:38:15.371587-03	2	None/5	3		13	1
54	2022-08-23 22:38:15.371587-03	1	4/5	3		13	1
55	2022-08-23 23:13:35.980939-03	13	3/5	1	[{"added": {}}]	13	1
56	2022-08-23 23:33:33.291632-03	13	3/5	3		13	1
57	2022-08-23 23:36:42.890338-03	14	4/5	3		13	1
58	2022-08-23 23:46:42.79022-03	6	CambioEstado object (6)	2	[{"changed": {"fields": ["FechaFin"]}}]	14	1
59	2022-08-23 23:47:06.094845-03	7	CambioEstado object (7)	1	[{"added": {}}]	14	1
60	2022-08-24 00:00:34.480343-03	15	5/5	3		13	1
61	2022-08-24 00:12:17.453745-03	9	CambioEstado object (9)	2	[{"changed": {"fields": ["FechaFin"]}}]	14	1
62	2022-08-24 00:12:32.900143-03	10	CambioEstado object (10)	1	[{"added": {}}]	14	1
63	2022-08-24 00:15:08.410129-03	6	2022-09-13->2022-09-14-Cabaña Principal	3		9	1
64	2022-08-24 00:15:08.431075-03	5	2022-09-02->2022-09-03-Cabaña Principal	3		9	1
65	2022-08-24 00:15:08.431075-03	4	2022-09-07->2022-09-09-Cabaña Principal	3		9	1
66	2022-08-24 00:15:08.431075-03	3	2022-09-07->2022-09-10-Cabaña Principal	3		9	1
67	2022-08-24 00:16:29.720342-03	13	CambioEstado object (13)	2	[{"changed": {"fields": ["FechaFin"]}}]	14	1
68	2022-08-24 00:16:51.689655-03	14	CambioEstado object (14)	1	[{"added": {}}]	14	1
69	2022-08-24 00:17:04.839911-03	14	CambioEstado object (14)	3		14	1
70	2022-08-24 00:17:10.759781-03	15	CambioEstado object (15)	1	[{"added": {}}]	14	1
71	2022-08-24 00:17:19.599903-03	15	CambioEstado object (15)	3		14	1
72	2022-08-24 00:17:24.599693-03	16	CambioEstado object (16)	1	[{"added": {}}]	14	1
73	2022-08-24 00:17:30.120276-03	16	CambioEstado object (16)	3		14	1
74	2022-08-24 00:17:34.74952-03	17	CambioEstado object (17)	1	[{"added": {}}]	14	1
75	2022-08-24 00:19:32.050364-03	18	CambioEstado object (18)	2	[{"changed": {"fields": ["FechaFin"]}}]	14	1
76	2022-08-24 00:19:43.55972-03	19	CambioEstado object (19)	1	[{"added": {}}]	14	1
77	2022-08-24 08:07:14.870812-03	3	2022-08-25=>2022-10-20	1	[{"added": {}}]	10	1
78	2022-08-24 08:19:26.633125-03	19	4/5	3		13	1
79	2022-08-24 08:19:26.635125-03	18	3/5	3		13	1
80	2022-08-24 09:24:36.178553-03	11	2022-08-24->2022-08-25-Cabaña Principal	3		9	1
81	2022-08-24 09:24:36.190761-03	10	2022-09-15->2022-09-18-Cabaña Mediana	3		9	1
82	2022-08-24 09:24:36.191791-03	9	2022-09-13->2022-09-15-Cabaña Principal	3		9	1
83	2022-08-24 09:24:36.191791-03	8	2022-09-06->2022-09-09-Cabaña Principal	3		9	1
84	2022-08-24 09:24:36.192785-03	7	2022-09-06->2022-09-09-Cabaña Principal	3		9	1
85	2022-08-24 09:25:04.090941-03	4	eminem	3		15	1
86	2022-08-24 09:25:04.092943-03	3	flauta	3		15	1
87	2022-08-24 09:36:23.885521-03	4	2022-08-24=>2022-09-29	1	[{"added": {}}]	10	1
88	2022-08-24 17:19:25.342701-03	1	Cabaña Principal	2	[{"changed": {"fields": ["Descripcion"]}}]	6	1
89	2022-08-24 17:19:34.588124-03	2	Cabaña Mediana	2	[{"changed": {"fields": ["Descripcion"]}}]	6	1
90	2022-08-24 17:19:43.477918-03	3	Cabaña Chica	2	[{"changed": {"fields": ["Descripcion"]}}]	6	1
91	2022-08-24 17:27:46.267886-03	1	Cabaña Principal	2	[{"changed": {"fields": ["Descripcion"]}}]	6	1
92	2022-08-24 17:28:21.127688-03	2	Cabaña Mediana	2	[{"changed": {"fields": ["Descripcion"]}}]	6	1
93	2022-08-24 17:28:59.197903-03	3	Cabaña Chica	2	[{"changed": {"fields": ["Descripcion"]}}]	6	1
94	2022-08-24 17:29:21.898166-03	1	Cabaña Principal	2	[{"changed": {"fields": ["Descripcion"]}}]	6	1
95	2022-08-24 18:05:40.924628-03	1	Cabaña Principal	2	[{"changed": {"fields": ["CostoPorAdulto", "CostoPorMenor"]}}]	6	1
96	2022-08-24 18:09:27.997002-03	1	Cabaña Principal	2	[{"added": {"name": "rango", "object": "2022-10-13=>2022-11-24"}}]	6	1
97	2022-08-24 18:51:51.929125-03	1	Cabaña Principal	2	[{"changed": {"fields": ["CostoPorAdulto", "CostoPorMenor"]}}]	6	1
98	2022-08-24 18:52:01.519484-03	2	Cabaña Mediana	2	[{"changed": {"fields": ["CostoPorAdulto", "CostoPorMenor"]}}]	6	1
99	2022-08-24 18:52:08.119547-03	3	Cabaña Chica	2	[{"changed": {"fields": ["CostoPorAdulto", "CostoPorMenor"]}}]	6	1
100	2022-08-25 00:35:29.525368-03	1	WiFi de alta velocidad	1	[{"added": {}}]	16	1
101	2022-08-25 00:35:44.135793-03	2	Servicio de limpieza	1	[{"added": {}}]	16	1
102	2022-08-25 00:40:07.150846-03	3	DirecTV con pack de películas	1	[{"added": {}}]	16	1
103	2022-08-25 12:32:40.166458-03	1	Cabaña Principal	2	[{"changed": {"fields": ["CantMaxPersonas"]}}]	6	1
104	2022-08-25 12:32:48.576326-03	2	Cabaña Mediana	2	[{"changed": {"fields": ["CantMaxPersonas"]}}]	6	1
105	2022-08-25 12:32:54.222261-03	2	Cabaña Mediana	2	[{"changed": {"fields": ["CantMaxPersonas"]}}]	6	1
106	2022-08-25 12:32:59.380732-03	3	Cabaña Chica	2	[{"changed": {"fields": ["CantMaxPersonas"]}}]	6	1
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
13	inquilinos	comentario
14	inquilinos	cambioestado
15	accounts	user
16	inquilinos	servicio
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-08-23 11:07:06.479571-03
2	contenttypes	0002_remove_content_type_name	2022-08-23 11:07:06.504407-03
3	auth	0001_initial	2022-08-23 11:07:06.624463-03
4	auth	0002_alter_permission_name_max_length	2022-08-23 11:07:06.634769-03
5	auth	0003_alter_user_email_max_length	2022-08-23 11:07:06.654729-03
6	auth	0004_alter_user_username_opts	2022-08-23 11:07:06.666691-03
7	auth	0005_alter_user_last_login_null	2022-08-23 11:07:06.682157-03
8	auth	0006_require_contenttypes_0002	2022-08-23 11:07:06.684762-03
9	auth	0007_alter_validators_add_error_messages	2022-08-23 11:07:06.698071-03
10	auth	0008_alter_user_username_max_length	2022-08-23 11:07:06.704751-03
11	auth	0009_alter_user_last_name_max_length	2022-08-23 11:07:06.714406-03
12	auth	0010_alter_group_name_max_length	2022-08-23 11:07:06.724322-03
13	auth	0011_update_proxy_permissions	2022-08-23 11:07:06.73492-03
14	auth	0012_alter_user_first_name_max_length	2022-08-23 11:07:06.744698-03
15	accounts	0001_initial	2022-08-23 11:07:06.833096-03
16	admin	0001_initial	2022-08-23 11:07:06.87211-03
17	admin	0002_logentry_remove_auto_add	2022-08-23 11:07:06.884718-03
18	admin	0003_logentry_add_action_flag_choices	2022-08-23 11:07:06.899427-03
19	inquilinos	0001_initial	2022-08-23 11:07:07.142543-03
20	sessions	0001_initial	2022-08-23 11:07:07.154349-03
21	inquilinos	0002_remove_estado_ambito	2022-08-23 11:19:08.635067-03
22	inquilinos	0003_cab_cal_prom	2022-08-23 11:57:07.163605-03
23	inquilinos	0004_remove_cab_cal_prom	2022-08-23 12:04:34.43399-03
24	inquilinos	0005_remove_comentario_cab_comentario_reserva_and_more	2022-08-23 22:40:03.772736-03
25	inquilinos	0006_comentario_cab	2022-08-24 08:21:48.514808-03
26	inquilinos	0007_cab_descripcion_alter_comentario_cab	2022-08-24 17:18:37.578237-03
27	inquilinos	0008_cab_costoporadulto_cab_costopormenor	2022-08-24 17:38:42.777491-03
28	inquilinos	0009_alter_cab_options_remove_cab_costopornoche_and_more	2022-08-25 00:33:06.589593-03
29	inquilinos	0010_cab_cantmaxpersonas	2022-08-25 12:29:42.909312-03
30	inquilinos	0011_reserva_motivocancelacion_alter_reserva_cantadultos_and_more	2022-08-26 09:35:56.214057-03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
by603rlznr1bgnrrpy6opqictvkbwlko	.eJxVjEEOwiAQRe_C2hDowJS6dO8ZyMBMpWpoUtqV8e7apAvd_vfef6lI21ri1mSJE6uz6tTpd0uUH1J3wHeqt1nnua7LlPSu6IM2fZ1ZnpfD_Tso1Mq3ltESgjgnAhm9BR_6DEYwMaXBMfghCAYJRCb31pFHg10aQdg5i6TeH-6SOAE:1oRXRO:-hiNl8J6JXP52uXt62ugbVTKbJkogxfu0w6iLbksLJU	2022-09-09 08:23:58.864689-03
3j399ngcyulzxp4fvtjwui5kghfph1go	.eJxVjEEOwiAQRe_C2hDowJS6dO8ZyMBMpWpoUtqV8e7apAvd_vfef6lI21ri1mSJE6uz6tTpd0uUH1J3wHeqt1nnua7LlPSu6IM2fZ1ZnpfD_Tso1Mq3ltESgjgnAhm9BR_6DEYwMaXBMfghCAYJRCb31pFHg10aQdg5i6TeH-6SOAE:1oRffZ:0G9YMvgPT32WbPwr0ipG2fI5p_tDRA6j1wmOnajbgts	2022-09-09 17:11:09.257028-03
9tmsawdglo9dbmfyazvft7alnj186d29	.eJxVjEEOwiAQAP_C2RBwWQGP3vsGssBWqgaS0p6MfzckPeh1ZjJvEWjfStg7r2HJ4iq0OP2ySOnJdYj8oHpvMrW6rUuUI5GH7XJqmV-3o_0bFOplbEGDR_SeUEF02SpmhovPEZOmGQkhcjaOHRhlZkfglVUJtTVn9IDi8wXJyzbq:1oRk9J:O6uyO_TmMfJYklSvORJvSC-69BVOw-oKO1GjnlmGrVQ	2022-09-09 21:58:09.920532-03
vhk0undj17b4v5gx8f6t94g3vonzobd8	.eJxVjDsOwjAQBe_iGln-xR9Kes5g7a5tHEC2FCcV4u4QKQW0b2bei0XY1hq3kZc4J3ZmUrHT74hAj9x2ku7Qbp1Tb-syI98VftDBrz3l5-Vw_w4qjPqtJ6NdTp5UEbkEpUwwwssEJkhUVoIF6YwLZFFDFnYi9OgkFaPBOgyCvT_y9zeh:1oRmGM:D2X0xM9w7MRrPjqgcLRKAtqK9pYMOw8KoXV7IhgaHwY	2022-09-10 00:13:34.633697-03
xzpailmktngetcp78vku4t14ckgg272s	.eJxVjEEOwiAQRe_C2hDowJS6dO8ZyMBMpWpoUtqV8e7apAvd_vfef6lI21ri1mSJE6uz6tTpd0uUH1J3wHeqt1nnua7LlPSu6IM2fZ1ZnpfD_Tso1Mq3ltESgjgnAhm9BR_6DEYwMaXBMfghCAYJRCb31pFHg10aQdg5i6TeH-6SOAE:1oQozk:eJkwAhT6gzuZqhzAcjXmnotwPCXB20n6cIgmblSpZMA	2022-09-07 08:56:28.263161-03
kbu520jeobnrsaz2dwmiymidgffvikv5	.eJxVjEEOwiAQRe_C2hDowJS6dO8ZyMBMpWpoUtqV8e7apAvd_vfef6lI21ri1mSJE6uz6tTpd0uUH1J3wHeqt1nnua7LlPSu6IM2fZ1ZnpfD_Tso1Mq3ltESgjgnAhm9BR_6DEYwMaXBMfghCAYJRCb31pFHg10aQdg5i6TeH-6SOAE:1oRCir:qZBwfdPUWK_ZYe8in_-ggUx60IEQ6JZAEyE9HDVW7G4	2022-09-08 10:16:37.712275-03
wclt6wu1ztk7m186ljopbosektx6xr2r	.eJxVjEEOwiAQRe_C2hDowJS6dO8ZyMBMpWpoUtqV8e7apAvd_vfef6lI21ri1mSJE6uz6tTpd0uUH1J3wHeqt1nnua7LlPSu6IM2fZ1ZnpfD_Tso1Mq3ltESgjgnAhm9BR_6DEYwMaXBMfghCAYJRCb31pFHg10aQdg5i6TeH-6SOAE:1oRIC9:wnY5wDFTn0AZfj6G0bsR3PLiPIM-yjwrru5wp_ICZsI	2022-09-08 16:07:13.644542-03
\.


--
-- Data for Name: inquilinos_cab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_cab (id, nombre, "cantHabitaciones", slug, descripcion, "costoPorAdulto", "costoPorMenor", "cantMaxPersonas") FROM stdin;
1	Cabaña Principal	4	cabana-principal	Ésta es nuestra cabaña mas ámplia y lujosa, cuenta con un gran patio e instalaciones de primer calidad.	1000	400	7
2	Cabaña Mediana	3	cabana-mediana	Cabaña orientada para aquellos que deseen tomarse unas vacaciones en las que poder descansar y estar al aire libre.	700	350	5
3	Cabaña Chica	1	cabana-chica	Nuestra cabaña más pequeña pero no por eso significa que no te sea conveniente, te esperamos!	400	200	2
\.


--
-- Data for Name: inquilinos_cambioestado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_cambioestado (id, "fechaFin", "fechaInicio", estado_id, reserva_id) FROM stdin;
53	2022-08-26	2022-08-25	1	30
73	\N	2022-08-26	4	30
74	2022-08-26	2022-08-26	1	37
75	\N	2022-08-26	4	37
76	2022-08-26	2022-08-26	1	38
77	2022-08-26	2022-08-26	4	38
79	\N	2022-08-26	3	38
78	2022-08-26	2022-08-26	1	39
80	\N	2022-08-26	4	39
81	2022-08-26	2022-08-26	1	40
82	\N	2022-08-26	4	40
83	2022-08-26	2022-08-26	1	41
84	\N	2022-08-26	4	41
85	2022-08-26	2022-08-26	1	42
86	\N	2022-08-26	5	42
87	2022-08-26	2022-08-26	1	43
88	\N	2022-08-26	5	43
89	\N	2022-08-26	1	44
90	\N	2022-08-26	1	45
91	\N	2022-08-26	1	46
92	\N	2022-08-26	1	47
93	2022-08-26	2022-08-26	1	48
94	\N	2022-08-26	4	48
23	\N	2022-08-24	1	12
24	2022-08-24	2022-08-24	1	13
25	\N	2022-08-24	4	13
27	2022-08-24	2022-08-24	1	15
28	\N	2022-08-24	3	15
26	2022-08-24	2022-08-24	1	14
29	\N	2022-08-24	3	14
31	2022-08-24	2022-08-24	1	17
32	\N	2022-08-24	3	17
30	2022-08-24	2022-08-24	1	16
33	\N	2022-08-24	3	16
34	2022-08-24	2022-08-24	1	18
36	\N	2022-08-24	3	18
35	2022-08-24	2022-08-24	1	19
37	\N	2022-08-24	3	19
38	2022-08-24	2022-08-24	1	20
39	\N	2022-08-24	3	20
40	2022-08-24	2022-08-24	1	21
41	\N	2022-08-24	3	21
42	2022-08-24	2022-08-24	1	22
44	\N	2022-08-24	3	22
43	2022-08-24	2022-08-24	1	23
45	\N	2022-08-24	3	23
46	2022-08-24	2022-08-24	1	24
47	\N	2022-08-24	5	24
48	\N	2022-08-24	1	25
49	\N	2022-08-24	1	26
56	2022-08-25	2022-08-25	1	33
57	2022-08-25	2022-08-25	3	33
58	2022-08-25	2022-08-25	2	33
59	2022-08-25	2022-08-25	5	33
60	\N	2022-08-25	3	33
61	2022-08-25	2022-08-25	1	34
62	\N	2022-08-25	4	34
63	2022-08-25	2022-08-25	1	35
64	\N	2022-08-25	5	35
65	2022-08-26	2022-08-26	1	36
66	\N	2022-08-26	3	36
55	2022-08-26	2022-08-25	1	32
67	\N	2022-08-26	4	32
52	2022-08-26	2022-08-25	1	29
54	2022-08-26	2022-08-25	1	31
69	\N	2022-08-26	4	31
51	2022-08-26	2022-08-25	1	28
70	\N	2022-08-26	4	28
50	2022-08-26	2022-08-25	1	27
71	\N	2022-08-26	4	27
68	2022-08-26	2022-08-26	4	29
72	\N	2022-08-26	4	29
95	2022-08-27	2022-08-27	1	49
97	\N	2022-08-27	4	49
96	2022-08-27	2022-08-27	1	50
98	2022-08-27	2022-08-27	3	50
99	\N	2022-08-27	5	50
100	\N	2022-08-27	1	51
\.


--
-- Data for Name: inquilinos_comentario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_comentario (id, comentario, calificacion, "fechaPublicacion", huesped_id, reserva_id, cab_id) FROM stdin;
35	Buenísima!	5	2022-08-26	1	42	3
36	Esto es un comentario ejemplo.	4	2022-08-26	1	43	3
37	La pase muy bien loko	4	2022-08-27	12	50	1
21	Muy buena la cabaña. La pasé muy bien.	4	2022-08-24	5	15	1
22	Muy contento con la atención!!!	3	2022-08-24	5	14	2
23	Gracias por la atención, hermosa cabaña.	5	2022-08-24	6	17	1
24	Un desastre todo	2	2022-08-24	6	16	1
25	Bastante bien.  Pero demoraron en confirmar la reserva.	3	2022-08-24	7	19	2
26	Muy buenaaaaaaaaaaaa	5	2022-08-24	7	18	1
27	Hermosa la cabaña y la atención.	5	2022-08-24	8	20	1
28	Podría ser mejor...	3	2022-08-24	8	21	2
29	Las mejores cabañas!!	5	2022-08-24	9	23	3
30	Muy buena la cabaña y la atención	4	2022-08-24	9	22	3
31	Muy buenas cabañas	4	2022-08-24	6	24	1
32	Muy buena	4	2022-08-25	11	35	3
33	Gran experiencia en la cabaña...	5	2022-08-26	1	38	3
34	asdasdsadadadads	3	2022-08-26	1	30	1
\.


--
-- Data for Name: inquilinos_estado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_estado (id, nombre) FROM stdin;
1	Pte Confirmacion
2	Rechazada
3	Confirmada
4	Cancelada
5	Finalizada
\.


--
-- Data for Name: inquilinos_foto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_foto (id, foto, descripcion, cab_id) FROM stdin;
3	cabs/image.jpg	Lorem ipsum dolor sit amet.	3
2	cabs/The-Wedge-Tiny-Cabin_1.jpg	Lorem ipsum dolor sit amet.	2
1	cabs/cabaña.jpg	Lorem ipsum dolor sit amet.	1
4	cabs/Modern-vacation-house-just3ds.com-1.jpg	Lorem ipsum dolor sit amet.	1
5	cabs/CTRGaafP5_720x0__1.webp	Lorem ipsum dolor sit amet.	2
\.


--
-- Data for Name: inquilinos_huesped; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_huesped (id, nombre, apellido, telefono, usuario_id) FROM stdin;
1	Taylor	Swift	455788965	2
5	Joaquin	Álvarez	3534687993	5
6	Samuel	Andrés	3534237553	6
7	Eder	Zoy	123456789	7
8	Valeria	Abdala	35346789	8
9	Franca	Pairetti	12346	9
10	Anibal	Álvarez	3538432775	10
11	Matias	Arias	123123213	11
12	Samuel	Andrés	3534237553	12
\.


--
-- Data for Name: inquilinos_instalacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_instalacion (id, nombre, descripcion) FROM stdin;
1	Asador	Asador con parrilla
2	Cochera	Cochera techada
3	Pileta	Pileta grande
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
1	2022-08-09	2022-08-26	1
2	2022-08-28	2022-09-15	1
3	2022-08-25	2022-10-20	2
4	2022-08-24	2022-09-29	3
5	2022-10-13	2022-11-24	1
\.


--
-- Data for Name: inquilinos_reserva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_reserva (id, "fechaDesde", "fechaHasta", "fechaReserva", "precioFinal", "cantAdultos", "cantMenores", cab_id, huesped_id, "motivoCancelacion") FROM stdin;
12	2022-09-07	2022-09-09	2022-08-24	5000	2	1	1	5	\N
13	2022-09-14	2022-09-17	2022-08-24	6000	1	0	2	5	\N
14	2022-09-22	2022-09-25	2022-08-24	6000	1	3	2	5	\N
15	2022-08-29	2022-08-31	2022-08-24	5000	1	0	1	5	\N
16	2022-09-14	2022-09-15	2022-08-24	2500	1	0	1	6	\N
17	2022-09-01	2022-09-04	2022-08-24	7500	1	0	1	6	\N
18	2022-09-05	2022-09-06	2022-08-24	2500	1	0	1	7	\N
19	2022-09-13	2022-09-17	2022-08-24	8000	1	0	2	7	\N
20	2022-08-24	2022-08-25	2022-08-24	2500	2	3	1	8	\N
21	2022-09-07	2022-09-09	2022-08-24	4000	3	0	2	8	\N
22	2022-09-15	2022-09-18	2022-08-24	4500	1	2	3	9	\N
23	2022-08-29	2022-08-31	2022-08-24	3000	1	0	3	9	\N
24	2022-09-10	2022-09-11	2022-08-24	2500	1	0	1	6	\N
25	2022-10-14	2022-10-22	2022-08-24	11200	2	2	1	6	\N
26	2022-11-09	2022-11-12	2022-08-24	3000	1	0	1	6	\N
32	2022-10-25	2022-10-31	2022-08-25	31200	4	3	1	1	\N
33	2022-11-03	2022-11-05	2022-08-25	10400	4	3	1	1	\N
34	2022-11-03	2022-11-06	2022-08-25	13800	3	4	1	10	\N
35	2022-09-06	2022-09-10	2022-08-25	3200	2	0	3	11	\N
36	2022-11-01	2022-11-06	2022-08-26	20000	2	5	1	1	Pésima experiencia en las cabañakas.
31	2022-10-03	2022-10-04	2022-08-25	2800	3	2	2	1	Cancelado kapo
28	2022-09-12	2022-09-13	2022-08-25	1000	1	0	1	1	Cancelada!
27	2022-09-27	2022-09-29	2022-08-25	4900	2	3	2	1	PAPER RINGS lalala
29	2022-09-10	2022-09-11	2022-08-25	1000	1	0	1	1	._.
30	2022-11-15	2022-11-17	2022-08-25	2000	1	0	1	1	CANCELADAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
37	2022-09-19	2022-09-21	2022-08-26	4900	2	3	2	1	
38	2022-09-21	2022-09-23	2022-08-26	1200	1	1	3	1	Nulla sed malesuada ligula. Maecenas eleifend sollicitudin ex, aliquet euismod mauris scelerisque vel. Sed commodo sit amet odio ac pharetra. Nunc pharetra finibus aliquet. Nulla quis euismod nunc. Nullam mollis nunc a erat interdum, et blandit felis lobortis. Nam luctus tincidunt tortor vel interdum.
39	2022-09-22	2022-09-24	2022-08-26	1200	1	1	3	1	No mw fuar LA ATENCION
40	2022-09-22	2022-09-24	2022-08-26	1200	1	1	3	1	I'm here on the kitchen floor\r\nYou call, but I won't hear it\r\nYou said no one else, how could you do this, babe?\r\nYou really blew this, babe\r\nWe ain't getting through this one, babe (yeah, yeah, yeah)\r\nThis is the last time I'll ever call you, babe\r\n(This is the last time, this is the last time)\r\nThis is the last time I'll ever call you, babe\r\n(What about your promises, promises, promises? No)\r\nWhat a waste\r\nTaking down the pictures and the plans we made, yeah\r\nAnd it's strange how your face doesn't look so innocent\r\nYour secret has its consequence and that's on you, babe
41	2022-09-26	2022-09-29	2022-08-26	6300	1	4	2	1	No hago a tiempo a ir
42	2022-09-21	2022-09-24	2022-08-26	1800	1	1	3	1	\N
43	2022-09-08	2022-09-10	2022-08-26	1200	1	1	3	1	\N
44	2022-09-07	2022-09-09	2022-08-26	1200	1	1	3	1	\N
45	2022-09-20	2022-09-23	2022-08-26	1800	1	1	3	1	\N
46	2022-09-13	2022-09-14	2022-08-26	600	1	1	3	1	\N
47	2022-09-12	2022-09-13	2022-08-26	3400	1	6	1	1	\N
48	2022-09-26	2022-09-28	2022-08-26	1600	2	0	3	1	Ejemplo de motivo cancelacion
50	2022-11-23	2022-11-24	2022-08-27	3800	3	2	1	12	\N
49	2022-11-15	2022-11-17	2022-08-27	7600	3	2	1	12	Ejemplo texto de motivo cancelacion.
51	2022-08-27	2022-08-28	2022-08-27	400	1	0	3	1	\N
\.


--
-- Data for Name: inquilinos_servicio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_servicio (id, nombre, descripcion) FROM stdin;
1	Internet	WiFi de alta velocidad
2	Limpieza	Servicio de limpieza
3	DirecTV	DirecTV con pack de películas
\.


--
-- Data for Name: inquilinos_servicio_cab; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inquilinos_servicio_cab (id, servicio_id, cab_id) FROM stdin;
1	1	1
2	1	2
3	2	1
4	2	2
5	2	3
6	3	3
\.


--
-- Name: accounts_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_groups_id_seq', 26, true);


--
-- Name: accounts_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_user_id_seq', 12, true);


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

SELECT pg_catalog.setval('public.auth_permission_id_seq', 65, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 106, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 16, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 30, true);


--
-- Name: inquilinos_cab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_cab_id_seq', 3, true);


--
-- Name: inquilinos_cambioestado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_cambioestado_id_seq', 100, true);


--
-- Name: inquilinos_comentario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_comentario_id_seq', 37, true);


--
-- Name: inquilinos_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_estado_id_seq', 5, true);


--
-- Name: inquilinos_foto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_foto_id_seq', 5, true);


--
-- Name: inquilinos_huesped_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_huesped_id_seq', 12, true);


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

SELECT pg_catalog.setval('public.inquilinos_rango_id_seq', 5, true);


--
-- Name: inquilinos_reserva_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_reserva_id_seq', 51, true);


--
-- Name: inquilinos_servicio_cab_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_servicio_cab_id_seq', 6, true);


--
-- Name: inquilinos_servicio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inquilinos_servicio_id_seq', 3, true);


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
-- Name: inquilinos_comentario inquilinos_comentario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_comentario
    ADD CONSTRAINT inquilinos_comentario_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_comentario inquilinos_comentario_reserva_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_comentario
    ADD CONSTRAINT inquilinos_comentario_reserva_id_key UNIQUE (reserva_id);


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
-- Name: inquilinos_servicio_cab inquilinos_servicio_cab_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_servicio_cab
    ADD CONSTRAINT inquilinos_servicio_cab_pkey PRIMARY KEY (id);


--
-- Name: inquilinos_servicio_cab inquilinos_servicio_cab_servicio_id_cab_id_d36069f8_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_servicio_cab
    ADD CONSTRAINT inquilinos_servicio_cab_servicio_id_cab_id_d36069f8_uniq UNIQUE (servicio_id, cab_id);


--
-- Name: inquilinos_servicio inquilinos_servicio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_servicio
    ADD CONSTRAINT inquilinos_servicio_pkey PRIMARY KEY (id);


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
-- Name: inquilinos_comentario_cab_id_3de34ac7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_comentario_cab_id_3de34ac7 ON public.inquilinos_comentario USING btree (cab_id);


--
-- Name: inquilinos_comentario_huesped_id_1a5a84db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_comentario_huesped_id_1a5a84db ON public.inquilinos_comentario USING btree (huesped_id);


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
-- Name: inquilinos_servicio_cab_cab_id_8437aa38; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_servicio_cab_cab_id_8437aa38 ON public.inquilinos_servicio_cab USING btree (cab_id);


--
-- Name: inquilinos_servicio_cab_servicio_id_92c07903; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX inquilinos_servicio_cab_servicio_id_92c07903 ON public.inquilinos_servicio_cab USING btree (servicio_id);


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
-- Name: inquilinos_comentario inquilinos_comentari_huesped_id_1a5a84db_fk_inquilino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_comentario
    ADD CONSTRAINT inquilinos_comentari_huesped_id_1a5a84db_fk_inquilino FOREIGN KEY (huesped_id) REFERENCES public.inquilinos_huesped(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_comentario inquilinos_comentari_reserva_id_3157bff1_fk_inquilino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_comentario
    ADD CONSTRAINT inquilinos_comentari_reserva_id_3157bff1_fk_inquilino FOREIGN KEY (reserva_id) REFERENCES public.inquilinos_reserva(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_comentario inquilinos_comentario_cab_id_3de34ac7_fk_inquilinos_cab_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_comentario
    ADD CONSTRAINT inquilinos_comentario_cab_id_3de34ac7_fk_inquilinos_cab_id FOREIGN KEY (cab_id) REFERENCES public.inquilinos_cab(id) DEFERRABLE INITIALLY DEFERRED;


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
-- Name: inquilinos_servicio_cab inquilinos_servicio__servicio_id_92c07903_fk_inquilino; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_servicio_cab
    ADD CONSTRAINT inquilinos_servicio__servicio_id_92c07903_fk_inquilino FOREIGN KEY (servicio_id) REFERENCES public.inquilinos_servicio(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: inquilinos_servicio_cab inquilinos_servicio_cab_cab_id_8437aa38_fk_inquilinos_cab_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquilinos_servicio_cab
    ADD CONSTRAINT inquilinos_servicio_cab_cab_id_8437aa38_fk_inquilinos_cab_id FOREIGN KEY (cab_id) REFERENCES public.inquilinos_cab(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

