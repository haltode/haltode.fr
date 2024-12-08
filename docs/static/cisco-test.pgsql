--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Debian 11.5-3.pgdg100+1)
-- Dumped by pg_dump version 11.5 (Debian 11.5-3.pgdg100+1)

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

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO haltode;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO haltode;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO haltode;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO haltode;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO haltode;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO haltode;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO haltode;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO haltode;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO haltode;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO haltode;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO haltode;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO haltode;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: dj_like; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.dj_like (
    id integer NOT NULL,
    song_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.dj_like OWNER TO haltode;

--
-- Name: dj_like_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.dj_like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dj_like_id_seq OWNER TO haltode;

--
-- Name: dj_like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.dj_like_id_seq OWNED BY public.dj_like.id;


--
-- Name: dj_song; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.dj_song (
    id integer NOT NULL,
    title character varying(256) NOT NULL,
    author character varying(256) NOT NULL,
    duration interval NOT NULL,
    is_playing boolean NOT NULL,
    start_time timestamp with time zone,
    yt_id character varying(11) NOT NULL,
    suggester_id integer NOT NULL
);


ALTER TABLE public.dj_song OWNER TO haltode;

--
-- Name: dj_song_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.dj_song_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dj_song_id_seq OWNER TO haltode;

--
-- Name: dj_song_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.dj_song_id_seq OWNED BY public.dj_song.id;


--
-- Name: dj_vote; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.dj_vote (
    id integer NOT NULL,
    song_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.dj_vote OWNER TO haltode;

--
-- Name: dj_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.dj_vote_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dj_vote_id_seq OWNER TO haltode;

--
-- Name: dj_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.dj_vote_id_seq OWNED BY public.dj_vote.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: haltode
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


ALTER TABLE public.django_admin_log OWNER TO haltode;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO haltode;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO haltode;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO haltode;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO haltode;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO haltode;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO haltode;

--
-- Name: social_auth_association; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.social_auth_association (
    id integer NOT NULL,
    server_url character varying(255) NOT NULL,
    handle character varying(255) NOT NULL,
    secret character varying(255) NOT NULL,
    issued integer NOT NULL,
    lifetime integer NOT NULL,
    assoc_type character varying(64) NOT NULL
);


ALTER TABLE public.social_auth_association OWNER TO haltode;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.social_auth_association_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_association_id_seq OWNER TO haltode;

--
-- Name: social_auth_association_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.social_auth_association_id_seq OWNED BY public.social_auth_association.id;


--
-- Name: social_auth_code; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.social_auth_code (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    code character varying(32) NOT NULL,
    verified boolean NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE public.social_auth_code OWNER TO haltode;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.social_auth_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_code_id_seq OWNER TO haltode;

--
-- Name: social_auth_code_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.social_auth_code_id_seq OWNED BY public.social_auth_code.id;


--
-- Name: social_auth_nonce; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.social_auth_nonce (
    id integer NOT NULL,
    server_url character varying(255) NOT NULL,
    "timestamp" integer NOT NULL,
    salt character varying(65) NOT NULL
);


ALTER TABLE public.social_auth_nonce OWNER TO haltode;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.social_auth_nonce_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_nonce_id_seq OWNER TO haltode;

--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.social_auth_nonce_id_seq OWNED BY public.social_auth_nonce.id;


--
-- Name: social_auth_partial; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.social_auth_partial (
    id integer NOT NULL,
    token character varying(32) NOT NULL,
    next_step smallint NOT NULL,
    backend character varying(32) NOT NULL,
    data jsonb NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    CONSTRAINT social_auth_partial_next_step_check CHECK ((next_step >= 0))
);


ALTER TABLE public.social_auth_partial OWNER TO haltode;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.social_auth_partial_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_partial_id_seq OWNER TO haltode;

--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.social_auth_partial_id_seq OWNED BY public.social_auth_partial.id;


--
-- Name: social_auth_usersocialauth; Type: TABLE; Schema: public; Owner: haltode
--

CREATE TABLE public.social_auth_usersocialauth (
    id integer NOT NULL,
    provider character varying(32) NOT NULL,
    uid character varying(255) NOT NULL,
    extra_data jsonb NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.social_auth_usersocialauth OWNER TO haltode;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE; Schema: public; Owner: haltode
--

CREATE SEQUENCE public.social_auth_usersocialauth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.social_auth_usersocialauth_id_seq OWNER TO haltode;

--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: haltode
--

ALTER SEQUENCE public.social_auth_usersocialauth_id_seq OWNED BY public.social_auth_usersocialauth.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: dj_like id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_like ALTER COLUMN id SET DEFAULT nextval('public.dj_like_id_seq'::regclass);


--
-- Name: dj_song id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_song ALTER COLUMN id SET DEFAULT nextval('public.dj_song_id_seq'::regclass);


--
-- Name: dj_vote id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_vote ALTER COLUMN id SET DEFAULT nextval('public.dj_vote_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: social_auth_association id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_association ALTER COLUMN id SET DEFAULT nextval('public.social_auth_association_id_seq'::regclass);


--
-- Name: social_auth_code id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_code ALTER COLUMN id SET DEFAULT nextval('public.social_auth_code_id_seq'::regclass);


--
-- Name: social_auth_nonce id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_nonce ALTER COLUMN id SET DEFAULT nextval('public.social_auth_nonce_id_seq'::regclass);


--
-- Name: social_auth_partial id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_partial ALTER COLUMN id SET DEFAULT nextval('public.social_auth_partial_id_seq'::regclass);


--
-- Name: social_auth_usersocialauth id; Type: DEFAULT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_usersocialauth ALTER COLUMN id SET DEFAULT nextval('public.social_auth_usersocialauth_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add song	1	add_song
2	Can change song	1	change_song
3	Can delete song	1	delete_song
4	Can view song	1	view_song
5	Can add vote	2	add_vote
6	Can change vote	2	change_vote
7	Can delete vote	2	delete_vote
8	Can view vote	2	view_vote
9	Can add like	3	add_like
10	Can change like	3	change_like
11	Can delete like	3	delete_like
12	Can view like	3	view_like
13	Can add log entry	4	add_logentry
14	Can change log entry	4	change_logentry
15	Can delete log entry	4	delete_logentry
16	Can view log entry	4	view_logentry
17	Can add permission	5	add_permission
18	Can change permission	5	change_permission
19	Can delete permission	5	delete_permission
20	Can view permission	5	view_permission
21	Can add group	6	add_group
22	Can change group	6	change_group
23	Can delete group	6	delete_group
24	Can view group	6	view_group
25	Can add user	7	add_user
26	Can change user	7	change_user
27	Can delete user	7	delete_user
28	Can view user	7	view_user
29	Can add content type	8	add_contenttype
30	Can change content type	8	change_contenttype
31	Can delete content type	8	delete_contenttype
32	Can view content type	8	view_contenttype
33	Can add session	9	add_session
34	Can change session	9	change_session
35	Can delete session	9	delete_session
36	Can view session	9	view_session
37	Can add association	10	add_association
38	Can change association	10	change_association
39	Can delete association	10	delete_association
40	Can view association	10	view_association
41	Can add code	11	add_code
42	Can change code	11	change_code
43	Can delete code	11	delete_code
44	Can view code	11	view_code
45	Can add nonce	12	add_nonce
46	Can change nonce	12	change_nonce
47	Can delete nonce	12	delete_nonce
48	Can view nonce	12	view_nonce
49	Can add user social auth	13	add_usersocialauth
50	Can change user social auth	13	change_usersocialauth
51	Can delete user social auth	13	delete_usersocialauth
52	Can view user social auth	13	view_usersocialauth
53	Can add partial	14	add_partial
54	Can change partial	14	change_partial
55	Can delete partial	14	delete_partial
56	Can view partial	14	view_partial
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$150000$bBPF7a8t40cI$IGxKXp622XY/4GZUeoJWfsShdGwvMUZJasm6vTPg2ck=	2019-11-28 23:18:59.875353+01	t	admin				t	t	2019-11-28 23:18:44.555246+01
5	pbkdf2_sha256$150000$u5w31NFFufkz$fPKzFvNFJS9KKI4QzI4KqgiQ4PhryaWBB01mgs8Ud5o=	\N	f	ing1-1				f	t	2019-11-28 23:21:09.940918+01
6	pbkdf2_sha256$150000$xv8zlBXZngXQ$qbq0h3VCGGHWwhfzfWFNDQd0zOZNi6H53X3llN05dBo=	\N	f	ing1-2				f	t	2019-11-28 23:24:28.045417+01
3	pbkdf2_sha256$150000$qK0ex8IruuGt$G9sttmLvisRA+yYHGXZAmT4bB4rFvAlzCrHhm8ajskc=	\N	f	acu1				t	t	2019-11-28 23:20:20+01
4	pbkdf2_sha256$150000$FTZnehHexE6Q$qcT+MB8Ig9g0l7ZAko0aV+st3WUyfkgZ9LQKYa4utng=	\N	f	acu2				t	t	2019-11-28 23:20:37+01
7	pbkdf2_sha256$150000$NoCL9r2zn0JG$SO21wXEr4EJj1auoKCL11abypv19aAkPsJSlhSWdRy8=	\N	f	ing1-3				f	t	2019-11-28 23:25:08.760717+01
1	pbkdf2_sha256$150000$ucCLKdLNnD2j$3NpkcAIUNUHRvIzzM6F9VcnnJRkOsbgkNB88I+yuvCM=	2019-11-28 23:30:03.417104+01	t	haltode				t	t	2019-11-28 23:18:30.285973+01
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: dj_like; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.dj_like (id, song_id, user_id) FROM stdin;
1	9	1
2	5	1
3	6	1
4	5	3
5	10	5
6	6	3
7	13	7
\.


--
-- Data for Name: dj_song; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.dj_song (id, title, author, duration, is_playing, start_time, yt_id, suggester_id) FROM stdin;
1	Code Lyoko Opening (French)	Multi-languages songs	00:03:28	f	\N	GOADRla8JJA	1
2	Code Lyoko Opening (English)	Multi-languages songs	00:03:26	f	\N	EGDUSlsDS9Q	1
3	Code Lyoko Opening (Serbian)	Multi-languages songs	00:03:44	f	\N	r1P1wvmhj74	1
4	Code Lyoko Opening (Hebrew)	Multi-languages songs	00:03:37	f	\N	JhKGHEDEcR0	1
5	Code Lyoko Opening (Greek)	Multi-languages songs	00:03:27	f	\N	rqE0ca15i7E	1
6	Code Lyoko Opening (Catalán)	Multi-languages songs	00:03:37	f	\N	VxlQAk5k6nE	1
7	Code Lyoko Opening (Portuguese)	Multi-languages songs	00:03:27	f	\N	ijW1l_ITuCs	1
13	Code Lyoko Opening (Polish)	Multi-languages songs	00:03:38	f	\N	GK8dzESUJ_8	5
12	Code Lyoko Opening (Latin-Spanish)	Multi-languages songs	00:03:08	f	\N	6AvX5olqvGE	5
11	Code Lyoko Opening (Spanish)	Multi-languages songs	00:03:26	f	\N	wF0b3ftNQjo	3
10	Code Lyoko Opening (Brazilian Portuguese)	Multi-languages songs	00:03:33	f	\N	QWdlWZYgYFk	3
9	Code Lyoko Opening (Hungarian)	Multi-languages songs	00:03:46	f	\N	4tt5Da4NtpE	7
8	Code Lyoko Opening (Japanese)	Multi-languages songs	00:03:38	f	\N	i96uu53no3A	2
\.


--
-- Data for Name: dj_vote; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.dj_vote (id, song_id, user_id) FROM stdin;
1	1	1
2	4	1
3	13	1
4	10	1
5	7	3
6	4	3
7	4	4
8	4	2
9	4	6
10	7	7
11	9	2
12	8	1
13	8	3
14	8	4
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-11-28 23:20:21.098896+01	3	acu1	1	[{"added": {}}]	7	2
2	2019-11-28 23:20:37.983196+01	4	acu2	1	[{"added": {}}]	7	2
3	2019-11-28 23:21:10.13811+01	5	ing1-1	1	[{"added": {}}]	7	2
4	2019-11-28 23:21:54.485055+01	5	ing1-1	2	[{"changed": {"fields": ["password"]}}]	7	2
5	2019-11-28 23:22:26.610914+01	3	acu1	2	[{"changed": {"fields": ["password"]}}]	7	2
6	2019-11-28 23:22:37.700398+01	4	acu2	2	[{"changed": {"fields": ["password"]}}]	7	2
7	2019-11-28 23:24:28.238418+01	6	ing1-2	1	[{"added": {}}]	7	2
8	2019-11-28 23:24:44.358922+01	3	acu1	2	[{"changed": {"fields": ["is_staff"]}}]	7	2
9	2019-11-28 23:24:50.63507+01	4	acu2	2	[{"changed": {"fields": ["is_staff"]}}]	7	2
10	2019-11-28 23:25:08.908301+01	7	ing1-3	1	[{"added": {}}]	7	2
11	2019-11-28 23:30:23.759002+01	13	Code Lyoko Opening (Polish) - Multi-languages songs (0:03:38s)	2	[{"changed": {"fields": ["suggester"]}}]	1	1
12	2019-11-28 23:30:28.9466+01	12	Code Lyoko Opening (Latin-Spanish) - Multi-languages songs (0:03:08s)	2	[{"changed": {"fields": ["suggester"]}}]	1	1
13	2019-11-28 23:30:35.579694+01	11	Code Lyoko Opening (Spanish) - Multi-languages songs (0:03:26s)	2	[{"changed": {"fields": ["suggester"]}}]	1	1
14	2019-11-28 23:30:44.504814+01	10	Code Lyoko Opening (Brazilian Portuguese) - Multi-languages songs (0:03:33s)	2	[{"changed": {"fields": ["suggester"]}}]	1	1
15	2019-11-28 23:30:49.911177+01	9	Code Lyoko Opening (Hungarian) - Multi-languages songs (0:03:46s)	2	[{"changed": {"fields": ["suggester"]}}]	1	1
16	2019-11-28 23:30:53.828298+01	8	Code Lyoko Opening (Japanese) - Multi-languages songs (0:03:38s)	2	[{"changed": {"fields": ["suggester"]}}]	1	1
17	2019-11-28 23:31:49.249768+01	5	acu1 voted for Code Lyoko Opening (Portuguese) - Multi-languages songs (0:03:27s)	1	[{"added": {}}]	2	1
18	2019-11-28 23:31:56.87847+01	6	acu1 voted for Code Lyoko Opening (Hebrew) - Multi-languages songs (0:03:37s)	1	[{"added": {}}]	2	1
19	2019-11-28 23:32:01.337162+01	7	acu2 voted for Code Lyoko Opening (Hebrew) - Multi-languages songs (0:03:37s)	1	[{"added": {}}]	2	1
20	2019-11-28 23:32:06.042492+01	8	admin voted for Code Lyoko Opening (Hebrew) - Multi-languages songs (0:03:37s)	1	[{"added": {}}]	2	1
21	2019-11-28 23:32:11.122162+01	9	ing1-2 voted for Code Lyoko Opening (Hebrew) - Multi-languages songs (0:03:37s)	1	[{"added": {}}]	2	1
22	2019-11-28 23:32:16.840693+01	10	ing1-3 voted for Code Lyoko Opening (Portuguese) - Multi-languages songs (0:03:27s)	1	[{"added": {}}]	2	1
23	2019-11-28 23:32:22.146307+01	11	admin voted for Code Lyoko Opening (Hungarian) - Multi-languages songs (0:03:46s)	1	[{"added": {}}]	2	1
24	2019-11-28 23:32:28.762127+01	12	haltode voted for Code Lyoko Opening (Japanese) - Multi-languages songs (0:03:38s)	1	[{"added": {}}]	2	1
25	2019-11-28 23:32:36.281038+01	13	acu1 voted for Code Lyoko Opening (Japanese) - Multi-languages songs (0:03:38s)	1	[{"added": {}}]	2	1
26	2019-11-28 23:32:40.724798+01	14	acu2 voted for Code Lyoko Opening (Japanese) - Multi-languages songs (0:03:38s)	1	[{"added": {}}]	2	1
27	2019-11-28 23:33:04.315783+01	4	acu1 liked Code Lyoko Opening (Greek) - Multi-languages songs (0:03:27s)	1	[{"added": {}}]	3	1
28	2019-11-28 23:33:08.73448+01	5	ing1-1 liked Code Lyoko Opening (Brazilian Portuguese) - Multi-languages songs (0:03:33s)	1	[{"added": {}}]	3	1
29	2019-11-28 23:33:14.453677+01	6	acu1 liked Code Lyoko Opening (Catalán) - Multi-languages songs (0:03:37s)	1	[{"added": {}}]	3	1
30	2019-11-28 23:33:21.536546+01	7	ing1-3 liked Code Lyoko Opening (Polish) - Multi-languages songs (0:03:38s)	1	[{"added": {}}]	3	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	dj	song
2	dj	vote
3	dj	like
4	admin	logentry
5	auth	permission
6	auth	group
7	auth	user
8	contenttypes	contenttype
9	sessions	session
10	social_django	association
11	social_django	code
12	social_django	nonce
13	social_django	usersocialauth
14	social_django	partial
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-11-28 23:18:16.656602+01
2	auth	0001_initial	2019-11-28 23:18:16.775991+01
3	admin	0001_initial	2019-11-28 23:18:16.921243+01
4	admin	0002_logentry_remove_auto_add	2019-11-28 23:18:16.97592+01
5	admin	0003_logentry_add_action_flag_choices	2019-11-28 23:18:17.002877+01
6	contenttypes	0002_remove_content_type_name	2019-11-28 23:18:17.029292+01
7	auth	0002_alter_permission_name_max_length	2019-11-28 23:18:17.036671+01
8	auth	0003_alter_user_email_max_length	2019-11-28 23:18:17.049988+01
9	auth	0004_alter_user_username_opts	2019-11-28 23:18:17.065197+01
10	auth	0005_alter_user_last_login_null	2019-11-28 23:18:17.077544+01
11	auth	0006_require_contenttypes_0002	2019-11-28 23:18:17.080596+01
12	auth	0007_alter_validators_add_error_messages	2019-11-28 23:18:17.112488+01
13	auth	0008_alter_user_username_max_length	2019-11-28 23:18:17.157989+01
14	auth	0009_alter_user_last_name_max_length	2019-11-28 23:18:17.192634+01
15	auth	0010_alter_group_name_max_length	2019-11-28 23:18:17.213869+01
16	auth	0011_update_proxy_permissions	2019-11-28 23:18:17.23357+01
17	dj	0001_initial	2019-11-28 23:18:17.356272+01
18	dj	0002_add_likes	2019-11-28 23:18:17.476132+01
19	sessions	0001_initial	2019-11-28 23:18:17.518173+01
20	default	0001_initial	2019-11-28 23:18:17.698757+01
21	social_auth	0001_initial	2019-11-28 23:18:17.700983+01
22	default	0002_add_related_name	2019-11-28 23:18:17.750406+01
23	social_auth	0002_add_related_name	2019-11-28 23:18:17.753051+01
24	default	0003_alter_email_max_length	2019-11-28 23:18:17.761111+01
25	social_auth	0003_alter_email_max_length	2019-11-28 23:18:17.763362+01
26	default	0004_auto_20160423_0400	2019-11-28 23:18:17.782122+01
27	social_auth	0004_auto_20160423_0400	2019-11-28 23:18:17.784476+01
28	social_auth	0005_auto_20160727_2333	2019-11-28 23:18:17.800864+01
29	social_django	0006_partial	2019-11-28 23:18:17.838324+01
30	social_django	0007_code_timestamp	2019-11-28 23:18:17.87485+01
31	social_django	0008_partial_timestamp	2019-11-28 23:18:17.903244+01
32	social_django	0001_initial	2019-11-28 23:18:17.923257+01
33	social_django	0002_add_related_name	2019-11-28 23:18:17.931212+01
34	social_django	0003_alter_email_max_length	2019-11-28 23:18:17.938131+01
35	social_django	0005_auto_20160727_2333	2019-11-28 23:18:17.945318+01
36	social_django	0004_auto_20160423_0400	2019-11-28 23:18:17.951456+01
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
x1ji5edwqgeb5vicbt8ibvaopp67s0fp	MmYxNDk2ZTA5YmVmMzIwOWU0NWE4YTFjN2ZkODU2ZmE4MGM5N2JlNzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkZjMxMDBkMThmYmU0NzNkNjNhZjExNzRmMDI5NzQ3NTNiOGE2MDE0In0=	2019-12-12 23:30:03.420056+01
\.


--
-- Data for Name: social_auth_association; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.social_auth_association (id, server_url, handle, secret, issued, lifetime, assoc_type) FROM stdin;
\.


--
-- Data for Name: social_auth_code; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.social_auth_code (id, email, code, verified, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_nonce; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.social_auth_nonce (id, server_url, "timestamp", salt) FROM stdin;
\.


--
-- Data for Name: social_auth_partial; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.social_auth_partial (id, token, next_step, backend, data, "timestamp") FROM stdin;
\.


--
-- Data for Name: social_auth_usersocialauth; Type: TABLE DATA; Schema: public; Owner: haltode
--

COPY public.social_auth_usersocialauth (id, provider, uid, extra_data, user_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 56, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 7, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: dj_like_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.dj_like_id_seq', 7, true);


--
-- Name: dj_song_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.dj_song_id_seq', 13, true);


--
-- Name: dj_vote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.dj_vote_id_seq', 14, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 30, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 14, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 36, true);


--
-- Name: social_auth_association_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.social_auth_association_id_seq', 1, false);


--
-- Name: social_auth_code_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.social_auth_code_id_seq', 1, false);


--
-- Name: social_auth_nonce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.social_auth_nonce_id_seq', 1, false);


--
-- Name: social_auth_partial_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.social_auth_partial_id_seq', 1, false);


--
-- Name: social_auth_usersocialauth_id_seq; Type: SEQUENCE SET; Schema: public; Owner: haltode
--

SELECT pg_catalog.setval('public.social_auth_usersocialauth_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: dj_like dj_like_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_like
    ADD CONSTRAINT dj_like_pkey PRIMARY KEY (id);


--
-- Name: dj_song dj_song_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_song
    ADD CONSTRAINT dj_song_pkey PRIMARY KEY (id);


--
-- Name: dj_song dj_song_yt_id_key; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_song
    ADD CONSTRAINT dj_song_yt_id_key UNIQUE (yt_id);


--
-- Name: dj_vote dj_vote_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_vote
    ADD CONSTRAINT dj_vote_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: social_auth_association social_auth_association_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_pkey PRIMARY KEY (id);


--
-- Name: social_auth_association social_auth_association_server_url_handle_078befa2_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_association
    ADD CONSTRAINT social_auth_association_server_url_handle_078befa2_uniq UNIQUE (server_url, handle);


--
-- Name: social_auth_code social_auth_code_email_code_801b2d02_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_email_code_801b2d02_uniq UNIQUE (email, code);


--
-- Name: social_auth_code social_auth_code_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_code
    ADD CONSTRAINT social_auth_code_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_pkey PRIMARY KEY (id);


--
-- Name: social_auth_nonce social_auth_nonce_server_url_timestamp_salt_f6284463_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_nonce
    ADD CONSTRAINT social_auth_nonce_server_url_timestamp_salt_f6284463_uniq UNIQUE (server_url, "timestamp", salt);


--
-- Name: social_auth_partial social_auth_partial_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_partial
    ADD CONSTRAINT social_auth_partial_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_pkey; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_pkey PRIMARY KEY (id);


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_provider_uid_e6b5e668_uniq; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_provider_uid_e6b5e668_uniq UNIQUE (provider, uid);


--
-- Name: dj_like unique like; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_like
    ADD CONSTRAINT "unique like" UNIQUE (song_id, user_id);


--
-- Name: dj_vote unique vote; Type: CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_vote
    ADD CONSTRAINT "unique vote" UNIQUE (song_id, user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: dj_like_song_id_d0f04921; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX dj_like_song_id_d0f04921 ON public.dj_like USING btree (song_id);


--
-- Name: dj_like_user_id_301796ec; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX dj_like_user_id_301796ec ON public.dj_like USING btree (user_id);


--
-- Name: dj_song_suggester_id_bad5e15a; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX dj_song_suggester_id_bad5e15a ON public.dj_song USING btree (suggester_id);


--
-- Name: dj_song_yt_id_2c5728a1_like; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX dj_song_yt_id_2c5728a1_like ON public.dj_song USING btree (yt_id varchar_pattern_ops);


--
-- Name: dj_vote_song_id_55d3c355; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX dj_vote_song_id_55d3c355 ON public.dj_vote USING btree (song_id);


--
-- Name: dj_vote_user_id_f84e4d34; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX dj_vote_user_id_f84e4d34 ON public.dj_vote USING btree (user_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: social_auth_code_code_a2393167; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX social_auth_code_code_a2393167 ON public.social_auth_code USING btree (code);


--
-- Name: social_auth_code_code_a2393167_like; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX social_auth_code_code_a2393167_like ON public.social_auth_code USING btree (code varchar_pattern_ops);


--
-- Name: social_auth_code_timestamp_176b341f; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX social_auth_code_timestamp_176b341f ON public.social_auth_code USING btree ("timestamp");


--
-- Name: social_auth_partial_timestamp_50f2119f; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX social_auth_partial_timestamp_50f2119f ON public.social_auth_partial USING btree ("timestamp");


--
-- Name: social_auth_partial_token_3017fea3; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX social_auth_partial_token_3017fea3 ON public.social_auth_partial USING btree (token);


--
-- Name: social_auth_partial_token_3017fea3_like; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX social_auth_partial_token_3017fea3_like ON public.social_auth_partial USING btree (token varchar_pattern_ops);


--
-- Name: social_auth_usersocialauth_user_id_17d28448; Type: INDEX; Schema: public; Owner: haltode
--

CREATE INDEX social_auth_usersocialauth_user_id_17d28448 ON public.social_auth_usersocialauth USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dj_like dj_like_song_id_d0f04921_fk_dj_song_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_like
    ADD CONSTRAINT dj_like_song_id_d0f04921_fk_dj_song_id FOREIGN KEY (song_id) REFERENCES public.dj_song(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dj_like dj_like_user_id_301796ec_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_like
    ADD CONSTRAINT dj_like_user_id_301796ec_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dj_song dj_song_suggester_id_bad5e15a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_song
    ADD CONSTRAINT dj_song_suggester_id_bad5e15a_fk_auth_user_id FOREIGN KEY (suggester_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dj_vote dj_vote_song_id_55d3c355_fk_dj_song_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_vote
    ADD CONSTRAINT dj_vote_song_id_55d3c355_fk_dj_song_id FOREIGN KEY (song_id) REFERENCES public.dj_song(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: dj_vote dj_vote_user_id_f84e4d34_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.dj_vote
    ADD CONSTRAINT dj_vote_user_id_f84e4d34_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: social_auth_usersocialauth social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: haltode
--

ALTER TABLE ONLY public.social_auth_usersocialauth
    ADD CONSTRAINT social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

