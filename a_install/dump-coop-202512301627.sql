--
-- PostgreSQL database dump
--

\restrict 0S4peqq25NrTUbmc9HaUcScOBhSt2uJRormg7IvAhzbnCmTdeum33dzL9M0Wd6p

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

-- Started on 2025-12-30 16:27:04 CET

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
-- TOC entry 234 (class 1259 OID 21134)
-- Name: choices_categories; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.choices_categories (
    choice_category_id integer NOT NULL,
    choice_category_name text,
    choice_category_status text,
    choice_category_summary text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.choices_categories OWNER TO sqlpage;

--
-- TOC entry 233 (class 1259 OID 21133)
-- Name: choices_categories_choice_category_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.choices_categories_choice_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.choices_categories_choice_category_id_seq OWNER TO sqlpage;

--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 233
-- Name: choices_categories_choice_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.choices_categories_choice_category_id_seq OWNED BY public.choices_categories.choice_category_id;


--
-- TOC entry 236 (class 1259 OID 21145)
-- Name: choices_items; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.choices_items (
    choice_id integer NOT NULL,
    choice_category_id integer,
    choice_label text,
    choice_value text,
    choice_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.choices_items OWNER TO sqlpage;

--
-- TOC entry 235 (class 1259 OID 21144)
-- Name: choices_items_choice_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.choices_items_choice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.choices_items_choice_id_seq OWNER TO sqlpage;

--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 235
-- Name: choices_items_choice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.choices_items_choice_id_seq OWNED BY public.choices_items.choice_id;


--
-- TOC entry 242 (class 1259 OID 21199)
-- Name: event_participants; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.event_participants (
    participant_id integer NOT NULL,
    event_id integer,
    participant_first_name text,
    participant_last_name text NOT NULL,
    participant_gender text DEFAULT 'N'::text,
    participant_age integer,
    participant_contact_phone text,
    participant_contact_email text,
    participant_postal_code integer,
    participant_function text,
    participant_category text,
    participant_status text,
    participant_rgpd_validation boolean,
    participant_selected boolean,
    participant_validation text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.event_participants OWNER TO sqlpage;

--
-- TOC entry 241 (class 1259 OID 21198)
-- Name: event_participants_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.event_participants_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.event_participants_participant_id_seq OWNER TO sqlpage;

--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 241
-- Name: event_participants_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.event_participants_participant_id_seq OWNED BY public.event_participants.participant_id;


--
-- TOC entry 240 (class 1259 OID 21174)
-- Name: events; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.events (
    event_id integer NOT NULL,
    event_name text NOT NULL,
    event_type text,
    event_status text,
    event_visio text,
    event_visio_url text,
    event_visio_code text,
    space_id integer,
    event_summary text,
    event_program_url text,
    event_picture_url text,
    event_date date,
    event_public_private text DEFAULT 'public'::text,
    event_audience_target text,
    event_participants_nb integer DEFAULT 0,
    event_participants_nb_max integer DEFAULT 0,
    event_entrance_fee integer DEFAULT 0,
    event_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    event_start_hour time without time zone,
    event_end_hour time without time zone,
    event_duration time without time zone,
    event_registration boolean
);


ALTER TABLE public.events OWNER TO sqlpage;

--
-- TOC entry 239 (class 1259 OID 21173)
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.events_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.events_event_id_seq OWNER TO sqlpage;

--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 239
-- Name: events_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.events_event_id_seq OWNED BY public.events.event_id;


--
-- TOC entry 238 (class 1259 OID 21161)
-- Name: faq_contacts; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.faq_contacts (
    contact_id integer NOT NULL,
    contact_gender text DEFAULT 'N'::text,
    contact_first_name text,
    contact_last_name text,
    contact_email text,
    contact_rgpd boolean,
    contact_status text DEFAULT 'online'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.faq_contacts OWNER TO sqlpage;

--
-- TOC entry 237 (class 1259 OID 21160)
-- Name: faq_contacts_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.faq_contacts_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faq_contacts_contact_id_seq OWNER TO sqlpage;

--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 237
-- Name: faq_contacts_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.faq_contacts_contact_id_seq OWNED BY public.faq_contacts.contact_id;


--
-- TOC entry 282 (class 1259 OID 21509)
-- Name: faq_questions; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.faq_questions (
    question_id integer NOT NULL,
    contact_id integer,
    question text,
    question_content text,
    answer text,
    answer_yes_no boolean DEFAULT false,
    faq_yes_no boolean,
    question_public_private text,
    question_category text,
    question_status text DEFAULT 'online'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.faq_questions OWNER TO sqlpage;

--
-- TOC entry 281 (class 1259 OID 21508)
-- Name: faq_questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.faq_questions_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faq_questions_question_id_seq OWNER TO sqlpage;

--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 281
-- Name: faq_questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.faq_questions_question_id_seq OWNED BY public.faq_questions.question_id;


--
-- TOC entry 246 (class 1259 OID 21229)
-- Name: forum_messages; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.forum_messages (
    message_id integer NOT NULL,
    topic_id integer,
    message_recipient_id integer,
    message_author_id integer,
    message_content text,
    message_status text,
    message_rank text DEFAULT 'post'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.forum_messages OWNER TO sqlpage;

--
-- TOC entry 245 (class 1259 OID 21228)
-- Name: forum_messages_message_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.forum_messages_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forum_messages_message_id_seq OWNER TO sqlpage;

--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 245
-- Name: forum_messages_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.forum_messages_message_id_seq OWNED BY public.forum_messages.message_id;


--
-- TOC entry 244 (class 1259 OID 21216)
-- Name: forum_topics; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.forum_topics (
    topic_id integer NOT NULL,
    topic_author_id integer,
    workspace_id integer,
    topic_name text,
    topic_category text,
    debug_target text,
    forum_type text,
    number_messages integer DEFAULT 0,
    forum_group text DEFAULT 'G0'::text,
    topic_status text,
    topic_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.forum_topics OWNER TO sqlpage;

--
-- TOC entry 243 (class 1259 OID 21215)
-- Name: forum_topics_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.forum_topics_topic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.forum_topics_topic_id_seq OWNER TO sqlpage;

--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 243
-- Name: forum_topics_topic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.forum_topics_topic_id_seq OWNED BY public.forum_topics.topic_id;


--
-- TOC entry 274 (class 1259 OID 21425)
-- Name: info_sections; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.info_sections (
    section_id integer NOT NULL,
    section_title text,
    section_content text,
    section_category text,
    section_lang text,
    section_number integer,
    section_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.info_sections OWNER TO sqlpage;

--
-- TOC entry 273 (class 1259 OID 21424)
-- Name: info_sections_section_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.info_sections_section_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.info_sections_section_id_seq OWNER TO sqlpage;

--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 273
-- Name: info_sections_section_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.info_sections_section_id_seq OWNED BY public.info_sections.section_id;


--
-- TOC entry 218 (class 1259 OID 21029)
-- Name: orga_dept_members; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.orga_dept_members (
    member_id integer NOT NULL,
    orga_dept_id integer,
    member_gender text DEFAULT 'N'::text,
    member_first_name text,
    member_last_name text NOT NULL,
    member_phone text,
    member_email text,
    member_category text,
    member_function text,
    member_date_birthday date,
    member_date_since date,
    member_date_last_subscription date,
    member_punchline text,
    member_cv_short text,
    member_cv_long text,
    member_picture_title text,
    member_picture_url text,
    member_selected boolean DEFAULT false,
    member_publish text,
    member_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.orga_dept_members OWNER TO sqlpage;

--
-- TOC entry 217 (class 1259 OID 21028)
-- Name: members_member_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.members_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.members_member_id_seq OWNER TO sqlpage;

--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 217
-- Name: members_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.members_member_id_seq OWNED BY public.orga_dept_members.member_id;


--
-- TOC entry 250 (class 1259 OID 21265)
-- Name: news; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.news (
    news_id integer NOT NULL,
    news_title text,
    news_content text,
    news_date date,
    news_img_url text,
    news_category text,
    news_public_private text,
    news_status text DEFAULT 'draft'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.news OWNER TO sqlpage;

--
-- TOC entry 249 (class 1259 OID 21264)
-- Name: news_news_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.news_news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_news_id_seq OWNER TO sqlpage;

--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 249
-- Name: news_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.news_news_id_seq OWNED BY public.news.news_id;


--
-- TOC entry 220 (class 1259 OID 21041)
-- Name: orga; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.orga (
    orga_id integer NOT NULL,
    orga_name text NOT NULL,
    orga_acronym text,
    orga_logo_url text,
    orga_punchline text,
    orga_summary text,
    orga_adress text,
    orga_postal_code integer,
    orga_town text,
    orga_country text DEFAULT 'France'::text,
    orga_latitude numeric(9,6),
    orga_longitude numeric(9,6),
    orga_contact_phone text,
    orga_contact_mail text,
    orga_status text,
    orga_legal_status text,
    orga_no_rna text,
    orga_no_siren integer,
    orga_no_siret integer,
    orga_no_tva_intracom integer,
    orga_code_naf_ape text,
    orga_date_creation date,
    orga_number_employees integer,
    orga_selected boolean,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.orga OWNER TO sqlpage;

--
-- TOC entry 222 (class 1259 OID 21053)
-- Name: orga_dept; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.orga_dept (
    orga_dept_id integer NOT NULL,
    orga_dept_name text NOT NULL,
    orga_id integer,
    orga_dept_acronym text,
    orga_dept_logo_url text,
    orga_dept_punchline text,
    orga_dept_summary text,
    orga_dept_adress text,
    orga_dept_postal_code integer,
    orga_dept_town text,
    orga_dept_country text,
    orga_dept_latitude numeric(9,6),
    orga_dept_longitude numeric(9,6),
    orga_dept_contact_phone text,
    orga_dept_contact_mail text,
    orga_dept_date_creation date,
    orga_dept_rank text,
    orga_dept_status text,
    orga_dept_legal_status text,
    orga_dept_number_employees integer,
    orga_dept_no_rna text,
    orga_dept_no_siren integer,
    orga_dept_no_siret integer,
    orga_dept_code_naf_ape text,
    orga_dept_no_tva_intracom integer,
    orga_dept_selected boolean,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now(),
    orga_dept_master text
);


ALTER TABLE public.orga_dept OWNER TO sqlpage;

--
-- TOC entry 286 (class 1259 OID 21558)
-- Name: orga_dept_docs; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.orga_dept_docs (
    orga_doc_id integer NOT NULL,
    orga_dept_id integer,
    orga_doc_title text,
    orga_doc_author text,
    orga_doc_url text,
    orga_doc_summary text,
    orga_doc_keywords text,
    orga_doc_date_publication date,
    orga_doc_date_period text,
    orga_doc_lang text,
    orga_doc_format text,
    orga_doc_number_page text,
    orga_doc_category text,
    orga_doc_type text,
    orga_doc_edition text DEFAULT 'draft'::text,
    orga_doc_selected boolean DEFAULT false,
    orga_doc_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.orga_dept_docs OWNER TO sqlpage;

--
-- TOC entry 221 (class 1259 OID 21052)
-- Name: orga_dept_orga_dept_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.orga_dept_orga_dept_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orga_dept_orga_dept_id_seq OWNER TO sqlpage;

--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 221
-- Name: orga_dept_orga_dept_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.orga_dept_orga_dept_id_seq OWNED BY public.orga_dept.orga_dept_id;


--
-- TOC entry 254 (class 1259 OID 21296)
-- Name: orga_dept_partners; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.orga_dept_partners (
    orga_partner_id integer NOT NULL,
    orga_dept_id integer,
    orga_partner_name text,
    orga_partner_acronym text,
    orga_partner_scope text,
    orga_partner_link text,
    orga_partner_logo_url text,
    orga_partner_logo_title text,
    orga_partner_type text,
    orga_partner_category text,
    orga_partner_date_since date,
    orga_partner_status text,
    orga_partner_punchline text,
    orga_partner_summary text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.orga_dept_partners OWNER TO sqlpage;

--
-- TOC entry 285 (class 1259 OID 21557)
-- Name: orga_docs_orga_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.orga_docs_orga_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orga_docs_orga_doc_id_seq OWNER TO sqlpage;

--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 285
-- Name: orga_docs_orga_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.orga_docs_orga_doc_id_seq OWNED BY public.orga_dept_docs.orga_doc_id;


--
-- TOC entry 219 (class 1259 OID 21040)
-- Name: orga_orga_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.orga_orga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orga_orga_id_seq OWNER TO sqlpage;

--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 219
-- Name: orga_orga_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.orga_orga_id_seq OWNED BY public.orga.orga_id;


--
-- TOC entry 253 (class 1259 OID 21295)
-- Name: orga_partners_orga_partner_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.orga_partners_orga_partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orga_partners_orga_partner_id_seq OWNER TO sqlpage;

--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 253
-- Name: orga_partners_orga_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.orga_partners_orga_partner_id_seq OWNED BY public.orga_dept_partners.orga_partner_id;


--
-- TOC entry 224 (class 1259 OID 21069)
-- Name: place; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.place (
    place_id integer NOT NULL,
    place_name text NOT NULL,
    place_status text,
    place_summary text,
    place_adress text,
    place_postal_code integer,
    place_town text,
    place_country text,
    place_latitude numeric(9,6),
    place_longitude numeric(9,6),
    place_contact_phone text,
    place_contact_mail text,
    place_type text,
    place_accessibility text,
    place_capacity_seats integer,
    place_capacity_standup integer,
    place_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.place OWNER TO sqlpage;

--
-- TOC entry 223 (class 1259 OID 21068)
-- Name: place_place_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.place_place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.place_place_id_seq OWNER TO sqlpage;

--
-- TOC entry 4242 (class 0 OID 0)
-- Dependencies: 223
-- Name: place_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.place_place_id_seq OWNED BY public.place.place_id;


--
-- TOC entry 230 (class 1259 OID 21107)
-- Name: place_spaces; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.place_spaces (
    space_id integer NOT NULL,
    place_id integer,
    space_name text NOT NULL,
    space_rank text,
    space_summary text,
    space_access text,
    space_type text,
    space_accessibility text,
    space_capacity_seats integer,
    space_capacity_standup integer,
    space_status text,
    space_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.place_spaces OWNER TO sqlpage;

--
-- TOC entry 284 (class 1259 OID 21526)
-- Name: place_spaces_pictures; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.place_spaces_pictures (
    space_picture_id integer NOT NULL,
    space_id integer,
    space_picture_url text,
    space_picture_title text,
    space_picture_summary text,
    space_picture_format text,
    space_picture_status text,
    space_picture_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.place_spaces_pictures OWNER TO sqlpage;

--
-- TOC entry 283 (class 1259 OID 21525)
-- Name: place_spaces_pictures_space_picture_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.place_spaces_pictures_space_picture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.place_spaces_pictures_space_picture_id_seq OWNER TO sqlpage;

--
-- TOC entry 4243 (class 0 OID 0)
-- Dependencies: 283
-- Name: place_spaces_pictures_space_picture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.place_spaces_pictures_space_picture_id_seq OWNED BY public.place_spaces_pictures.space_picture_id;


--
-- TOC entry 229 (class 1259 OID 21106)
-- Name: place_spaces_space_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.place_spaces_space_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.place_spaces_space_id_seq OWNER TO sqlpage;

--
-- TOC entry 4244 (class 0 OID 0)
-- Dependencies: 229
-- Name: place_spaces_space_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.place_spaces_space_id_seq OWNED BY public.place_spaces.space_id;


--
-- TOC entry 260 (class 1259 OID 21341)
-- Name: prm1; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm1 (
    prm1_id integer NOT NULL,
    prm1_gender text DEFAULT 'N'::text,
    prm1_first_name text,
    prm1_last_name text NOT NULL,
    prm1_phone text,
    prm1_email text,
    prm1_category text,
    prm1_function text,
    prm1_date_birthday date,
    prm1_cv_short text,
    prm1_cv_long text,
    prm1_selected boolean DEFAULT false,
    prm1_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm1 OWNER TO sqlpage;

--
-- TOC entry 262 (class 1259 OID 21353)
-- Name: prm1_doc; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm1_doc (
    prm1_doc_id integer NOT NULL,
    prm1_id integer,
    prm1_doc_title text,
    prm1_doc_author text,
    prm1_doc_url text,
    prm1_doc_summary text,
    prm1_doc_keywords text,
    prm1_doc_date_publication date,
    prm1_doc_lang text,
    prm1_doc_format text,
    prm1_doc_category text,
    prm1_doc_type text,
    prm1_doc_selected boolean DEFAULT false,
    prm1_doc_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    prm1_doc_date_period integer
);


ALTER TABLE public.prm1_doc OWNER TO sqlpage;

--
-- TOC entry 261 (class 1259 OID 21352)
-- Name: prm1_doc_prm1_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm1_doc_prm1_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm1_doc_prm1_doc_id_seq OWNER TO sqlpage;

--
-- TOC entry 4245 (class 0 OID 0)
-- Dependencies: 261
-- Name: prm1_doc_prm1_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm1_doc_prm1_doc_id_seq OWNED BY public.prm1_doc.prm1_doc_id;


--
-- TOC entry 259 (class 1259 OID 21340)
-- Name: prm1_prm1_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm1_prm1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm1_prm1_id_seq OWNER TO sqlpage;

--
-- TOC entry 4246 (class 0 OID 0)
-- Dependencies: 259
-- Name: prm1_prm1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm1_prm1_id_seq OWNED BY public.prm1.prm1_id;


--
-- TOC entry 258 (class 1259 OID 21329)
-- Name: prm2; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm2 (
    prm2_id integer NOT NULL,
    prm2_name text NOT NULL,
    prm2_acronym text,
    prm2_logo_url text,
    prm2_punchline text,
    prm2_summary text,
    prm2_adress text,
    prm2_postal_code integer,
    prm2_town text,
    prm2_country text DEFAULT 'France'::text,
    prm2_latitude real,
    prm2_longitude real,
    prm2_contact_phone text,
    prm2_contact_mail text,
    prm2_status text,
    prm2_legal_status text,
    prm2_no_rna text,
    prm2_no_siren integer,
    prm2_no_siret integer,
    prm2_no_tva_intracom integer,
    prm2_code_naf_ape text,
    prm2_date_creation date,
    prm2_number_employees integer,
    prm2_selected boolean DEFAULT false,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm2 OWNER TO sqlpage;

--
-- TOC entry 257 (class 1259 OID 21328)
-- Name: prm2_prm2_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm2_prm2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm2_prm2_id_seq OWNER TO sqlpage;

--
-- TOC entry 4247 (class 0 OID 0)
-- Dependencies: 257
-- Name: prm2_prm2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm2_prm2_id_seq OWNED BY public.prm2.prm2_id;


--
-- TOC entry 276 (class 1259 OID 21436)
-- Name: prm2_sub; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm2_sub (
    prm2_sub_id integer NOT NULL,
    prm2_sub_name text NOT NULL,
    prm2_id integer,
    prm2_sub_acronym text,
    prm2_sub_logo_url text,
    prm2_sub_punchline text,
    prm2_sub_summary text,
    prm2_sub_adress text,
    prm2_sub_postal_code integer,
    prm2_sub_town text,
    prm2_sub_country text,
    prm2_sub_latitude real,
    prm2_sub_longitude real,
    prm2_sub_contact_phone text,
    prm2_sub_contact_mail text,
    prm2_sub_date_creation date,
    prm2_sub_rank text,
    prm2_sub_status text,
    prm2_sub_legal_status text,
    prm2_sub_nb_employees integer,
    prm2_sub_no_rna text,
    prm2_sub_no_siren integer,
    prm2_sub_no_siret integer,
    prm2_sub_code_naf_ape text,
    prm2_sub_no_tva_intracom integer,
    prm2_sub_selected boolean DEFAULT false,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm2_sub OWNER TO sqlpage;

--
-- TOC entry 326 (class 1259 OID 22247)
-- Name: prm2_sub_docs; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm2_sub_docs (
    prm2_sub_doc_id integer NOT NULL,
    prm2_sub_id integer,
    prm2_sub_doc_title text,
    prm2_sub_doc_author text,
    prm2_sub_doc_url text,
    prm2_sub_doc_summary text,
    prm2_sub_doc_keywords text,
    prm2_sub_doc_date_publication date,
    prm2_sub_doc_date_period integer,
    prm2_sub_doc_lang text,
    prm2_sub_doc_format text,
    prm2_sub_doc_category text,
    prm2_sub_doc_type text,
    prm2_sub_doc_selected boolean DEFAULT false,
    prm2_sub_doc_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm2_sub_docs OWNER TO sqlpage;

--
-- TOC entry 325 (class 1259 OID 22246)
-- Name: prm2_sub_docs_prm2_sub_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm2_sub_docs_prm2_sub_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm2_sub_docs_prm2_sub_doc_id_seq OWNER TO sqlpage;

--
-- TOC entry 4248 (class 0 OID 0)
-- Dependencies: 325
-- Name: prm2_sub_docs_prm2_sub_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm2_sub_docs_prm2_sub_doc_id_seq OWNED BY public.prm2_sub_docs.prm2_sub_doc_id;


--
-- TOC entry 328 (class 1259 OID 22270)
-- Name: prm2_sub_employees; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm2_sub_employees (
    employee_id integer NOT NULL,
    prm1_id integer,
    prm2_sub_id integer,
    employee_title text,
    employee_function text DEFAULT 'employee'::text,
    employee_category text,
    employee_status text DEFAULT 'active'::text,
    employee_selected boolean DEFAULT false,
    employee_since date,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm2_sub_employees OWNER TO sqlpage;

--
-- TOC entry 327 (class 1259 OID 22269)
-- Name: prm2_sub_employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm2_sub_employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm2_sub_employees_employee_id_seq OWNER TO sqlpage;

--
-- TOC entry 4249 (class 0 OID 0)
-- Dependencies: 327
-- Name: prm2_sub_employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm2_sub_employees_employee_id_seq OWNED BY public.prm2_sub_employees.employee_id;


--
-- TOC entry 275 (class 1259 OID 21435)
-- Name: prm2_sub_prm2_sub_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm2_sub_prm2_sub_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm2_sub_prm2_sub_id_seq OWNER TO sqlpage;

--
-- TOC entry 4250 (class 0 OID 0)
-- Dependencies: 275
-- Name: prm2_sub_prm2_sub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm2_sub_prm2_sub_id_seq OWNED BY public.prm2_sub.prm2_sub_id;


--
-- TOC entry 264 (class 1259 OID 21369)
-- Name: prm3; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm3 (
    prm3_id integer NOT NULL,
    prm3_name text,
    prm3_summary text,
    prm3_category text,
    prm3_status text,
    prm3_selected boolean DEFAULT false,
    prm3_formal text,
    prm3_nb_participants integer,
    prm3_type text,
    prm3_date_creation date,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm3 OWNER TO sqlpage;

--
-- TOC entry 330 (class 1259 OID 22294)
-- Name: prm3_docs; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm3_docs (
    prm3_doc_id integer NOT NULL,
    prm3_id integer,
    prm3_doc_title text NOT NULL,
    prm3_doc_url text,
    prm3_doc_summary text,
    prm3_doc_keywords text,
    prm3_doc_status text,
    prm3_doc_category text,
    prm3_doc_format text,
    prm3_doc_selected boolean DEFAULT false,
    prm3_doc_date_publication date,
    prm3_doc_type text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm3_docs OWNER TO sqlpage;

--
-- TOC entry 329 (class 1259 OID 22293)
-- Name: prm3_docs_prm3_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm3_docs_prm3_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm3_docs_prm3_doc_id_seq OWNER TO sqlpage;

--
-- TOC entry 4251 (class 0 OID 0)
-- Dependencies: 329
-- Name: prm3_docs_prm3_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm3_docs_prm3_doc_id_seq OWNED BY public.prm3_docs.prm3_doc_id;


--
-- TOC entry 266 (class 1259 OID 21380)
-- Name: prm3_participants; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.prm3_participants (
    prm3_participant_id integer NOT NULL,
    prm3_id integer,
    prm1_id integer,
    prm2_sub_id integer,
    employee_id integer,
    prm3_participant_role text DEFAULT 'participant'::text,
    prm3_participant_type text,
    prm3_participant_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.prm3_participants OWNER TO sqlpage;

--
-- TOC entry 265 (class 1259 OID 21379)
-- Name: prm3_participants_prm3_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm3_participants_prm3_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm3_participants_prm3_participant_id_seq OWNER TO sqlpage;

--
-- TOC entry 4252 (class 0 OID 0)
-- Dependencies: 265
-- Name: prm3_participants_prm3_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm3_participants_prm3_participant_id_seq OWNED BY public.prm3_participants.prm3_participant_id;


--
-- TOC entry 263 (class 1259 OID 21368)
-- Name: prm3_prm3_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.prm3_prm3_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prm3_prm3_id_seq OWNER TO sqlpage;

--
-- TOC entry 4253 (class 0 OID 0)
-- Dependencies: 263
-- Name: prm3_prm3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.prm3_prm3_id_seq OWNED BY public.prm3.prm3_id;


--
-- TOC entry 226 (class 1259 OID 21080)
-- Name: process; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.process (
    process_id integer NOT NULL,
    process_title text,
    process_description text,
    process_category text,
    process_status text,
    process_publication_status text,
    process_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.process OWNER TO sqlpage;

--
-- TOC entry 225 (class 1259 OID 21079)
-- Name: process_process_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.process_process_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.process_process_id_seq OWNER TO sqlpage;

--
-- TOC entry 4254 (class 0 OID 0)
-- Dependencies: 225
-- Name: process_process_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.process_process_id_seq OWNED BY public.process.process_id;


--
-- TOC entry 228 (class 1259 OID 21091)
-- Name: process_steps; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.process_steps (
    process_step_id integer NOT NULL,
    process_id integer,
    process_step_number integer,
    process_step_author text,
    process_step_title text,
    process_step_icon text,
    process_step_link text,
    process_step_description text,
    process_step_selected boolean,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.process_steps OWNER TO sqlpage;

--
-- TOC entry 227 (class 1259 OID 21090)
-- Name: process_steps_process_step_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.process_steps_process_step_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.process_steps_process_step_id_seq OWNER TO sqlpage;

--
-- TOC entry 4255 (class 0 OID 0)
-- Dependencies: 227
-- Name: process_steps_process_step_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.process_steps_process_step_id_seq OWNED BY public.process_steps.process_step_id;


--
-- TOC entry 288 (class 1259 OID 21575)
-- Name: project; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project (
    project_id integer NOT NULL,
    project_name text,
    project_summary text,
    project_category text,
    project_nb_participants integer,
    project_status text,
    project_date_start_scheduled date,
    project_date_start_actual date,
    project_date_end_scheduled date,
    project_date_end_actual date,
    project_duration_scheduled integer,
    project_duration_actual integer,
    project_completion_percentage integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    project_date_creation date
);


ALTER TABLE public.project OWNER TO sqlpage;

--
-- TOC entry 298 (class 1259 OID 21667)
-- Name: project_building; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_building (
    building_id integer NOT NULL,
    project_id integer,
    building_name text,
    building_status text,
    building_summary text,
    building_adress text,
    building_postal_code integer,
    building_town text,
    building_country text,
    building_latitude numeric(9,6),
    building_longitude numeric(9,6),
    building_contact_phone text,
    building_contact_mail text,
    building_type text,
    building_accessibility text,
    building_capacity_seats integer,
    building_capacity_standup integer,
    building_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_building OWNER TO sqlpage;

--
-- TOC entry 297 (class 1259 OID 21666)
-- Name: project_building_building_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_building_building_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_building_building_id_seq OWNER TO sqlpage;

--
-- TOC entry 4256 (class 0 OID 0)
-- Dependencies: 297
-- Name: project_building_building_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_building_building_id_seq OWNED BY public.project_building.building_id;


--
-- TOC entry 300 (class 1259 OID 21683)
-- Name: project_building_rooms; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_building_rooms (
    room_id integer NOT NULL,
    building_id integer,
    room_name text NOT NULL,
    room_rank text,
    room_type text,
    room_summary text,
    room_todo text,
    room_access text,
    room_accessibility text,
    room_capacity_seats integer,
    room_capacity_standup integer,
    room_status text,
    room_selected boolean,
    room_width integer,
    room_length integer,
    room_height integer,
    room_wall_material text,
    room_floor_material text,
    room_quality_level text,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_building_rooms OWNER TO sqlpage;

--
-- TOC entry 302 (class 1259 OID 21699)
-- Name: project_building_rooms_pictures; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_building_rooms_pictures (
    room_picture_id integer NOT NULL,
    building_id integer,
    project_id integer,
    room_id integer,
    room_picture_url text,
    room_picture_title text,
    room_picture_summary text,
    room_picture_format text,
    room_picture_status text,
    room_picture_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    workpackage_id integer,
    worksequence_id integer
);


ALTER TABLE public.project_building_rooms_pictures OWNER TO sqlpage;

--
-- TOC entry 301 (class 1259 OID 21698)
-- Name: project_building_rooms_pictures_room_picture_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_building_rooms_pictures_room_picture_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_building_rooms_pictures_room_picture_id_seq OWNER TO sqlpage;

--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 301
-- Name: project_building_rooms_pictures_room_picture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_building_rooms_pictures_room_picture_id_seq OWNED BY public.project_building_rooms_pictures.room_picture_id;


--
-- TOC entry 299 (class 1259 OID 21682)
-- Name: project_building_rooms_room_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_building_rooms_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_building_rooms_room_id_seq OWNER TO sqlpage;

--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 299
-- Name: project_building_rooms_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_building_rooms_room_id_seq OWNED BY public.project_building_rooms.room_id;


--
-- TOC entry 318 (class 1259 OID 21932)
-- Name: project_docs; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_docs (
    project_doc_id integer NOT NULL,
    project_id integer,
    project_doc_title text,
    project_doc_author text,
    project_doc_url text,
    project_doc_cloud_url text,
    project_doc_summary text,
    project_doc_keywords text,
    project_doc_date_publication date,
    project_doc_date_period integer,
    project_doc_lang text,
    project_doc_format text,
    project_doc_category text,
    project_doc_type text,
    project_doc_local_cloud text,
    project_doc_cloud_format text,
    project_doc_selected boolean DEFAULT false,
    project_doc_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    project_forum_message_id integer,
    project_doc_title_link text,
    project_forum_message_id_local_cloud text GENERATED ALWAYS AS (((project_forum_message_id || '_'::text) || project_doc_local_cloud)) STORED
);


ALTER TABLE public.project_docs OWNER TO sqlpage;

--
-- TOC entry 317 (class 1259 OID 21931)
-- Name: project_docs_project_doc_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_docs_project_doc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_docs_project_doc_id_seq OWNER TO sqlpage;

--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 317
-- Name: project_docs_project_doc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_docs_project_doc_id_seq OWNED BY public.project_docs.project_doc_id;


--
-- TOC entry 333 (class 1259 OID 22752)
-- Name: project_docs_project_forum_message_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_docs_project_forum_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_docs_project_forum_message_id_seq OWNER TO sqlpage;

--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 333
-- Name: project_docs_project_forum_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_docs_project_forum_message_id_seq OWNED BY public.project_docs.project_forum_message_id;


--
-- TOC entry 296 (class 1259 OID 21655)
-- Name: project_forum_messages; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_forum_messages (
    project_forum_message_id integer NOT NULL,
    project_forum_topic_id integer,
    project_forum_message_recipient_id integer,
    project_forum_message_author_id integer,
    project_forum_message_content text,
    project_forum_message_status text,
    project_forum_message_rank text DEFAULT 'post'::text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_forum_messages OWNER TO sqlpage;

--
-- TOC entry 295 (class 1259 OID 21654)
-- Name: project_forum_messages_project_forum_message_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_forum_messages_project_forum_message_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_forum_messages_project_forum_message_id_seq OWNER TO sqlpage;

--
-- TOC entry 4261 (class 0 OID 0)
-- Dependencies: 295
-- Name: project_forum_messages_project_forum_message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_forum_messages_project_forum_message_id_seq OWNED BY public.project_forum_messages.project_forum_message_id;


--
-- TOC entry 294 (class 1259 OID 21642)
-- Name: project_forum_topics; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_forum_topics (
    project_forum_topic_id integer NOT NULL,
    project_id integer,
    project_forum_topic_author_id integer,
    project_forum_topic_name text,
    project_forum_topic_category text,
    debug_target text,
    forum_type text,
    number_messages integer DEFAULT 0,
    forum_group text DEFAULT 'G0'::text,
    project_forum_topic_status text,
    project_forum_topic_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_forum_topics OWNER TO sqlpage;

--
-- TOC entry 293 (class 1259 OID 21641)
-- Name: project_forum_topics_project_forum_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_forum_topics_project_forum_topic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_forum_topics_project_forum_topic_id_seq OWNER TO sqlpage;

--
-- TOC entry 4262 (class 0 OID 0)
-- Dependencies: 293
-- Name: project_forum_topics_project_forum_topic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_forum_topics_project_forum_topic_id_seq OWNED BY public.project_forum_topics.project_forum_topic_id;


--
-- TOC entry 320 (class 1259 OID 22046)
-- Name: project_meeting; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_meeting (
    project_meeting_id integer NOT NULL,
    project_meeting_place_id integer,
    project_id integer,
    project_meeting_title text,
    project_meeting_agenda text,
    project_meeting_visio text,
    project_meeting_visio_url text,
    project_meeting_visio_code text,
    project_meeting_date date,
    project_meeting_hour_start time without time zone,
    project_meeting_hour_end time without time zone,
    project_meeting_duration time without time zone,
    project_meeting_type text,
    project_meeting_participants_nb integer DEFAULT 0,
    project_meeting_alert text DEFAULT 'alert_end'::text,
    project_meeting_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_meeting OWNER TO sqlpage;

--
-- TOC entry 292 (class 1259 OID 21631)
-- Name: project_meeting_participants; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_meeting_participants (
    project_meeting_participant_id integer NOT NULL,
    project_meeting_id integer,
    user_id integer,
    prm1_id integer,
    prm2_sub_id integer,
    employee_id integer,
    project_meeting_participant_role text,
    project_meeting_participant_type text,
    project_meeting_participant_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_meeting_participants OWNER TO sqlpage;

--
-- TOC entry 291 (class 1259 OID 21630)
-- Name: project_meeting_participants_project_meeting_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_meeting_participants_project_meeting_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_meeting_participants_project_meeting_participant_id_seq OWNER TO sqlpage;

--
-- TOC entry 4263 (class 0 OID 0)
-- Dependencies: 291
-- Name: project_meeting_participants_project_meeting_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_meeting_participants_project_meeting_participant_id_seq OWNED BY public.project_meeting_participants.project_meeting_participant_id;


--
-- TOC entry 290 (class 1259 OID 21620)
-- Name: project_meeting_places; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_meeting_places (
    project_meeting_place_id integer NOT NULL,
    project_meeting_place_name text NOT NULL,
    project_meeting_place_status text,
    project_meeting_place_summary text,
    project_meeting_place_adress text,
    project_meeting_place_postal_code integer,
    project_meeting_place_town text,
    project_meeting_place_country text,
    project_meeting_place_latitude numeric(9,6),
    project_meeting_place_longitude numeric(9,6),
    project_meeting_place_contact_phone text,
    project_meeting_place_contact_mail text,
    project_meeting_place_type text,
    project_meeting_place_accessibility text,
    project_meeting_place_capacity_seats integer,
    project_meeting_place_capacity_standup integer,
    project_meeting_place_selected boolean,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_meeting_places OWNER TO sqlpage;

--
-- TOC entry 289 (class 1259 OID 21619)
-- Name: project_meeting_places_project_meeting_place_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_meeting_places_project_meeting_place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_meeting_places_project_meeting_place_id_seq OWNER TO sqlpage;

--
-- TOC entry 4264 (class 0 OID 0)
-- Dependencies: 289
-- Name: project_meeting_places_project_meeting_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_meeting_places_project_meeting_place_id_seq OWNED BY public.project_meeting_places.project_meeting_place_id;


--
-- TOC entry 319 (class 1259 OID 22045)
-- Name: project_meeting_project_meeting_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_meeting_project_meeting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_meeting_project_meeting_id_seq OWNER TO sqlpage;

--
-- TOC entry 4265 (class 0 OID 0)
-- Dependencies: 319
-- Name: project_meeting_project_meeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_meeting_project_meeting_id_seq OWNED BY public.project_meeting.project_meeting_id;


--
-- TOC entry 306 (class 1259 OID 21726)
-- Name: project_products; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_products (
    product_id integer NOT NULL,
    product_category_id integer,
    product_name text,
    product_summary text,
    product_ienes_url text,
    product_functional_unit text,
    product_unit text,
    product_climate_change_indicator double precision,
    product_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_products OWNER TO sqlpage;

--
-- TOC entry 304 (class 1259 OID 21710)
-- Name: project_products_categories; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_products_categories (
    product_category_id integer NOT NULL,
    product_category_parent_id integer,
    product_category_name text,
    product_category_status text,
    product_category_summary text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_products_categories OWNER TO sqlpage;

--
-- TOC entry 303 (class 1259 OID 21709)
-- Name: project_products_categories_product_category_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_products_categories_product_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_products_categories_product_category_id_seq OWNER TO sqlpage;

--
-- TOC entry 4266 (class 0 OID 0)
-- Dependencies: 303
-- Name: project_products_categories_product_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_products_categories_product_category_id_seq OWNED BY public.project_products_categories.product_category_id;


--
-- TOC entry 305 (class 1259 OID 21725)
-- Name: project_products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_products_product_id_seq OWNER TO sqlpage;

--
-- TOC entry 4267 (class 0 OID 0)
-- Dependencies: 305
-- Name: project_products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_products_product_id_seq OWNED BY public.project_products.product_id;


--
-- TOC entry 287 (class 1259 OID 21574)
-- Name: project_project_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_project_id_seq OWNER TO sqlpage;

--
-- TOC entry 4268 (class 0 OID 0)
-- Dependencies: 287
-- Name: project_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_project_id_seq OWNED BY public.project.project_id;


--
-- TOC entry 308 (class 1259 OID 21742)
-- Name: project_workpackage; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_workpackage (
    workpackage_id integer NOT NULL,
    workpackage_parent_id integer,
    project_id integer,
    workpackage_name text,
    workpackage_summary text,
    workpackage_todo text,
    workpackage_type text,
    workpackage_cost_estimated numeric(10,2),
    workpackage_cost_actual numeric(10,2),
    workpackage_nb_participants integer,
    workpackage_status text,
    workpackage_date_start_scheduled date,
    workpackage_date_start_actual date,
    workpackage_rank text,
    workpackage_mode text,
    workpackage_date_end_scheduled date,
    workpackage_date_end_actual date,
    workpackage_duration_scheduled integer,
    workpackage_completion_percentage integer,
    workpackage_duration_actual integer,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_workpackage OWNER TO sqlpage;

--
-- TOC entry 332 (class 1259 OID 22321)
-- Name: project_workpackage_expenses; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_workpackage_expenses (
    expense_id integer NOT NULL,
    workpackage_id integer,
    provider_id integer,
    expense_category text,
    expense_name text,
    expense_summary text,
    expense_unit text,
    expense_value numeric(10,2) NOT NULL,
    expense_quantity integer,
    expense_invoice_url text,
    expense_invoice_date date,
    expense_invoice_ref text,
    expense_status text,
    expense_tax_rate integer,
    expense_saving integer,
    expense_material_origin text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_workpackage_expenses OWNER TO sqlpage;

--
-- TOC entry 331 (class 1259 OID 22320)
-- Name: project_workpackage_expenses_expense_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_workpackage_expenses_expense_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_workpackage_expenses_expense_id_seq OWNER TO sqlpage;

--
-- TOC entry 4269 (class 0 OID 0)
-- Dependencies: 331
-- Name: project_workpackage_expenses_expense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_workpackage_expenses_expense_id_seq OWNED BY public.project_workpackage_expenses.expense_id;


--
-- TOC entry 312 (class 1259 OID 21774)
-- Name: project_workpackage_materials; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_workpackage_materials (
    material_id integer NOT NULL,
    product_id integer,
    workpackage_id integer,
    material_summary text,
    material_unit text,
    material_quantity integer,
    material_status text,
    material_volume1 real,
    material_volume2 real,
    material_area real,
    material_length real,
    material_heigth real,
    material_width real,
    material_weigth real,
    material_thickness real,
    material_equiv_fonctional_units integer,
    material_carbon_footprint double precision,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_workpackage_materials OWNER TO sqlpage;

--
-- TOC entry 311 (class 1259 OID 21773)
-- Name: project_workpackage_materials_material_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_workpackage_materials_material_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_workpackage_materials_material_id_seq OWNER TO sqlpage;

--
-- TOC entry 4270 (class 0 OID 0)
-- Dependencies: 311
-- Name: project_workpackage_materials_material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_workpackage_materials_material_id_seq OWNED BY public.project_workpackage_materials.material_id;


--
-- TOC entry 314 (class 1259 OID 21811)
-- Name: project_workpackage_participants; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_workpackage_participants (
    workpackage_participant_id integer NOT NULL,
    workpackage_id integer,
    prm1_id integer,
    prm2_sub_id integer,
    employee_id integer,
    prm3_id integer,
    workpackage_participant_role text DEFAULT 'participant'::text,
    workpackage_participant_type text,
    workpackage_participant_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_workpackage_participants OWNER TO sqlpage;

--
-- TOC entry 313 (class 1259 OID 21810)
-- Name: project_workpackage_participants_workpackage_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_workpackage_participants_workpackage_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_workpackage_participants_workpackage_participant_id_seq OWNER TO sqlpage;

--
-- TOC entry 4271 (class 0 OID 0)
-- Dependencies: 313
-- Name: project_workpackage_participants_workpackage_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_workpackage_participants_workpackage_participant_id_seq OWNED BY public.project_workpackage_participants.workpackage_participant_id;


--
-- TOC entry 310 (class 1259 OID 21758)
-- Name: project_workpackage_waste; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_workpackage_waste (
    waste_id integer NOT NULL,
    workpackage_id integer,
    recipiend_id integer,
    waste_name text,
    waste_summary text,
    waste_ienes_url text,
    waste_category_id integer,
    waste_value real,
    waste_destination text,
    waste_functional_unit text,
    waste_unit text,
    waste_quantity integer,
    waste_status text,
    updated_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_workpackage_waste OWNER TO sqlpage;

--
-- TOC entry 309 (class 1259 OID 21757)
-- Name: project_workpackage_waste_waste_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_workpackage_waste_waste_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_workpackage_waste_waste_id_seq OWNER TO sqlpage;

--
-- TOC entry 4272 (class 0 OID 0)
-- Dependencies: 309
-- Name: project_workpackage_waste_waste_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_workpackage_waste_waste_id_seq OWNED BY public.project_workpackage_waste.waste_id;


--
-- TOC entry 307 (class 1259 OID 21741)
-- Name: project_workpackage_workpackage_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_workpackage_workpackage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_workpackage_workpackage_id_seq OWNER TO sqlpage;

--
-- TOC entry 4273 (class 0 OID 0)
-- Dependencies: 307
-- Name: project_workpackage_workpackage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_workpackage_workpackage_id_seq OWNED BY public.project_workpackage.workpackage_id;


--
-- TOC entry 322 (class 1259 OID 22064)
-- Name: project_worksequence; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_worksequence (
    worksequence_id integer NOT NULL,
    workpackage_id integer,
    room_id integer,
    worksequence_name text,
    worksequence_summary text,
    worksequence_todo text,
    worksequence_type text,
    worksequence_nb_participants integer DEFAULT 0,
    worksequence_start_date_scheduled date,
    worksequence_start_date_actual date,
    worksequence_start_hour_scheduled time without time zone,
    worksequence_start_hour_actual time without time zone,
    worksequence_end_hour_scheduled time without time zone,
    worksequence_end_hour_actual time without time zone,
    worksequence_duration_scheduled time without time zone,
    worksequence_duration_actual time without time zone,
    worksequence_completion_percentage integer,
    worksequence_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_worksequence OWNER TO sqlpage;

--
-- TOC entry 324 (class 1259 OID 22206)
-- Name: project_worksequence_participants; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.project_worksequence_participants (
    worksequence_participant_id integer NOT NULL,
    worksequence_id integer,
    prm1_id integer,
    prm2_sub_id integer,
    employee_id integer,
    prm3_id integer,
    worksequence_participant_role text DEFAULT 'participant'::text,
    worksequence_participant_type text,
    worksequence_participant_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.project_worksequence_participants OWNER TO sqlpage;

--
-- TOC entry 323 (class 1259 OID 22205)
-- Name: project_worksequence_participan_worksequence_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_worksequence_participan_worksequence_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_worksequence_participan_worksequence_participant_id_seq OWNER TO sqlpage;

--
-- TOC entry 4274 (class 0 OID 0)
-- Dependencies: 323
-- Name: project_worksequence_participan_worksequence_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_worksequence_participan_worksequence_participant_id_seq OWNED BY public.project_worksequence_participants.worksequence_participant_id;


--
-- TOC entry 321 (class 1259 OID 22063)
-- Name: project_worksequence_worksequence_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.project_worksequence_worksequence_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_worksequence_worksequence_id_seq OWNER TO sqlpage;

--
-- TOC entry 4275 (class 0 OID 0)
-- Dependencies: 321
-- Name: project_worksequence_worksequence_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.project_worksequence_worksequence_id_seq OWNED BY public.project_worksequence.worksequence_id;


--
-- TOC entry 268 (class 1259 OID 21392)
-- Name: regex; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.regex (
    regex_id integer NOT NULL,
    regex_name text,
    regex_value text,
    regex_description text,
    regex_comment text,
    regex_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.regex OWNER TO sqlpage;

--
-- TOC entry 267 (class 1259 OID 21391)
-- Name: regex_regex_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.regex_regex_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.regex_regex_id_seq OWNER TO sqlpage;

--
-- TOC entry 4276 (class 0 OID 0)
-- Dependencies: 267
-- Name: regex_regex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.regex_regex_id_seq OWNED BY public.regex.regex_id;


--
-- TOC entry 232 (class 1259 OID 21123)
-- Name: rss; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.rss (
    rss_id integer NOT NULL,
    rss_title text,
    rss_feed text,
    rss_link text,
    rss_description text,
    rss_status text,
    rss_category text,
    rss_item_title text,
    rss_item_link text,
    rss_item_description text,
    rss_item_table text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.rss OWNER TO sqlpage;

--
-- TOC entry 231 (class 1259 OID 21122)
-- Name: rss_rss_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.rss_rss_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rss_rss_id_seq OWNER TO sqlpage;

--
-- TOC entry 4277 (class 0 OID 0)
-- Dependencies: 231
-- Name: rss_rss_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.rss_rss_id_seq OWNED BY public.rss.rss_id;


--
-- TOC entry 316 (class 1259 OID 21892)
-- Name: sessions; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.sessions (
    session_id integer NOT NULL,
    username text,
    user_id integer,
    session_token text,
    created_at timestamp with time zone DEFAULT now(),
    logout_at timestamp with time zone DEFAULT now(),
    session_duration integer
);


ALTER TABLE public.sessions OWNER TO sqlpage;

--
-- TOC entry 315 (class 1259 OID 21891)
-- Name: sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sessions_session_id_seq OWNER TO sqlpage;

--
-- TOC entry 4278 (class 0 OID 0)
-- Dependencies: 315
-- Name: sessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.sessions_session_id_seq OWNED BY public.sessions.session_id;


--
-- TOC entry 256 (class 1259 OID 21312)
-- Name: users; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username text,
    password_hash text,
    user_gender text DEFAULT 'N'::text,
    user_first_name text,
    user_last_name text,
    user_email text,
    user_phone text,
    user_short_cv text,
    user_role text,
    user_lang text DEFAULT 'FR'::text,
    user_level text DEFAULT 'L0'::text,
    user_group text DEFAULT 'G0'::text,
    rgpd_validation boolean,
    user_selected boolean,
    user_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO sqlpage;

--
-- TOC entry 255 (class 1259 OID 21311)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO sqlpage;

--
-- TOC entry 4279 (class 0 OID 0)
-- Dependencies: 255
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 252 (class 1259 OID 21277)
-- Name: workdocs; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.workdocs (
    workdoc_id integer NOT NULL,
    workspace_id integer,
    message_id integer,
    workdoc_url text,
    workdoc_title text,
    workdoc_summary text,
    workdoc_author text,
    workdoc_category text,
    workdoc_format text,
    workdoc_status text,
    workdoc_version integer DEFAULT 0,
    workdoc_type text,
    workdoc_lang text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.workdocs OWNER TO sqlpage;

--
-- TOC entry 272 (class 1259 OID 21414)
-- Name: workdocs_cloud; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.workdocs_cloud (
    workdoc_cloud_id integer NOT NULL,
    workspace_id integer,
    message_id integer,
    workdoc_cloud_url text,
    workdoc_cloud_title text,
    workdoc_cloud_summary text,
    workdoc_cloud_author text,
    workdoc_cloud_category text,
    workdoc_cloud_format text,
    workdoc_cloud_status text,
    workdoc_cloud_type text,
    workdoc_cloud_lang text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.workdocs_cloud OWNER TO sqlpage;

--
-- TOC entry 271 (class 1259 OID 21413)
-- Name: workdocs_cloud_workdoc_cloud_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.workdocs_cloud_workdoc_cloud_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workdocs_cloud_workdoc_cloud_id_seq OWNER TO sqlpage;

--
-- TOC entry 4280 (class 0 OID 0)
-- Dependencies: 271
-- Name: workdocs_cloud_workdoc_cloud_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.workdocs_cloud_workdoc_cloud_id_seq OWNED BY public.workdocs_cloud.workdoc_cloud_id;


--
-- TOC entry 251 (class 1259 OID 21276)
-- Name: workdocs_workdoc_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.workdocs_workdoc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workdocs_workdoc_id_seq OWNER TO sqlpage;

--
-- TOC entry 4281 (class 0 OID 0)
-- Dependencies: 251
-- Name: workdocs_workdoc_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.workdocs_workdoc_id_seq OWNED BY public.workdocs.workdoc_id;


--
-- TOC entry 270 (class 1259 OID 21403)
-- Name: workmeeting_participants; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.workmeeting_participants (
    workmeeting_participant_id integer NOT NULL,
    workmeeting_id integer,
    workspace_id integer,
    user_id integer,
    workmeeting_participant_role text,
    workmeeting_participant_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.workmeeting_participants OWNER TO sqlpage;

--
-- TOC entry 269 (class 1259 OID 21402)
-- Name: workmeeting_participants_workmeeting_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.workmeeting_participants_workmeeting_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workmeeting_participants_workmeeting_participant_id_seq OWNER TO sqlpage;

--
-- TOC entry 4282 (class 0 OID 0)
-- Dependencies: 269
-- Name: workmeeting_participants_workmeeting_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.workmeeting_participants_workmeeting_participant_id_seq OWNED BY public.workmeeting_participants.workmeeting_participant_id;


--
-- TOC entry 278 (class 1259 OID 21486)
-- Name: workmeetings; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.workmeetings (
    workmeeting_id integer NOT NULL,
    workspace_id integer,
    workmeeting_title text,
    workmeeting_agenda text,
    workmeeting_visio text,
    workmeeting_visio_url text,
    workmeeting_visio_code text,
    workmeeting_date date,
    workmeeting_type text,
    space_id integer,
    workmeeting_participants_nb integer,
    workmeeting_alert text DEFAULT 'alert_end'::text,
    workmeeting_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    workmeeting_hour_start time without time zone,
    workmeeting_hour_end time without time zone,
    workmeeting_duration time without time zone
);


ALTER TABLE public.workmeetings OWNER TO sqlpage;

--
-- TOC entry 277 (class 1259 OID 21485)
-- Name: workmeetings_workmeeting_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.workmeetings_workmeeting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workmeetings_workmeeting_id_seq OWNER TO sqlpage;

--
-- TOC entry 4283 (class 0 OID 0)
-- Dependencies: 277
-- Name: workmeetings_workmeeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.workmeetings_workmeeting_id_seq OWNED BY public.workmeetings.workmeeting_id;


--
-- TOC entry 280 (class 1259 OID 21498)
-- Name: workspace_participants; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.workspace_participants (
    workspace_participant_id integer NOT NULL,
    workspace_id integer,
    user_id integer,
    workspace_participant_role text,
    workspace_partcipant_status text,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.workspace_participants OWNER TO sqlpage;

--
-- TOC entry 279 (class 1259 OID 21497)
-- Name: workspace_participants_workspace_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.workspace_participants_workspace_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workspace_participants_workspace_participant_id_seq OWNER TO sqlpage;

--
-- TOC entry 4284 (class 0 OID 0)
-- Dependencies: 279
-- Name: workspace_participants_workspace_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.workspace_participants_workspace_participant_id_seq OWNED BY public.workspace_participants.workspace_participant_id;


--
-- TOC entry 248 (class 1259 OID 21246)
-- Name: workspaces; Type: TABLE; Schema: public; Owner: sqlpage
--

CREATE TABLE public.workspaces (
    workspace_id integer NOT NULL,
    workspace_coordinator_id integer,
    workspace_title text,
    workspace_summary text,
    workspace_category text,
    workspace_status text,
    workspace_participants_nb integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.workspaces OWNER TO sqlpage;

--
-- TOC entry 247 (class 1259 OID 21245)
-- Name: workspaces_workspace_id_seq; Type: SEQUENCE; Schema: public; Owner: sqlpage
--

CREATE SEQUENCE public.workspaces_workspace_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.workspaces_workspace_id_seq OWNER TO sqlpage;

--
-- TOC entry 4285 (class 0 OID 0)
-- Dependencies: 247
-- Name: workspaces_workspace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sqlpage
--

ALTER SEQUENCE public.workspaces_workspace_id_seq OWNED BY public.workspaces.workspace_id;


--
-- TOC entry 3608 (class 2604 OID 22630)
-- Name: choices_categories choice_category_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.choices_categories ALTER COLUMN choice_category_id SET DEFAULT nextval('public.choices_categories_choice_category_id_seq'::regclass);


--
-- TOC entry 3611 (class 2604 OID 22631)
-- Name: choices_items choice_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.choices_items ALTER COLUMN choice_id SET DEFAULT nextval('public.choices_items_choice_id_seq'::regclass);


--
-- TOC entry 3626 (class 2604 OID 22632)
-- Name: event_participants participant_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.event_participants ALTER COLUMN participant_id SET DEFAULT nextval('public.event_participants_participant_id_seq'::regclass);


--
-- TOC entry 3619 (class 2604 OID 22633)
-- Name: events event_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.events ALTER COLUMN event_id SET DEFAULT nextval('public.events_event_id_seq'::regclass);


--
-- TOC entry 3614 (class 2604 OID 22634)
-- Name: faq_contacts contact_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.faq_contacts ALTER COLUMN contact_id SET DEFAULT nextval('public.faq_contacts_contact_id_seq'::regclass);


--
-- TOC entry 3706 (class 2604 OID 22635)
-- Name: faq_questions question_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.faq_questions ALTER COLUMN question_id SET DEFAULT nextval('public.faq_questions_question_id_seq'::regclass);


--
-- TOC entry 3635 (class 2604 OID 22636)
-- Name: forum_messages message_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.forum_messages ALTER COLUMN message_id SET DEFAULT nextval('public.forum_messages_message_id_seq'::regclass);


--
-- TOC entry 3630 (class 2604 OID 22637)
-- Name: forum_topics topic_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.forum_topics ALTER COLUMN topic_id SET DEFAULT nextval('public.forum_topics_topic_id_seq'::regclass);


--
-- TOC entry 3692 (class 2604 OID 22638)
-- Name: info_sections section_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.info_sections ALTER COLUMN section_id SET DEFAULT nextval('public.info_sections_section_id_seq'::regclass);


--
-- TOC entry 3643 (class 2604 OID 22640)
-- Name: news news_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.news ALTER COLUMN news_id SET DEFAULT nextval('public.news_news_id_seq'::regclass);


--
-- TOC entry 3586 (class 2604 OID 22641)
-- Name: orga orga_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga ALTER COLUMN orga_id SET DEFAULT nextval('public.orga_orga_id_seq'::regclass);


--
-- TOC entry 3590 (class 2604 OID 22642)
-- Name: orga_dept orga_dept_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept ALTER COLUMN orga_dept_id SET DEFAULT nextval('public.orga_dept_orga_dept_id_seq'::regclass);


--
-- TOC entry 3714 (class 2604 OID 22643)
-- Name: orga_dept_docs orga_doc_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_docs ALTER COLUMN orga_doc_id SET DEFAULT nextval('public.orga_docs_orga_doc_id_seq'::regclass);


--
-- TOC entry 3581 (class 2604 OID 22639)
-- Name: orga_dept_members member_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_members ALTER COLUMN member_id SET DEFAULT nextval('public.members_member_id_seq'::regclass);


--
-- TOC entry 3651 (class 2604 OID 22644)
-- Name: orga_dept_partners orga_partner_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_partners ALTER COLUMN orga_partner_id SET DEFAULT nextval('public.orga_partners_orga_partner_id_seq'::regclass);


--
-- TOC entry 3593 (class 2604 OID 22645)
-- Name: place place_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place ALTER COLUMN place_id SET DEFAULT nextval('public.place_place_id_seq'::regclass);


--
-- TOC entry 3602 (class 2604 OID 22646)
-- Name: place_spaces space_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place_spaces ALTER COLUMN space_id SET DEFAULT nextval('public.place_spaces_space_id_seq'::regclass);


--
-- TOC entry 3711 (class 2604 OID 22647)
-- Name: place_spaces_pictures space_picture_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place_spaces_pictures ALTER COLUMN space_picture_id SET DEFAULT nextval('public.place_spaces_pictures_space_picture_id_seq'::regclass);


--
-- TOC entry 3666 (class 2604 OID 22648)
-- Name: prm1 prm1_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm1 ALTER COLUMN prm1_id SET DEFAULT nextval('public.prm1_prm1_id_seq'::regclass);


--
-- TOC entry 3671 (class 2604 OID 22649)
-- Name: prm1_doc prm1_doc_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm1_doc ALTER COLUMN prm1_doc_id SET DEFAULT nextval('public.prm1_doc_prm1_doc_id_seq'::regclass);


--
-- TOC entry 3661 (class 2604 OID 22650)
-- Name: prm2 prm2_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2 ALTER COLUMN prm2_id SET DEFAULT nextval('public.prm2_prm2_id_seq'::regclass);


--
-- TOC entry 3695 (class 2604 OID 22651)
-- Name: prm2_sub prm2_sub_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub ALTER COLUMN prm2_sub_id SET DEFAULT nextval('public.prm2_sub_prm2_sub_id_seq'::regclass);


--
-- TOC entry 3787 (class 2604 OID 22652)
-- Name: prm2_sub_docs prm2_sub_doc_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub_docs ALTER COLUMN prm2_sub_doc_id SET DEFAULT nextval('public.prm2_sub_docs_prm2_sub_doc_id_seq'::regclass);


--
-- TOC entry 3791 (class 2604 OID 22653)
-- Name: prm2_sub_employees employee_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub_employees ALTER COLUMN employee_id SET DEFAULT nextval('public.prm2_sub_employees_employee_id_seq'::regclass);


--
-- TOC entry 3675 (class 2604 OID 22654)
-- Name: prm3 prm3_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm3 ALTER COLUMN prm3_id SET DEFAULT nextval('public.prm3_prm3_id_seq'::regclass);


--
-- TOC entry 3797 (class 2604 OID 22655)
-- Name: prm3_docs prm3_doc_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm3_docs ALTER COLUMN prm3_doc_id SET DEFAULT nextval('public.prm3_docs_prm3_doc_id_seq'::regclass);


--
-- TOC entry 3679 (class 2604 OID 22656)
-- Name: prm3_participants prm3_participant_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm3_participants ALTER COLUMN prm3_participant_id SET DEFAULT nextval('public.prm3_participants_prm3_participant_id_seq'::regclass);


--
-- TOC entry 3596 (class 2604 OID 22657)
-- Name: process process_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.process ALTER COLUMN process_id SET DEFAULT nextval('public.process_process_id_seq'::regclass);


--
-- TOC entry 3599 (class 2604 OID 22658)
-- Name: process_steps process_step_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.process_steps ALTER COLUMN process_step_id SET DEFAULT nextval('public.process_steps_process_step_id_seq'::regclass);


--
-- TOC entry 3719 (class 2604 OID 22659)
-- Name: project project_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project ALTER COLUMN project_id SET DEFAULT nextval('public.project_project_id_seq'::regclass);


--
-- TOC entry 3737 (class 2604 OID 22660)
-- Name: project_building building_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building ALTER COLUMN building_id SET DEFAULT nextval('public.project_building_building_id_seq'::regclass);


--
-- TOC entry 3740 (class 2604 OID 22661)
-- Name: project_building_rooms room_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building_rooms ALTER COLUMN room_id SET DEFAULT nextval('public.project_building_rooms_room_id_seq'::regclass);


--
-- TOC entry 3743 (class 2604 OID 22662)
-- Name: project_building_rooms_pictures room_picture_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building_rooms_pictures ALTER COLUMN room_picture_id SET DEFAULT nextval('public.project_building_rooms_pictures_room_picture_id_seq'::regclass);


--
-- TOC entry 3768 (class 2604 OID 22663)
-- Name: project_docs project_doc_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_docs ALTER COLUMN project_doc_id SET DEFAULT nextval('public.project_docs_project_doc_id_seq'::regclass);


--
-- TOC entry 3772 (class 2604 OID 22753)
-- Name: project_docs project_forum_message_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_docs ALTER COLUMN project_forum_message_id SET DEFAULT nextval('public.project_docs_project_forum_message_id_seq'::regclass);


--
-- TOC entry 3733 (class 2604 OID 22664)
-- Name: project_forum_messages project_forum_message_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_forum_messages ALTER COLUMN project_forum_message_id SET DEFAULT nextval('public.project_forum_messages_project_forum_message_id_seq'::regclass);


--
-- TOC entry 3728 (class 2604 OID 22665)
-- Name: project_forum_topics project_forum_topic_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_forum_topics ALTER COLUMN project_forum_topic_id SET DEFAULT nextval('public.project_forum_topics_project_forum_topic_id_seq'::regclass);


--
-- TOC entry 3774 (class 2604 OID 22666)
-- Name: project_meeting project_meeting_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting ALTER COLUMN project_meeting_id SET DEFAULT nextval('public.project_meeting_project_meeting_id_seq'::regclass);


--
-- TOC entry 3725 (class 2604 OID 22667)
-- Name: project_meeting_participants project_meeting_participant_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting_participants ALTER COLUMN project_meeting_participant_id SET DEFAULT nextval('public.project_meeting_participants_project_meeting_participant_id_seq'::regclass);


--
-- TOC entry 3722 (class 2604 OID 22668)
-- Name: project_meeting_places project_meeting_place_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting_places ALTER COLUMN project_meeting_place_id SET DEFAULT nextval('public.project_meeting_places_project_meeting_place_id_seq'::regclass);


--
-- TOC entry 3749 (class 2604 OID 22669)
-- Name: project_products product_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_products ALTER COLUMN product_id SET DEFAULT nextval('public.project_products_product_id_seq'::regclass);


--
-- TOC entry 3746 (class 2604 OID 22670)
-- Name: project_products_categories product_category_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_products_categories ALTER COLUMN product_category_id SET DEFAULT nextval('public.project_products_categories_product_category_id_seq'::regclass);


--
-- TOC entry 3752 (class 2604 OID 22671)
-- Name: project_workpackage workpackage_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage ALTER COLUMN workpackage_id SET DEFAULT nextval('public.project_workpackage_workpackage_id_seq'::regclass);


--
-- TOC entry 3801 (class 2604 OID 22672)
-- Name: project_workpackage_expenses expense_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_expenses ALTER COLUMN expense_id SET DEFAULT nextval('public.project_workpackage_expenses_expense_id_seq'::regclass);


--
-- TOC entry 3758 (class 2604 OID 22673)
-- Name: project_workpackage_materials material_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_materials ALTER COLUMN material_id SET DEFAULT nextval('public.project_workpackage_materials_material_id_seq'::regclass);


--
-- TOC entry 3761 (class 2604 OID 22674)
-- Name: project_workpackage_participants workpackage_participant_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_participants ALTER COLUMN workpackage_participant_id SET DEFAULT nextval('public.project_workpackage_participants_workpackage_participant_id_seq'::regclass);


--
-- TOC entry 3755 (class 2604 OID 22675)
-- Name: project_workpackage_waste waste_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_waste ALTER COLUMN waste_id SET DEFAULT nextval('public.project_workpackage_waste_waste_id_seq'::regclass);


--
-- TOC entry 3779 (class 2604 OID 22676)
-- Name: project_worksequence worksequence_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_worksequence ALTER COLUMN worksequence_id SET DEFAULT nextval('public.project_worksequence_worksequence_id_seq'::regclass);


--
-- TOC entry 3783 (class 2604 OID 22677)
-- Name: project_worksequence_participants worksequence_participant_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_worksequence_participants ALTER COLUMN worksequence_participant_id SET DEFAULT nextval('public.project_worksequence_participan_worksequence_participant_id_seq'::regclass);


--
-- TOC entry 3683 (class 2604 OID 22678)
-- Name: regex regex_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.regex ALTER COLUMN regex_id SET DEFAULT nextval('public.regex_regex_id_seq'::regclass);


--
-- TOC entry 3605 (class 2604 OID 22679)
-- Name: rss rss_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.rss ALTER COLUMN rss_id SET DEFAULT nextval('public.rss_rss_id_seq'::regclass);


--
-- TOC entry 3765 (class 2604 OID 22680)
-- Name: sessions session_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.sessions ALTER COLUMN session_id SET DEFAULT nextval('public.sessions_session_id_seq'::regclass);


--
-- TOC entry 3654 (class 2604 OID 22681)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 3647 (class 2604 OID 22682)
-- Name: workdocs workdoc_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workdocs ALTER COLUMN workdoc_id SET DEFAULT nextval('public.workdocs_workdoc_id_seq'::regclass);


--
-- TOC entry 3689 (class 2604 OID 22683)
-- Name: workdocs_cloud workdoc_cloud_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workdocs_cloud ALTER COLUMN workdoc_cloud_id SET DEFAULT nextval('public.workdocs_cloud_workdoc_cloud_id_seq'::regclass);


--
-- TOC entry 3686 (class 2604 OID 22684)
-- Name: workmeeting_participants workmeeting_participant_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workmeeting_participants ALTER COLUMN workmeeting_participant_id SET DEFAULT nextval('public.workmeeting_participants_workmeeting_participant_id_seq'::regclass);


--
-- TOC entry 3699 (class 2604 OID 22685)
-- Name: workmeetings workmeeting_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workmeetings ALTER COLUMN workmeeting_id SET DEFAULT nextval('public.workmeetings_workmeeting_id_seq'::regclass);


--
-- TOC entry 3703 (class 2604 OID 22686)
-- Name: workspace_participants workspace_participant_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workspace_participants ALTER COLUMN workspace_participant_id SET DEFAULT nextval('public.workspace_participants_workspace_participant_id_seq'::regclass);


--
-- TOC entry 3639 (class 2604 OID 22687)
-- Name: workspaces workspace_id; Type: DEFAULT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workspaces ALTER COLUMN workspace_id SET DEFAULT nextval('public.workspaces_workspace_id_seq'::regclass);


--
-- TOC entry 4121 (class 0 OID 21134)
-- Dependencies: 234
-- Data for Name: choices_categories; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.choices_categories (choice_category_id, choice_category_name, choice_category_status, choice_category_summary, created_at, updated_at) FROM stdin;
1	status	active	\N	2025-02-14 15:42:15+01	2025-02-14 15:42:15+01
2	gender	active	\N	2025-02-15 10:20:05+01	2025-02-15 10:20:05+01
3	lang	active	\N	2025-02-15 10:21:45+01	2025-02-15 10:21:45+01
4	doc_format	active		2025-02-15 10:53:20+01	2025-02-15 10:54:12+01
5	img_format	active	\N	2025-02-15 10:56:01+01	2025-02-15 10:56:01+01
7	event	active	\N	2025-02-15 13:32:24+01	2025-02-15 13:32:24+01
8	question_category	active	\N	2025-02-15 13:45:52+01	2025-02-15 13:45:52+01
9	member_category	active	\N	2025-02-15 13:48:54+01	2025-02-15 13:48:54+01
10	news_category	active	article post	2025-02-15 13:55:44+01	2025-02-15 13:59:00+01
11	legal_status	active	sa sarl  	2025-02-15 14:03:25+01	2025-02-15 14:03:25+01
12	doc_category	active	report bilan	2025-02-15 14:11:19+01	2025-02-15 14:11:19+01
13	doc_type	active	report leaflet manual	2025-02-15 14:14:38+01	2025-02-15 14:14:38+01
14	partner_type	active	partenaire réseau social	2025-02-15 14:23:36+01	2025-02-15 14:23:36+01
15	partner_category	active	or argent	2025-02-15 14:24:53+01	2025-02-15 14:24:53+01
16	place_type	active	siège bureaux salle de réunion	2025-02-16 16:09:14+01	2025-02-16 16:09:14+01
17	space_type	active	visio training	2025-02-16 16:14:43+01	2025-02-16 16:14:43+01
18	space_level	active	siège annexe	2025-02-16 16:19:25+01	2025-02-16 16:19:25+01
19	topic_category	active	technique general...	2025-02-16 16:27:14+01	2025-02-16 16:27:14+01
20	debug_category	active	bug 	2025-02-16 16:35:21+01	2025-02-16 16:35:21+01
21	meeting_category	active	conference concert...	2025-02-17 09:04:34+01	2025-02-17 09:15:49+01
22	workspace_category	active		2025-02-17 09:33:12+01	2025-02-17 09:33:12+01
23	prm1_category	active		2025-02-17 09:47:28+01	2025-02-17 09:47:28+01
24	employee_function	active		2025-02-17 10:17:43+01	2025-02-17 10:17:43+01
25	employee_category	active		2025-02-17 10:22:01+01	2025-02-17 10:22:01+01
26	prm3_type	active		2025-02-17 10:33:05+01	2025-02-17 10:33:05+01
27	prm3_category	active		2025-02-17 10:37:12+01	2025-02-17 10:37:12+01
28	prm3_role	active		2025-02-17 12:30:02+01	2025-02-17 12:30:02+01
29	user_role	active	admin supervisor	2025-02-17 13:10:45+01	2025-02-17 13:10:45+01
30	user_group	active		2025-02-17 13:12:37+01	2025-02-17 13:12:37+01
31	user_level	active		2025-02-17 13:14:15+01	2025-02-17 13:14:15+01
32	workmeeting_alert	active		2025-02-17 18:16:53+01	2025-02-17 18:16:53+01
33	project_category	active		2025-02-18 15:40:28+01	2025-02-18 15:40:28+01
34	building_type	active		2025-02-18 17:54:12+01	2025-02-18 17:54:12+01
36	project_role	active		2025-02-19 14:17:25+01	2025-02-19 14:17:25+01
37	room_type	active		2025-02-19 17:28:52+01	2025-02-19 17:28:52+01
38	workpackage_type	active		2025-02-20 13:29:15+01	2025-02-20 13:29:15+01
39	worksequence_role	active		2025-02-21 08:42:44+01	2025-02-21 08:42:44+01
40	worksequence_type	active		2025-02-21 08:50:18+01	2025-02-21 08:50:18+01
41	doc_cloud_format	active		2025-02-27 09:18:56+01	2025-02-27 09:18:56+01
42	meeting_participant_role	active	meeting_participant_type	2025-02-27 16:39:39+01	2025-02-27 16:42:14+01
43	list_hours	active		2025-03-03 09:13:07+01	2025-03-23 17:08:15+01
44	workspace_category	active		2025-03-07 11:07:57+01	2025-03-07 11:07:57+01
45	material_category	active		2025-03-16 15:50:25+01	2025-03-16 15:50:25+01
46	material_unit	active		2025-03-16 15:51:01+01	2025-03-16 15:51:01+01
47	work_mode	active	autonome mixte...	2025-03-17 15:40:27+01	2025-03-17 15:50:50+01
48	expense_category	active		2025-03-17 19:49:34+01	2025-03-17 19:52:07+01
49	material_origin	active	neuf récup réemploi	2025-03-21 08:15:50+01	2025-03-21 08:15:50+01
50	tax_rate	active		2025-03-21 08:22:04+01	2025-03-21 08:22:04+01
51	expense_unit	active		2025-03-29 14:34:02+01	2025-03-29 14:34:02+01
35	building_accessibility	active	acces	2025-02-18 17:54:32+01	2025-04-15 11:59:42.972752+02
55	legal_info	active		2025-04-15 16:10:42.547584+02	2025-04-15 16:10:42.547584+02
56	user_role	active		2025-04-16 12:18:54.00448+02	2025-04-16 12:18:54.00448+02
57	project_meeting_place_type	active		2025-04-17 09:04:53.691408+02	2025-04-17 09:04:53.691408+02
6	edition_status	active	\N	2025-02-15 13:28:51+01	2025-02-15 13:28:51+01
58	quality_level	active	état des pièces	2025-06-10 11:39:03.048828+02	2025-06-10 11:39:03.048828+02
\.


--
-- TOC entry 4123 (class 0 OID 21145)
-- Dependencies: 236
-- Data for Name: choices_items; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.choices_items (choice_id, choice_category_id, choice_label, choice_value, choice_status, created_at, updated_at) FROM stdin;
4	1	active	active	active	2025-02-14 14:55:19+01	2025-02-15 10:49:43+01
5	1	inactive	inactive	active	2025-02-14 15:08:29+01	2025-02-15 10:49:36+01
6	2	Homme	M	active	2025-02-15 10:26:56+01	2025-02-15 10:49:30+01
7	2	Femme	F	active	2025-02-15 10:27:31+01	2025-02-15 10:49:12+01
8	2	Unknown	N	active	2025-02-15 10:37:15+01	2025-02-15 10:49:21+01
9	1	archive	archived	active	2025-02-15 10:50:15+01	2025-02-15 10:50:15+01
10	3	français	FR	active	2025-02-15 10:50:38+01	2025-02-15 10:50:38+01
11	3	english	EN	active	2025-02-15 10:50:58+01	2025-02-15 10:50:58+01
12	3	deutsch	DE	active	2025-02-15 10:51:15+01	2025-02-15 10:51:15+01
13	3	Español	ES	active	2025-02-15 10:52:29+01	2025-02-15 10:52:29+01
14	4	pdf	pdf	active	2025-02-15 10:53:41+01	2025-02-15 10:53:41+01
15	4	doc	doc	active	2025-02-15 10:53:56+01	2025-02-15 10:53:56+01
16	4	docx	docx	active	2025-02-15 10:54:33+01	2025-02-15 10:54:33+01
17	4	jpeg	jpeg	active	2025-02-15 10:55:21+01	2025-02-15 10:55:21+01
18	5	jpeg	jpeg	active	2025-02-15 10:56:24+01	2025-02-15 10:56:24+01
19	5	png	png	active	2025-02-15 10:56:36+01	2025-02-15 10:56:36+01
20	5	svg	svg	active	2025-02-15 10:56:55+01	2025-02-15 10:56:55+01
22	6	brouillon	draft	active	2025-02-15 13:29:26+01	2025-02-15 13:29:26+01
24	7	réunion	meeting	active	2025-02-15 13:32:48+01	2025-02-15 13:32:48+01
25	7	conférence	conference	active	2025-02-15 13:33:07+01	2025-02-15 13:33:07+01
26	7	concert	concert	active	2025-02-15 13:33:20+01	2025-02-15 13:33:20+01
27	7	repas	festive_meal	active	2025-02-15 13:34:29+01	2025-02-15 13:34:29+01
28	7	bal	ball	active	2025-02-15 13:35:03+01	2025-02-15 13:35:03+01
29	7	rencontre sportive	sports_meeting	active	2025-02-15 13:36:14+01	2025-02-15 13:36:14+01
30	7	autre	N	active	2025-02-15 13:36:26+01	2025-02-15 13:36:26+01
31	8	general	general	active	2025-02-15 13:46:08+01	2025-02-15 13:46:08+01
32	8	technique	technical	active	2025-02-15 13:46:23+01	2025-02-15 13:46:23+01
33	8	autre	N	active	2025-02-15 13:46:49+01	2025-02-15 13:46:49+01
34	9	gouvernance	govern	active	2025-02-15 13:49:19+01	2025-02-15 13:49:19+01
35	9	salarié ou membre actif	team	active	2025-02-15 13:49:52+01	2025-02-15 13:49:52+01
36	9	simple salarié ou adhérent	member	active	2025-02-15 13:50:22+01	2025-02-15 13:50:22+01
37	9	autre	N	active	2025-02-15 13:50:32+01	2025-02-15 13:50:32+01
38	10	annonce	annoncement	active	2025-02-15 13:56:17+01	2025-02-15 13:56:17+01
39	10	article	article	active	2025-02-15 13:56:38+01	2025-02-15 13:56:38+01
40	10	info	info	active	2025-02-15 13:56:53+01	2025-02-15 13:56:53+01
41	10	autre	N	active	2025-02-15 13:57:10+01	2025-02-15 13:57:10+01
42	10	éditorial	edito	active	2025-02-15 13:57:57+01	2025-02-15 13:57:57+01
43	11	asso 1901	NGO	active	2025-02-15 14:03:57+01	2025-02-15 14:03:57+01
44	11	agence gouvernementale	GO	active	2025-02-15 14:04:40+01	2025-02-15 14:04:40+01
45	11	collectivité locale	EPCI	active	2025-02-15 14:05:00+01	2025-02-15 14:05:00+01
46	11	entreprise individuelle	EI	active	2025-02-15 14:05:26+01	2025-02-15 14:05:26+01
47	11	Sarl	SARL	active	2025-02-15 14:05:46+01	2025-02-15 14:05:46+01
48	11	SA	SA	active	2025-02-15 14:06:00+01	2025-02-15 14:06:00+01
49	11	SAS	SAS	active	2025-02-15 14:06:11+01	2025-02-15 14:06:11+01
50	11	SCI	SCI	active	2025-02-15 14:06:30+01	2025-02-15 14:06:30+01
51	11	SCIC	SCIC	active	2025-02-15 14:06:48+01	2025-02-15 14:06:48+01
52	11	autre	N	active	2025-02-15 14:06:59+01	2025-02-15 14:06:59+01
53	12	rapport annuel d'activité	annual_report	active	2025-02-15 14:11:49+01	2025-02-15 14:11:49+01
54	12	bilan annuel	annual_results	active	2025-02-15 14:12:32+01	2025-02-15 14:12:32+01
55	12	plaquette d'info	leaflet	active	2025-02-15 14:13:09+01	2025-02-15 14:13:09+01
56	12	autre	N	active	2025-02-15 14:13:21+01	2025-02-15 14:13:21+01
57	13	manuel	manual	active	2025-02-15 14:15:01+01	2025-02-15 14:15:01+01
58	13	plaquette	leaflet	active	2025-02-15 14:15:33+01	2025-02-15 14:15:33+01
59	13	affiche	poster	active	2025-02-15 14:15:46+01	2025-02-15 14:15:46+01
60	13	autre	N	active	2025-02-15 14:16:24+01	2025-02-15 14:16:24+01
61	12	devis	quote	active	2025-02-15 14:16:44+01	2025-02-15 14:17:24+01
62	12	facture	invoice	active	2025-02-15 14:17:08+01	2025-02-15 14:17:08+01
63	13	carte	map	active	2025-02-15 14:17:44+01	2025-02-15 14:17:44+01
64	14	partenaire	partner	active	2025-02-15 14:23:52+01	2025-02-15 14:23:52+01
65	14	réseau social	social_network	active	2025-02-15 14:24:26+01	2025-02-15 14:24:26+01
66	15	or	gold	active	2025-02-15 14:25:09+01	2025-02-15 14:25:09+01
67	15	argent	silver	active	2025-02-15 14:25:25+01	2025-02-15 14:25:25+01
68	15	bronze	bronze	active	2025-02-15 14:25:38+01	2025-02-15 14:25:38+01
69	16	siège	headquarters	active	2025-02-16 16:09:47+01	2025-02-16 16:09:47+01
70	16	salle des fêtes	ballroom	active	2025-02-16 16:10:17+01	2025-02-16 16:10:17+01
71	16	salle de réunion	meeting_room	active	2025-02-16 16:10:42+01	2025-02-16 16:10:42+01
72	13	stade	stadium	active	2025-02-16 16:11:05+01	2025-02-16 16:11:05+01
73	16	autre	N	active	2025-02-16 16:11:17+01	2025-02-16 16:11:17+01
74	16	groupe scolaire	school	active	2025-02-16 16:12:02+01	2025-02-16 16:12:02+01
75	17	salle visio	visio	active	2025-02-16 16:15:01+01	2025-02-16 16:15:01+01
76	17	salle de formation	training_room	active	2025-02-16 16:15:25+01	2025-02-16 16:15:25+01
77	17	amphithéâtre	amphitheatre	active	2025-02-16 16:16:22+01	2025-02-16 16:16:22+01
78	17	auditorium	auditorium	active	2025-02-16 16:16:40+01	2025-02-16 16:16:40+01
79	17	autre	N	active	2025-02-16 16:16:55+01	2025-02-16 16:16:55+01
80	17	terrain de sport	sportfield	active	2025-02-16 16:17:20+01	2025-02-16 16:17:20+01
81	18	siège	main	active	2025-02-16 16:19:46+01	2025-02-16 16:19:46+01
82	18	salle	room	active	2025-02-16 16:20:08+01	2025-02-16 16:20:08+01
83	18	annexe	annex	active	2025-02-16 16:20:38+01	2025-02-16 16:20:38+01
84	18	autre	N	active	2025-02-16 16:20:50+01	2025-02-16 16:20:50+01
85	6	closed	closed	active	2025-02-16 16:24:39+01	2025-02-16 16:24:39+01
86	19	general	general	active	2025-02-16 16:27:41+01	2025-02-16 16:27:41+01
87	19	projet	project	active	2025-02-16 16:27:59+01	2025-02-16 16:27:59+01
88	19	autre	N	active	2025-02-16 16:28:11+01	2025-02-16 16:28:11+01
89	19	relation aux bénéficiaires	beneficiaries	active	2025-02-16 16:28:48+01	2025-02-16 16:28:48+01
90	20	bug	bug	active	2025-02-16 16:35:34+01	2025-02-16 16:35:34+01
91	20	amélioration	enhacement	active	2025-02-16 16:36:43+01	2025-02-16 16:36:43+01
92	20	autre	N	active	2025-02-16 16:36:54+01	2025-02-16 16:36:54+01
93	21	concert	concert	active	2025-02-17 09:04:53+01	2025-02-17 09:04:53+01
94	21	conference	conference	active	2025-02-17 09:05:19+01	2025-02-17 09:05:19+01
95	21	AG	General_assembly	active	2025-02-17 09:16:23+01	2025-02-17 09:16:23+01
96	21	formation	courses	active	2025-02-17 09:17:46+01	2025-02-17 09:17:46+01
97	21	conseil d'administration	CA	active	2025-02-17 09:18:24+01	2025-02-17 09:18:24+01
98	21	mooc	mooc	active	2025-02-17 09:18:42+01	2025-02-17 09:18:42+01
99	21	autre	N	active	2025-02-17 09:19:21+01	2025-02-17 09:19:21+01
100	22	groupe projet	project_team	active	2025-02-17 09:34:49+01	2025-02-17 09:34:49+01
101	22	espace utilisateurs	users_group	active	2025-02-17 09:35:26+01	2025-02-17 09:35:26+01
102	22	réflexion stratégie	strategy_group	active	2025-02-17 09:36:17+01	2025-02-17 09:36:17+01
103	22	autre	N	active	2025-02-17 09:36:29+01	2025-02-17 09:36:29+01
104	23	prm1_cat1	prm1_cat1	active	2025-02-17 09:47:55+01	2025-02-17 09:47:55+01
105	23	prm1_cat2	prm1_cat2	active	2025-02-17 09:48:09+01	2025-02-17 09:48:09+01
106	23	prm1_cat3	prm1_cat3	active	2025-02-17 09:48:25+01	2025-02-17 09:48:25+01
23	6	autre	N	active	2025-02-15 13:29:44+01	2025-02-15 13:29:44+01
107	24	directeur	general_manager	active	2025-02-17 10:18:20+01	2025-02-17 10:18:20+01
108	24	représentant légal	legal_representative	active	2025-02-17 10:18:46+01	2025-02-17 10:18:46+01
109	24	responsable financier	financial_manager	active	2025-02-17 10:19:12+01	2025-02-17 10:19:12+01
110	24	responsable technique	technical_manager	active	2025-02-17 10:19:34+01	2025-02-17 10:19:34+01
111	24	responsable formation	training_manager	active	2025-02-17 10:20:03+01	2025-02-17 10:20:03+01
112	24	responsable administratif	office_manager	active	2025-02-17 10:20:29+01	2025-02-17 10:20:29+01
113	24	salarié	employee	active	2025-02-17 10:20:48+01	2025-02-17 10:20:48+01
114	24	autre	N	active	2025-02-17 10:20:59+01	2025-02-17 10:20:59+01
115	25	pro_cat1	pro_cat1	active	2025-02-17 10:22:27+01	2025-02-17 10:22:27+01
116	25	pro_cat2	pro_cat2	active	2025-02-17 10:22:41+01	2025-02-17 10:22:41+01
117	25	pro_cat3	pro_cat3	active	2025-02-17 10:22:54+01	2025-02-17 10:22:54+01
118	26	prm1-prm1	prm1-prm1	active	2025-02-17 10:33:30+01	2025-02-17 10:33:30+01
119	26	prm2-prm2	prm2-prm2	active	2025-02-17 10:33:51+01	2025-02-17 10:33:51+01
120	26	prm1-prm2	prm1-prm2	active	2025-02-17 10:34:12+01	2025-02-17 10:34:12+01
121	26	employees	employees	active	2025-02-17 10:34:29+01	2025-02-17 10:34:29+01
122	26	prm1-employees	prm1-employees	active	2025-02-17 10:34:49+01	2025-02-17 10:34:49+01
123	27	couple	couple	active	2025-02-17 10:37:29+01	2025-02-17 10:37:29+01
124	27	famille	family	active	2025-02-17 10:37:48+01	2025-02-17 10:37:48+01
125	27	coloc	coloc	active	2025-02-17 10:38:01+01	2025-02-17 10:38:01+01
126	27	copropriété	co-ownership	active	2025-02-17 10:38:49+01	2025-02-17 10:38:49+01
127	27	entraide	self-help_group	active	2025-02-17 10:39:43+01	2025-02-17 10:39:43+01
128	27	consortium	consortium	active	2025-02-17 10:40:09+01	2025-02-17 10:40:09+01
129	27	equipe pro	pro_team	active	2025-02-17 10:40:29+01	2025-02-17 10:40:29+01
130	27	equipe non pro	nopro_team	active	2025-02-17 10:40:53+01	2025-02-17 10:40:53+01
131	27	equipe pro no-pro	mixed_team	active	2025-02-17 10:41:14+01	2025-02-17 10:41:14+01
132	27	autre	N	active	2025-02-17 10:41:25+01	2025-02-17 10:41:25+01
133	28	pilote	leader	active	2025-02-17 12:30:28+01	2025-02-17 12:30:28+01
134	28	coordinateur	coordinator	active	2025-02-17 12:30:43+01	2025-02-17 12:30:43+01
135	28	animateur technique	technical_assistant	active	2025-02-17 12:31:21+01	2025-02-17 12:31:21+01
136	28	formateur	coach	active	2025-02-17 12:31:34+01	2025-02-17 12:31:34+01
137	28	conseiller juridique	legal_advisor	active	2025-02-17 12:32:08+01	2025-02-17 12:32:08+01
138	28	controleur	controler	active	2025-02-17 12:32:26+01	2025-02-17 12:32:26+01
139	28	participant	participant	active	2025-02-17 12:32:42+01	2025-02-17 12:32:42+01
140	28	autre	N	active	2025-02-17 12:32:57+01	2025-02-17 12:32:57+01
141	29	admin	admin	active	2025-02-17 13:10:59+01	2025-02-17 13:10:59+01
142	29	superviseur	supervisor	active	2025-02-17 13:11:21+01	2025-02-17 13:11:21+01
143	29	editeur	editor	active	2025-02-17 13:11:38+01	2025-02-17 13:11:38+01
144	29	viewer	viewer	active	2025-02-17 13:11:54+01	2025-02-17 13:11:54+01
145	30	groupe 0	G0	active	2025-02-17 13:13:01+01	2025-02-17 13:13:01+01
146	30	groupe 1	G1	active	2025-02-17 13:13:20+01	2025-02-17 13:13:20+01
147	30	groupe 2	G2	active	2025-02-17 13:13:33+01	2025-02-17 13:13:33+01
148	30	groupe 3	G3	active	2025-02-17 13:13:47+01	2025-02-17 13:13:47+01
149	30	groupe 4	G4	active	2025-02-17 13:14:01+01	2025-02-17 13:14:01+01
150	31	niveau 0	L0	active	2025-02-17 13:14:47+01	2025-02-17 13:14:47+01
151	31	niveau 1	l1	active	2025-02-17 13:15:03+01	2025-02-17 13:15:03+01
152	31	niveau 2	L2	active	2025-02-17 13:15:17+01	2025-02-17 13:15:17+01
153	31	niveau 3	L3	active	2025-02-17 13:15:31+01	2025-02-17 13:17:39+01
154	31	niveau 4	L4	active	2025-02-17 13:15:47+01	2025-02-17 13:15:47+01
155	32	fin d'alerte	alert_end	active	2025-02-17 18:17:43+01	2025-02-17 18:17:43+01
156	32	réunion confirmée	confirmed	active	2025-02-17 18:18:09+01	2025-02-17 18:18:09+01
157	32	changement de date	change_date	active	2025-02-17 18:18:44+01	2025-02-17 18:18:44+01
158	32	changemet horaire	change_hour	active	2025-02-17 18:19:03+01	2025-02-17 18:19:03+01
159	32	chagement_lieu	change_place	active	2025-02-17 18:19:21+01	2025-02-17 18:19:21+01
160	32	changement lien visio	change_url	active	2025-02-17 18:19:45+01	2025-02-17 18:19:45+01
161	32	change OdJ	change_agenda	active	2025-02-17 18:20:06+01	2025-02-17 18:20:06+01
162	32	important	important	active	2025-02-17 18:20:37+01	2025-02-17 18:20:37+01
163	33	rénovation maison individuelle	house_renovation	active	2025-02-18 15:41:56+01	2025-02-18 15:43:32+01
164	33	création maison individuelle	house_creation	active	2025-02-18 15:42:20+01	2025-02-18 15:44:23+01
165	33	rénovation batiment	building_renovation	active	2025-02-18 15:45:07+01	2025-02-18 15:45:07+01
166	33	création batiment	building_creation	active	2025-02-18 15:45:44+01	2025-02-18 15:45:44+01
167	33	restauration petit patrimoine	small_heritage_restoration	active	2025-02-18 15:46:44+01	2025-02-18 15:46:44+01
168	33	autre	N	active	2025-02-18 15:46:55+01	2025-02-18 15:46:55+01
169	35	accessible PMR	accessible	active	2025-02-18 17:55:46+01	2025-02-18 17:55:46+01
170	35	non accessible	no_accessible	active	2025-02-18 17:56:09+01	2025-02-18 17:56:09+01
173	34	maison individuelle	house	active	2025-02-18 17:57:36+01	2025-02-18 17:57:36+01
174	34	bâtiment	building	active	2025-02-18 17:57:55+01	2025-02-18 17:57:55+01
175	34	petit patrimoine	small_heritage	active	2025-02-18 17:58:20+01	2025-02-18 18:00:21+01
176	34	atelier	workshop	active	2025-02-18 17:58:41+01	2025-02-18 17:58:41+01
177	34	usine	factory	active	2025-02-18 17:58:56+01	2025-02-18 17:58:56+01
178	34	commerce	trade_buidling	active	2025-02-18 17:59:46+01	2025-02-18 17:59:46+01
179	34	non précisé	N	active	2025-02-18 18:00:01+01	2025-02-18 18:00:01+01
180	36	pilote	leader	active	2025-02-19 14:17:46+01	2025-02-19 14:17:46+01
181	36	maître d'ouvrage	project_owner	active	2025-02-19 14:18:36+01	2025-02-19 14:18:36+01
182	36	maître d'oeuvre	project_manager	active	2025-02-19 14:19:10+01	2025-02-19 14:19:10+01
183	36	entreprise bâtiment	building_contractor	active	2025-02-19 14:20:15+01	2025-02-19 14:20:15+01
184	36	pro bâtiment	builder	active	2025-02-19 14:20:53+01	2025-02-19 14:20:53+01
185	36	participant	participant	active	2025-02-19 14:21:11+01	2025-02-19 14:21:11+01
186	36	financeur	funder	active	2025-02-19 14:21:44+01	2025-02-19 14:21:44+01
187	36	autre	N	active	2025-02-19 14:21:58+01	2025-02-19 14:21:58+01
188	37	salle de séjour	living_room	active	2025-02-19 17:29:26+01	2025-02-19 17:29:26+01
189	37	chambre	bedroom	active	2025-02-19 17:29:48+01	2025-02-19 17:29:48+01
190	37	cuisine	kitchen	active	2025-02-19 17:30:04+01	2025-02-19 17:30:04+01
191	37	wc	wc	active	2025-02-19 17:30:17+01	2025-02-19 17:30:17+01
192	37	salle de bain	bathroom	active	2025-02-19 17:30:37+01	2025-02-19 17:30:37+01
193	37	couloir	corridor	active	2025-02-19 17:30:56+01	2025-02-19 17:30:56+01
194	37	débarras	storeroom	active	2025-02-19 17:31:25+01	2025-02-19 17:31:25+01
195	37	grenier	attic	active	2025-02-19 17:31:54+01	2025-02-19 17:31:54+01
196	37	cave	cellar	active	2025-02-19 17:32:13+01	2025-02-19 17:32:13+01
197	37	autre	N	active	2025-02-19 17:32:24+01	2025-02-19 17:32:24+01
198	38	génie civil	civil_engineering	active	2025-02-20 13:29:52+01	2025-02-20 13:29:52+01
199	38	maçonnerie	brickworking	active	2025-02-20 13:30:19+01	2025-02-20 13:30:19+01
200	38	charpente	woodwork	active	2025-02-20 13:30:40+01	2025-02-20 13:30:40+01
201	38	électricité	electricity	active	2025-02-20 13:30:56+01	2025-02-20 13:30:56+01
202	38	peinture	painting	active	2025-02-20 13:31:11+01	2025-02-20 13:31:11+01
171	35	accessibilité partielle	part_accessible	active	2025-02-18 17:57:00+01	2025-04-15 11:41:01.984872+02
203	38	plomberie	plumbing	active	2025-02-20 13:31:31+01	2025-02-20 13:31:31+01
204	38	carrelage	carrelage	active	2025-02-20 13:32:05+01	2025-02-20 13:32:05+01
205	38	démolition	demolition	active	2025-02-20 13:32:28+01	2025-02-20 13:32:28+01
206	38	autre	N	active	2025-02-20 13:32:46+01	2025-02-20 13:32:46+01
207	39	animateur technique	technical_advisor	active	2025-02-21 08:43:17+01	2025-02-21 08:43:17+01
208	39	formateur	coach	active	2025-02-21 08:43:32+01	2025-02-21 08:43:32+01
209	39	participant	participant	active	2025-02-21 08:43:49+01	2025-02-21 08:43:49+01
210	39	apprenti	trainee	active	2025-02-21 08:44:09+01	2025-02-21 08:44:09+01
211	39	autre	N	active	2025-02-21 08:44:20+01	2025-02-21 08:44:20+01
212	40	chantier école	training	active	2025-02-21 08:50:46+01	2025-02-21 08:50:46+01
213	40	pré-prod	preprod	active	2025-02-21 08:51:08+01	2025-02-21 08:51:08+01
214	40	production	prod	active	2025-02-21 08:51:22+01	2025-02-21 08:51:22+01
215	40	postprod	postprod	active	2025-02-21 08:51:39+01	2025-02-21 08:51:39+01
216	40	autre	N	active	2025-02-21 08:51:53+01	2025-02-21 08:51:53+01
217	41	google_sheet	google_sheet	active	2025-02-27 09:19:36+01	2025-02-27 09:19:36+01
218	41	google_doc	google_doc	active	2025-02-27 09:20:00+01	2025-02-27 09:20:00+01
219	41	office365-excel	excel	active	2025-02-27 09:24:25+01	2025-02-27 09:24:25+01
220	41	office365-word	word	active	2025-02-27 09:24:48+01	2025-02-27 09:24:48+01
221	41	office365-powerpoint	powerpoint	active	2025-02-27 09:26:04+01	2025-02-27 09:26:04+01
222	41	pdf	pdf	active	2025-02-27 09:26:33+01	2025-02-27 09:26:33+01
223	41	page web	website	active	2025-02-27 09:27:09+01	2025-02-27 09:27:09+01
224	41	office365-form	form	active	2025-02-27 09:28:49+01	2025-02-27 09:28:49+01
225	41	google-slide	google_slide	active	2025-02-27 09:29:13+01	2025-02-27 09:29:13+01
226	41	google survey	google_survey	active	2025-02-27 09:29:35+01	2025-02-27 09:29:35+01
227	41	framapad	framapad	active	2025-02-27 09:30:22+01	2025-02-27 09:30:22+01
228	41	github	github	active	2025-02-27 09:30:38+01	2025-02-27 09:30:38+01
229	41	autre	N	active	2025-02-27 09:30:50+01	2025-02-27 09:30:50+01
230	42	coordinator	coordinator	active	2025-02-27 16:40:01+01	2025-02-27 16:40:01+01
231	42	co_coordinator	co_coordinator	active	2025-02-27 16:40:24+01	2025-02-27 16:40:24+01
232	42	participant	participant	active	2025-02-27 16:40:42+01	2025-02-27 16:40:42+01
233	42	speaker	speaker	active	2025-02-27 16:41:03+01	2025-02-27 16:41:03+01
234	42	coach	coach	active	2025-02-27 16:41:15+01	2025-02-27 16:41:15+01
235	42	secretary	secretary	active	2025-02-27 16:41:33+01	2025-02-27 16:41:33+01
236	42	autre	N	active	2025-02-27 16:41:52+01	2025-02-27 16:41:52+01
283	43	10:15	10:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:42:55.755966+02
285	43	10:45	10:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:43:07.510007+02
281	43	09:45	09:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:43:21.56296+02
286	43	11:00	11:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:43:48.061371+02
255	43	04:30	04:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:43:54.928249+02
248	43	02:45	02:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:44:01.354528+02
277	43	09:00	09:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:44:08.590376+02
258	43	05:15	05:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:44:16.545583+02
266	43	07:15	07:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:44:23.394519+02
268	43	07:45	07:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:44:29.800938+02
305	43	16:00	16:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:44:44.455679+02
306	43	16:15	16:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:44:52.488571+02
300	43	14:30	14:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:45:05.288249+02
251	43	03:30	03:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:45:27.150425+02
253	43	04:00	04:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:45:34.037854+02
304	43	15:45	15:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:45:49.363747+02
254	43	04:15	04:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:46:02.730737+02
260	43	05:45	05:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:46:09.477764+02
274	43	08:15	08:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:46:16.843674+02
270	43	07:15	07:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:46:24.133035+02
296	43	13:30	13:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:46:42.569878+02
302	43	15:15	15:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:47:06.832835+02
303	43	15:30	15:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:47:15.349714+02
295	43	13:15	13:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:47:24.30625+02
298	43	14:00	14:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:47:33.910447+02
308	43	16:45	16:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:47:43.341163+02
246	43	02:15	02:15:00	active	2025-03-03 09:50:24+01	2025-04-24 16:47:52.657582+02
293	43	12:45	12:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:48:15.292924+02
301	43	15:00	15:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:48:24.908673+02
307	43	16:30	16:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:48:33.390946+02
297	43	13:45	13:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:48:44.772068+02
294	43	13:00	13:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:48:53.756278+02
263	43	06:30	06:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:49:02.45885+02
269	43	07:00	07:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:49:09.941842+02
247	43	02:30	02:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:49:18.550292+02
264	43	06:45	06:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:49:26.506446+02
271	43	07:30	07:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:49:33.800724+02
292	43	12:30	12:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:49:43.002498+02
291	43	12:15	12:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:50:12.800512+02
289	43	11:45	11:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:50:31.365332+02
288	43	11:30	11:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:50:40.353481+02
244	43	01:45	01:45:00	active	2025-03-03 09:49:50+01	2025-04-24 16:50:58.582321+02
242	43	01:15	01:15:00	active	2025-03-03 09:49:13+01	2025-04-24 16:51:14.902993+02
249	43	03:00	03:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:51:25.396216+02
245	43	02:00	02:00:00	active	2025-03-03 09:50:07+01	2025-04-24 16:51:33.417347+02
261	43	06:00	06:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:51:40.901068+02
282	43	10:00	10:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:51:47.97832+02
267	43	07:30	07:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:51:56.582078+02
241	43	01:00	01:00:00	active	2025-03-03 09:48:53+01	2025-04-24 16:52:05.311692+02
237	43	00:00	00:00:00	active	2025-03-03 09:13:32+01	2025-04-24 16:52:14.489344+02
238	43	00:15	00:15:00	active	2025-03-03 09:43:20+01	2025-04-24 16:52:21.658156+02
239	43	00:30	00:30:00	active	2025-03-03 09:43:36+01	2025-04-24 16:52:32.128117+02
250	43	03:15	03:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:52:40.641558+02
240	43	00:45	00:45:00	active	2025-03-03 09:43:52+01	2025-04-24 16:52:49.29722+02
243	43	01:30	01:30:00	active	2025-03-03 09:49:28+01	2025-04-24 16:52:59.551325+02
252	43	03:45	03:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:53:09.347059+02
280	43	09:30	09:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:53:18.442287+02
256	43	04:45	04:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:53:35.676846+02
276	43	08:45	08:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:53:43.523733+02
257	43	05:00	05:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:53:52.685769+02
259	43	05:30	05:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:53:59.97306+02
278	43	09:15	09:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:54:09.876048+02
262	43	06:15	06:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:54:32.856582+02
265	43	07:00	07:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:54:41.606409+02
273	43	08:00	08:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:55:43.76773+02
275	43	08:30	08:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:55:58.563781+02
342	44	wks-projet	wks_project	active	2025-03-07 11:08:41+01	2025-03-07 11:08:41+01
343	44	wks_website	wks_website	active	2025-03-07 11:09:09+01	2025-03-07 11:09:09+01
344	44	Autre	N	active	2025-03-07 11:09:25+01	2025-03-07 11:09:25+01
345	37	ensemble du bâtiment	Main_Building	active	2025-03-12 10:07:36+01	2025-03-12 10:07:36+01
346	46	mètre linéaire	ml	active	2025-03-16 15:51:37+01	2025-03-16 15:51:37+01
347	46	mètre carré	m2	active	2025-03-16 15:52:04+01	2025-03-16 15:52:04+01
348	46	mètre cube	m3	active	2025-03-16 15:52:23+01	2025-03-16 15:52:23+01
349	46	gramme	g	active	2025-03-16 15:52:39+01	2025-03-16 15:52:39+01
350	46	kilogramme	kg	active	2025-03-16 15:52:53+01	2025-03-16 15:52:53+01
351	46	tonne	t	active	2025-03-16 15:53:05+01	2025-03-16 15:53:05+01
352	46	litre	l	active	2025-03-16 15:53:21+01	2025-03-16 15:53:21+01
354	45	sable	sand	active	2025-03-16 16:04:48+01	2025-03-16 16:04:48+01
355	45	ciment	cement	active	2025-03-16 16:05:13+01	2025-03-16 16:05:13+01
356	45	parpaing	concrete_block	active	2025-03-16 16:05:39+01	2025-03-17 08:32:04+01
357	46	autre	N	active	2025-03-16 16:05:53+01	2025-03-16 16:05:53+01
358	47	travaux en autonomie	diy	active	2025-03-17 15:47:56+01	2025-03-17 15:47:56+01
359	47	travaux par un professionnel	work_pro	active	2025-03-17 15:49:23+01	2025-03-17 15:49:23+01
360	47	auto réno accompagnée	guided_work	active	2025-03-17 15:50:26+01	2025-03-17 15:50:26+01
361	48	matériaux	materials	active	2025-03-17 19:50:16+01	2025-03-17 19:50:16+01
362	48	prestation entreprise	contracts	active	2025-03-17 19:50:41+01	2025-03-17 19:50:41+01
363	48	équipement	aquipment	active	2025-03-17 19:51:06+01	2025-03-17 19:51:06+01
364	48	autre	N	active	2025-03-17 19:51:18+01	2025-03-17 19:51:18+01
365	49	neuf	new	active	2025-03-21 08:16:09+01	2025-03-21 08:16:09+01
366	49	réemploi	reused	active	2025-03-21 08:18:07+01	2025-03-21 08:18:07+01
367	49	recyclage	recycling	active	2025-03-21 08:19:08+01	2025-03-21 08:19:08+01
368	49	autre	N	active	2025-03-21 08:19:26+01	2025-03-21 08:19:26+01
369	50	0	0	active	2025-03-21 08:22:22+01	2025-03-21 08:22:22+01
370	50	5,5	5,5	active	2025-03-21 08:22:34+01	2025-03-21 08:22:34+01
372	50	10	10	active	2025-03-21 08:22:58+01	2025-03-21 08:22:58+01
375	50	20	20	active	2025-03-21 08:23:43+01	2025-03-21 08:23:43+01
376	51	kg	kg	active	2025-03-29 14:34:30+01	2025-03-29 14:34:30+01
377	51	u	u	active	2025-03-29 14:35:14+01	2025-03-29 14:35:14+01
378	51	m2	m2	active	2025-03-29 14:35:29+01	2025-03-29 14:35:29+01
379	51	m3	m3	active	2025-03-29 14:35:42+01	2025-03-29 14:35:42+01
380	51	t	t	active	2025-03-29 14:35:55+01	2025-03-29 14:35:55+01
381	51	h	h	active	2025-03-29 14:36:15+01	2025-03-29 14:36:15+01
382	51	j	j	active	2025-03-29 14:36:28+01	2025-03-29 14:36:28+01
383	51	autre	N	active	2025-03-29 14:36:40+01	2025-03-29 14:36:40+01
398	48	tools	tools	active	2025-04-23 18:00:39.504503+02	2025-04-23 18:00:39.504503+02
172	35	inconnu	N	active	2025-02-18 17:57:18+01	2025-04-15 11:41:18.547851+02
384	55	CGU	CGU	active	2025-04-15 16:11:30.437396+02	2025-04-15 16:11:30.437396+02
385	55	CGV	CGV	active	2025-04-15 16:11:44.465508+02	2025-04-15 16:11:44.465508+02
386	55	manuel d''utilisation pour les utilisateurs	help_user	active	2025-04-15 16:12:14.059059+02	2025-04-15 16:12:14.059059+02
387	55	manuel d''utilisation pour les développeurs	help_dev	active	2025-04-15 16:12:49.036097+02	2025-04-15 16:12:49.036097+02
388	56	viewer	viewer	active	2025-04-16 12:19:15.725168+02	2025-04-16 12:19:15.725168+02
389	56	editor	editor	active	2025-04-16 12:19:32.078898+02	2025-04-16 12:19:32.078898+02
390	56	supervisor	supervisor	active	2025-04-16 12:19:48.583509+02	2025-04-16 12:19:48.583509+02
391	56	admin	admin	active	2025-04-16 12:20:01.384467+02	2025-04-16 12:20:01.384467+02
392	56	public	public	active	2025-04-16 12:23:03.902353+02	2025-04-16 12:23:03.902353+02
393	57	Salle de réunion	meeting_room	active	2025-04-17 09:05:27.58262+02	2025-04-17 09:05:27.58262+02
394	57	amphithéâtre	amphitheater	active	2025-04-17 09:05:58.916996+02	2025-04-17 09:05:58.916996+02
395	57	auditorium	auditorium	active	2025-04-17 09:06:17.986339+02	2025-04-17 09:06:17.986339+02
396	57	salle visio	visio_room	active	2025-04-17 09:06:49.498229+02	2025-04-17 09:06:49.498229+02
397	57	autre	N	active	2025-04-17 09:07:01.910956+02	2025-04-17 09:07:01.910956+02
325	43	20:00	20:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:39:14.228422+02
326	43	20:15	20:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:39:26.236782+02
329	43	21:00	21:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:39:44.562523+02
330	43	21:15	21:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:39:57.034548+02
331	43	21:30	21:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:40:09.351609+02
332	43	21:45	21:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:40:21.863643+02
333	43	22:00	22:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:40:34.819216+02
334	43	22:15	22:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:40:46.995797+02
327	43	20:30	20:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:40:59.433522+02
328	43	20:45	20:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:41:11.298661+02
337	43	23:15	23:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:41:24.542773+02
338	43	23:30	23:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:41:34.912092+02
335	43	22:30	22:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:41:46.125894+02
340	43	14:45	14:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:41:57.365977+02
341	43	22:45	22:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:42:10.359844+02
339	43	23:45	23:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:42:21.992106+02
336	43	23:00	23:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:42:32.394415+02
284	43	10:30	10:30:00	active	2025-03-03 09:51:02+01	2025-04-24 16:42:44.075043+02
287	43	11:15	11:15:00	active	2025-03-03 09:51:02+01	2025-04-24 16:43:36.834502+02
314	43	17:15	17:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:44:36.418063+02
318	43	18:15	18:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:45:13.021898+02
312	43	17:45	17:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:45:20.21925+02
319	43	18:30	18:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:45:40.741926+02
324	43	19:45	19:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:45:56.300489+02
323	43	19:30	19:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:46:35.082435+02
299	43	14:15	14:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:46:51.443506+02
313	43	17:00	17:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:46:59.766812+02
310	43	17:15	17:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:48:05.696937+02
316	43	17:45	17:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:49:59.838441+02
290	43	12:00	12:00:00	active	2025-03-03 09:51:02+01	2025-04-24 16:50:22.180652+02
309	43	17:00	17:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:50:48.783792+02
317	43	18:00	18:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:51:07.259709+02
272	43	07:45	07:45:00	active	2025-03-03 09:51:02+01	2025-04-24 16:53:28.163258+02
311	43	17:30	17:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:54:19.29364+02
315	43	17:30	17:30:00	active	2025-03-03 19:51:02+01	2025-04-24 16:54:55.450626+02
322	43	19:15	19:15:00	active	2025-03-03 19:51:02+01	2025-04-24 16:55:04.782005+02
320	43	18:45	18:45:00	active	2025-03-03 19:51:02+01	2025-04-24 16:55:13.618179+02
321	43	19:00	19:00:00	active	2025-03-03 19:51:02+01	2025-04-24 16:55:22.671558+02
21	6	validé	ready_for_publication	active	2025-02-15 13:29:05+01	2025-02-15 13:29:05+01
399	58	parfait état	perfect condition	active	2025-06-10 11:40:36.424014+02	2025-06-10 11:40:36.424014+02
400	58	bon état	good_condition	active	2025-06-10 11:44:55.673307+02	2025-06-10 11:44:55.673307+02
401	58	état moyen	average_condition	active	2025-06-10 11:46:06.350662+02	2025-06-10 11:46:06.350662+02
402	58	dégradé	deteriorated_condition	active	2025-06-10 11:47:05.853798+02	2025-06-10 11:47:05.853798+02
403	58	indécent	substandard_housing	active	2025-06-10 11:48:05.041888+02	2025-06-10 11:48:05.041888+02
404	58	autre	N	active	2025-06-10 11:48:31.21712+02	2025-06-10 11:48:31.21712+02
\.


--
-- TOC entry 4129 (class 0 OID 21199)
-- Dependencies: 242
-- Data for Name: event_participants; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.event_participants (participant_id, event_id, participant_first_name, participant_last_name, participant_gender, participant_age, participant_contact_phone, participant_contact_email, participant_postal_code, participant_function, participant_category, participant_status, participant_rgpd_validation, participant_selected, participant_validation, created_at, updated_at) FROM stdin;
10	2	testy	testa		\N			\N	\N	\N	\N	t	\N	\N	2025-06-08 16:19:01.817322+02	2025-06-08 16:19:01.817322+02
\.


--
-- TOC entry 4127 (class 0 OID 21174)
-- Dependencies: 240
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.events (event_id, event_name, event_type, event_status, event_visio, event_visio_url, event_visio_code, space_id, event_summary, event_program_url, event_picture_url, event_date, event_public_private, event_audience_target, event_participants_nb, event_participants_nb_max, event_entrance_fee, event_selected, created_at, updated_at, event_start_hour, event_end_hour, event_duration, event_registration) FROM stdin;
2	Réunion publique		active	face-to-face			3		\N	\N	2025-07-10	public		1	\N	50	\N	2025-05-25 18:29:13.622137+02	2025-06-08 16:19:38.248394+02	\N	\N	\N	t
3	Réunion privée	meeting	active	face-to-face			3		\N	\N	2025-09-11	private		0	\N	\N	\N	2025-06-08 16:14:59.496562+02	2025-06-08 16:14:59.496562+02	14:00:00	17:00:00	03:30:00	f
4	test	meeting	active	face-to-face			3		\N	\N	2025-12-05	public		0	\N	\N	\N	2025-11-12 12:16:51.747554+01	2025-11-12 12:16:51.747554+01	02:00:00	02:15:00	00:15:00	f
\.


--
-- TOC entry 4125 (class 0 OID 21161)
-- Dependencies: 238
-- Data for Name: faq_contacts; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.faq_contacts (contact_id, contact_gender, contact_first_name, contact_last_name, contact_email, contact_rgpd, contact_status, created_at, updated_at) FROM stdin;
16	M	Nk49Zopk	vsXmJgoO	GhTjifF9@noWHERE.com	t	archived	2025-05-25 19:07:28.439449+02	2025-11-21 18:21:55.967823+01
15	M	7ppvxnEO	kjKVL2lQ	XvHkwusD@noWHERE.com	t	archived	2025-05-01 18:09:37.257513+02	2025-11-22 09:17:25.728519+01
17	M	7ppvxnEO	kjKVL2lQ	XvHkwusD@noWHERE.com	t	archived	2025-06-03 09:13:05.195134+02	2025-11-22 09:17:25.728519+01
19	M	7ppvxnEO	kjKVL2lQ	XvHkwusD@noWHERE.com	t	archived	2025-06-04 09:29:34.02595+02	2025-11-22 09:17:25.728519+01
18	M	vFqo7qHp	p9mgFUag	H3bvuLeG@noWHERE.com	t	archived	2025-06-03 20:17:33.650021+02	2025-12-01 13:49:17.543745+01
26	\N	\N	\N	\N	t	online	2025-12-30 15:36:57.310924+01	2025-12-30 15:36:57.310924+01
\.


--
-- TOC entry 4169 (class 0 OID 21509)
-- Dependencies: 282
-- Data for Name: faq_questions; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.faq_questions (question_id, contact_id, question, question_content, answer, answer_yes_no, faq_yes_no, question_public_private, question_category, question_status, created_at, updated_at) FROM stdin;
2	15	question test	question test\r\n	ma réponse\r\n	t	t	public	general	active	2025-05-01 18:09:37.292412+02	2025-06-03 11:48:06.29259+02
4	17	xwxw	xccx\r\n	cxccx\r\n	t	t	private	general	active	2025-06-03 09:13:05.350992+02	2025-06-03 11:49:53.979648+02
3	16	sqsq		\N	f	\N	public	\N	online	2025-05-25 19:07:28.718029+02	2025-05-25 19:07:28.718029+02
5	18	cxcx	   dds	\N	f	\N	public	\N	online	2025-06-03 20:17:33.846143+02	2025-06-03 20:17:33.846143+02
6	19	xwxw	xwxw\r\n		f	f	private	general	archived	2025-06-04 09:29:34.271071+02	2025-11-22 09:17:36.749173+01
13	\N	\N	\N	\N	f	\N	public	\N	online	2025-12-30 15:36:57.353699+01	2025-12-30 15:36:57.353699+01
\.


--
-- TOC entry 4133 (class 0 OID 21229)
-- Dependencies: 246
-- Data for Name: forum_messages; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.forum_messages (message_id, topic_id, message_recipient_id, message_author_id, message_content, message_status, message_rank, created_at, updated_at) FROM stdin;
338	122	\N	19	Your message :ds\r\n	active	main	2025-12-01 11:37:19.821626+01	2025-12-01 11:37:19.821626+01
339	123	\N	19	Your message :sdsd\r\n	active	main	2025-12-01 11:38:36.777243+01	2025-12-01 11:38:36.777243+01
340	124	\N	19	Your message :ds\r\n	active	main	2025-12-01 11:49:13.055188+01	2025-12-01 11:49:13.055188+01
341	124	\N	19	Votre réponse :cxcx\r\n	active	post	2025-12-01 13:47:30.123654+01	2025-12-01 13:47:30.123654+01
342	124	\N	19	Votre réponse :w\\<w<\r\n	active	post	2025-12-01 13:47:39.061394+01	2025-12-01 13:47:39.061394+01
343	124	\N	19	Votre réponse :w\\<w<\r\n	active	post	2025-12-01 13:47:58.486456+01	2025-12-01 13:47:58.486456+01
344	124	\N	19	Votre réponse :ww<\r\n	active	post	2025-12-01 13:48:05.69036+01	2025-12-01 13:48:05.69036+01
345	125	\N	19	Your message :ds\r\n	active	main	2025-12-01 13:51:29.702348+01	2025-12-01 13:51:29.702348+01
347	125	\N	19	xwxwww\r\n	active	post	2025-12-01 14:20:57.933315+01	2025-12-01 14:24:09.511553+01
\.


--
-- TOC entry 4131 (class 0 OID 21216)
-- Dependencies: 244
-- Data for Name: forum_topics; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.forum_topics (topic_id, topic_author_id, workspace_id, topic_name, topic_category, debug_target, forum_type, number_messages, forum_group, topic_status, topic_selected, created_at, updated_at) FROM stdin;
123	19	4	dd	general	\N	forum_wkps	1	G0	online	\N	2025-12-01 11:38:36.715673+01	2025-12-01 11:38:36.85506+01
124	19	4	dsds	general	\N	forum_wkps	5	G0	online	\N	2025-12-01 11:49:13.009489+01	2025-12-01 13:48:05.725789+01
122	19	4	dss	general	\N	forum_wkps	1	G0	online	\N	2025-12-01 11:37:19.743522+01	2025-12-01 11:37:19.944625+01
125	19	\N	dds	general	\N	forum	2	G0	active	\N	2025-12-01 13:51:29.66612+01	2025-12-01 14:24:24.297281+01
\.


--
-- TOC entry 4161 (class 0 OID 21425)
-- Dependencies: 274
-- Data for Name: info_sections; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.info_sections (section_id, section_title, section_content, section_category, section_lang, section_number, section_status, created_at, updated_at) FROM stdin;
2	2. Histoire de Co-op	## La belette entrée dans un grenier  \n*Jean de la Fontaine*\n\nDamoiselle belette, au corps long et fluet,  \nEntra dans un grenier par un trou fort étroit :  \nElle sortait de maladie.  \nLà, vivant à discrétion,  \nLa galande fit chère lie,  \nMangea, rongea : Dieu sait la vie,  \nEt le lard qui périt en cette occasion !  \nLa voilà, pour conclusion,  \nGrasse, maflue, et rebondie.  \nAu bout de la semaine, ayant dîné son soûl,  \nElle entend quelque bruit, veut sortir par le trou,  \nNe peut plus repasser, et croit s’être méprise.  \nAprès avoir fait quelques tours,  \nC’est, dit-elle, l’endroit, me voilà bien surprise ;  \nJ’ai passé par ici depuis cinq ou six jours,  \nUn rat, qui la voyait en peine,  \nLui dit : Vous aviez lors la panse un peu moins pleine.  \nVous êtes maigre entrée, il faut maigre sortir.  \nCe que je vous dis là, l’on le dit à bien d’autres ;  \nMais ne confondons point, par trop approfondir,  \nLeurs affaires avec les vôtres.   	about	FR	2	active	2024-10-28 14:37:19+01	2025-03-06 09:45:49+01
7	1. Nous contacter	Pour toute question concernant la modération ou l'administration du site\nlui-même ou une problématique ne pouvant être évoquée publiquement, ou\nsi vous avez rencontré un bogue en parcourant le site web l\\'association\nXXX ou si vous souhaitez suggérer des évolutions pour le site, vous\npouvez nous contacter, en déposant votre message sur [le formulaire de\ncontact](http://localhost:8080/a_faq/faq_form.sql).\n\nPour toute question concernant des demandes d'aide liées aux thématiques\ndu site (comme *comment faire marcher tel logiciel* ou *j'ai tel message\nd'erreur qui s'affiche*), veuillez consulter [la foire aux\nquestions.](http://localhost:8080/a_faq/faq_display.sql)\n\nPour poser des questions techniques, vous pouvez utiliser [le\nforum](http://localhost:8080/a_forum/forum.sql) ( cela nécessite de se\ncréer un compte).	legal	FR	1	active	2024-10-29 09:34:24+01	2024-12-05 15:32:43+01
8	2. Éditeur	Ce site est édité par l'association XXX\n\nSiège social : ????	legal	FR	2	active	2024-10-29 09:42:36+01	2024-10-29 09:47:36+01
9	3. Hébergeur	Ce site est hébergé sur les serveurs de la société XXXX. Siège social :\nXXXXX	legal	FR	3	active	2024-10-29 09:43:19+01	2024-10-29 09:47:43+01
10	4. Directeur de publication	Le directeur de publication est M. XXXX, \\<xxxxx@asso-coopXXXXX.org\\>.\nLes courriels nécessitent une confirmation de votre part.	legal	FR	4	active	2024-10-29 09:43:48+01	2024-10-29 09:47:49+01
11	5. Cookies	Le site utilise actuellement les cookies suivants :\n\n-   *session_token* :\n\n    -   durée : courte (suppression à la fermeture du navigateur),\n\n    -   usage : cookie de session sur le site,\n\n    -   concerne : les visites authentifiées ;	legal	FR	5	active	2024-10-29 09:44:24+01	2024-10-29 09:47:57+01
12	6. Données à caractère personnel	Cette liste de données à caractère personnel concerne les visites du\nsite effectuées avec un compte. Il n'y a pas de données à caractère\npersonnel lors des visites anonymes sans compte.\n\nLa loi (le [Règlement sur la protection des données à caractère\npersonnel ou\nRGPD](https://fr.wikipedia.org/wiki/Règlement_général_sur_la_protection_des_données)\net la [Loi informatique et libertés ou\nLIL](https://fr.wikipedia.org/wiki/Loi_informatique_et_libertés) en\nFrance) requiert une base légale pour chaque traitement de DCP. Cette\nobligation s'applique quelle que soit l'état d'activité du compte.\nAinsi, si un compte est inactif, une base légale doit exister pour\njustifier d'une conservation des DCP associées.\n\n\\-- à adapter en fonction de la gestion réelle des données des\nutilisateurs\n\n*Pour les comptes actifs, des données sont obligatoirement stockées en\nbase pour rendre le service. Les tâches suivantes sont réalisées pour le\nservice :*\n\n-   *transmettre un mot de passe initial pour créer un compte en ayant\n    > validé l'adresse. Cette tâche utilise l'adresse de courriel ;*\n\n-   *transmettre des notifications liées aux services, par exemple les\n    > publications/rejets de dépêches ou les attributions de prix\n    > mensuels. Cette tâche utilise l'adresse de courriel ;*\n\n-   *afficher les données publiques liées au compte (le compte lui-même,\n    > les contenus du compte, les commentaires du compte, etc.). Cette\n    > tâche nécessite en interne un identifiant unique par compte ;*\n\n-   *gérer les litiges éventuels (par exemple, le manifestement illégal,\n    > le prétendument illégal) et le cadre légal (par exemple, la\n    > modification des données de son propre compte, le droit d'auteur).\n    > Cette tâche nécessite d'avoir des données d'identification,\n    > d'attribution et de contact pour les publications de contenus /\n    > commentaires faits par des tiers (les comptes) ;*\n\n-   *détecter et gérer des éventuels abus du service (comptes multiples,\n    > etc.) ;*\n\n-   *gérer la limitation de la conservation des DCP et la limitation\n    > dans le temps des habilitations (modération, administration).\n    > Cette tâche nécessite d'avoir la date de dernière visite.*\n\n*Le RGPD limite la conservation des DCP. Dans le présent contexte, cette\nobligation concerne à la fois les comptes toujours ouverts mais\ninutilisés pendant une certaine durée aussi bien que les comptes fermés.\nEn tout état de cause, l\\'association XXX n'a pas d'intérêt ou de besoin\nlégitime à conserver indéfiniment ces données, dès qu'une période\nraisonnable est passée. Pour définir cette période raisonnable,\nl\\'association XXX tient compte de la prescription après 3 mois pour le\ndroit de la presse en France. l\\'association XXX estime que les risques\nde revoir le même spammeur avec les mêmes coordonnées diminuent\nénormément en quelques mois ou mêmes semaines. Etc.*\n\n*Les données à caractère personnel nécessaires à la fourniture du\nservice :*\n\n-   *identifiant ou pseudo : unique dans l'ensemble du site, il définit\n    > aussi un élément de l'adresse qui sera associé au compte (la\n    > partie entre le \\'/users/\\' et le \\'/\\' dans l'adresse associée au\n    > compte). Il n'est pas modifiable par la personne utilisant le\n    > compte. Il est nécessaire pour créer un compte identifiable de\n    > l'extérieur de façon unique.*\n\n-   *nom affichable : choisi par la personne utilisant le compte et\n    > modifiable à tout moment tant que le compte est ouvert. Il est\n    > nécessaire à identifier l'utilisateur aux autres utilisateurs du\n    > site (sachant que l'identifiant ou pseudo est utilisé à défaut).*\n\n-   *adresse de courriel : définie par la personne utilisant le compte,\n    > validée par le courriel initialement envoyé à la création du\n    > compte ; elle est modifiable par la suite tant que le compte est\n    > ouvert. Il est nécessaire pour valider l'humanité du compte et\n    > pour les notifications.*\n\n-   *mot de passe : initialement généré aléatoirement et pouvant être\n    > modifié à tout moment par la personne utilisant le compte tant que\n    > celui-ci est ouvert. Il sert à s'authentifier sur le site.*\n\n-   *date et adresse IP de connexion courante ;*\n\n-   *date et adresse IP de connexion précédente ;*\n\n-   *date de dernière visite ;*\n\n*Les données à caractère personnel non-obligatoires pour le service et\nfournies par les utilisateurs sont :*\n\n-   *une image d'avatar : la personne utilisant le compte peut y\n    > associer une image (qui peut ou non l'identifier) et peut la\n    > modifier à tout moment tant que le compte est ouvert ;*\n\n-   *une adresse d'un site web personnel : la personne utilisant le\n    > compte peut y associer une telle adresse et peut la modifier à\n    > tout moment tant que le compte est ouvert ;*\n\n-   *une adresse de messagerie instantanée XMPP : la personne utilisant\n    > le compte peut y associer une telle adresse et peut la modifier à\n    > tout moment tant que le compte est ouvert ;*\n\n-   *une adresse de compte Mastodon : la personne utilisant le compte\n    > peut y associer une telle adresse et peut la modifier à tout\n    > moment tant que le compte est ouvert ;*\n\n-   *une signature ajoutée à chaque commentaire : la personne utilisant\n    > le compte peut y associer une telle signature et peut la modifier\n    > à tout moment tant que le compte est ouvert ;*\n\n-   *une feuille de style personnelle : la personne utilisant le compte\n    > peut y associer une telle feuille de style et peut la modifier à\n    > tout moment tant que le compte est ouvert.*	legal	FR	6	active	2024-10-29 09:45:16+01	2024-10-29 09:48:03+01
13	7. Quelles sont les données sans caractère personnel relatives au compte traitées par le site ?	Cette liste de données sans caractère personnel concerne les visites du\nsite effectuées avec un compte.\n\nLe compte peut être associé à des contenus (dépêches, journal personnel,\nentrées de forums, sondages, pages wiki, liens, entrées dans le système\nde suivi), des commentaires, des notes ou des étiquetages, ainsi que des\ncontenus sur lesquels le compte a contribué. Le compte peut aussi être\nassocié à des applications ou sites tiers, ayant été autorisés à accéder\nà certaines informations via une API Oauth2. Le compte est associé\néventuellement à des opérations administratives (changement de mot de\npasse, sanctions temporaires d'interdiction de commenter, etc.).\n\nLa fermeture du compte était sans effet sur ces données. Une demande\nd'anonymisation (réattribution de tout à l'utilisateur fictif Anonyme)\nest possible en passant par l'équipe du site.	legal	FR	7	active	2024-10-29 09:46:33+01	2024-10-29 09:48:22+01
41	PARTIE II - BILLETTERIE	Les présentes conditions de vente s'appliquent de plein droit et sans restrictions à toutes les réservations effectuées pour des représentations à compter du 1er septembre 2018. Elles sont susceptibles de modifications sans préavis. La réservation de places par le client ou le règlement des places implique son adhésion sans réserves aux présentes.	CGV	FR	8	active	2024-12-17 10:28:24+01	2024-12-17 10:45:50+01
15	Préambule	Les présentes Conditions Générales d'Utilisation (ci-après "CGU") régissent l'accès et l'utilisation du site [Nom du site], édité par [Nom de l'entreprise], dont le siège social est situé [Adresse de l'entreprise]. L'utilisateur reconnaît avoir pris connaissance des CGU et s'engage à les respecter.	CGU	FR	0	active	2024-10-29 10:22:56+01	2024-12-05 15:35:30+01
16	Article 1 – Définitions	Site : désigne le site internet accessible à l'adresse [URL du site].\nVisiteur :  toute personne  naviguant sur le Site, à quelque titre que ce soit, sans s'être connecté.\nUtilisateur : toute personne  naviguant sur le Site, à quelque titre que ce soit après s'être connecté en fournissant son email et son mot de passe.\nContenu : désigne l'ensemble des éléments présents sur le Site (textes, images, vidéos, logos, etc.).	CGU	FR	1	active	2024-10-29 10:23:23+01	2024-12-05 15:45:40+01
17	Article 2 – Objet	Les présentes CGU ont pour objet de définir les conditions dans lesquelles les utilisateurs peuvent accéder au Site et l'utiliser. En accédant au Site, l'utilisateur accepte sans réserve les présentes CGU.	CGU	FR	2	active	2024-10-29 10:23:49+01	2024-10-29 10:28:12+01
18	Article 3 – Accès au site	L'accès au Site est ouvert à tout utilisateur disposant d'une connexion Internet. Le site est accessible gratuitement, hors coûts de connexion et d'abonnement à Internet. \nCertaines sections du site sont toutefois  réservées aux seuls utilisateurs enregistrés, en fonction des droits qui leur ont été accordés.\n 	CGU	FR	3	active	2024-10-29 10:24:26+01	2024-12-05 15:47:36+01
19	Article 4 – Propriété intellectuelle	Le contenu du site (textes, images, logos, etc.) accessible aux visiteurs est sous licence creative commons CC-BY-NC-SA (Attribution Pas d'utilisation commerciale Partage dans les mêmes conditions).\nLe contenu du site (textes, images, logos, etc.) accessible aux utilisateurs est sous licence creative commons CC-Zero pour faciliter le partage et la coproduction des contenus.	CGU	FR	4	active	2024-10-29 10:24:53+01	2024-12-05 15:53:27+01
20	Article 5 – Données personnelles	Le site ne collecte que le nom, et l'adresse e-mail des visiteurs qui introduisent une demande via le formulaire de contact. Ces données ne sont collectées que pour pouvoir répondre aux demandes formulées. Conformément à la réglementation en vigueur (RGPD), le visiteur dispose d'un droit d'accès, de rectification et de suppression de ses données personnelles. Pour toute demande, contactez [email du DPO].\nDe même les utilisateurs enregistrés  dispose d'un droit d'accès, de rectification et de suppression de ses données personnelles. Pour toute demande, contactez [email du DPO].	CGU	FR	5	active	2024-10-29 10:25:22+01	2024-12-05 15:56:47+01
21	Article 6 – Responsabilité	L'utilisation du Site se fait sous la seule responsabilité de l'utilisateur. [Nom de l'entreprise] ne saurait être tenu responsable de tout dommage direct ou indirect, y compris pertes de données ou de profit, résultant de l'accès ou de l'utilisation du Site.	CGU	FR	6	active	2024-10-29 10:25:51+01	2024-10-29 10:28:46+01
22	Article 7 – Liens hypertextes	Le site peut contenir des liens vers d'autres sites internet. [Nom de l'entreprise] n'exerce aucun contrôle sur le contenu de ces sites et ne saurait être tenu responsable de leur disponibilité ou de leur contenu.	CGU	FR	7	active	2024-10-29 10:26:21+01	2024-10-29 10:28:52+01
23	Article 8 – Modification des CGU	[Nom de l'entreprise] se réserve le droit de modifier à tout moment les présentes CGU. Les utilisateurs sont invités à les consulter régulièrement. Les modifications prennent effet à compter de leur publication sur le Site.	CGU	FR	8	active	2024-10-29 10:26:51+01	2024-10-29 10:28:58+01
24	Article 9 – Loi applicable	Les présentes CGU sont régies par la loi française. En cas de litige, et après tentative de résolution amiable, les tribunaux de [Ville] seront compétents.	CGU	FR	9	active	2024-10-29 10:27:24+01	2024-10-29 10:29:04+01
25	Article 10 – Contact	Pour toute question relative aux présentes CGU, vous pouvez contacter [Nom de l'entreprise] à l'adresse suivante : [Adresse e-mail].	CGU	FR	10	active	2024-10-29 10:27:58+01	2024-10-29 10:29:12+01
28	CO-OP un site internet simple mais complet réalisé avec sqlpage 	COOP est le résultat d'un parcours d'apprentissage de sql via SQLPage\npar un « no-pro » (le développement informatique n'est pas mon métier et\nma culture informatique est très limitée). L'objectif était de\ndévelopper un site web complet, fonctionnel, dynamique (tous les\ncontenus gérés à partir de tables). L'argument de cette base de données\nest le suivi de chantiers de réhabilitation de bâtiments dans le cadre\nde chantiers participatifs associant des professionnels et des\nparticuliers. Le suivi et la coordination de ces chantiers sont assurés\npar des associations indépendantes organisées en réseau. Cela explique\nle nom du site et le volet consacré au travail collaboratif.\n\nLe code de COOP est très simple : utilisation de SQLITE comme moteur de\ngestion de base de données, requêtes SQL de base (requêtes\nélémentaires : pas d'utilisation de triggers, pragma...), SQLPage socle\n(pas de composants « custom », pas de scripts), une écriture des\nrequêtes très scolaire, des noms de fichiers et de dossiers très\nexplicites...	hero	EN	1	active	2024-11-14 17:08:38+01	2025-03-05 17:00:59+01
29	CO-OP a simple but complete website built with sqlpage	COOP is the result of a "no-pro" learning curve in sql via SQLPage (IT\ndevelopment is not my profession and my IT culture is very limited). The\naim was to develop a complete, functional, dynamic website (all content\nmanaged from tables). The purpose of the central database is to monitor\nbuilding rehabilitation projects as part of participative projects\ninvolving professionals and private individuals. These projects are\nmonitored and coordinated by a network of independent associations. This\nexplains the name of the site and the section devoted to collaborative\nwork.\n\nCOOP\\'s code is very simple: use of SQLITE as the database management\nengine, basic SQL queries (elementary queries: no use of triggers,\npragma\\...), SQLPage base (no custom components, no scripts), very\nacademic query writing, very explicit file and folder names\\...	hero	EN	2	active	2024-12-05 16:57:13+01	2025-03-05 17:02:19+01
31	CO-OP a website built ti present an organization and its projects	There are many commercial or open source, no-code applications available\nto meet the most classic needs expected of a web site. But there are\ncases where the database structure is too specific to use one of these\napplications. The website must therefore be built around the database.\nThis is the purpose of SQLPage, a major advantage of which is that it is\na "simple code" application accessible to people whose core business is\nnot IT development, but who need to put a specific database online.\n\nPutting a database online is not limited to putting the data itself\nonline. It also involves the development of other peripheral functions\nexpected of a web site:\n\n-   "**admin**" function: website administration, user rights management\n    and maintenance,\n\n-   "**corporate**" function: presenting the structure that publishes\n    the website: who we are, what we do, presenting our team\\...\n\n-   "**contact**" function: provide a contact and exchange interface for\n    visitors: contact form, registration form, FAQ\\...\n\n-   "**interface**" function: to provide an interface for feeding and\n    maintaining the database that justified the creation of the site,\n\n-   **"community**" function: offering collaborative tools for editors\n    who feed the database or produce content for the site.\n\nCOOP\\'s structure is designed to meet all these functions.	hero	EN	4	active	2024-12-05 17:03:05+01	2025-03-05 17:05:06+01
32	CO-OP une plateforme pour faciliter le travail collaboratif autour d'un projet	CO-OP entre dans la catégorie PSM : Project Management\nSystem. Il existe de nombreuses applications de gestion de projets.\nElles se distinguent entre elles par les finalités recherchées et le\ncontexte métier dans lesquelles elles sont déployées.\n\nCO-OP vise surtout l'analyse des interventions des acteurs à chaque\nniveau du projet. CO-OP a été conçu dans le contexte spécifique de\nconduite de chantiers de rénovation de bâtiment avec des équipes mixtes\nde professionnels et non professionnels (démarche ARA : auto\nréhabilitation accompagnée). Il serait possible d'enrichir CO-OP avec\ndes tables sur les matériaux et services de manière à pouvoir mettre une\nanalyse plus complète incluant le détail des coûts.\n\nCO-OP peut toutefois être transposer à d'autres types de projet\nsstructurés autour de la notion de lots de travaux/tâches et de\nséquences/tâches.\n\nUn autre aspect de CO-OP est de proposer un espace virtuel de travail,\nun « hub » autour du projet avec des modules de planification des\nréunions, de gestion de la documentation, un forum. Cela évite la\ndispersion souvent constatée entre un outil de gestion de projet, des\ndocuments dispersés ici et là, un outil de messagerie séparé...\n\nCO-OP ne vise pas les projets complexes. Il privilégie une interface\nsobre et ergonomique pour une possible alternative à la gestion de\nprojets avec des feuilles de calcul sous excel® ou calc® . Ces outils\nsont très simples d'emploi mais marquent des limites. SQLPAge qui permet\nd'exploiter une vraie base de données, permet de dépasser ces limites.	hero	FR	5	active	2024-12-05 17:03:58+01	2025-03-05 17:09:30+01
33	CO-OP a digital coworking place to develop projects	The project module falls into the PSM category: Project Management\nSystem. There are many different project management applications. They\ncan be distinguished from one another by their intended purpose and the\nbusiness context in which they are deployed.\n\nCO-OP main aim is to analyze the actions of players at every level of\nthe project. CO-OP was designed for the specific context of building\nrenovation projects involving mixed teams of professionals and\nnon-professionals (ARA: auto réhabilitation accompagnée). It would be\npossible to enrich CO-OP with tables on materials and services in order\nto provide a more complete analysis, including detailed costs.\n\nCO-OP can, however, be transposed to other types of project structured\naround the notion of work packages/tasks and sequences/tasks.\n\nAnother aspect of CO-OP is that it offers a virtual workspace, a "hub"\naround the project, with modules for scheduling meetings, managing\ndocumentation and a forum. This avoids the dispersion often seen between\na project management tool, documents scattered here and there, a\nseparate messaging tool...\n\nCO-OP is not designed for complex projects. It favors a sober, ergonomic\ninterface as a possible alternative to project management with excel® or\ncalc® spreadsheets. These tools are very easy to use, but have their\nlimitations. SQLPAge, which allows you to use a real database, overcomes\nthese limitations.	hero	EN	6	active	2024-12-05 17:04:52+01	2025-03-05 17:07:54+01
35	PARTIE I - PRESTATIONS DE SERVICE	Les présentes conditions de vente s'appliquent de plein droit et sans restrictions à toutes les prestations de services effectuées à compter du 1er septembre 2018. Elles sont susceptibles de modifications sans préavis. Les présentes conditions sont acceptées sans restriction par le client qui fait appel aux services de la compagnie. \n\n## I. ENGAGEMENT DE LA COMPAGNIE\n\n1. Il est entendu que la compagnie ne s’engage à intervenir qu’après la production d’un accord écrit et officiel de la part du client (a minima la  signature d’un devis). Dans le cas où des négociations auraient été entamées sans la production d’un tel écrit, le client ne pourra se retourner contre la compagnie si celle-ci n’est plus disponible pour l’intervention visée.\n\n2 . Si un devis signé suffit pour certaines interventions, il est à noter que la cession de spectacles devra impérativement faire l’objet d’un contrat de cession. \n\n3 . Nos devis sont valables 6 semaines à compter de leur date d’édition.\n\n4 . Dans le cas où une intervention aurait lieu sans signature du client (retard ou oubli) malgré son accord oral ou écrit, des frais de pénalité à hauteur de 50 € TTC seront facturés en sus du prix de la prestation afin de couvrir les frais engendrés.	CGV	FR	2	active	2024-12-17 10:18:47+01	2024-12-17 10:44:54+01
36	II. FRAIS ANNEXES À LA PRESTATION	1 . Le client, dans le cas d’un contrat de cession de spectacle, devra s’assurer des formalités déclaratives vis-à-vis des droits d’auteurs et droits voisins liés à la représentation, et du règlement de ces droits.\n\n2 . Des frais de déplacements, d’hébergement et de repas peuvent s’appliquer pour les prestations de service réalisées en dehors du lieu de domicile des intervenants ou de la ville du siège social de la compagnie. Il est à noter que les intervenants peuvent également partir de leur lieu de domicile ou du lieu de leur dernière prestation, auquel cas la facturation des frais de déplacements prendra en compte ce point de départ en lieu et place du siège de l’association. 	CGV	FR	3	active	2024-12-17 10:20:18+01	2024-12-17 10:45:03+01
37	III . ACCUEIL DE LA COMPAGNIE	1 . L’accueil d’un spectacle de la compagnie est soumis aux conditions énoncées dans la fiche technique, qui fait partie intégrale du contrat de cession.\n\n2 . Si des adaptations et ajustements techniques sont à prévoir pour accueillir le spectacle, le client s’engage à contacter le responsable technique de la compagnie le plus tôt possible afin de s’assurer que ces modifications sont compatibles avec la représentation. La compagnie se réserve le droit d’annuler la représentation dans le cas où l’accueil ne correspond pas à ce qui est demandé dans la fiche technique ou aux ajustements\nconsentis. Cette annulation n’ouvre droit à aucune indemnité et la prestation est tout de même facturée. \n\n3 . Dans le cas d’ateliers théâtres organisés par le client, en particulier pour les publics mineurs, le client est seul responsable de la sécurité des bénéficiaires de l’atelier.\n	CGV	FR	4	active	2024-12-17 10:21:44+01	2024-12-17 10:45:12+01
38	IV . ATELIERS ET COURS	1 . Toute inscription aux cours de théâtre organisés par la compagnie est ferme et définitive. L’élève s’engage pour l’année, et aucun remboursement ne saurait être consenti, y compris dans le cas d’un paiement mensuel ou trimestriel.\n\n2 . En cas de retard ou d’arrêt des paiements, la compagnie emploiera la procédure indiquée en V-3.\n\n3 . Tout manquement au règlement intérieur fourni en début d’année peut mener à l’exclusion des cours. Aucun remboursement ne saurait alors être réclamé.	CGV	FR	5	active	2024-12-17 10:22:54+01	2024-12-17 10:45:35+01
39	V . PAIEMENT	1 . À l’issue de la prestation, une facture est envoyée par mail à au client. Dès l’envoi de cette facture, le client dispose de 30 jours pour la régler.\n\n2 . Le paiement se fait par virement sur le compte de la compagnie. Il n’est possible de régler par chèque qu’avec l’accord exprès de la compagnie.\n\n3 . Toute facture impayée sous 30 jours fera l’objet d’une relance. Dès cette première relance, conformément à l'article L. 441-6 du code de commerce, une indemnité forfaitaire de recouvrement de 4 0 € s e r a automatiquement due, et des pénalités de retard au taux annuel de 20 % commenceront à courir. 	CGV	FR	6	active	2024-12-17 10:24:39+01	2024-12-17 10:45:26+01
40	VI . RÉCLAMATIONS - LITIGES	1 . Toute contestation, quelle qu'en soit la nature doit être formulée par écrit adressé à la direction Anonymous International.\n\n2 . Nous nous réservons la possibilité d'apporter toutes modifications dans l'ordre, la durée et la distribution du spectacle. D'autre part, nous nous  réservons le droit d'annuler toute représentation qui ne pourrait avoir lieu si des cas fortuits ou des cas de force majeure nous y contraignaient tels que (et sans que cette liste ne soit exhaustive) intempéries, grèves, incendie, dégât des eaux, maladie d'un interprète etc... dans une telle hypothèse nous proposerions une autre date de représentation. \n\n3 . Dans le cas d’une annulation décidée par l’organisateur, notamment dans le cadre d’une interdiction de rassemblement ou de consignes sanitaires alourdies, la prestation sera intégralement facturée. Un avoir sera ensuite remis à l’organisateur afin qu’il puisse reprogrammer la prestation, ou une autre de son choix.\n\n4 . Le contrat de cession d’un spectacle ne donne aucun droit à un enregistrement du spectacle. Tout enregistrement sous quelque forme que ce soit, y compris photographique, est strictement interdit. Nous nous réservons le droit d'entamer une procédure en réparation des préjudices subis.	CGV	FR	7	active	2024-12-17 10:27:15+01	2024-12-17 10:45:43+01
43	II . RÉSERVATION - DÉLAIS DE PAIEMENT	1. Toute place réservée par mail ou par téléphone est considérée comme due, même en cas d’absence au moment de la représentation. Une facture correspondant au montant des places réservées sera dans ce cas envoyée après la représentation. Anonymous International se réserve le droit de remettre en vente toute place réservée et non retirée 20 minutes avant le début de la représentation.	CGV	FR	10	active	2024-12-17 10:34:13+01	2024-12-17 10:46:08+01
44	III . ANNULATIONS	1. Nous n'acceptons aucune annulation après paiement des places par le client. En matière de spectacle, la jurisprudence considère que le rapport qui s'établit entre la structure qui annonce un spectacle, indique le prix des places et l'heure de représentation et le public qui achète un billet, quel que soit ensuite le mode de paiement (espèces, chèque, carte de crédit, mandat), est un rapport contractuel. Dans ces conditions, ce n'est que si l'entreprise de spectacle ne remplit pas son obligation que le spectateur peut demander le remboursement ou contester le contrat. Le règlement\npar carte bancaire des places spontanément achetées par les spectateurs n’est pas assimilé aux ventes à distance de produits ou de prestations de service et ne peut s'appliquer au contrat passé entre le spectateur et Anonymous International	CGV	FR	11	active	2024-12-17 10:35:49+01	2024-12-17 10:46:17+01
45	IV . RÉCLAMATIONS - LITIGES	1. Toute contestation, quelle qu'en soit la nature doit être formulée par écrit à la direction d’Anonymous International.\n\n2. Le nombre de billets doit être vérifié par le client au moment où ils sont délivrés par notre personnel. Aucune réclamation ultérieure ne pourra être prise en compte.\n\n3. Nous nous réservons la possibilité d'apporter toutes modifications dans l'ordre, la durée et la distribution du spectacle. D'autre part, nous nous réservons le droit d'annuler toute représentation qui ne pourrait avoir lieu si des cas fortuits ou des cas de force majeure nous y contraignaient tels que (et sans que cette liste ne soit exhaustive) intempéries, grèves, incendie, dégât des eaux, maladie d'un interprète etc... dans une telle hypothèse nous proposerions une autre date de représentation.\n\n4. Nous déclinons toute responsabilité pour les dommages quelle qu'en soit la nature qui seraient susceptibles d'atteindre les effets, objets ou  matériels apportés par les spectateurs. Les spectateurs sont responsables de tout dommage direct ou indirect qu'ils pourraient causer à l'occasion de leur présence durant la représentation.\n\n5. Les billets ne donnent aucun droit à un enregistrement du spectacle. Tout enregistrement, sous quelque forme que ce soit, y compris  photographiquement est strictement interdit. Nous nous réservons le droit d'entamer une procédure en réparation des préjudices subis	CGV	FR	12	active	2024-12-17 10:38:05+01	2024-12-17 10:46:32+01
50	3. Droits Permissions Privilèges des utilisateurs	## 1.1. Permissions CRUD&#x20;\r\n\r\nCOOP distingue plusieurs rôles pour les utilisateurs connectés :&#x20;\r\n\r\n* **Lecteur (viewer)** : ce rôle permet de consulter les informations internes (actualités, agenda, FAQ) et de publier sur le forum.\r\n* &#x20;**Éditeur (editor)** : ce rôle permet aux utilisateurs de lire, créer et modifier du contenu.\r\n* &#x20;**Superviseur (supervisor)**: ce rôle permet aux utilisateurs de lire, créer, modifier et supprimer du contenu.&#x20;\r\n* **Administrateur  (admin)** : ce rôle est principalement dédié à la gestion du site et contrôle les utilisateurs.&#x20;\r\n\r\nLes utilisateurs créent leurs propres comptes et mots de passe. Par défaut, ils n'ont aucun rôle. Leur niveau de permission est défini par l'administrateur. Les mots de passe ne sont donc jamais transmis et ne sont pas stockés dans la base de données (uniquement le hash\\_password).\r\n\r\n&#x20;L'administrateur est informé des demandes de création de compte via un flux RSS dédié (/a\\_rss\\_feed/rss\\_new\\_users\\_5.sql).\r\n\r\nL'accès aux fichiers SQL est filtré par un composant shell spécifique :\r\n\r\n* &#x20;/a\\_shells/shell\\_2.sql pour les utilisateurs visualisant les fichiers\r\n* &#x20;/a\\_shells/shell\\_3.sql pour les éditeurs /a\\_shells/shell\\_4.sql pour les superviseurs&#x20;\r\n* /a\\_shells/shell\\_5.sql pour les administrateurs Après vérification du rôle de l'utilisateur,&#x20;\r\n\r\nchaque shell appelle un shell\\_core (/a\\_shells/shell\\_core.sql), qui affiche le menu des permissions de l'utilisateur.&#x20;\r\n\r\nPour faciliter la navigation dans les fichiers en fonction des niveaux de permissions, nous avons adopté le principe d'utilisation de suffixes à la fin du nom de fichier :&#x20;\r\n\r\n* /news\\_private\\_display\\_3.sql : fichier éditeur pour la liste des actualités internes&#x20;\r\n* /news\\_private\\_display\\_4.sql : fichier superviseur pour la liste des actualités internes (identique à ci-dessus, mais avec une fonction DELETE supplémentaire).\r\n\r\n&#x20;Les fichiers avec le suffixe \\_1₁ sont accessibles à tout utilisateur connecté (par exemple, /a\\_panels/panel\\_user\\_1.sql pour les mises à jour de profil utilisateur).&#x20;\r\n\r\nLes fichiers avec le suffixe \\_0 sont des fichiers de traitement intermédiaire (INSERT, UPDATE, DELETE) sans en-tête.\r\n\r\n&#x20;Les fichiers sans suffixe sont des fichiers liés aux visiteurs du site non connectés (par exemple, /b\\_about/orga\\_about.sql pour le menu « Qui sommes-nous ? »).\r\n\r\n## &#x20;1.2. Autorisations de niveau et de groupe\r\n\r\n&#x20;COOP permet de gérer deux autres types d'autorisations :&#x20;\r\n\r\n* **niveau (L)&#x20;**: autorisation d'accéder à certains champs d'une table ou à une table enfant particulière d'une table principale&#x20;\r\n* **groupe (G)&#x20;**: autorisation d'accéder à tous les champs d'une table, mais seulement à une partie des données.&#x20;\r\n\r\nPour comprendre l'utilité potentielle de ces deux filtres, imaginons un club sportif avec deux sections : football et rugby.\r\n\r\n* &#x20;Les membres disposent d'une autorisation CRUD « visualiseur » : ils peuvent consulter les actualités internes, publier des commentaires sur le forum, mais n'ont pas accès aux données des joueurs.&#x20;\r\n* Une autorisation CRUD « éditeur » est attribuée aux entraîneurs sportifs, aux préparateurs physiques et aux comptables.&#x20;\r\n* Une autorisation CRUD « superviseur » est attribuée aux managers, au médecin et au directeur financier.\r\n\r\n&#x20;La table des données joueurs peut être conçue de deux manières :\r\n\r\n* &#x20;soit comme une table JOUEUR avec les champs : L1\\_données\\_sportives\\_joueur, L2\\_données\\_médicales\\_joueur, L3\\_données\\_financières\\_joueur,\r\n* &#x20;soit comme une table JOUEUR principale (ID\\_joueur, nom\\_joueur) et trois tables liées : L1\\_SPORT (ID\\_joueur, données\\_sport), L2\\_MÉDICALES (ID\\_joueur, données\\_médicales), L3\\_FINANCIÈRES (ID\\_joueur, données\\_financières).&#x20;\r\n\r\nNous attribuons ensuite les autorisations de niveau 1 aux entraîneurs sportifs, de niveau 2 aux gardiens et de niveau 3 aux comptables. Cela garantit que chaque responsable ne voit que les données qui le concernent (et évite que chacun ait accès à des données médicales ou financières sensibles). De plus, vous pouvez insérer un champ « groupe » dans chaque table, avec la valeur G1 pour le football et G2 pour le rugby.\r\n\r\n&#x20;Un entraîneur de niveau 1 ne pourra consulter et modifier que les données de niveau 1 (données sportives) des joueurs de football. Des requêtes CREATE peuvent également être configurées, de sorte qu'un enregistrement créé par un entraîneur de niveau 1 prenne automatiquement la valeur G1. Pour les responsables, nous pouvons conserver le filtre L (les données médicales ne sont visibles que par un médecin), mais leur donner accès à tous les joueurs, avec des droits de suppression.\r\n\r\n&#x20;La combinaison des trois types d'autorisations (CRUD, L, G) couvre un très large éventail de situations. Dans une entreprise, vous pouvez associer chaque service à un groupe ; Dans une école, vous pouvez créer des combinaisons entre classes et niveaux…&#x20;\r\n\r\n## 1.3 Principe de répartition des droits des modules&#x20;\r\n\r\nLes droits sont répartis par section :\r\n\r\n* &#x20;**/a\\_ modules&#x20;**: admin (5) administration générale du site, gestion des utilisateurs, débogage, …\r\n* **&#x20;/b\\_modules** : superviseur (4) contenu général, descriptions des organisations et des membres, validation des événements…&#x20;\r\n* /**c\\_ modules** : tous les utilisateurs connectés (1) avec modération finale par l’administrateur (5)\r\n* **&#x20;/d\\_ et /e\\_ modules** : éditeurs (3) avec modération par le superviseur (4) COOP ne valorise pas les filtres L et G. Cela aurait pu être possible sur les modules PRM et projet pour séparer les équipes, affecter certaines équipes à certaines tâches, ou répartir les équipes selon l’emplacement du bâtiment.\r\n	help_dev	FR	3	active	2025-02-22 11:25:23+01	2025-06-17 15:23:07.300785+02
51	4. Dossiers et fichiers	# 1. Dossiers et fichiers\r\n\r\n## 1.1. Nommage des dossiers\r\n\r\nLes dossiers regroupent les fichiers d'un module ou d'un sous-module donné (voir approche modulaire).\r\n\r\nLe nommage des dossiers repose sur :\r\n\r\n* un préfixe qui fait référence à la section à laquelle appartient le fichier (voir structure générale de COOP).\r\n* un rappel du nom de la table.\r\n\r\nexemple : /a\\_panels\r\n\r\n## 1.2. Nommage des fichiers\r\n\r\nLe nommage des fichiers repose sur :\r\n\r\n* un terme évoquant intuitivement la table associée au module ;\r\n* un terme évoquant le composant du module : main, archive, doc… ;\r\n* un terme évoquant la requête SQL ou le composant SQLPage : EDIT, FORM…\r\n* un suffixe faisant référence aux droits de l'utilisateur : \\_3 ou \\_4\r\n\r\nExemple :\r\n\r\nmy\\_table\\_main\\_display\\_4.sql → Le fichier ne peut être ouvert que par un utilisateur disposant des droits superviseur. Il concerne la table/module « my\\_table ». « main » signifie que nous sommes sur le processeur central du module et que la requête est soit une table, soit une liste.\r\n\r\nmy\\_table\\_archive\\_display\\_4.sql → Le fichier ne peut être ouvert que par un utilisateur disposant des droits administrateur. Il concerne la table/module « my\\_table ». « archive » signifie que nous sommes sur les colonnes où la valeur de « may\\_table\\_status »="archived" indique que la requête est une liste. Composant\r\n\r\nmy\\_table\\_main\\_create\\_0.sql → Le fichier est un fichier de traitement, sans en-tête, avec une requête CREATE. Il concerne la table/module « my\\_table ».\r\n\r\nCela engendre des noms de chemins de fichiers assez complexes, mais permet une lecture intuitive (pas besoin d'ouvrir le fichier pour connaître son contenu et son rôle) et évite toute confusion entre des modules quasi jumeaux (par exemple, les modules de forum et de débogage). Ceci est particulièrement utile lors de la conception d'un site web, surtout en mode collaboratif.\r\n\r\nUne nomenclature cohérente des fichiers facilite le clonage des modules. Il suffit d'effectuer une série d'opérations de copier/coller/renommer pour créer un nouveau module à partir d'un module de référence.\r\n\r\n## 1.3 Contenu du dossier\r\n\r\nLe dossier contient une série de fichiers que l'on peut qualifier de cœur du module et que l'on identifie par le terme « main ». Par exemple :\r\n\r\n* my\\_table\\_main\\_display\\_4.sql : liste ou table permettant d'afficher les données de la table (le 4 indique que ce fichier ne peut être ouvert que par un superviseur disposant des droits de suppression).\r\n* my\\_table\\_main\\_display\\_3.sql : liste ou table permettant d'afficher les données de la table (le 4 indique que ce fichier ne peut être ouvert que par un éditeur disposant des droits de lecture, de création et de modification).\r\n* my\\_table\\_main\\_form\\_3.sql : formulaire permettant de créer les données.\r\n* my\\_table\\_main\\_edit\\_3.sql : formulaire permettant de mettre à jour les données.\r\n* my\\_table\\_main\\_form\\_4.sql : formulaire permettant de créer les données (le superviseur peut avoir accès à certains champs supplémentaires par rapport à l'éditeur. Par exemple, il contrôle le champ « my\\_table\\_status », qui autorise la mise en ligne ou l'archivage d'un enregistrement).\r\n* my\\_table\\_main\\_edit\\_4.sql : formulaire de mise à jour des données\r\n* my\\_table\\_main\\_create\\_0.sql : traitement d'insertion des données dans la base de données\r\n* my\\_table\\_main\\_update\\_0.sql : traitement d'insertion des données dans la base de données\r\n* my\\_table\\_main\\_delete\\_0.sql : traitement de suppression des données de la base de données\r\n\r\nAutour du cœur « main » du dossier, selon la complexité du module, nous créons avec la même logique les fichiers liés aux fonctions secondaires :\r\n\r\n* my\\_table\\_doc\\_display\\_4.sql : si la fonction principale du module est la description d'une entreprise, les fichiers « doc » concernent le traitement des documents associés à chaque entreprise. Nous pouvons également disposer de fichiers pour des fonctionnalités spécifiques :\r\n* my\\_table\\_archive\\_display\\_4.sql : visualisation des données archivées\r\n* my\\_table\\_anonym\\_0.sql : traitement d'anonymisation des données (pour éviter la suppression des données dans les tables avec des contraintes de clé étrangère)\r\n* my\\_table\\_csv\\_0.sql : traitement pour Exportation de données au format CSV. Nous pouvons systématiquement ajouter un fichier 404.sql dans chaque dossier. Ceci est très utile en développement, où des erreurs de chemin peuvent survenir. Certains dossiers COOP contiennent de nombreux fichiers. Cela résulte du choix d'appliquer le principe d'une fonction/fonctionnalité par fichier. Une application plus compacte pourrait être obtenue en regroupant plusieurs fonctions dans un seul fichier, mais COOP est un exercice d'apprentissage où la lisibilité a été privilégiée aux performances.\r\n\r\n1.4. Contenu du fichier\r\n\r\nLes fichiers standard présentent une structure typique :\r\n\r\n* un en-tête avec un filtre sur le niveau d'autorisation de l'utilisateur\r\n\r\nSELECT \\\\'dynamic\\\\' AS component, sqlpage.run\\_sql(\\\\'a\\_shells/shell\\_5.sql\\\\' AS properties;\r\n\r\n* (facultatif) la déclaration de certaines variables\r\n\r\nSET my\\_variable =\\\\...\r\n\r\n* un chemin de navigation :\r\n\r\nSELECT \\\\'breadcrumb\\\\' AS component;\r\n\r\n* ou un panneau de gestion\r\n\r\nSELECT \\\\'datagrid\\\\' AS component;\r\n\r\n* ou des boutons/alertes\r\n\r\nSELECT \\\\'button\\\\' AS component; SELECT \\\\'alert\\\\' AS component;\r\n\r\n* le composant principal :\r\n\r\nSELECT \\\\'form\\\\' AS component; SELECT \\\\'table\\\\' AS component; SELECT \\\\'list\\\\' AS component;\r\n\r\n* avec un lien vers le(s) fichier(s) de traitement\r\n\r\ncreate\\_0.sql, delete\\_0.sql\r\n\r\nLes fichiers de traitement (avec un suffixe 0) ont une structure plus simple :\r\n\r\n* pas d'en-tête\r\n* (facultatif) la déclaration de certaines variables : SET my\\_variable =...\r\n* une requête SQL : INSERT, UPDATE, DELETE\r\n* un retour SELECT \\\\'redirect\\\\' AS component ;\r\n\r\nDans les fichiers de traitement, les listes de champs sont souvent écrites avec un champ/une ligne ; cela facilite la lecture et la correction.\r\n\r\n# 2. Structures des tables\r\n\r\n## 2.1. Nommage des tables et des colonnes\r\n\r\nLe choix a été fait de nommer les colonnes de la manière la plus explicite possible, en rappelant le nom de la table dans le nom de la colonne. Cela simplifie l'écriture des requêtes, mais d'une part, cela facilite leur lecture et, d'autre part, cela évite les ambiguïtés entre les tables (exemple : user\\_first\\_name ne peut pas être confondu avec member\\_first\\_name) ou la confusion entre le nom d'une colonne et les termes réservés (exemple : user\\_role ne peut pas être confondu avec le terme réservé role).\r\n\r\n## 2.2. Structures des tables\r\n\r\nSi l'objectif est de publier des données sur un site web, la structure des tables doit être adaptée à cet objectif. Les tables sont construites autour de 4 types de colonnes :\r\n\r\n* colonnes de clés primaires et étrangères ;\r\n* colonnes de données ;\r\n* colonnes de gestion des données ;\r\n* colonnes de métadonnées.\r\n\r\nColonnes de clés primaires et étrangères : elles contribuent à la cohérence de la base de données, mais jouent un rôle important dans la gestion du site web pour l'écriture des chemins de navigation d'un écran à l'autre :\r\n\r\nmy\\_file.sql?table2\\_id='||$table2\\_id\r\n\r\nLes colonnes de gestion des données sont particulièrement intéressantes dans le contexte d'un site web servant d'outil de gestion des données. Par exemple :\r\n\r\n* le champ « my\\_table\\_status » avec les valeurs possibles : en ligne, brouillon, archivé permet de gérer la publication des données.\r\n* Le champ « my\\_table\\_selected » (avec les valeurs possibles : oui, non) vous permettra d'effectuer des sélections sur un groupe de données pour les modifier par lots.\r\n* Le champ « my\\_table\\_public\\_private » (avec les valeurs possibles : public, privé) vous permettra de gérer la publication des données sur le site public ou pour les utilisateurs connectés.\r\n* Les champs « my\\_table\\_category » ou « my\\_table\\_type » vous permettront d'utiliser la même table pour deux modules distincts ou de configurer des filtres dans l'affichage des données.\r\n\r\nLes colonnes de métadonnées décrivent les données. On peut ainsi indiquer qui a créé les données, quand elles ont été créées, à qui elles sont destinées, etc. Cela peut être utile pour certains traitements :\r\n\r\n* Les champs « created\\_at », « update\\_at » permettent, par exemple, de supprimer de l'affichage les événements dont la date est passée.\r\n* Les champs « author\\_id » et « recipient\\_id » seront centraux dans le module « chat ».\r\n	help_dev	FR	4	active	2025-02-22 11:26:03+01	2025-06-17 15:37:12.786458+02
53	5. Volet « corporate » et « community »	# 1. Modules « Site web d'entreprise » et « Communauté »\r\n\r\n## 1.1. « Site web d'entreprise »\r\n\r\nLe site web est conçu pour une gestion dynamique de tous les éléments des tables. Les seules informations codées en dur à configurer lors de l'installation de COOP sont l'orga\\_dept\\_id dans $orga\\_footer, $orga\\_dept\\_name et $logo dans /var/www/coop/a\\_shells/shell\\_core.sql. Par défaut, l'orga\\_dept\\_id est défini sur « 2 », mais si vous avez modifié la table orga\\_dept, cette valeur peut être adaptée. Vous devrez peut-être effectuer les mêmes ajustements dans les fichiers du dossier /var/www/coop/b\\_about.\r\n\r\nLa table info\\_sections permet de renseigner les informations générales et légales de votre organisation : conditions générales, mentions légales, informations administratives, etc. Vous pouvez accéder à cette table en étant connecté en tant qu'administrateur. Le lien se trouve dans le tableau de bord « INFO SITE ».\r\n\r\nToutes les autres informations sont gérées via le panneau de supervision : FAQ, organisation et services, membres, actualités, événements, lieux.\r\n\r\nCOOP permet une gestion simple des membres d'une association ou d'une petite entreprise : profil, fonction au sein de l'organisation… Dans le cas d'une association, vous pouvez suivre les adhésions grâce à la colonne « date\\_last\\_subscription ».\r\n\r\nLe module « Événements » permet une gestion simple des événements et réunions : date, lieux, plan, localisation, inscription, tarifs…\r\n\r\nLe module « Actualités » est configuré sur un paramètre d'affichage de 3 mois.\r\n\r\n## 1.2. Module « Communauté »\r\n\r\nLe module « Espaces de travail » combine plusieurs modules. Il s'agit d'une version simple et simplifiée des modules proposés dans les grandes applications telles qu'Office 365 ou Google Workspace. Cependant, au fil des ans, ces applications sont devenues de plus en plus riches en fonctionnalités et sont parfois surdimensionnées pour les petites communautés de travail.\r\n\r\nL'accent a été mis sur l'ergonomie : rejoindre ou quitter un groupe de travail se fait en un clic (join\\_0.sql, quit\\_0.sql). Le créateur d'un groupe de travail devient son coordinateur et est le seul à pouvoir créer une réunion. Il peut également désigner un ou plusieurs autres participants comme coordinateurs ; ces derniers pourront alors également créer des réunions. Le coordinateur peut décider de fermer le groupe de travail. Cela équivaut à changer son statut en « archivé », mais cela ne le supprime pas. Seuls les superviseurs peuvent supprimer définitivement un espace de travail.\r\n\r\nLe module comprend également un forum général, un forum de débogage (pour améliorer le site web ou l'application COOP) et un chat, un forum individuel.\r\n\r\nL'introduction de modules « communautaires » dans COOP contribue à la volonté de disposer de tous les outils nécessaires à la gestion de projet. On observe souvent une dispersion du travail en équipe entre une application de gestion de projet, une application de messagerie, une application de gestion de groupe, etc. Cependant, il est difficile de concurrencer les applications dédiées et, par conséquent, les modules COOP restent très simples, voire simplistes.\r\n	help_dev	FR	5	active	2025-02-22 11:27:28+01	2025-06-17 15:39:28.180021+02
61	3. Rights, Permissions, User privileges	## 1.1. CRUD permissions\r\n\r\nCOOP distinguishes several roles for logged-in users:\r\n\r\n* **viewer**: this role gives access to read internal information (news, agenda, FAQ) and post in the forum\r\n* **editor:** this role enables users to read, create and edit content\r\n* **supervisor**: this role allows you to read, create, edit and delete content\r\n* **admin**: this role is mainly dedicated to site management and has control over users.\r\n\r\nUsers create their own accounts and passwords. By default, they have no role. Their permission level will be decided by the admin. There is therefore no circulation of passwords at any time, and they are not stored in the database (only the hash\\_password).\r\n\r\nThe admin is informed of account creation requests via a dedicated RSS feed (/a\\_rss\\_feed/rss\\_new\\_users\\_5.sql).\r\n\r\nAccess to sql files is filtered by a specific shell component:\r\n\r\n* /a\\_shells/shell\\_2.sql for viewers\r\n* /a\\_shells/shell\\_3.sql for editors\r\n* /a\\_shells/shell\\_4.sql for supervisors\r\n* /a\\_shells/shell\\_5.sql for admins\r\n\r\nAfter verifying the user's role, each shell calls a shell\\_core (/a\\_shells/shell\\_core.sql), which displays the user's permissions menu.\r\n\r\nTo make it easier to find your way around files according to permission levels, we've adopted the principle of using suffixes at the end of the file name:\r\n\r\n* /news\\_private\\_display\\_3.sql: editor file for internal news list\r\n* /news\\_private\\_display\\_4.sql: supervisor file for listing internal news (same as above, but with an additional DELETE function).\r\n* Files with the suffix \\_1₁ are files accessible to any logged-in user (e.g. /a\\_panels/panel\\_user\\_1.sql for user profile updates).\r\n* Files with the suffix \\_0 are intermediate processing files (INSERT, UPDATE, DELETE) without a header.\r\n* Files without a suffix are files linked to site visitors who are not logged in (e.g. /b\\_about/orga\\_about.sql for the "Who are we?" menu).\r\n\r\n## 1.2. Level and Group permissions\r\n\r\nCOOP includes the ability to manage 2 other types of permissions:\r\n\r\n* level (L): permission to access certain fields in a table, or a particular child table of a main table\r\n* group (G): permission to access all the fields in a table, but only part of the data.\r\n\r\nTo understand the possible usefulness of these two filters, let's imagine a sports club with 2 sections: soccer and rugby:\r\n\r\n* members are assigned a CRUD "viewer" permission: they can consult internal news, post comments on the forum... but have no access to player data\r\n* an "editor" CRUD permission is assigned to sports coaches, trainers and accountants\r\n* a CRUD "supervisor" permission is assigned to managers, the doctor and the financial director.\r\n* The player data table can be designed in 2 ways: either as a PLAYER table with fields: L1\\_player\\_sport\\_data, L2\\_player\\_medical\\_data, L3\\_player\\_financial\\_data or as a main PLAYER table (player\\_id, player\\_name) and 3 linked tables:L1\\_SPORT (player\\_id, sport\\_data), L2\\_MEDICAL (player\\_id, medical\\_data), L3\\_FINANCIAL (player\\_id, financial\\_data).\r\n* We then assign L1 permission to sports coaches, L2 to caretakers and L3 to accountants. This ensures that each manager only sees the data relevant to him or her (and avoids everyone having access to sensitive medical or financial data).\r\n* In addition, you can insert a "group" field in each table, with the value G1 for soccer and G2 for rugby. A G1 coach will only be able to consult and edit level 1 data (sports data) for soccer players. CREATE queries can also be set up, so that a record created by a G1 coach will automatically take the value G1.\r\n* For managers, we can keep the L filter (medical data is only visible to a doctor), but give them access to all players, with data deletion rights.\r\n\r\nThe combination of the three types of permissions (CRUD, L, G) covers a very wide range of situations. In a company, you can associate each department with a group; in a school, you can create combinations between classes and levels...\r\n\r\n## 1.3 Module rights distribution principle\r\n\r\nRights are distributed by section:\r\n\r\n* /a\\_ modules: admin (5) general site administration, user management, debugging, ...\r\n* /b\\_ : supervisor (4) general content, organization and member descriptions, event validation...\r\n* /c\\_ modules: all logged-in users (1) with ultimate moderation by the administrator (5)\r\n* /d\\_ and /e\\_ modules: editors (3) with supervisor moderation (4)\r\n\r\nCOOP does not value the L and G filters. This could have been possible on the PRM and project modules to separate teams or assign certain teams to certain jobs, or distribute teams according to building location.\r\n	help_dev	EN	3	active	2025-02-22 16:13:44+01	2025-06-17 14:39:53.605584+02
59	 2. COOP general structure	# 1. COOP general structure\r\n\r\nThere are many commercial or open source, no-code applications available to meet the most classic needs expected of a web site. But there are cases where the database structure is too specific to use one of these applications. The website must therefore be built around the database. This is the purpose of SQLPage, a major advantage of which is that it is a "simple code" application accessible to people whose core business is not IT development, but who need to put a specific database online.\r\n\r\nPutting a database online is not limited to putting the data itself online. It also involves the development of other peripheral functions expected of a website:\r\n\r\n* "**admin**" function: website administration, user rights management and maintenance,\r\n* "**corporate**" function: presenting the structure that publishes the website: who we are, what we do, presenting our team...\r\n* "**contact**" function: provide a contact and exchange interface for visitors: contact form, registration form, FAQ...\r\n* "**interface**" function: to provide an interface for feeding and maintaining the database that justified the creation of the site,\r\n* **"community**" function: offering collaborative tools for editors who feed the database or produce content for the site.\r\n\r\nCOOP's structure is designed to meet all these functions. The folders are logically organized, with functions identified by alphabetical suffixes.\r\n\r\n* The first group covers admin functions\r\n* **group A suffix /a\\_**: site management admin modules: sessions, users, info, rss...\r\n* The second group covers website and community functions\r\n* **group B suffix /b\\_**: corporate and visitor contact modules\r\n* **group C suffix /c\\_**: community modules: forum, chat, wokspaces...\r\n* and a third group of files specific to COOP whose theme is the management of supported housing rehabilitation projects (interface function):\r\n* **group D suffix /d\\_**: PRM (project relationship management) modules\r\n* **group E suffix /e\\_**: PMS (project management system) modules\r\n* Finally, documents, images, etc. are grouped in special folders:\r\n* **group X suffix /x\\_**: document storage modules.\r\n\r\nIn order to put a specific database online (groups D and E), it is necessary to ensure the development of the other components and at least the modules of group A.\r\n\r\nBy default, CO-OP offers full functionality.\r\n\r\nIf you wish to use CO-OP only for project management (group A, D, E), simply :\r\n\r\n* rename the a\\_panels folder → a\\_panels\\_default\r\n* rename the a\\_panels\\_project folder → a\\_panels\r\n* rename the a\\_shells folder → a\\_panels\\_default\r\n* rename the a\\_shells\\_project folder → a\\_shells\r\n\r\nIf you wish to use CO-OP solely for managing an associative or corporate website (group A, B, C), simply:\r\n\r\n* rename the folder a\\_panels → a\\_panels\\_default\r\n* rename the folder a\\_panels\\_website → a\\_panels\r\n* rename the folder a\\_shells → a\\_panels\\_default\r\n* rename the folder a\\_shells\\_website→ a\\_shells.\r\n\r\n# 2. COOP modular approach\r\n\r\n## 2.1. General principle\r\n\r\nA module is defined as all the elements required to create a particular functionality. Each component A, B, C, D, E corresponds to a coherent set of modules.\r\n\r\n## 2.2 Simple module\r\n\r\nA simple module consists of :\r\n\r\n* a table\r\n* a simple folder (see folder contents) containing files for creating, editing, publishing and deleting data,\r\n* a link in the menu bar\r\n* a link in the admin, supervisor or editor administration table, as appropriate\r\n\r\nExample of a simple module: news (folder /b\\_news), which enables articles to be published either on the public site or on the internal site.\r\n\r\n## 2.3 Complex module\r\n\r\nA complex module is made up of :\r\n\r\n* several tables, sometimes linked by constraints (foreign keys)\r\n* several folders containing files for creating, editing, publishing and deleting data in each table,\r\n* a link in the menu bar\r\n* a link in the admin, supervisor or editor administration table, as appropriate\r\n\r\nexample of a complex module: workspaces (folder /c\\_wokspaces), which combines tables for forum management, chat, document sharing and meeting organization.\r\n\r\n## 2.4. Dependency between modules\r\n\r\nEven for simple modules, there are dependencies:\r\n\r\n* all modules depend on Group A modules: users, sessions, shells, panels, info\r\n* there are dependencies between certain modules within group B (e.g.: members, orga\\_dept, events, place, place\\_space tables depend on orga)\r\n* certain modules in group C are dependent on tables in group B (meetings and workmeetings are dependent on place\\_space, and therefore on orga and orga\\_dept)\r\n* group D modules depend only on group A base modules\r\n* group E modules depend on group D modules and group A base modules\r\n\r\nDependency links can be visualized by browsing through tables to identify references to an external table, often (but not always) to a foreign key.\r\n\r\nThe deletion of certain records in a table implies the deletion of related records in other tables. In this case, COOP systematically displays a warning message before deleting a parent record. A "my\\_table\\_status" field has been introduced in most tables. This allows a record to be archived rather than deleted. For tables of type users, members, etc., data anonymization is provided, which can be used when a person requests the deletion of their personal data from the database.\r\n\r\n## 2.5. Cloning modules\r\n\r\nIf a certain consistency is maintained in the naming of tables, columns, folders and files, it is possible to create a new module, by a succession of copy/paste/rename operations based on the structure of a reference module. This doesn't mean you don't have to do some coding if you add or remove columns from certain tables, but it does save you a lot of time on the overall coding of the module.\r\n	help_dev	EN	2	active	2025-02-22 16:12:26+01	2025-06-17 14:43:48.038399+02
60	4. Files, folders, tables structure	# 1. Folders and files\r\n\r\n## 1.1.  Folders naming\r\n\r\nFolders group together the files of a given module or sub-module (see modular approach).\r\n\r\nFolder naming is based on :\r\n\r\n* a prefix that refers to the section to which the file belongs (see COOP general structure).\r\n* a reminder of the table name\r\n\r\nexample :\r\n\r\n/a\\_panels\r\n\r\n## 1.2. File naming\r\n\r\nFile naming is based on :\r\n\r\n* a term that intuitively evokes the table associated with the module,\r\n* a term that evokes the module component: main, archive, doc....,\r\n* a term that evokes the sql query or SQLPage component : EDIT, FORM...\r\n* a suffix that refers to the user rights : \\_3 or \\_4\r\n\r\nExample:\r\n\r\n* my\\_table\\_main\\_display\\_4.sql → the file can only be opened by a user with supervisor rights, it concerns the "my\\_table" table/module, "main" means that we're on the module's central processing and display that the query is either a table or list component,\r\n* my\\_table\\_archive\\_display\\_4.sql → the file can only be opened by a user with administrator rights, it concerns the "my\\_table" table/module, "archive" means we're on columns where the value of "may\\_table\\_status"="archived" and display that the query is either a component\r\n* my\\_table\\_main\\_create\\_0.sql → the file is a processing file, without a header, with a CREATE request. it concerns the "my\\_table" table/module.\r\n\r\nThis leads to rather cumbersome file path names, but makes for intuitive reading (no need to open the file to find out its contents and role) and avoids possible confusion between modules that are almost twins (e.g. forum and debug modules). This is particularly useful when designing a website, especially if this is done in collaborative mode.\r\n\r\nConsistent file naming facilitates module cloning. Simply perform a series of copy/paste/rename operations to create a new module from a reference module.\r\n\r\n## 1.3 Folder contents\r\n\r\nThe folder contains a series of files that can be referred to as the heart of the module, and which are identified by the term "main". For example :\r\n\r\n* my\\_table\\_main\\_display\\_4.sql: the list or table used to display table data (the 4 indicates that this file can only be opened by a supervisor with DELETE permission).\r\n* my\\_table\\_main\\_display\\_3.sql: the list or table used to display table data (the 4 indicates that this file can only be opened by an editor with read, create and modify permissions)\r\n* my\\_table\\_main\\_form\\_3.sql: the form used to create data\r\n* my\\_table\\_main\\_edit\\_3.sql: the form used to update data\r\n* &#x20;my\\_table\\_main\\_form\\_4.sql: the form used to create data (the supervisor may have access to certain additional fields compared to the editor. For example, the supervisor controls the "my\\_table\\_status" field, which authorizes a record to be put online or archived).\r\n* my\\_table\\_main\\_edit\\_4.sql: the form used to update data\r\n* my\\_table\\_main\\_create\\_0.sql: data insertion processing in the database\r\n* my\\_table\\_main\\_update\\_0.sql: data insertion processing in the database\r\n* my\\_table\\_main\\_delete\\_0.sql: processing used to delete data from the database\r\n\r\nAround the "main" heart of the folder, depending on the complexity of the module, we create with the same logic the files linked to the secondary functions:\r\n\r\n* my\\_table\\_doc\\_display\\_4.sql: if the main function of the module is the description of a company, the "doc" files concern the processing of documents associated with each company We can also have files for specific functionalities:\r\n* my\\_table\\_archive\\_display\\_4.sql: visualization of archived data\r\n* my\\_table\\_anonym\\_0.sql: processing to anonymize data (to avoid deleting data in tables with foreign key constraints)\r\n* my\\_table\\_csv\\_0.sql: processing for csv export of data. We can systematically add a 404.sql file in each folder. This is quite useful during development where we can make mistakes on the paths. Some COOP folders contain a lot of files. This results from a choice to apply the principle of one function/functionality per file. A more compact application could be achieved by grouping several functions in a single file, but COOP is a learning exercise where readability was preferred to performance.\r\n\r\n## 1.4. File contents\r\n\r\nThe standard files have a typical structure:\r\n\r\n* a header with a filter on the user permission level\r\n\r\nSELECT \\\\'dynamic\\\\' AS component, sqlpage.run\\_sql(\\\\'a\\_shells/shell\\_5.sql\\\\' AS properties;\r\n\r\n* (optional) the declaration of some variables\r\n\r\nSET my\\_variable =\\\\...\r\n\r\n* a navigation path:\r\n\r\nSELECT \\\\'breadcrumb\\\\' AS component;\r\n\r\nor a management panel\r\n\r\nSELECT \\\\'datagrid\\\\' AS component;\r\n\r\nor buttons/alerts\r\n\r\nSELECT \\\\'button' AS component;  SELECT \\\\'alert' AS component;&#x20;\r\n\r\n* the main component:\r\n\r\nSELECT \\\\'form' AS component; SELECT \\\\'table' AS component;  SELECT \\\\'list' AS component;&#x20;\r\n\r\nwith a link to the processing file(s)\r\n\r\ncreate\\_0.sql, delete\\_0.sql\r\n\r\nThe processing files (with a suffix 0) have a simpler structure:\r\n\r\n* no header\r\n* (optional) the declaration of some variables SET my\\_variable =...\r\n* a SQL query: INSERT, UPDATE, DELETE\r\n* a return SELECT \\\\'redirect\\\\' AS component ;\r\n\r\nIn processing files, field lists are often written with one field/one line; this makes reading and correction easier).\r\n\r\n# 2. Table structures\r\n\r\n## 2.1. Naming tables and columns\r\n\r\nThe decision was made to name the columns as explicitly as possible, with a reminder of the table name in the column name. This makes writing queries more cumbersome, but on the one hand it makes them easier to read and on the other hand it avoids ambiguities between tables (example: user\\_first\\_name cannot be confused with member\\_first\\_name) or confusion between the name of a column and reserved terms (example: user\\_role cannot be confused with the reserved term role).\r\n\r\n## 2.2. Table structures\r\n\r\nIf the objective is to publish data as part of a website, the structure of the tables must be adapted to this objective. The tables are built around 4 types of columns:\r\n\r\n* primary and foreign key columns,\r\n* data columns,\r\n* data management columns,\r\n* metadata columns.\r\n\r\n**Primary and foreign key columns**: they help maintain the consistency of the database but in the management of the website they will play an important role in writing paths for navigation from one screen to another :\r\n\r\nmy\\_file.sql?table2\\_id='||$table2\\_id\r\n\r\n**Data management columns** are of particular interest in the context of a website that will serve as a data management tool, for example:\r\n\r\n* the "my\\_table\\_status" field with the possible values: online, draft, archived will allow you to manage the publication of data.\r\n* the "my\\_table\\_selected" field with the possible values: yes, no will allow you to make selections on a group of data for batch modification,\r\n* the "my\\_table\\_public\\_private" field with the possible values: public, private will allow you to manage the publication of data either on the public site or for connected users.\r\n* The "my\\_table\\_category" or "my\\_table\\_type" fields will allow you to use the same table for 2 separate modules or set up filters in the data display.\r\n\r\n**Metadata columns** are data that describe the data. We can therefore describe who created the data, when it was created, who it is intended for, etc. This can be useful in certain treatments:\r\n\r\n* The "created\\_at, updated\\_at" fields will allow, for example, to remove events whose date has passed FROM the display,\r\n* the "author\\_id" and "recipient\\_id" fields will be central in the "chat" module\r\n	help_dev	EN	4	active	2025-02-22 16:13:00+01	2025-06-17 14:50:00.952174+02
56	7. Trucs et astuces	# 1. Trucs et astuces\r\n\r\nCOOP est basé sur la version de base de SQLPage, sans scripts, composants maison ni fonctions avancées. Certaines situations nécessitent donc des solutions de contournement. Celles-ci résident principalement dans la structure des tables, avec l'utilisation de colonnes spécialement créées pour faciliter la gestion des données et la construction des requêtes. Les trucs et astuces suivants ne sont pas forcément totalement orthodoxes et nécessitent parfois des ajustements.\r\n\r\n## 1.1. Éléments et sous-éléments (orga/orga\\_dept, place/place\\_space, building/building\\_room)\r\n\r\nLa section « corporate » de COOP (section B) décrit la structure responsable de la publication du site web. Dans COOP, il est prévu que toute organisation (table orga) puisse avoir des « départements » (table orga\\_dept). Prenons l'exemple d'un club sportif : il pourrait avoir une section football et une section rugby. Intuitivement, nous pourrions organiser le lien entre les tables orga et orga\\_dept :\r\n\r\n* club → orga\\_id=1\r\n* section football → orga\\_id=1, orga\\_dept=1\r\n* section rugby → orga\\_id=1, orga\\_dept=2\r\n\r\nEn effet, cela pose quelques problèmes pour formuler plusieurs cas dans une même requête SQL, comme par exemple prendre en compte des clubs non organisés en sections (les joueurs doivent-ils être rattachés au club ou à la section ?…). Cela nécessite des requêtes sur les tables orga et orga\\_dept. Plusieurs solutions permettent de contourner ce problème. Dans COOP, le principe adopté est de créer systématiquement un département fictif, de rang « principal » ("main") :\r\n\r\n* le club → orga\\_id=1, orga\\_name= "sporting club"\r\n* la section « principal » → orga\\_id=1, orga\\_dept=1, dept\\_rank= "principal", dept\\_name= "sporting club"\r\n* la section football → orga\\_id=1, orga\\_dept=2, dept\\_rank= "dept", dept\\_name= "foot"\r\n* la section rugby → orga\\_id=1, orga\\_dept=3, dept\\_rank= "dept", dept\\_name= "rugby"\r\n\r\nToutes les requêtes cibleront donc le niveau départemental. La création d'un département « principal » facilitera et clarifiera les processus tels que le rattachement des joueurs à leur section sportive et des employés de la direction du club à la section « principale »  ("main" (cela é ("main" vite de gérer le rattachement de certains employés à la table orga et d'autres à la table orga\\_dept). Ce principe est parfaitement adapté à une entreprise avec un siège social et des établissements, ou à une école avec plusieurs classes.\r\n\r\nLe même principe s'applique à la gestion des places. L'utilisation d'une table place\\_spaces permet de gérer les situations où une organisation possède plusieurs places ou plusieurs salles dans le même bâtiment (cas d'une école), ou plusieurs terrains dans le même complexe sportif. La création d'une place dans la table places (place\\_id=1, place\\_name= "my\\_place") crée automatiquement un espace dans la table spaces (space\\_id=1, place\\_id=1, space\\_rank= "main", space\\_name= "my\\_place").\r\n\r\nLe fonctionnement des forums repose également sur l'étiquetage du premier message comme « principal », les autres messages pouvant être qualifiés de « post ». Le principe utilisé s'avère assez robuste, mais il présente une dimension contre-intuitive lorsqu'on utilise COOP pour une organisation sans département ni lieu unique. Le pied de page de la page d'accueil du site web COOP repose sur une requête sur orga\\_dept\\_id="2". Il en va de même pour le contenu des sections du menu « À propos », qui repose sur la table « info\\_sections ». Ce principe permet d'envisager de rendre le menu « À propos » plus sophistiqué, par exemple pour présenter le profil des acteurs de chaque section ou des étudiants de chaque cours.\r\n\r\nL'astuce « principal » ("main"  est également utilisée lors de la création d'un nouveau projet : un workpckage « main » est créé. Ce workpckage couvrira la durée totale du projet et pourra être utilisé pour le suivi des coûts fixes ou la participation des architectes ou des consultants.\r\n\r\n## 1.2. Forum, débogage, chat\r\n\r\nCes trois modules reposent sur les mêmes tables : forum\\_topics, forum\\_messages. Le filtrage entre les forums s'effectue via la colonne « forum\\_type ». Forum et Debug sont des modules quasiment jumeaux. Leurs seules différences résident dans leur finalité : discussion générale dans un cas et signalement de bugs dans l'autre. Certaines colonnes (debug\\_target) ne seront pas utilisées dans le forum et les choix de catégories seront différents. Le chat se distingue par l'utilisation de deux colonnes de métadonnées, author\\_id et recipient, qui permettent de limiter les échanges sur le forum à deux personnes. La table forum\\_topics comprend les colonnes workspace\\_id et forum\\_group, qui permettent de créer des forums pour les participants d'un espace de travail ou d'un groupe d'utilisateurs (voir la notion de groupe dans la section droits et permissions).\r\n\r\n## 1.3. Liste de choix. Pattern\r\n\r\nLes listes de choix des menus déroulants sont pilotées par deux tables sous le contrôle de l'administrateur. Cela garantit la cohérence des listes et la possibilité de les modifier sans intervention sur les fichiers. De même, les règles RegEX sont pilotées par une table sous le contrôle de l'administrateur. Cela permet de les modifier si nécessaire.\r\n\r\n## 1.4. RSS\r\n\r\nDans la version de base de SQLPAGE (sans scripts), il n'est pas possible d'envoyer des notifications à un administrateur ou à un superviseur depuis SQLPage lors de la création d'un enregistrement. L'administrateur doit donc, par exemple, consulter la liste des comptes en attente pour débloquer les droits des nouveaux utilisateurs. Pour éviter de devoir consulter cette liste toutes les heures, des flux RSS ont été créés dans COOP (dossier /a\\_RSS-feed). L'administrateur peut ensuite coller le lien dans son client de messagerie de type Thunderbird et être informé au rythme qu'il a défini (toutes les heures, une fois par jour, etc.) d'une nouvelle inscription sur le site. Les fichiers de configuration des flux RSS doivent être codés manuellement, mais COOP intègre un module RSS pour décrire ces flux, ce qui permet de les afficher soit dans le menu « À propos » pour les flux grand public, soit dans les panneaux d'administration (administrateur, superviseur ou éditeur).\r\n\r\n1.5 Purge des fichiers documents et images\r\n\r\nDans COOP, il est possible de joindre des documents à une organisation, un groupe de travail, un bâtiment, etc. Par précaution, une limite de 5 Mo a été fixée pour la taille des documents, mais l'accumulation de tous les documents peut surcharger inutilement le serveur à long terme.\r\n\r\nLa procédure de purge des fichiers orphelins d'un serveur Linux a été décrite comme un processus utilisant le composant « step » de SQLPage dans le tableau de bord d'administration.\r\n	help_dev	FR	7	active	2025-02-22 11:29:06+01	2025-06-17 15:54:24.164774+02
4	3. Fonctionnement de l''équipe-projet	 ## Les grenouilles qui demandent un roi  \n*Jean de la Fontaine*\n\nLes grenouilles se lassant  \nDe l’état démocratique  \nPar leurs clameurs firent tant  \nQue Jupin les soumit au pouvoir monarchique.  \nIl leur tomba du ciel un roi tout pacifique :  \nCe roi fit toutefois un tel bruit en tombant,  \nQue la gent marécageuse,  \nCent fort sotte et fort peureuse,  \nS’alla cacher sous les eaux,  \nDans les joncs, dans les roseaux,  \nDans les trous du marécage,  \nSans oser de longtemps regarder au visage  \nCelui quelles croyaient être un géant nouveau.  \nOr c’était un soliveau,  \nDe qui la gravité fit peur à la première  \nQui, de le voir, s’aventurant,  \nOsa bien quitter sa tanière.  \nElle approcha, mais en tremblant.  \nUne autre la suivit, une autre en fit autant :  \nIl en vint une fourmilière ;  \nEt leur troupe à la fin se rendit familière  \nJusqu’à sauter sur l’épaule du roi.  \nLe bon sire le souffre, et se tient toujours coi.  \nJupin en a bientôt la cervelle rompue :  \nDonnez-nous, dit ce peuple, un roi qui se remue !  \nLe monarque des dieux leur envoie une grue,  \nQui les croque, qui les tue,  \nQui les gobe à son plaisir  \nEt grenouilles de se plaindre,  \nEt Jupin de leur dire ; Eh quoi ! votre désir  \nÀ ses lois croit-il nous astreindre ?  \nVous avez dû premièrement  \nGarder votre gouvernement ;  \nMais ne l’ayant pas fait, il vous devait suffire   \nQue votre premier roi fût débonnaire et doux.  \nDe celui-ci contentez-vous,  \nDe peur d’en rencontrer un pire.   	about	FR	3	active	2024-10-28 16:51:15+01	2025-03-06 09:45:09+01
1	1. Finalités du projet	## Le coq et le renard  \r\n*Jean de la Fontaine*\r\n\r\nSur la brandie d’un arbre était en sentinelle\r\n\r\nUn vieux coq adroit et matois.\r\n\r\nFrère, dit un renard, adoucissant sa voix,\r\n\r\nNous ne sommes plus en querelle ;\r\n\r\nPaix générale cette fois.\r\n\r\nJe viens te l’annoncer ; descends, que je t’embrasse :\r\n\r\nNe me retarde point, de grâce ;\r\n\r\nJe dois faire aujourd’hui vingt postes sans manquer.\r\n\r\nLes tiens et toi pouvez vaquer,\r\n\r\nSans nulle crainte, à vos affaires ;\r\n\r\nNous vous y servirons en frères.\r\n\r\nFaites-en les feux dès ce soir,\r\n\r\nEt cependant viens recevoir\r\n\r\nLe baiser d’amour fraternelle.\r\n\r\nAmi, reprit le coq, je ne pouvais jamais\r\n\r\nApprendre une plus douce et meilleure nouvelle\r\n\r\nQue celle\r\n\r\nDe cette paix ;\r\n\r\nEt ce m’est une double joie\r\n\r\nDe la tenir de toi. Je vois deux lévriers,\r\n\r\nQui, je m’assure, sont courriers\r\n\r\nQue pour ce sujet on envoie :\r\n\r\nIls vont vite, et seront dans un moment à nous.\r\n\r\nJe descends : nous pourrons nous entre-baiser tous.\r\n\r\nAdieu, dit le renard, ma traite est longue à faire :\r\n\r\nNous nous réjouirons du succès de l’affaire\r\n\r\nUne autre fois. Le galant aussitôt\r\n\r\nTire ses grègues, gagne au haut,\r\n\r\nMal content de son stratagème.\r\n\r\nEt notre vieux coq en soi-même\r\n\r\nSe mit à rire de sa peur ;\r\n\r\nCar c’est double plaisir de tromper le trompeur. 	about	FR	1	active	2024-10-28 14:36:38+01	2025-04-15 16:25:52.496127+02
57	0. For those who don't read the manuals	If you are unfamiliar with [the term\r\nRTFM](https://en.wikipedia.org/wiki/RTFM), you can explore the COOP\r\nwebsite directly, either as a simple visitor (not logged in), or by\r\nsuccessively using the various possible statuses: viewer, editor,\r\nsupervisor, admin.\r\n\r\nInstalling COOP is straightforward:\r\n\r\n-   download the entire COOP folder from Github\r\n\r\n-   paste this folder into /var/www\r\n\r\n-   release write permissions on sub-folders with an "x\\_" prefix (these\r\n    are used to download documents or images)\r\n\r\n-   in the terminal, go to the COOP folder: /var/www/coop\r\n\r\n-   launch SQLPage: /var/www/SQLPage/SQLPage.bin\r\n\r\n-   in your browser, go to: http://localhost:8080/\r\n\r\n-   start the tour.\r\n\r\nTo change roles, simply use the following identifiers:\r\n\r\n-   viewer1@coopcoop.net\r\n\r\n-   editor1@coopcoop.net\r\n\r\n-   supervisor1@coopcoop.net\r\n\r\n-   admin1@coopcoop.net\r\n\r\nwith password: CoopCoop1\r\n\r\nYou can create new users, but you\\'ll then need to switch to "admin"\r\nmode to set the rights of new administrators.\r\n\r\nIn the admin panel, you\\'ll find a "Help Dev" menu with COOP\\'s on-board\r\ndocumentation.\r\n\r\nTo complete the demo, in the admin, supervisor and editor panels,\r\nyou\\'ll find links to RSS feeds (see the principle of these feeds in\r\nHelp-Dev).	help_dev	EN	0	archived	2025-02-22 16:10:58+01	2025-04-15 14:49:40.639435+02
67	7. Tips and tricks	# 1. Tips and tricks\r\n\r\nCOOP is based on the basic version of SQLPage, without scripts, home-made components or advanced functions. There are therefore certain situations that require finding workarounds. These mainly reside in the structure of the tables with the use of columns specifically created to facilitate data management and query construction. The following tips and tricks are not necessarily completely orthodox and sometimes involve "tinkering".\r\n\r\n## 1.1. Elements and sub-element (orga/orga\\_dept, place/place\\_space, building/building\\_room)\r\n\r\nThe "corporate" section of COOP (section B) describes the structure that is responsible for publishing the website. In COOP, it has been planned that any organisations (table orga) can have "departments" (table orga\\_dept). If we take the example of a sports club, it could have a football section and a rugby section. Intuitively we could organize the link between the orga and orga\\_dept tables:\r\n\r\n* the club → orga\\_id=1\r\n* the football section → orga\\_id=1, orga\\_dept=1\r\n* the rugby section → orga\\_id=1, orga\\_dept=2\r\n\r\nIn fact, this poses some problems to formulate in a single SQL query several cases such as, for example, taking into account clubs that are not organized with sections (should the players be attached to the club or to the section?...). This requires queries on the orga table and on the orga\\_dept table. There are several ways to get around the problem. In COOP, the principle adopted is to systematically create a fictitious department, with a rank "main":\r\n\r\n* the club → orga\\_id=1, orga\\_name= "sporting club"\r\n* the "main" section → orga\\_id=1, orga\\_dept=1, dept\\_rank= "main", dept\\_name = "sporting club"\r\n* the football section → orga\\_id=1, orga\\_dept=2, dept\\_rank= "dept", dept\\_name= "foot"\r\n* the rugby section → orga\\_id=1, orga\\_dept=3, dept\\_rank= "dept", dept\\_name= "rugby"\r\n\r\nAll queries will therefore target the department level. The creation of a "main" department will facilitate and clarify processes such as the attachment of players to their sports section and club management employees to the "main" section (this avoids having to manage the attachment of certain employees to the orga table and others to the orga\\_dept table). The principle adapts well to a company with a head office and establishments or a school with several classes.\r\n\r\nThe same principle is applied for managing places. Using a place\\_spaces table allows you to manage situations where an organisation has several places or several rooms in the same building (case of a school), several fields on the same sports center. Creating a place in the places table (place\\_id=1, place\\_name= "my\\_place") automatically creates a space in the spaces table (space\\_id=1, place\\_id=1, space\\_rank= "main", space\\_name= "my\\_place"). The functioning of forums is also based on labeling the first message AS "main" the other messages can be qualified as "post". The principle used turns out to be quite robust, but it has a counter-intuitive dimension when using COOP for an organisation that does not have a department or a single place. The footer of the COOP website home page is based on a query on orga\\_dept\\_id="2". The same goes for the content of the sections of the "about" menu which is based on the "info\\_sections" table. The principle allows us to consider making the "about" menu more sophisticated, for example, to present the profile of the players in each section or the students in each class.\r\n\r\nThe "main" trick is also used when a new project is created : a workpckage "main" is created. This workpackage will have the duration of the whole project and can be used for the follow up of fixed costs or the participation of the architects or consultants.\r\n\r\n## 1.2. Forum, debug, chat\r\n\r\nThese three modules are based on the same tables: forum\\_topics, forum\\_messages. Filtering between forums is done using the "forum\\_type" column. Forum and Debug are almost twin modules. They are distinguished only by their purposes: general discussion in one case and bug reporting in the other. Some columns (debug\\_target) will not be used in forum and the category choices will be different. Chat is distinguished by the use of two metadata columns author\\_id and recipient which allow to limit exchanges on the forum to 2 people. The forum\\_topics table includes columns workspace\\_id, forum\\_group which allow to create forums for participants of a workspace or a group of users (see notion of group in the rights and permissions section).\r\n\r\n## 1.3. Choice list. Pattern\r\n\r\nThe choice lists in the drop-down menus are driven from 2 tables under the administrator's control. This ensures consistency in the lists and the ability to change these lists without having to intervene on the files. Similarly, the RegEX rules are driven from a table under the administrator's control. This allows them to be changed if necessary.\r\n\r\n## 1.4. RSS\r\n\r\nIn the base version of SQLPAGE (without scripts), it is not possible to send notifications to an admin or supervisor from SQLPage at the creation of a record. The admin must therefore, for example, consult the list of pending accounts to unlock the rights of new users. To avoid having to consult this list every hour, RSS feeds have been created in COOP (folder /a\\_RSS-feed). The admin can then paste the link into his Thunderbird-type mail client and he will be informed at the rate he has set (every hour, once a day, etc.) of a new registration on the site. The RSS feed configuration files must be coded by hand, but COOP integrates an RSS module for describing these feeds, which allows them to be displayed either in the "about" menu for general public feeds or in the admin, supervisor, editor administration panels.\r\n\r\n## 1.5 Purging document and image files\r\n\r\nIn COOP, it is possible to attach documents to an organisation, a work group, a building, etc. As a precaution, a limit of 5 MB has been set for the size of documents, but the accumulation of all documents can unnecessarily load the server in the long run.\r\n\r\n1. The procedure to purge a linux like server from orphan files has been described as a process with the "step" component of SQLPage in the admin dasboard.\r\n	help_dev	EN	7	active	2025-02-22 16:17:04+01	2025-06-17 14:53:57.366196+02
65	6. PRM and project management modules	# 1. PRM: Project Relationship Management\r\n\r\nThe acronym CRM: Customer Relationship Management is well known. The CRM approach is most often based on a binary relationship: seller <-> buyer, but a project is often a team effort and tools based on a binary relationship are not enough.\r\n\r\nIn the PRM approach we find the classic tables of address books for individuals (PRM1) and legal entities (PRM2). In COOP, we detail the employees who are the individuals linked to a legal entity, as in the HRM (human resources management) databases. This allows COOP to be used, for example, to form teams of players or manage the distribution of students in the classes making up a school.\r\n\r\nCOOP introduces another table, that of groups (PRM3) which allows all sorts of combinations: between individuals (a couple, a family, a group of volunteers), between companies (consortium, etc.), between companies and individuals. This table then allows you to solve problems on the construction intervention side. Indeed, a house is often owned not by one person but by a couple. You may also have to do work in a home shared by roommates. During the work, it is common for companies to temporarily join forces to respond to a call for tenders. In the specific case of COOP, we analyze the monitoring of construction sites carried out by a family and craftsmen. The PRM3 table allows you to manage situations such as the constitution of a sports team including, depending on the case, only amateur players or players and employees of the sports club.\r\n\r\n# 2. Project module\r\n\r\n## 2.1. Project module: general orientation\r\n\r\nCO-OP is primarily designed to manage and analyze building renovation projects involving mixed teams of professionals and non-professionals (ARA: auto réhabilitation accompagnée). CO-OP can also be used to monitor all aspects of a project: material and service flows, working hours, carbon footprint, waste flows, etc.\r\n\r\nCO-OP can, however, be transposed to other types of project structured around the notion of work packages/tasks and sequences/tasks.\r\n\r\nAnother aspect of CO-OP is that it offers a virtual workspace, a "hub" around the project, with modules for scheduling meetings, managing documentation and a forum. This avoids the dispersion often seen between a project management tool, documents scattered here and there, a separate messaging tool...\r\n\r\nCO-OP does not target complex projects. It favors a sober, ergonomic interface as a possible alternative to project management with excel® or calc® spreadsheets. These tools are very easy to use, but have their limitations. SQLPAge, which allows you to use a real database, overcomes these limitations. It is therefore aimed at a public of individuals carrying out a self-renovation or self-build project, or an association supporting individuals in this type of approach.\r\n\r\n## 2.2 Project module: functionalities\r\n\r\n### 2.2.1. Project management dashboard\r\n\r\nProject data can be tracked at the level of the entire project, or at the level of each workpackage. Users with supervisor rights can view through a datagrid dasboard :\r\n\r\n* timeline planning (planning and actual) with Gantt charts\r\n* expenses incurred, with details by expense type and schedule\r\n* overall carbon footprint of materials used (based on ienes catalog data)\r\n* total working time, by sequence, by participant\r\n* waste by work phase, by type and destination\r\n* building location\r\n* photos of buildings and rooms.\r\n\r\n### 2.2.2. Project management tools\r\n\r\nAll logged-in users with supervisor or editor rights can :\r\n\r\n* create and modify data concerning projects, work packages and sequences,\r\n* create and participate in meetings and discussion forums,\r\n* share documents,\r\n* describe buildings where work is to be carried out,\r\n* manage building-related pictures and plans.\r\n\r\n## 2.3. Project module: structure\r\n\r\nIn CO-OP, projects are made up of wokpackages, which group together worksequences. Workpackages are coherent work packages: civil engineering, structural work, carpentry, plumbing, etc. Worksequences are the actual site sequences.\r\n\r\nProject management is based on :\r\n\r\n* the **project list (project\\_main\\_display)** with the list of projects + elements common to all projects: materials base needed to calculate carbon footprints, meeting venues,\r\n* the **"hub" of each project (project\\_hub\\_display)** in three sections:\r\n* a dashboard (accessible only to supervisors) with summary data on planning, expenses, carbon footprint, work times...\r\n* a management area for managing work packages, buildings, meetings and documents\r\n* a list of work packages\r\n* the **hub for each workpackage (workpackage\\_hub\\_display)** in three sections:\r\n* a dashboard (accessible only to supervisors) with summary data on scheduling, expenses, carbon footprint, work times...\r\n* a management area for managing sequence batches, expenses, participants, waste and materials\r\n* a list of sequences\r\n\r\n## 2.4. Project module: rights management\r\n\r\nProjects are managed by supervisors and editors.\r\n\r\nSupervisors have full rights (CREATE, UPDATE, DELETE) over projects and project elements. They have a "dashboard" section in the project hub. They can download working times by sequence or by participant.\r\n\r\nEditors cannot create projects, but they can create all the elements of a project: workpackage, worksequence, building, meeting, document. They have no DELETE rights.\r\n\r\nIt would be possible to quickly configure CO-OP to set access filters according to project type. In this way, projects could be distributed among editors according to the nature of the project or their geographical location. To do this, simply add a G column in the project table, a G input field when creating a project and THEN add a G condition to the project display. We would then set editors' rights to G1, G2, G3... They would THEN only be able to work on projects corresponding to their group.\r\n\r\n## 2.5.Project module: tips and tricks\r\n\r\n**Workpackage - main**: the creation of a new project automatically triggers the creation of a "main" work package. This serves as a general framework for analyzing the project's progress. It is given the total duration of the project. The participants in this work package will be the project owner(s), project manager(s) and design office(s).... General expenses and fixed expenses can be recorded: building permit fees, design fees, etc. Once this first batch has been filled in, the real work packages can be created.\r\n\r\n**Workpackage - planning**: The mechanics of this module are based on the start date (planned or actual) and duration (planned or actual) of a work package. The end date (planned or actual) is calculated directly from these two data. A work package may be independent or linked to a parent work package. In this case, the planned start date is automatically calculated from the planned end date of the parent work package.\r\n\r\nIf the planned start date or duration of a work package that is the parent of one or more other sprints is modified, the planned start dates will be recalculated via a recursive CTE.\r\n\r\nThe work package schedule is visualized via the "chart" component in the form of a GANTT graph.\r\n\r\nIf you wish to mark milestones in the project's progress, you can create one-day work packages which will enable you to visualize these milestones in the calendar.\r\n\r\nYou can then go to the "meeting" module to set the date of the corresponding site review meeting.\r\n\r\n**Documents:** a distinction is made between local documents, stored on the server, and online documents, stored on a remote server. This enables a project team to work collaboratively on a document such as google doc®, office365® or framapad®.\r\n\r\n**Meetings:** Registration and deregistration is very simple for logged-in users; it is also possible to register outsiders from the PRM1 or PRM2 address books. Experience has taught us that project team meetings often change date, time, place or content. We have therefore included an alert system with a notification icon on the meeting list. CO-OP does not include an e-mail invitation system. However, it would be possible to implement this functionality (see <https://github.com/sqlpage/SQLPage/discussions/842> contribution based on the use of the sqlpage.fetch\\_with\\_meta function).\r\n\r\n**Meetings (coordinator)**: when an editor creates a meeting, he becomes its coordinator and can edit it for modification.\r\n\r\n**Buildings:** when a building is created, a room of the same name is automatically created, with the rank of "main". From then on, we only work at part level.The "main" part refers to the building as a whole.\r\n\r\n**Building location:** click on the building to view its location on a map.\r\n\r\n**Picture mangement** : in the field of building rehabilitation it is quiet important to have pictured of every detail. Pictures are attached at the room level level (the "main" room discribe the building as a whole).\r\n\r\n**Geometric/geopgraphic description of buildings:** the present version of CO-OP does not allow buildings to be integrated into a geographic information system (GIS). However, it is possible to enable postgis as an extension of Postgresql and therefore develop modules to ensure this integration.\r\n\r\n**Worksequence (duration):** by default, CO-OP establishes the duration of a work sequence by the difference between the end time and the start time.However,(*an alternative could be to set up a calculation based on the* *duration declared for each sequence*). A worksite sequence is a maximum of 24 hours.The sequence start date also acts as the sequence end date.\r\n\r\nFor a detailed analysis, it is preferable to sequence working times as close as possible to the actual time. For example, a morning sequence from 7:30 to 12:00 and an afternoon sequence from 13:30 to 17:00, rather than a single sequence from 7:30 to 17:00. The time grain is 15 minutes, which is already very fine on construction sites whereE calculations are usually made by the hour, half-day or day.\r\n\r\n**CSV:** CO-OP's CSV component enables you to export worksequence details by work package, by sequence or for a specific participant.This is made possible by a set of links between 6 tables, which would have been very difficult to achieve in a simple spreadsheet.\r\n\r\n**Participants :** Workpackages and woksequences are all linked to participants. These are selected from the PRM1, PRM2 and PRM3 tables. The type of participation depends on the project level:\r\n\r\n* participants → workpackage "main": project owner, assistant project owner, architect, prime contractor, bank...\r\n* participants → standard workpackage: companies, consortium of companies\r\n* participants → worksequence: company, company employee, non-professional stakeholders: project owner, family member, self-help group, volunteer.\r\n\r\nIn CO-OP, there are 2 separate participant tables (workpackage\\_participants and worksequences\\_participants). We could have imagined a single table with a filter according to the type of participation, but this would complicate the structuring of input forms and display tables without providing any additional information.\r\n\r\nTo enter participants in a project, it is therefore necessary to have created them upstream in the prm1, prm2 or prm3 tables, as appropriate.\r\n\r\n**expenses**: the follow up of expenses is done at the workpackage level. It is a basic recording module. The date of the invoice is the reference date of the expense.\r\n\r\n**Carbon footprint**: Carbon footprints are now required for new buildings, and will be increasingly used in the future. Calculating the carbon footprint of a construction project requires a link between design tools (architectural design software with the creation of quantities for each type of material), a reference database on the carbon footprint of each material (in France, the [ienes database](https://base-inies.fr/consultation/recherche-fdes)) and calculation software to establish the final footprint. This calculation follows strict rules, including the use of approved software. CO-OP falls far short of these requirements. It can only provide an approximate assessment of an operation's carbon footprint. CO-OP's carbon footprint section is intended for educational purposes, with no regulatory pretensions. To draw up a balance sheet for an operation, you first need to supply the local database with the carbon footprint of the materials used. To do this, you need to list the materials used, consult the ienes database to retrieve the link to the file, the functional unit used, and the value of the global carbon equivalent indicator for a functional unit of the material concerned. You can then create a record in CO-OP.Then, when you're in a work package, you can establish the quantity of materials consumed. To establish this quantity, we can either use the plans as a basis for planning, or use actual material purchases as a basis. The functional unit of the ienes database does not always correspond to the reality of the project (for example, the carbon footprint of a material is estimated for 1 m² on a 30cm thickness where the implementation was carried out on a 20cm thickness).In this case, the regulations require that the higher value be applied (in the example, calculate as if the wall were 30cm thick). As CO-OP's aim is not to comply with regulations but to provide an educational estimate, we apply a rule of three to bring the carbon footprint calculation as close as possible to the actual quantity of material. Furthermore, for the sake of simplicity, the calculation only takes into account the overall carbon footprint of materials, where it would be possible to develop the calculation on other indicators present in the ienes database.\r\n\r\n**Construction site waste management:** the management of construction site waste is now mandatory. CO-OP includes a module for this purpose. The module combines an analysis of waste destination (reuse, recycling, etc.), value (product or expense) and the carbon footprint of the waste, which may have to be subtracted FROM the operation's overall carbon footprint.\r\n	help_dev	EN	6	active	2025-02-22 16:16:04+01	2025-06-17 14:54:27.119674+02
14	8. Quelles sont les données inutiles au service qui sont supprimées des comptes fermés ?	[Depuis le 28 juin\n2023](https://linuxfr.org/news/regles-de-perennite-des-comptes-linuxfr-org-et-donnees-a-caractere-personnel),\nles données associées inutiles au service des comptes fermés sont\nsupprimées.\n\nLes comptes créés et sans connexion pendant sept jours seront purgés.\n\nLes comptes inactifs pendant trois ans seront fermés :\n\n-   les éventuels contenus et commentaires non publics de ces comptes\n    > seront supprimés ;\n\n-   en l'absence de contenus ou commentaires publics ou de contributions\n    > à des contenus publics, le compte sera purgé (les éventuels\n    > étiquetages seront réattribués à l\\'utilisateur Anonyme) ;\n\n-   sinon\n\n    -   seront conservés l'identifiant ou pseudo, l'adresse de courriel,\n        > le nom affichable et la signature (pour l'attribution du droit\n        > d'auteur) ;\n\n    -   seront supprimées de la base le mot de passe, les dates et\n        > adresses IP des deux dernières connexions du compte, l'image\n        > éventuelle d'avatar, les éventuelles adresses de site web\n        > personnel, de messagerie instantanée XMPP et/ou de compte\n        > Mastodon, l'éventuelle feuille de style personnelle ;\n\n    -   seront supprimées les applications utilisant l\\'API du site\n        > reliées au compte, ainsi que les accès et tokens reliés à ces\n        > applications ou au compte.\n\nPrécision : la durée de trois ans commence à courir à partir du\nlendemain de la dernière activité sur le compte.\n\nLes comptes fermés (par les personnes détentrices des comptes ou par\nl'équipe) depuis plus d'un an verront les données associées réduites par\nrapport au besoin de service :\n\n-   les éventuels contenus et commentaires non publics de ces comptes\n    > seront supprimés ;\n\n-   en l'absence de contenus ou commentaires publics ou de contributions\n    > à des contenus publics, le compte sera purgé (les éventuels\n    > étiquetages seront réattribués à l\\'utilisateur Anonyme) ;\n\n-   sinon\n\n    -   seront conservés l'identifiant ou pseudo, le nom affichable et\n        > la signature (pour l'attribution du droit d'auteur) ;\n\n    -   seront supprimées de la base active l'adresse de courriel, le\n        > mot de passe, les dates et adresses IP des deux dernières\n        > connexions du compte, l'image éventuelle d'avatar, les\n        > éventuelles adresses de site web personnel, de messagerie\n        > instantanée XMPP et/ou de compte Mastodon, l'éventuelle\n        > feuille de style personnelle ;\n\n    -   seront supprimées les applications utilisant l\\'API du site\n        > reliées au compte, ainsi que les accès et tokens reliés à ces\n        > applications ou au compte.\n\nLa principale différence concerne la conservation de l'adresse de\ncourriel pour permettre une réouverture du compte et un envoi de nouveau\nmot de passe en cas de demande.\n\nCes opérations seront faites manuellement dans les meilleurs délais (par\nune équipe de bénévoles initialement, puis, et à terme,\nautomatiquement).	legal	FR	8	active	2024-10-29 09:47:19+01	2024-10-29 09:48:09+01
30	CO-OP un site pour présenter une organisation et ses projets	Il existe de nombreuses applications commerciales ou open source,\nno-code pour répondre aux besoins les plus classiques attendues d'un\nsite web . Mais il existe des cas où la structure de la base de données\nest trop spécifique pour que l'on puisse utiliser une de ces\napplications. Il faut donc construire le site web autour de la base de\ndonnées. C'est la finalité de SQLPage dont un gros atout est d'être une\napplication à « code simple » accessible à des personnes dont le\ndéveloppement informatique n'est pas le cœur de métier mais qui ont\nbesoin de mettre en ligne une base de données spécifiques.\n\nMettre en ligne une base de données ne se limite pas à la mise en ligne\ndes données proprement dites. Il faut aussi assurer le développement des\nautres fonctions périphériques attendues d'un site web :\n\n-   **fonction « admin**: administrer le site web : gérer des droits\n    des utilisateurs, assurer la maintenance,\n\n-   **fonction « corporate »** : présenter la structure éditrice du site\n    web : qui nous sommes, quelles sont nos activités, présentation de\n    notre équipe...\n\n-   **fonction « contact »**: offrir une interface de contact et\n    d'échange avec les visiteurs : formulaire de contact, formulaire\n    d'inscription, FAQ...\n\n-   **fonction « interface»**: offrir une interface pour alimenter et\n    maintenir la base de données qui a justifié la création du site,\n\n-   **fonction « community »**: offrir des outils collaboratifs pour\n    les rédacteurs qui alimente la base de données ou produisent les\n    contenus sur le site.\n\nLa structure de COOP, tente de répondre à toutes fonctions.	hero	FR	3	active	2024-12-05 17:02:17+01	2025-03-12 08:47:46+01
34	Préambule	La compagnie **Anonymous international** est une association déclarée sous la loi du 1er juillet 1901, à but non\nlucratif. Le présent document fixe les conditions générales de vente pour les prestations de service fournies par la\ncompagnie (cession de spectacles, interventions de comédiens, formation, action culturelle…) ainsi que la vente de\nbillets pour les spectacles organisés par la compagnie (billetterie). La compagnie déclare être en règle vis-à-vis des\nobligations liées à l’activité de spectacle vivant, et être titulaire des licences d’entrepreneur du spectacle de catégorie 2\net 3 ou équivalent.\nEn l’absence de dispositions contractuelles plus précises, le droit commun s’applique aux contrats passés avec la\ncompagnie.\nLe présent document est scindé en deux parties distinctes. La première est liée aux prestations de services. La\nseconde à la vente de tickets dans le cadre de billetteries de spectacles.\nIl est entendu par “prestations de services”, de manière non-exhaustive : la vente spectacles (contrats de cession), les\nprestations de formation, les interventions de comédiens sous forme d’improvisation ou non, les ateliers, stages et\nformations (en dehors des ateliers hebdomadaires organisés par la compagnie elle-même), les prestations\nd’accompagnement, les actions culturelles ou de médiation…\nIl est entendu par “billetterie” les cas où la compagnie elle-même est chargée de l’organisation de la billetterie d’un\nspectacle (notamment lorsqu’elle est organisatrice de la représentation). Les conditions de vente évoquées dans la\npartie “billetterie” ne sauraient donc être appliquées aux représentations de spectacles de la compagnie organisés par\ndes tiers, ceux-ci ayant leurs propres conditions de billetterie.	CGV	FR	1	active	2024-12-17 10:16:10+01	2024-12-17 10:44:45+01
42	I. TARIF ET DÉTERMINATION DES PLACES	1. Le tarif et la situation des places sont affichés sur la plateforme HelloAsso, sur les éléments de communication du spectacle, ainsi qu’au guichet le soir du spectacle ou communiqués sur simple demande. Tous les tarifs sont susceptibles de modification sans préavis. Ils sont validés uniquement après confirmation de notre part du règlement demandé. Les éventuelles réductions et opérations de promotion organisées sont annoncées par voie de presse et/ou d'affichage. Il appartient aux spectateurs qui entendent s’en prévaloir d'en réclamer l'application au moment de la réservation des places ou de leur achat en billetterie.\n\n2 . Le spectateur doit être présent au plus tard 20 minutes avant l’heure annoncée de début du spectacle. Le public entre en salle 15 minutes avant le début de la représentation. Toute place non-retirée 20 minutes avant le début de la représentation est susceptible d’être remise en vente, et ce même si un paiement avait été encaissé pour ces places. Anonymous International se réserve le droit de refuser l’entrée à un spectateur ne  espectant pas ces délais.\n\n3. Les prix des places indiqués sont les prix pratiqués pour des billets au tarif normal achetés sur place, directement au guichet. Pour les billets réservés par tous autres moyens, des frais de réservation peuvent être perçus en sus du prix guichet. Par ailleurs, le pourboire éventuellement consenti par l’acheteur à la plateforme HelloAsso n’est en aucun cas lié à Anonymous International.\n\n4. Les billets émis sont uniques et nous ne pouvons en délivrer de duplicata.\n\n5. Le billet électronique émis par HelloAsso représente une preuve de paiement qui ne dispense pas l’acheteur de retirer un ticket le soir de la  représentation.\n\n6. Le placement est libre. Ne sont réservées que des places pour les personnes à mobilité réduite, et, éventuellement, pour quelques professionnels ou\npartenaires invités. \n\n7. Le spectacle débute à l'heure indiquée sur les billets. Les horaires annoncés sont susceptibles de modifications sans préavis. Seul l'horaire porté sur le billet est garanti. Aucun remboursement ne sera consenti aux spectateurs retardataires.\n\n8. Les billets émis ne sont ni repris ni remboursés. Ils sont valables uniquement pour la représentation pour laquelle ils ont été émis. En cas 'annulation de la représentation de notre fait, ils peuvent être échangés pour une autre date en fonction de la disponibilité des places, mais en cas d'interruption d'une représentation après la première moitié du spectacle ils ne pourraient être ni échangés pour une autre date, ni remboursés.\n\n9. Nos prix sont établis en euros et nous n'acceptons pas les règlements dans d’autres devises.\n	CGV	FR	9	active	2024-12-17 10:32:49+01	2024-12-17 10:46:00+01
47	0. Pour les impatients	Si vous ne connaissez pas [l'expression\r\nRTFM](https://fr.wikipedia.org/wiki/RTFM_(expression)) vous pouvez\r\ndirectement découvrir le site web COOP soit comme simple visiteur (non\r\nconnecté) soit en utilisant successivement les différents statuts\r\npossibles : viewer, editor, supervisor, admin.\r\n\r\nL'installation de COOP est classique :\r\n\r\n-   télécharger l'ensemble du dossier COOP depuis Github\r\n\r\n-   coller ce dossier dans /var/www\r\n\r\n-   libérer les droits d'écriture sur les sous dossiers ayant un préfixe\r\n    « x\\_ » (ils sont utilisés pour le téléchargement de documents ou\r\n    d'images)\r\n\r\n-   dans le terminal, se placer dans le dossier COOP : /var/www/coop\r\n\r\n-   lancer SQLPage : /var/www/sqlpage/sqlpage.bin\r\n\r\n-   dans votre navigateur se rendre à : http://localhost:8080/\r\n\r\n-   commencer la visite.\r\n\r\nPour changer de rôle, il suffit d'utiliser les identifiants suivants :\r\n\r\n-   viewer1@coopcoop.net\r\n\r\n-   editor1@coopcoop.net\r\n\r\n-   supervisor1@coopcoop.net\r\n\r\n-   admin1@coopcoop.net\r\n\r\navec le mot de passe : CoopCoop1\r\n\r\nVous pouvez créer de nouveaux utilisateurs, mais vous devrez passer\r\nensuite en mode « admin » pour fixer les droits des nouveaux\r\nadministrateurs.\r\n\r\nDans le panneau administrateur, vous trouverez un menu « Help Dev » avec\r\nla documentation embarquée de COOP.\r\n\r\nPour compléter la démo, dans les panneaux d'administration admin,\r\nsupervisor et editor, vous trouvez les liens vers des flux RSS (voir le\r\nprincipe de ces flux dans Help-Dev).\r\n	help_dev	FR	0	archived	2025-01-11 15:24:09+01	2025-04-15 14:50:54.904472+02
48	2. COOP structure générale	# 1. Structure générale de COOP\r\n\r\n&#x20;Il existe de nombreuses applications commerciales ou open source, sans code, pour répondre aux besoins les plus classiques d'un site web. Mais il arrive que la structure de la base de données soit trop spécifique pour utiliser l'une de ces applications. Le site web doit alors être construit autour de cette base de données. C'est l'objectif de SQLPage, dont l'un des principaux avantages est d'être une application « simple code » accessible aux personnes dont le cœur de métier n'est pas le développement informatique, mais qui ont besoin de mettre en ligne une base de données spécifique. Mettre en ligne une base de données ne se limite pas à mettre en ligne les données elles-mêmes. Cela implique également le développement d'autres fonctionnalités périphériques attendues d'un site web : Fonction « admin » : administration du site, gestion et maintenance des droits des utilisateurs. Fonction « corporate » : présentation de la structure qui édite le site : qui nous sommes, ce que nous faisons, présentation de notre équipe… Fonction « contact » : mise à disposition d'une interface de contact et d'échange pour les visiteurs : formulaire de contact, formulaire d'inscription, FAQ… Fonction « interface » : mise à disposition d'une interface pour alimenter et maintenir la base de données ayant motivé la création du site. Fonction « communauté » : mise à disposition d'outils collaboratifs pour les éditeurs qui alimentent la base de données ou produisent du contenu pour le site. La structure de COOP est conçue pour répondre à toutes ces fonctions. Les dossiers sont organisés de manière logique, les fonctions étant identifiées par des suffixes alphabétiques. Le premier groupe regroupe les fonctions d'administration :&#x20;\r\n\r\n* **Groupe A, suffixe /a\\_&#x20;**: modules d'administration de gestion du site : sessions, utilisateurs, infos, flux RSS…\r\n\r\n&#x20;Le deuxième groupe regroupe les fonctions du site web et de la communauté.\r\n\r\n* **&#x20;Groupe B, suffixe /b\\_** : modules de contact avec les entreprises et les visiteurs.&#x20;\r\n* **Groupe C, suffixe /c\\_** : modules communautaires : forum, chat, espaces de travail…\r\n\r\n&#x20;Et un troisième groupe de fichiers spécifiques à COOP, dont le thème est la gestion des projets de réhabilitation de logements accompagnés (fonction interface) :\r\n\r\n* **&#x20;Groupe D, suffixe /d\\_** : modules PRM (gestion de la relation projet)&#x20;\r\n* **Groupe E, suffixe /e\\_** : modules PMS (système de gestion de projet)&#x20;\r\n\r\nEnfin, les documents, images, etc. sont regroupés dans des dossiers spécifiques :&#x20;\r\n\r\n* **Groupe X, suffixe /x\\_&#x20;**: modules de stockage de documents.\r\n\r\n&#x20;Pour mettre en ligne une base de données spécifique (groupes D et E), il est nécessaire d'assurer le développement des autres composants et au moins des modules du groupe A. Par défaut, COOP offre toutes les fonctionnalités. Si vous souhaitez utiliser CO-OP uniquement pour la gestion de projets (groupes A, D, E), il vous suffit de :&#x20;\r\n\r\n* Renommer le dossier a\\_panels → a\\_panels\\_default&#x20;\r\n* Renommer le dossier a\\_panels\\_project → a\\_panels&#x20;\r\n* Renommer le dossier a\\_shells → a\\_panels\\_default&#x20;\r\n* Renommer le dossier a\\_shells\\_project → a\\_shells&#x20;\r\n\r\nSi vous souhaitez utiliser CO-OP uniquement pour la gestion d'un site web associatif ou d'entreprise (groupes A, B, C), il vous suffit de :&#x20;\r\n\r\n* Renommer le dossier a\\_panels → a\\_panels\\_default&#x20;\r\n* Renommer le dossier a\\_panels\\_website → a\\_panels&#x20;\r\n* Renommer le dossier a\\_shells → a\\_panels\\_default&#x20;\r\n* Renommer le dossier a\\_shells\\_website → a\\_shells.&#x20;\r\n*\r\n\r\n# 2. Approche modulaire COOP\r\n\r\n## &#x20;2.1. Principe général\r\n\r\n&#x20;Un module est défini comme l'ensemble des éléments nécessaires à la création d'une fonctionnalité particulière. Chaque composant A, B, C, D, E correspond à un ensemble cohérent de modules.\r\n\r\n## &#x20;2.2 Module simple&#x20;\r\n\r\nUn module simple est composé de :&#x20;\r\n\r\n* une table un dossier simple (voir le contenu du dossier) contenant les fichiers permettant de créer, modifier, publier et supprimer des données ;&#x20;\r\n* un lien dans la barre de menus&#x20;\r\n* un lien dans la table d'administration de l'administrateur, du superviseur ou de l'éditeur, selon le cas&#x20;\r\n\r\nExemple de module simple : actualités (dossier /b\\_news), qui permet de publier des articles soit sur le site public, soit sur le site interne.\r\n\r\n**&#x20;2.3 Module complexe**\r\n\r\n&#x20;Un module complexe est composé de :&#x20;\r\n\r\n* plusieurs tables, parfois liées par des contraintes (clés étrangères) ;&#x20;\r\n* plusieurs dossiers contenant des fichiers permettant de créer, modifier, publier et supprimer des données dans chaque table ;&#x20;\r\n* un lien dans la barre de menus ;&#x20;\r\n* un lien dans la table d’administration administrateur, superviseur ou éditeur, selon le cas.&#x20;\r\n\r\nExemple de module complexe : les espaces de travail (dossier /c\\_wokspaces), qui regroupent des tables pour la gestion des forums, le chat, le partage de documents et l’organisation des réunions.\r\n\r\n&#x20;2.4. Dépendances entre modules&#x20;\r\n\r\nMême pour les modules simples, il existe des dépendances :&#x20;\r\n\r\n* Tous les modules dépendent des modules du groupe A : utilisateurs, sessions, shells, panneaux, informations&#x20;\r\n* Il existe des dépendances entre certains modules du groupe B (par exemple : les tables membres, orga\\_dept, événements, lieu, place\\_space dépendent de orga)&#x20;\r\n* Certains modules du groupe C dépendent des tables du groupe B (les réunions et les réunions de travail dépendent de place\\_space, et donc de orga et orga\\_dept)\r\n* Les modules du groupe D dépendent uniquement des modules de base du groupe A&#x20;\r\n* Les modules du groupe E dépendent des modules du groupe D et des modules de base du groupe A&#x20;\r\n\r\nLes liens de dépendance peuvent être visualisés en parcourant les tables afin d'identifier les références à une table externe, souvent (mais pas toujours) à une clé étrangère. La suppression de certains enregistrements d'une table entraîne la suppression des enregistrements associés dans d'autres tables. Dans ce cas, COOP affiche systématiquement\r\n	help_dev	FR	2	active	2025-02-22 08:38:59+01	2025-06-17 15:10:59.743639+02
54	6. Modules PRM et Projet	# 1. PRM : Gestion de la Relation Projet\r\n\r\nL’acronyme CRM : Gestion de la Relation Client est bien connu. L’approche CRM repose le plus souvent sur une relation binaire : vendeur <-> acheteur, mais un projet est souvent un travail d’équipe et les outils basés sur une relation binaire ne suffisent pas.\r\n\r\nDans l’approche PRM, on retrouve les tables classiques des carnets d’adresses des particuliers (PRM1) et des personnes morales (PRM2). Dans COOP, on détaille les employés, c’est-à-dire les personnes physiques rattachées à une personne morale, comme dans les bases de données de GRH (gestion des ressources humaines). Cela permet d’utiliser COOP, par exemple, pour constituer des équipes de joueurs ou gérer la répartition des élèves dans les classes d’un établissement scolaire.\r\n\r\nCOOP introduit une autre table, celle des groupes (PRM3), qui autorise toutes sortes de combinaisons : entre individus (un couple, une famille, un groupe de bénévoles), entre entreprises (consortium, etc.), entre entreprises et particuliers. Cette table permet ensuite de résoudre des problèmes liés à l’intervention sur le chantier. En effet, une maison est souvent détenue non pas par une seule personne, mais par un couple. Vous pouvez également être amené à effectuer des travaux dans un logement partagé entre colocataires. Pendant les travaux, il est courant que des entreprises s'associent temporairement pour répondre à un appel d'offres. Dans le cas spécifique de COOP, nous analysons le suivi des chantiers réalisés par une famille et des artisans. Le tableau PRM3 permet de gérer des situations telles que la constitution d'une équipe sportive incluant, selon le cas, uniquement des joueurs amateurs ou des joueurs et des salariés du club sportif.\r\n\r\n# 2. Module Projet\r\n\r\n## 2.1. Module Projet : orientation générale\r\n\r\nCO-OP est principalement conçu pour gérer et analyser des projets de rénovation de bâtiments impliquant des équipes mixtes de professionnels et de non-professionnels (ARA : auto-réhabilitation accompagnée). CO-OP permet également de suivre tous les aspects d'un projet : flux de matériaux et de services, heures de travail, empreinte carbone, flux de déchets, etc.\r\n\r\nCO-OP est toutefois transposable à d'autres types de projets structurés autour des notions de lots de travaux et de séquences de travaux.\r\n\r\nUn autre aspect de CO-OP est qu'il offre un espace de travail virtuel, véritable « hub » autour du projet, avec des modules de planification de réunions, de gestion de la documentation et un forum. Cela évite la dispersion souvent observée entre un outil de gestion de projet, des documents dispersés ici et là, une messagerie séparée…\r\n\r\nCO-OP ne cible pas les projets complexes. Il privilégie une interface sobre et ergonomique comme alternative possible à la gestion de projet avec des tableurs Excel® ou Calc®. Ces outils sont très simples d'utilisation, mais présentent leurs limites. SQLPAge, qui permet d'utiliser une véritable base de données, pallie ces limitations. Il s'adresse donc à un public de particuliers réalisant un projet d'auto-rénovation ou d'auto-construction, ou à une association accompagnant des particuliers dans ce type de démarche.\r\n\r\n## 2.2 Module Projet : fonctionnalités\r\n\r\n### 2.2.1. Tableau de bord de gestion de projet\r\n\r\nLes données du projet peuvent être suivies à l'échelle du projet dans son ensemble ou de chaque lot de travail. Les utilisateurs disposant de droits de supervision peuvent consulter, via un tableau de bord en grille de données :\r\n\r\n* la planification chronologique (prévue et réelle) avec des diagrammes de Gantt ;\r\n* les dépenses engagées, détaillées par type de dépense et par échéancier ;\r\n* l'empreinte carbone globale des matériaux utilisés (basée sur les données du catalogue ienes) ;\r\n* le temps de travail total, par séquence, par intervenant ;\r\n* les déchets par phase de travail, par type et par destination ;\r\n* la localisation des bâtiments ;\r\n* les photos des bâtiments et des pièces.\r\n\r\n### 2.2.2. Outils de gestion de projet\r\n\r\nTous les utilisateurs connectés disposant de droits de supervision ou d'édition peuvent :\r\n\r\n* créer et modifier les données relatives aux projets, lots de travaux et séquences ;\r\n* créer et participer à des réunions et des forums de discussion ;\r\n* partager des documents ;\r\n* décrire les bâtiments où les travaux doivent être réalisés ;\r\n* gérer les photos et les plans relatifs aux bâtiments.\r\n\r\n## 2.3. Module Projet : structure\r\n\r\nDans CO-OP, les projets sont constitués de lots de travaux, qui regroupent des séquences de travail. Les lots de travaux sont des lots de travaux cohérents : génie civil, gros œuvre, menuiserie, plomberie, etc. Les séquences de travaux sont les séquences de chantier réelles.\r\n\r\nLa gestion de projet s'appuie sur :\r\n\r\n* la liste des projets (project\\_main\\_display) avec la liste des projets + les éléments communs à tous les projets : base de matériaux nécessaire au calcul de l'empreinte carbone, lieux de réunion,\r\n* le « hub » de chaque projet (project\\_hub\\_display) en trois sections :\r\n* un tableau de bord (accessible uniquement aux superviseurs) avec des données récapitulatives sur le planning, les dépenses, l'empreinte carbone, les temps de travail…\r\n* un espace de gestion pour la gestion des lots de travaux, des bâtiments, des réunions et des documents\r\n* une liste des lots de travaux\r\n\r\nle hub de chaque lot de travaux (workpackage\\_hub\\_display) en trois sections :\r\n\r\n* un tableau de bord (accessible uniquement aux superviseurs) avec des données récapitulatives sur le planning, les dépenses, l'empreinte carbone, les temps de travail…\r\n* un espace de gestion pour la gestion des lots de séquences, des dépenses, des intervenants, des déchets et des matériaux\r\n* une liste des séquences\r\n\r\n## 2.4. Module Projet : Gestion des droits\r\n\r\nLes projets sont gérés par le superviseur.\r\n\r\nLes superviseurs disposent de droits complets (CRÉER, METTRE À JOUR, SUPPRIMER) sur les projets et leurs éléments. Ils disposent d'une section « Tableau de bord » dans le hub projet. Ils peuvent télécharger les temps de travail par séquence ou par participant.\r\n\r\nLes éditeurs ne peuvent pas créer de projets, mais ils peuvent créer tous les éléments d'un projet : lot de travail, séquence de travail, bâtiment, réunion, document. Ils n'ont pas de droits de SUPPRESSION.\r\n\r\nIl serait possible de configurer rapidement CO-OP pour définir des filtres d'accès par type de projet. Ainsi, les projets pourraient être répartis entre les éditeurs en fonction de leur nature ou de leur localisation géographique. Pour ce faire, il suffit d'ajouter une colonne G dans la table des projets, un champ de saisie G lors de la création d'un projet, puis une condition G à l'affichage du projet. Nous définirions alors les droits des éditeurs sur G1, G2, G3… Ils ne pourraient alors travailler que sur les projets correspondant à leur groupe.\r\n\r\n## 2.5. Module Projet : trucs et astuces\r\n\r\n**Lot de travaux principal&#x20;**("main")**&#x20;:** la création d’un nouveau projet déclenche automatiquement la création d’un lot de travaux principal ("main"). Ce lot sert de cadre général pour l’analyse de l’avancement du projet. Sa durée totale est indiquée. Les participants à ce lot sont le(s) maître(s) d’ouvrage, le(s) chef(s) de projet et le(s) bureau(x) d’études. Les frais généraux et les frais fixes peuvent être enregistrés : frais de permis de construire, frais de conception, etc. Une fois ce premier lot renseigné, les lots de travaux réels peuvent être créés.\r\n\r\n**Lot de travaux - planification** : le fonctionnement de ce module repose sur la date de début (prévue ou réelle) et la durée (prévue ou réelle) d’un lot de travaux. La date de fin (prévue ou réelle) est calculée directement à partir de ces deux données. Un lot de travaux peut être indépendant ou lié à un lot parent. Dans ce cas, la date de début prévue est automatiquement calculée à partir de la date de fin prévue du lot parent.\r\n\r\nSi la date de début ou la durée prévue d'un lot de travaux parent d'un ou plusieurs autres sprints est modifiée, les dates de début prévues sont recalculées via un CTE récursif.\r\n\r\nLe planning du lot de travaux est visualisé via le composant « chart » sous forme de diagramme de GANTT.\r\n\r\nSi vous souhaitez marquer des jalons dans l'avancement du projet, vous pouvez créer des lots de travaux d'une journée, ce qui vous permettra de les visualiser dans le calendrier.\r\n\r\nVous pouvez ensuite accéder au module « réunion » pour fixer la date de la réunion de revue de site correspondante.\r\n\r\n**Documents&#x20;**: une distinction est faite entre les documents locaux, stockés sur le serveur, et les documents en ligne, stockés sur un serveur distant. Cela permet à une équipe projet de travailler en collaboration sur un document tel que Google Doc®, Office 365® ou Framapad®.\r\n\r\n**Réunions** : L'inscription et la désinscription sont très simples pour les utilisateurs connectés ; il est également possible d'inscrire des personnes externes à partir des carnets d'adresses PRM1 ou PRM2. L'expérience nous a appris que les réunions d'équipe projet changent souvent de date, d'heure, de lieu ou de contenu. Nous avons donc intégré un système d'alerte avec une icône de notification dans la liste des réunions. CO-OP ne propose pas de système d'invitation par e-mail. Cependant, il serait possible d'implémenter cette fonctionnalité (voir la contribution https://github.com/sqlpage/SQLPage/discussions/842 basée sur l'utilisation de la fonction sqlpage.fetch\\_with\\_meta).\r\n\r\n**Réunions (coordinateur)&#x20;**: lorsqu'un éditeur crée une réunion, il en devient le coordinateur et peut la modifier.\r\n\r\n**Bâtiments&#x20;**: lorsqu'un bâtiment est créé, une salle du même nom est automatiquement créée, avec le rang « principal ». Dès lors, nous travaillons uniquement au niveau des parties. La partie « principale » désigne le bâtiment dans son ensemble.\r\n\r\n**Localisation du bâtiment** : cliquez sur le bâtiment pour visualiser sa localisation sur une carte.\r\n\r\n**Gestion des images&#x20;**: dans le domaine de la réhabilitation de bâtiments, il est essentiel d'avoir des images de chaque détail. Des photos sont jointes au niveau de la pièce (la pièce « principale » décrit le bâtiment dans son ensemble).\r\n\r\n**Description géométrique/géographique des bâtiments&#x20;**: la version actuelle de CO-OP ne permet pas l'intégration des bâtiments dans un système d'information géographique (SIG). Cependant, il est possible d'activer PostGIS comme extension de PostgreSQL et donc de développer des modules pour assurer cette intégration.\r\n\r\n**Séquence de travail (durée)** : par défaut, CO-OP détermine la durée d'une séquence de travail par la différence entre l'heure de fin et l'heure de début. Cependant, (une alternative pourrait être de configurer un calcul basé sur la durée déclarée pour chaque séquence). Une séquence de chantier dure au maximum 24 heures. La date de début de la séquence fait également office de date de fin.\r\n\r\nPour une analyse détaillée, il est préférable de séquencer les heures de travail au plus près de l'heure réelle. Par exemple, une séquence matinale de 7 h 30 à 12 h et une séquence après-midi de 13 h 30 à 17 h, plutôt qu'une séquence unique de 7 h 30 à 17 h. Le granularité temporelle est de 15 minutes, ce qui est déjà très correct sur les chantiers où les calculs d'E sont généralement effectués à l'heure, à la demi-journée ou à la journée.\r\n\r\n**CSV** : Le composant CSV de CO-OP permet d'exporter les détails des séquences de travail par lot de travaux, par séquence ou pour un participant spécifique. Ceci est rendu possible grâce à un ensemble de liens entre 6 tables, ce qui aurait été très difficile à réaliser dans une simple feuille de calcul.\r\n\r\n**Participants** : Les lots de travaux et les séquences de travail sont tous liés à des participants. Ceux-ci sont sélectionnés dans les tables PRM1, PRM2 et PRM3. Le type de participation dépend du niveau du projet :\r\n\r\n* Participants → lot de travail « principal » : MOE, AMO, architecte, entreprise générale, banque…\r\n* Participants → lot de travail standard : entreprises, groupement d'entreprises\r\n* Participants → séquence de travail : entreprise, salarié de l'entreprise, parties prenantes non professionnelles : MOE, membre de la famille, groupe d'entraide, bénévole.\r\n\r\nDans CO-OP, il existe deux tables de participants distinctes (workpackage\\_participants et worksequences\\_participants). On aurait pu imaginer une table unique avec un filtre selon le type de participation, mais cela complexifierait la structuration des formulaires de saisie et l'affichage des tables sans apporter d'informations supplémentaires.\r\n\r\nPour saisir les participants à un projet, il est donc nécessaire de les avoir créés en amont dans les tables prm1, prm2 ou prm3, selon le cas.\r\n\r\n**Dépenses** : le suivi des dépenses se fait au niveau du lot de travail. Il s'agit d'un module d'enregistrement basique. La date de la facture est la date de référence de la dépense.\r\n\r\n**Empreinte carbone** : les empreintes carbone sont désormais obligatoires pour les bâtiments neufs et seront de plus en plus utilisées à l'avenir. Le calcul de l'empreinte carbone d'un projet de construction nécessite une articulation entre des outils de conception (logiciels de conception architecturale avec création de quantités pour chaque type de matériau), une base de données de référence sur l'empreinte carbone de chaque matériau (en France, la base de données ienes) et un logiciel de calcul pour établir l'empreinte finale. Ce calcul suit des règles strictes, notamment l'utilisation de logiciels agréés. CO-OP est loin de répondre à ces exigences. Il ne peut fournir qu'une évaluation approximative de l'empreinte carbone d'une opération. La section Bilan carbone de CO-OP est destinée à des fins pédagogiques, sans prétention réglementaire. Pour établir le bilan d'une opération, vous devez d'abord fournir à la base de données locale l'empreinte carbone des matériaux utilisés. Pour ce faire, vous devez lister les matériaux utilisés, consulter la base de données ienes pour récupérer le lien vers le fichier, l'unité fonctionnelle utilisée et la valeur de l'indicateur d'équivalent carbone global pour une unité fonctionnelle du matériau concerné. Vous pouvez ensuite créer un enregistrement dans CO-OP. Ensuite, lorsque vous êtes dans un lot de travaux, vous pouvez déterminer la quantité de matériaux consommée. Pour établir cette quantité, nous pouvons soit utiliser les plans comme base de planification, soit nous baser sur les achats réels de matériaux. L'unité fonctionnelle de la base de données ienes ne correspond pas toujours à la réalité du projet (par exemple, l'empreinte carbone d'un matériau est estimée pour 1 m² sur une épaisseur de 30 cm alors que la mise en œuvre a été réalisée sur une épaisseur de 20 cm). Dans ce cas, la réglementation exige d'appliquer la valeur la plus élevée (dans cet exemple, calculer comme si le mur avait une épaisseur de 30 cm). L'objectif de CO-OP n'étant pas de se conformer à la réglementation, mais de fournir une estimation pédagogique, nous appliquons une règle de trois afin de rapprocher le calcul de l'empreinte carbone de la quantité réelle de matériaux. De plus, par souci de simplicité, le calcul ne prend en compte que l'empreinte carbone globale des matériaux, alors qu'il serait possible de le développer sur d'autres indicateurs présents dans la base de données ienes.\r\n\r\n**Gestion des déchets de chantier :** la gestion des déchets de chantier est désormais obligatoire. CO-OP propose un module à cet effet. Ce module combine une analyse de la destination des déchets (réutilisation, recyclage, etc.), de leur valeur (produit ou dépense) et de leur empreinte carbone, qui peut être soustraite de l'empreinte carbone globale de l'exploitation.\r\n	help_dev	FR	6	active	2025-02-22 11:27:58+01	2025-06-17 15:49:22.135652+02
70	1. COOP ?	COOP is the result of a personal project around the  monitoring of building rehabilitation projects in mix mode involving professionals and private individuals. These projects are monitored and coordinated by a network of independent associations. This explains the name of the app and the section devoted to collaborative work.\r\n\r\n&#x20;\r\n\r\nCOOP is a 3 in 1 modular app combining a website, teams workspaces and building rehab projects management. COOP is a multilevel user app : admin, supervisor, editor, viewer, public, with a possibility of group permissions at each level.&#x20;\r\n\r\n* &#x20; The project management module allows to monitor  project schedule throug gantt charts, team composition, workhours, expenses, wastes, carbon footprint, meetings schedules, pictures gallery and documents . The module include also a supervisor dashboard with various stats.&#x20;\r\n* &#x20; The workspace module includes various tools : FAQ, forum, chat, news, events.\r\n* &#x20; The website module includes standard features : About us, Contact form, FAQ, news, events, event registration. It includes also some tools to manage a small orgnization : members and membership follow up, document.\r\n* &#x20; The admin panel includes the users permissions management,  a debug forum, help and process management, connexions stats, list of choices and patterns managemet.&#x20;\r\n\r\nI am not an IT pro so I choose \\[SQLPage]\\(https://sql-page.com/) to develop COOP. COOP code is very simple: basic SQL queries, SQLPage base (no custom components, no scripts), very academic query writing, very explicit file and folder names... The first version of COOP was develop with sqlite as database engine but it was not constistent with the collaborative aim of COOP, so COOP was rewrite to work on postgresql. Postgreql allows multiple connexions in the same time and postgresql offers much more features for further developpements (for example : links to postgis).\r\n\r\nCOOP can be used as a template, a draft to develop more complex apps around project management, or as a set of examples to discover SQLpage.\r\n\r\nCOOP was developed with SQLpage 0.35.2, postgresql 16, linux mint 22.1. Development tools : VSCodium, DBeaver-CE, Pandoc, Retex (\\*all free and open source apps, thanks to all developers !\\*)\r\n	help_dev	EN	1	active	2025-06-17 12:20:04.697709+02	2025-06-17 14:42:40.977424+02
64	5. website and community modules	# 1. "Corporate website" and "Community" modules\r\n\r\n## 1.1. "Corporate website"\r\n\r\nThe website is designed for dynamic management of all elements from tables. The only hardcoded info to set up when installing COOP is the orga\\_dept\\_id in $orga\\_footer, $orga\\_dept\\_name, $logo in /var/www/coop/a\\_shells/shell\\_core.sql. By default, the orga\\_dept\\_id is set on '2' but if you have made some changes in the orga\\_dept table it can be the good value. You may have to do the same adjustments in the files of the folder /var/www/coop/b\\_about.\r\n\r\nThe info\\_sections table in is used to populate the general and legal info about your organisation: T\\&Cs, T\\&Cs, legal notices, administrative information, etc. You can access to this table when logged as admin. The link is in the admin dashboard "INFO SITE".\r\n\r\nAll other info are managed through the supervisor panel : FAQ, organisation and departments, members, news, events, places.\r\n\r\nCOOP allows basic management of the members of an association or a small enterprise : profile, function in the organisation... In the case of an association, you can follow up the membership with the column date\\_last\\_subscription.\r\n\r\nThe event module allows basic management of events, meetings : date, places, map, location, registration, fees...\r\n\r\nThe news module is set up on a 3 months display parameter.\r\n\r\n## 1.2. "Community" module\r\n\r\nThe "workspaces" module combines several modules. The module is a basic and unpretentious version of modules that are offered in large applications such AS office 365 or googleworkspace. But over the years these applications have become increasingly rich in features and are sometimes oversized for small work communities.\r\n\r\nThe emphasis has been placed on ergonomics: joining or leaving a workgroup is done with one click (join\\_0.sql, quit\\_0.sql). The creator of a workgroup becomes its coordinator and is the only one who can create a meeting, but he can also designate another or several participants as co-coordinators, they will then also be able to create meetings. The coordinator can decide to close the workgroup. This is equivalent to changing its status to "archived" but this does not delete it. Only supervisors will be able to permanently delete a workspace.\r\n\r\nThe module includes also a general forum, a debug forum (to improve the website or the COOP app) and a chat which is one-to-one forum.\r\n\r\nThe introduction of "community" modules in COOP contributes to the desire to have all the tools at hand as part of a project management. We often see a dispersion of team work between a project management application, a messaging application, a group management application, etc. But it is difficult to compete with dedicated applications and, therefore, COOP modules remain very simple or even simplistic.\r\n	help_dev	EN	5	active	2025-02-22 16:15:37+01	2025-06-17 14:54:44.253159+02
46	1. COOP ?	COOP est le fruit d'un projet personnel autour du suivi de projets de réhabilitation de bâtiments en mode mixte, impliquant professionnels et particuliers. Ces projets sont suivis et coordonnés par un réseau d'associations indépendantes. D'où le nom de l'application et la section dédiée au travail collaboratif.&#x20;\r\n\r\nCOOP est une application modulaire 3 en 1 combinant un site web, des espaces de travail pour les équipes et la gestion de projets de réhabilitation de bâtiments. COOP est une application multi-utilisateurs : administrateur, superviseur, éditeur, lecteur, public, avec possibilité de groupes d'autorisations à chaque niveau.\r\n\r\n* &#x20;Le module de gestion de projet permet de suivre le planning du projet grâce aux diagrammes de Gantt, la composition des équipes, les heures de travail, les dépenses, les déchets, l'empreinte carbone, les plannings des réunions, la galerie d'images et les documents. Le module inclut également un tableau de bord pour superviseur avec diverses statistiques.&#x20;\r\n* Le module espace de travail comprend divers outils : FAQ, forum, chat, actualités, événements. Le module site web comprend les fonctionnalités standard : À propos, formulaire de contact, FAQ, actualités, événements, inscription aux événements. Il inclut également des outils pour gérer une petite organisation : suivi des membres et des adhésions, documentation.\r\n* &#x20;L'interface d'administration comprend la gestion des permissions des utilisateurs, un forum de débogage, la gestion de l'aide et des processus, les statistiques de connexion, la gestion des listes de choix et des modèles. Je ne suis pas un expert en informatique, j'ai donc choisi SQLPage pour développer COOP. Le code de COOP est très simple : requêtes SQL basiques, base SQLPage (pas de composants personnalisés, pas de scripts), écriture de requêtes très académique, noms de fichiers et de dossiers très explicites…&#x20;\r\n\r\nLa première version de COOP a été développée avec SQLite comme moteur de base de données, mais cela ne correspondait pas à l'objectif collaboratif de COOP. COOP a donc été réécrit pour fonctionner sur PostgreSQL. PostgreSQL permet plusieurs connexions simultanées et offre bien plus de fonctionnalités pour des développements ultérieurs (par exemple, des liens vers PostGIS). COOP peut être utilisé comme modèle, comme ébauche pour développer des applications plus complexes autour de la gestion de projet, ou comme ensemble d'exemples pour découvrir SQLPage.\r\n\r\n&#x20;COOP a été développé avec SQLpage 0.35.2, PostgreSQL 16 et Linux Mint 22.1. Outils de développement : VSCodium, DBeaver-CE, Pandoc, Retex (applications gratuites et open source, merci à tous les développeurs !).\r\n	help_dev	FR	1	active	2024-12-19 18:19:18+01	2025-06-17 15:01:59.649866+02
\.


--
-- TOC entry 4137 (class 0 OID 21265)
-- Dependencies: 250
-- Data for Name: news; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.news (news_id, news_title, news_content, news_date, news_img_url, news_category, news_public_private, news_status, created_at, updated_at) FROM stdin;
10	news 50	*Podi pa mèy beue, èy trop beuut*\n\nJe ne peux plus boire, j’ai trop bu	2025-05-08	/x_news_pictures/2025-03-06_13h31m05s_R92balJQ.jpg		public	active	2025-01-16 16:09:24+01	2025-03-06 13:36:30+01
12	news 52	*I’a pas arré qu’arrangi l’estoumac coume de béue un coun cop a chabrot*\n\n Il n’y a rien qui fasse autant de bien à l’estomac comme de boire un bon coup de bouillon et de vin ensemble 	2025-02-08	/x_news_pictures/2025-03-06_13h32m41s_ROpK4Flv.jpg	comment	public	active	2025-01-16 16:12:14+01	2025-03-06 13:37:03+01
13	news 53	*Que sap leau lou couet*\n\n Il sait lever le coude 	2026-01-15	/x_pictures_events/2025-01-16_16h12m33s_mgshl90U.pdf	comment	public	active	2025-01-16 16:12:33+01	2025-03-06 13:37:20+01
14	news 54	*Tantoûlhits pas tan aquere boutelhe*\n\nNe secouez pas autant cette bouteille	2025-02-07	\N	annoncement	public	active	2025-01-16 16:13:17+01	2025-03-06 13:37:33+01
15	dsds	xwxw	2025-05-29	\N	annoncement	public	active	2025-05-29 12:33:45.866817+02	2025-05-29 12:35:10.838787+02
6	news 46	*Qu’es tout regagnat coum un herissoun, saben pa de cau bort lou préne* \r\n\r\nIl est tout rechigné comme un hérisson, on ne sait pas par de quel côté l’aborder 	2026-02-18	/x_news_pictures/2025-03-06_13h29m19s_Edq6ep7c.jpg	annoncement	public	archived	2025-01-03 10:07:10+01	2025-05-29 12:36:10.798542+02
7	news 47	*Souy tan sadout que n’èy pa mèy nade arrouniclhe au bénte*\r\n\r\nJ’ai tant mangé que je n’ai plus aucun pli au ventre\r\n	2024-10-15	\N	annoncement	private	active	2025-01-03 10:21:51+01	2025-06-08 16:32:00.299622+02
8	news 48	*Que prefèri aué lous peus blans que de n’en aué pa du tout*\r\n\r\nJe préfère avoir des cheveux blancs que ne pas en avoir du tout\r\n	2023-02-26	/x_news_pictures/2025-03-06_13h33m52s_t81L1oaf.jpg	annoncement	private	active	2025-01-03 11:02:21+01	2025-06-08 16:37:04.139742+02
9	news 49	*Qu’es ta bernique que trouberé peus aux ùus*\r\n\r\nElle est si difficile qu’elle trouverait des poils sur les oeufs\r\n	2026-02-07	\N	annoncement	private	active	2025-01-03 11:05:43+01	2025-06-09 15:34:59.019881+02
\.


--
-- TOC entry 4107 (class 0 OID 21041)
-- Dependencies: 220
-- Data for Name: orga; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.orga (orga_id, orga_name, orga_acronym, orga_logo_url, orga_punchline, orga_summary, orga_adress, orga_postal_code, orga_town, orga_country, orga_latitude, orga_longitude, orga_contact_phone, orga_contact_mail, orga_status, orga_legal_status, orga_no_rna, orga_no_siren, orga_no_siret, orga_no_tva_intracom, orga_code_naf_ape, orga_date_creation, orga_number_employees, orga_selected, updated_at, created_at) FROM stdin;
4	ASSO-002		\N				\N			44.082599	-1.172064			active			\N	\N	\N		\N	\N	\N	2025-04-29 17:35:03.354141+02	2025-04-28 18:14:43.243948+02
2	Les Ateliers du Boucaou		/x_logos/2025-07-12_12h50m26s_8ZQJp4o3.png				\N			\N	\N			active	NGO		\N	\N	\N		\N	\N	\N	2025-07-12 14:50:26.438703+02	2025-04-28 16:57:59.903938+02
\.


--
-- TOC entry 4109 (class 0 OID 21053)
-- Dependencies: 222
-- Data for Name: orga_dept; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.orga_dept (orga_dept_id, orga_dept_name, orga_id, orga_dept_acronym, orga_dept_logo_url, orga_dept_punchline, orga_dept_summary, orga_dept_adress, orga_dept_postal_code, orga_dept_town, orga_dept_country, orga_dept_latitude, orga_dept_longitude, orga_dept_contact_phone, orga_dept_contact_mail, orga_dept_date_creation, orga_dept_rank, orga_dept_status, orga_dept_legal_status, orga_dept_number_employees, orga_dept_no_rna, orga_dept_no_siren, orga_dept_no_siret, orga_dept_code_naf_ape, orga_dept_no_tva_intracom, orga_dept_selected, updated_at, created_at, orga_dept_master) FROM stdin;
6	Sub de Coop	2		\N				\N	\N		\N	\N			\N	dept	active		\N		\N	\N		\N	\N	2025-05-24 18:40:33.857741+02	2025-05-24 18:40:33.857741+02	\N
2	Les Ateliers du Boucaou	2		/x_logos/2025-12-22_14h23m29s_dpTuDvcq.png				\N			44.082414	-1.171803			\N	main	active	NGO	\N		\N	\N		\N	\N	2025-12-22 15:23:29.480406+01	2025-04-28 16:57:59.955206+02	master
\.


--
-- TOC entry 4173 (class 0 OID 21558)
-- Dependencies: 286
-- Data for Name: orga_dept_docs; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.orga_dept_docs (orga_doc_id, orga_dept_id, orga_doc_title, orga_doc_author, orga_doc_url, orga_doc_summary, orga_doc_keywords, orga_doc_date_publication, orga_doc_date_period, orga_doc_lang, orga_doc_format, orga_doc_number_page, orga_doc_category, orga_doc_type, orga_doc_edition, orga_doc_selected, orga_doc_status, created_at, updated_at) FROM stdin;
16	2	test		/x_docs/2025-11-19_15h37m16s_O7UZqfMJ.pdf			\N								t	active	2025-11-19 16:37:16.449487+01	2025-11-19 16:37:16.449487+01
\.


--
-- TOC entry 4105 (class 0 OID 21029)
-- Dependencies: 218
-- Data for Name: orga_dept_members; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.orga_dept_members (member_id, orga_dept_id, member_gender, member_first_name, member_last_name, member_phone, member_email, member_category, member_function, member_date_birthday, member_date_since, member_date_last_subscription, member_punchline, member_cv_short, member_cv_long, member_picture_title, member_picture_url, member_selected, member_publish, member_status, created_at, updated_at) FROM stdin;
4	2	M	Arcangelo	 Corelli		arcangelo.corelli@coop.net	govern	chef d'orchestre	1653-02-15	2025-01-01	2025-02-01		**Arcangelo Corelli**, né le [17 février](https://fr.wikipedia.org/wiki/17_f%C3%A9vrier) [1653](https://fr.wikipedia.org/wiki/1653_en_musique_classique) à [Fusignano](https://fr.wikipedia.org/wiki/Fusignano) et mort le [8 janvier](https://fr.wikipedia.org/wiki/8_janvier) [1713](https://fr.wikipedia.org/wiki/1713_en_musique_classique) à [Rome](https://fr.wikipedia.org/wiki/Rome), est un [violoniste](https://fr.wikipedia.org/wiki/Violoniste), [chef d'orchestre](https://fr.wikipedia.org/wiki/Chef_d%27orchestre) et [compositeur](https://fr.wikipedia.org/wiki/Compositeur) [italien](https://fr.wikipedia.org/wiki/Italie).\r\n\r\nAuteur d’un œuvre somme toute modeste et bien que n’ayant cultivé que trois genres instrumentaux – [sonate](https://fr.wikipedia.org/wiki/Sonate), [sonate en trio](https://fr.wikipedia.org/wiki/Sonate_en_trio) et [concerto](https://fr.wikipedia.org/wiki/Concerto) – Corelli est néanmoins considéré comme l'un des compositeurs majeurs de la [période baroque](https://fr.wikipedia.org/wiki/Musique_baroque). Il exerça une influence durant sa vie, mais également longtemps après, grâce à l'édition de ses opus chez de nombreux éditeurs à travers toute l'[Europe](https://fr.wikipedia.org/wiki/Europe).\r\n	é à [Fusignano](https://fr.wikipedia.org/wiki/Fusignano) près de [Ravenne](https://fr.wikipedia.org/wiki/Ravenne), Arcangelo Corelli est le cinquième enfant d'une famille prospère de propriétaires terriens[\\[1\\]](https://fr.wikipedia.org/wiki/Arcangelo_Corelli#cite_note-Grove-1). Il reçoit le même prénom que son père, lequel est mort 5 semaines avant sa naissance. Le petit Arcangelo est ainsi élevé par sa mère Santa (née Ruffini ou Raffini) aux côtés de ses quatre frères et sœurs.\r\n\r\nIl reçoit probablement ses premières leçons d'un professeur local, avant de partir en [1666](https://fr.wikipedia.org/wiki/1666) à [Bologne](https://fr.wikipedia.org/wiki/Bologne), ville qui est à l'époque un centre majeur de la culture musicale, avec une école florissante de violonistes. Il y apprend le [violon](https://fr.wikipedia.org/wiki/Violon) auprès de deux célèbres violonistes Leonardo Brugnoli et Giovanni Benvenuti, eux-mêmes élèves d'[Ercole Gaibara](https://fr.wikipedia.org/wiki/Ercole_Gaibara). En 1671, il se rend à Rome et devient violoniste de l'[église Saint-Louis-des-Français](https://fr.wikipedia.org/wiki/%C3%89glise_Saint-Louis-des-Fran%C3%A7ais_de_Rome). Il y subit notamment l'influence d'[Alessandro Stradella](https://fr.wikipedia.org/wiki/Alessandro_Stradella) (autre élève de Gaibara), lequel fut créateur de la formation en [concerto grosso](https://fr.wikipedia.org/wiki/Concerto_grosso), dont Corelli contribue au développement. Il fait partie des musiciens qui participent à la première présentation publique de l'[oratorio](https://fr.wikipedia.org/wiki/Oratorio) le plus connu de Stradella, *San Giovanni Battista*, en 1675, en l'église San Giovanni Battista dei Fiorentini, à Rome[\\[2\\]](https://fr.wikipedia.org/wiki/Arcangelo_Corelli#cite_note-2).\r\n		/x_pictures_persons/2025-05-19_09h25m18s_A44RITpu.jpg	f	true	active	2025-05-19 11:25:18.525098+02	2025-11-21 09:54:00.252951+01
3	2	M	Gregorio 	Allegri		gregorio.allegri@coopcoop.net	govern	chef de choeur	1982-01-01	2025-01-01	2021-02-01	\N	**Gregorio Allegri** (né Gregorio Costantino en [1582](https://fr.wikipedia.org/wiki/1582_en_musique_classique) à [Rome](https://fr.wikipedia.org/wiki/Rome) – mort le [17 février](https://fr.wikipedia.org/wiki/17_f%C3%A9vrier) [1652](https://fr.wikipedia.org/wiki/1652_en_musique_classique), dans la même ville) est un prêtre, [chantre d'église](https://fr.wikipedia.org/wiki/Chantre_\\(christianisme\\)) et [compositeur](https://fr.wikipedia.org/wiki/Compositeur) [italien](https://fr.wikipedia.org/wiki/Italie).\r\n\r\nIl est considéré comme l'un des compositeurs romains les plus importants de son temps. Il est l'auteur d'un très célèbre [*Miserere*](https://fr.wikipedia.org/wiki/Miserere_\\(Allegri\\)) (Psaume 50). Il vécut principalement à Rome.\r\n\r\nSon frère aîné, [Domenico Allegri](https://fr.wikipedia.org/w/index.php?title=Domenico_Allegri\\&action=edit\\&redlink=1), avait lui aussi embrassé la vie [ecclésiastique](https://fr.wikipedia.org/wiki/Clerg%C3%A9) et était également compositeur (à la [basilique Sainte-Marie-du-Trastevere](https://fr.wikipedia.org/wiki/Basilique_Sainte-Marie-du-Trastevere)). Fils d'un cocher du nom de Costantino, il a formé le nom d'Allegri d'après le prénom de son grand-père, Allegro.\r\n	Gregorio Allegri étudie le chant, et plus généralement la [musique](https://fr.wikipedia.org/wiki/Musique), avec plusieurs de ses frères, auprès de [Giovanni Bernardino Nanino](https://fr.wikipedia.org/wiki/Giovanni_Bernardino_Nanino), à l'[église Saint-Louis-des-Français](https://fr.wikipedia.org/wiki/%C3%89glise_Saint-Louis-des-Fran%C3%A7ais_de_Rome), à [Rome](https://fr.wikipedia.org/wiki/Rome), de [1591](https://fr.wikipedia.org/wiki/1591) à [1596](https://fr.wikipedia.org/wiki/1596). Après la mue sans doute, il se perfectionne dans les différentes disciplines musicales, dont la composition. Après avoir terminé sa formation, il entre dans la carrière musicale, en tant que [chantre](https://fr.wikipedia.org/wiki/Chantre_\\(christianisme\\)) (1601-1607) dans la même église. Ordonné prêtre, il exerce en tant que maître du chœur ([maître de chapelle](https://fr.wikipedia.org/wiki/Ma%C3%AEtre_de_chapelle)) à la cathédrale de [Fermo](https://fr.wikipedia.org/wiki/Fermo), de 1607 à 1621. Il y obtient un [bénéfice ecclésiastique](https://fr.wikipedia.org/wiki/B%C3%A9n%C3%A9fice_eccl%C3%A9siastique) qui l'aide à exercer sa lourde charge. Il compose un grand nombre de [motets](https://fr.wikipedia.org/wiki/Motet) et d’autres pièces de [musique religieuse](https://fr.wikipedia.org/wiki/Musique_religieuse). Ils lui valurent d’être remarqué par le pape [Urbain VIII](https://fr.wikipedia.org/wiki/Urbain_VIII) qui l’engage alors dans le chœur de la [Chapelle Sixtine](https://fr.wikipedia.org/wiki/Chapelle_Sixtine). Il garde cette position de décembre 1629 jusqu’à son décès. Il y est élu *Maître de chapelle* en [1650](https://fr.wikipedia.org/wiki/1650). Il est de caractère particulièrement simple et agréable&#x20;\r\n	portrait    de   Gregorio    Allegri	/x_pictures_events/2025-11-21_08h37m04s_hFBWJYvs.jpg	f	true	active	2025-05-19 11:21:49.193413+02	2025-11-21 09:54:00.252951+01
2	2	M	Claudio 	Monteverdi		Claudio.Monteverdi@coopcoop.net	govern	compositeur	1567-01-15	2025-01-01	2025-02-01		**Claudio Monteverdi** (baptisé le 15 janvier 1567 à [Crémone](https://fr.wikipedia.org/wiki/Cr%C3%A9mone)[\\[1\\]](https://fr.wikipedia.org/wiki/Claudio_Monteverdi#cite_note-Fabbri6-1) et mort le [29 novembre](https://fr.wikipedia.org/wiki/29_novembre) [1643](https://fr.wikipedia.org/wiki/1643_en_musique_classique) à [Venise](https://fr.wikipedia.org/wiki/Venise)), est un [compositeur](https://fr.wikipedia.org/wiki/Compositeur) [italien](https://fr.wikipedia.org/wiki/Italiens).\r\n\r\nSes œuvres, essentiellement vocales, se situent à la charnière de la [Renaissance](https://fr.wikipedia.org/wiki/Musique_de_la_Renaissance) et du [baroque](https://fr.wikipedia.org/wiki/Musique_baroque). Au cours de sa longue vie, il a produit des pièces appartenant aussi bien au style ancien qu'au nouveau et a apporté d’importants changements au style de son époque. Il est considéré comme l'un des créateurs de l'[opéra](https://fr.wikipedia.org/wiki/Op%C3%A9ra) et, avec [*L'Orfeo*](https://fr.wikipedia.org/wiki/L%27Orfeo), comme l'auteur du premier chef-d'œuvre du genre. Il est également le dernier grand représentant de l'école italienne du [madrigal](https://fr.wikipedia.org/wiki/Madrigal), auquel il a consacré neuf Livres, ainsi que l'auteur d'une œuvre de musique religieuse [polyphonique](https://fr.wikipedia.org/wiki/Polyphonie) (messes, vêpres, motets…).\r\n	Né à [Crémone](https://fr.wikipedia.org/wiki/Cr%C3%A9mone) en 1567[\\[2\\]](https://fr.wikipedia.org/wiki/Claudio_Monteverdi#cite_note-2),[\\[3\\]](https://fr.wikipedia.org/wiki/Claudio_Monteverdi#cite_note-3) dans la patrie des luthiers, élève de [Marc'Antonio Ingegneri](https://fr.wikipedia.org/wiki/Marc%27Antonio_Ingegneri), il y apprit, en même temps qu'il acquérait une formation humaniste, l’orgue, la viole, le chant et le [contrepoint](https://fr.wikipedia.org/wiki/Contrepoint_rigoureux) en usage à la fin de la Renaissance. Âgé de vingt ans à peine, il publie en 1587, à [Venise](https://fr.wikipedia.org/wiki/Venise), son premier Livre de Madrigaux à cinq voix.\r\n\r\nEn [1590](https://fr.wikipedia.org/wiki/1590), Monteverdi commença à travailler comme maître de musique de la chambre, à la cour de l'exubérant [Vincenzo Ier de Mantoue](https://fr.wikipedia.org/wiki/Vincent_Ier_de_Mantoue). En 1601 il y devient maître de chapelle. Il y restera, malgré de nombreuses difficultés, jusqu'en [1613](https://fr.wikipedia.org/wiki/1613), ne quittant la ville qu'après la mort, en 1612, de son premier patron.\r\n\r\nÀ [Mantoue](https://fr.wikipedia.org/wiki/Mantoue), comme plus tard à Venise, Monteverdi se consacra aussi bien à l’écriture de madrigaux, composant les *Livres II* à *V*, qu'à la musique religieuse et au tout nouveau genre de l'[opéra](https://fr.wikipedia.org/wiki/Art_lyrique). Dans le cinquième Livre de Madrigaux, publié en [1605](https://fr.wikipedia.org/wiki/1605), le compositeur, pour la première fois, expose l'opposition du style nouveau (ou [*seconda prattica*](https://fr.wikipedia.org/wiki/Seconda_pratica)), qu'il associe dans sa préface à la *Perfection de la musique moderne*, et du style ancien (ou [*prima prattica*](https://fr.wikipedia.org/wiki/Prima_pratica)), caractérisé par une stricte observance des règles du [contrepoint](https://fr.wikipedia.org/wiki/Contrepoint_rigoureux), telles qu'elles étaient enseignées, au milieu du siècle précédent, par [Gioseffo Zarlino](https://fr.wikipedia.org/wiki/Gioseffo_Zarlino). En outre, cinq des madrigaux accueillent pour la première fois une [basse continue](https://fr.wikipedia.org/wiki/Basse_continue), marquant le passage du style ancien *à voix seules*, au nouveau *stile&#x20;*[*concertato*](https://fr.wikipedia.org/wiki/Concertato) baroque.\r\n		/x_pictures_persons/2025-05-19_09h17m15s_nRT9M6Ko.jpg	f	true	active	2025-05-19 11:17:15.716482+02	2025-11-21 09:54:00.252951+01
30	2	M	cxc	cxcx		cxxcxc@dds.fr			\N	\N	\N					\N	t	true	archived	2025-11-21 09:58:49.879106+01	2025-11-21 09:58:49.879106+01
10	2	M	Franceco	Durante	000000	bNm67z5a@nowhere.com	team	arrangeur	1979-04-11	2025-01-01	2025-02-01	\N	**Francesco Durant**e (parfois appelé en français François Durante), né le 31 mars 16841 à Frattamaggiore (Campanie) et mort le 30 septembre 17551 à Naples, est un compositeur italien de musique baroque.\r\n	Né dans une famille de musiciens, il se rendit à [Naples](https://fr.wikipedia.org/wiki/Naples) en [1699](https://fr.wikipedia.org/wiki/1699_en_musique_classique), à la mort de son père, pour poursuivre ses études musicales auprès de son oncle Angelo[\\[2\\]](https://fr.wikipedia.org/wiki/Francesco_Durante#cite_note-Vignal-2), directeur du [conservatoire de Sant'Onofrio](https://fr.wikipedia.org/wiki/Conservatoire_de_Sant%27Onofrio_a_Porta_Capuana). À [Naples](https://fr.wikipedia.org/wiki/Naples) en [1705](https://fr.wikipedia.org/wiki/1705_en_musique_classique), il fit jouer sa première œuvre connue, un « *scherzo drammatico* » aujourd'hui perdu.\r\n\r\nDurant quelques mois, entre [1710](https://fr.wikipedia.org/wiki/1710_en_musique_classique) et [1711](https://fr.wikipedia.org/wiki/1711_en_musique_classique), il enseigna au [conservatoire de Sant'Onofrio](https://fr.wikipedia.org/wiki/Conservatoire_de_Sant%27Onofrio_a_Porta_Capuana), avant de prendre le chemin de [Rome](https://fr.wikipedia.org/wiki/Rome) où il séjourna probablement en [1718](https://fr.wikipedia.org/wiki/1718_en_musique_classique). Nommé en [1728](https://fr.wikipedia.org/wiki/1728_en_musique_classique) maître de musique au [Conservatoire dei Poveri di Gesù Cristo](https://fr.wikipedia.org/wiki/Conservatoire_dei_Poveri_di_Ges%C3%B9_Cristo) à Naples, il eut [Pergolèse](https://fr.wikipedia.org/wiki/Giovanni_Battista_Pergolesi) parmi ses élèves[\\[1\\]](https://fr.wikipedia.org/wiki/Francesco_Durante#cite_note-Honegger-1). Il démissionna de ce poste en [1739](https://fr.wikipedia.org/wiki/1739), sans qu'on en connaisse les raisons, puis en [1742](https://fr.wikipedia.org/wiki/1742), il succéda à [Nicola Porpora](https://fr.wikipedia.org/wiki/Nicola_Porpora) au conservatoire [*Conservatoire de Santa Maria di Loreto*](https://fr.wikipedia.org/wiki/Conservatoire_de_Santa_Maria_di_Loreto)[\\[1\\]](https://fr.wikipedia.org/wiki/Francesco_Durante#cite_note-Honegger-1), le plus ancien et le plus grand conservatoire napolitain dont il sut relever le niveau.\r\n\r\nÀ partir de [1745](https://fr.wikipedia.org/wiki/1745), et jusqu'à sa mort, il cumula cette charge avec celle de « *primo maestro* » de [Sant'Onofrio](https://fr.wikipedia.org/wiki/Conservatoire_de_Sant%27Onofrio_a_Porta_Capuana), où il avait été rappelé.\r\n	portrait    de   Franceco   Durante	/x_pictures_events/2025-05-01_17h06m58s_eUHGqeFf.png	f	true	active	2024-10-29 17:14:11+01	2025-11-21 09:54:00.252951+01
5	2	M	Giuseppe Torelli	Torelli		giuseppe.torelli@coopcoop.net	team	instrumentiste	1658-04-22	2025-01-01	2025-02-01	 violoniste et un compositeur italien de musique baroque.	**Giuseppe Torelli** né le [22 avril](https://fr.wikipedia.org/wiki/22_avril) [1658](https://fr.wikipedia.org/wiki/1658_en_musique_classique) à [Vérone](https://fr.wikipedia.org/wiki/V%C3%A9rone) et mort le [8 février](https://fr.wikipedia.org/wiki/8_f%C3%A9vrier) [1709](https://fr.wikipedia.org/wiki/1709_en_musique_classique) à [Bologne](https://fr.wikipedia.org/wiki/Bologne), est un [violoniste](https://fr.wikipedia.org/wiki/Violoniste) et un [compositeur](https://fr.wikipedia.org/wiki/Compositeur) [italien](https://fr.wikipedia.org/wiki/Italie) de [musique baroque](https://fr.wikipedia.org/wiki/Musique_baroque). Il est le frère du peintre [Felice Torelli](https://fr.wikipedia.org/wiki/Felice_Torelli).&#x20;\r\n	La formation musicale de Torelli est en grande partie inconnue. La première mention de son nom apparait le [27 juin](https://fr.wikipedia.org/wiki/27_juin) [1684](https://fr.wikipedia.org/wiki/1684_en_musique_classique) à Bologne où il est nommé : *membre de l'Accademia filarmonica*. Il semble qu'il ait pris des leçons auprès d'[Ercole Gaibara](https://fr.wikipedia.org/wiki/Ercole_Gaibara)[\\[réf. souhaitée\\]](https://fr.wikipedia.org/wiki/Aide:R%C3%A9f%C3%A9rence_n%C3%A9cessaire). Il est par contre certain qu'il a étudié la composition auprès de [Giacomo Antonio Perti](https://fr.wikipedia.org/wiki/Giacomo_Antonio_Perti) à [Bologne](https://fr.wikipedia.org/wiki/Bologne).\r\n\r\nEn septembre [1686](https://fr.wikipedia.org/wiki/1686_en_musique_classique), Torelli pose sa candidature pour obtenir un poste de joueur de *violette* — c'est-à-dire altiste — au sein de l'orchestre permanent de la [basilique San Petronio](https://fr.wikipedia.org/wiki/Basilique_San_Petronio_\\(Bologne\\)) de Bologne. Il obtient le poste après une période d'essai de six mois. Il restera membre de cet orchestre jusqu'en [janvier](https://fr.wikipedia.org/wiki/Janvier) [1696](https://fr.wikipedia.org/wiki/1696), date de sa dissolution.\r\n\r\nEn [1698](https://fr.wikipedia.org/wiki/1698_en_musique_classique), Torelli publie à [Augsbourg](https://fr.wikipedia.org/wiki/Augsbourg) ses *Concerti musicali a quattro* opus 6. Dans la dédicace, il réclame le titre de premier violon au service du [margrave de Brandebourg](https://fr.wikipedia.org/wiki/Marche_de_Brandebourg). La même année, Torelli exerce la fonction de [maître de chapelle](https://fr.wikipedia.org/wiki/Ma%C3%AEtre_de_chapelle) à la cour du comte d'[Ansbach](https://fr.wikipedia.org/wiki/Ansbach). En [1699](https://fr.wikipedia.org/wiki/1699_en_musique_classique) et [1700](https://fr.wikipedia.org/wiki/1700_en_musique_classique), il part en tournée en compagnie du chanteur Francesco Antonio Pistocchi ; tournée qui le mène probablement à [Berlin](https://fr.wikipedia.org/wiki/Berlin) puis à [Vienne](https://fr.wikipedia.org/wiki/Vienne_\\(Autriche\\)) ([Autriche](https://fr.wikipedia.org/wiki/Autriche))[\\[réf. souhaitée\\]](https://fr.wikipedia.org/wiki/Aide:R%C3%A9f%C3%A9rence_n%C3%A9cessaire). Au printemps [1701](https://fr.wikipedia.org/wiki/1701_en_musique_classique), Torelli retourne à Bologne et reprend sa place dans l'orchestre de la basilique San Petronio reconstitué sous la direction de Perti. Il finit sa vie à Bologne.\r\n		/x_pictures_persons/2025-05-19_09h28m17s_IqoWzfwA.png	t	true	active	2025-05-19 11:28:17.731174+02	2025-11-21 09:54:00.252951+01
\.


--
-- TOC entry 4141 (class 0 OID 21296)
-- Dependencies: 254
-- Data for Name: orga_dept_partners; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.orga_dept_partners (orga_partner_id, orga_dept_id, orga_partner_name, orga_partner_acronym, orga_partner_scope, orga_partner_link, orga_partner_logo_url, orga_partner_logo_title, orga_partner_type, orga_partner_category, orga_partner_date_since, orga_partner_status, orga_partner_punchline, orga_partner_summary, created_at, updated_at) FROM stdin;
4	2	Postgresql	Postgres	software	https://www.postgresql.org/	/x_logos/2025-04-30_12h03m37s_sq8qase7.png	logo de   Postgresql	partner	gold	2025-04-01	active	The world's most advanced open source database	PostgreSQL is a powerful, open source object-relational database system with over 35 years of active development that has earned it a strong reputation for reliability, feature robustness, and performance. 	2025-04-30 14:03:37.259934+02	2025-04-30 14:03:37.259934+02
1	2	LINUX		software	https://fr.wikipedia.org/wiki/Linux	/x_logos/2025-01-28_13h25m42s_Ik75dKyF.png	logo de   LINUX	partner	gold	2002-12-03	active	Free and open		2024-12-06 13:29:22+01	2024-12-06 13:29:22+01
3	2	SQLITE		database	https://www.sqlite.org/index.html	/x_logos/2025-01-28_13h26m39s_O7oTKSWj.png	logo de   SQLITE	partner	gold	2024-09-01	active	A light weight database		2024-12-07 13:23:47+01	2024-12-07 13:23:47+01
5	2	DBeaver Community		software	https://dbeaver.io/	/x_logos/2025-04-30_12h07m45s_8QhQGqHY.png		partner	silver	\N	active	 Free Universal Database Tool 	DBeaver Community is a free cross-platform database tool for developers, database administrators, analysts, and everyone working with data. It supports all popular SQL databases like MySQL, MariaDB, PostgreSQL, SQLite, Apache Family, and more.	2025-04-30 14:07:45.975329+02	2025-04-30 14:07:45.975329+02
6	2	DB Browser for SQLite		software	https://sqlitebrowser.org/	/x_logos/2025-04-30_12h10m16s_2SeZScvk.png	logo de   DB Browser for SQLite	partner	silver	2025-04-01	active	a high quality, visual, open source tool	DB Browser for SQLite (DB4S) is a high quality, visual, open source tool designed for people who want to create, search, and edit SQLite or SQLCipher database files. DB4S gives a familiar spreadsheet-like interface on the database in addition to providing a full SQL query facility. It works with Windows, macOS, and most versions of Linux and Unix. Documentation for the program is on the wiki.	2025-04-30 14:10:16.144074+02	2025-04-30 14:10:16.144074+02
10	2	VSCodium		software	https://vscodium.com/	/x_logos/2025-05-01_07h09m45s_tCtc37hH.png	logo de   VSCodium	partner	silver	2024-04-01	active	Free/Libre Open Source Software Binaries of VS Code		2025-05-01 09:09:45.471553+02	2025-05-01 09:09:45.471553+02
11	2	Signal			https://signal.org/fr/	/x_logos/2025-05-01_11h57m19s_etWR9kdD.png		social_network		\N	active	Exprimez-vous librement	Zéro compromis sur la sécurité	2025-05-01 13:57:19.626213+02	2025-05-01 13:57:19.626213+02
12	2	Mastodon			https://joinmastodon.org/fr	/x_logos/2025-05-01_11h58m52s_677t3Oko.png		social_network		\N	active	Le réseau social qui n'est pas à vendre		2025-05-01 13:58:52.795231+02	2025-05-01 13:58:52.795231+02
9	2	PeerTube			https://peertube.fr/	/x_logos/2025-05-01_12h01m09s_sXdYf99C.png	logo de   You Tube	social_network		2015-01-01	active		un logiciel libre d'hébergement de vidéo décentralisé permettant la diffusion en pair à pair, et un média social sur lequel les utilisateurs peuvent envoyer, regarder, commenter, évaluer et partager des vidéos en streaming. Il est créé en 2015 et est développé depuis 2017 par Framasoft. Il fonctionne sur le principe d'une fédération d'instances hébergées par des entités autonomes[3]. Son objectif est de fournir une alternative aux plateformes centralisées telles que YouTube, Vimeo[4],[5] et plus récemment Twitch avec l'ajout de la prise en charge de la diffusion en direct[6]. 	2024-12-08 10:00:18+01	2024-12-08 10:00:18+01
2	2	SQLPage		software	https://fr.wikipedia.org/wiki/Linux	/x_logos/2025-01-28_13h26m23s_GyR4XYE8.png	logo de   SQLPage	partner	gold	2002-12-03	active	from SQL to WWW		2024-12-07 11:06:37+01	2024-12-07 11:06:37+01
8	2	Linkedin			https://fr.linkedin.com/in/co-op-0000000000000000000000	/x_logos/2025-01-28_13h27m48s_xDTbvGw5.png	logo de   Linkedin	social_network		2015-01-01	active			2024-12-08 09:50:44+01	2024-12-08 09:50:44+01
7	2	Linux Mint		os	https://www.linuxmint.com/	/x_logos/2025-01-28_13h27m33s_w9heeLwp.png	logo de   Linux Mint			2015-01-01	active	a friendly operating system	Linux Mint is an operating system for desktop and laptop computers. It is designed to work 'out of the box' and comes fully equipped with the apps most people need.\r\n	2024-12-07 13:50:07+01	2024-12-07 13:50:07+01
\.


--
-- TOC entry 4111 (class 0 OID 21069)
-- Dependencies: 224
-- Data for Name: place; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.place (place_id, place_name, place_status, place_summary, place_adress, place_postal_code, place_town, place_country, place_latitude, place_longitude, place_contact_phone, place_contact_mail, place_type, place_accessibility, place_capacity_seats, place_capacity_standup, place_selected, created_at, updated_at) FROM stdin;
3	place001	active			\N			43.885000	-0.499200					\N	\N	\N	2025-05-01 11:37:47.267324+02	2025-05-01 11:42:29.027935+02
\.


--
-- TOC entry 4117 (class 0 OID 21107)
-- Dependencies: 230
-- Data for Name: place_spaces; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.place_spaces (space_id, place_id, space_name, space_rank, space_summary, space_access, space_type, space_accessibility, space_capacity_seats, space_capacity_standup, space_status, space_selected, created_at, updated_at) FROM stdin;
3	3	place001						\N	\N	active	\N	2025-05-01 11:37:47.314109+02	2025-11-22 14:11:42.682469+01
\.


--
-- TOC entry 4171 (class 0 OID 21526)
-- Dependencies: 284
-- Data for Name: place_spaces_pictures; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.place_spaces_pictures (space_picture_id, space_id, space_picture_url, space_picture_title, space_picture_summary, space_picture_format, space_picture_status, space_picture_selected, created_at, updated_at) FROM stdin;
2	3	/x_pictures_spaces/2025-11-22_09h23m49s_cr8HkxdX.jpg	img001	\N	png	active	\N	2025-05-01 13:49:37.906776+02	2025-11-22 10:23:49.048274+01
\.


--
-- TOC entry 4147 (class 0 OID 21341)
-- Dependencies: 260
-- Data for Name: prm1; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm1 (prm1_id, prm1_gender, prm1_first_name, prm1_last_name, prm1_phone, prm1_email, prm1_category, prm1_function, prm1_date_birthday, prm1_cv_short, prm1_cv_long, prm1_selected, prm1_status, created_at, updated_at) FROM stdin;
9	M	Sébastien	d'Ornano	+33 7 67 75 60 09	sqlpage.dornano@boucaou.eu	prm1_cat1		1956-12-08			f	active	2025-04-23 10:56:54.855165+02	2025-12-04 17:52:44.641232+01
11	M	Jean-Pierre	Martin	+33 6	dsdsds@nn.fd	prm1_cat1		\N			f	active	2025-04-27 14:08:39.8519+02	2025-12-04 17:52:44.641232+01
10	M	jean	Dupont	+33 6	jean.dupont@nnnn.gf	prm1_cat1		\N			f	active	2025-04-27 12:27:18.788667+02	2025-12-04 17:52:44.641232+01
8	M	Marcel	Durand	+33 6	wjjwcxxc@hh.fr	prm1_cat1		\N			f	active	2025-04-23 10:53:04.881413+02	2025-12-04 17:52:44.641232+01
\.


--
-- TOC entry 4149 (class 0 OID 21353)
-- Dependencies: 262
-- Data for Name: prm1_doc; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm1_doc (prm1_doc_id, prm1_id, prm1_doc_title, prm1_doc_author, prm1_doc_url, prm1_doc_summary, prm1_doc_keywords, prm1_doc_date_publication, prm1_doc_lang, prm1_doc_format, prm1_doc_category, prm1_doc_type, prm1_doc_selected, prm1_doc_status, created_at, updated_at, prm1_doc_date_period) FROM stdin;
7	9	xwx		/x_docs/2025-12-04_16h54m09s_qCmpMAY9.pdf			\N					f	active	2025-12-04 17:54:09.36726+01	2025-12-04 18:30:45.610354+01	\N
9	9	sdds		/x_docs/2025-12-04_17h02m11s_r0YrTMyC.pdf			\N					f	active	2025-12-04 18:02:11.369847+01	2025-12-04 18:30:45.610354+01	\N
8	9	xxwx		/x_docs/2025-12-04_17h00m32s_IbNoQJWt.pdf			\N					f	active	2025-12-04 18:00:32.935641+01	2025-12-04 18:30:45.610354+01	\N
\.


--
-- TOC entry 4145 (class 0 OID 21329)
-- Dependencies: 258
-- Data for Name: prm2; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm2 (prm2_id, prm2_name, prm2_acronym, prm2_logo_url, prm2_punchline, prm2_summary, prm2_adress, prm2_postal_code, prm2_town, prm2_country, prm2_latitude, prm2_longitude, prm2_contact_phone, prm2_contact_mail, prm2_status, prm2_legal_status, prm2_no_rna, prm2_no_siren, prm2_no_siret, prm2_no_tva_intracom, prm2_code_naf_ape, prm2_date_creation, prm2_number_employees, prm2_selected, updated_at, created_at) FROM stdin;
3	compagnie bleue		\N				\N			\N	\N			archived			\N	\N	\N		\N	\N	\N	2025-04-22 09:57:38.438953+02	2025-04-22 09:45:39.042841+02
5	Compagnie jaune		\N				\N			\N	\N			active			\N	\N	\N		\N	\N	\N	2025-04-27 14:06:13.914544+02	2025-04-27 14:06:13.914544+02
2	compagnie bleue		\N				\N			44.082584	-1.172093			active			\N	\N	\N		\N	\N	\N	2025-06-09 20:40:37.977176+02	2025-04-22 09:42:32.851883+02
6	test		\N				\N			\N	\N			active			\N	\N	\N		\N	\N	f	2025-12-11 10:04:48.56449+01	2025-12-11 10:04:48.56449+01
\.


--
-- TOC entry 4163 (class 0 OID 21436)
-- Dependencies: 276
-- Data for Name: prm2_sub; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm2_sub (prm2_sub_id, prm2_sub_name, prm2_id, prm2_sub_acronym, prm2_sub_logo_url, prm2_sub_punchline, prm2_sub_summary, prm2_sub_adress, prm2_sub_postal_code, prm2_sub_town, prm2_sub_country, prm2_sub_latitude, prm2_sub_longitude, prm2_sub_contact_phone, prm2_sub_contact_mail, prm2_sub_date_creation, prm2_sub_rank, prm2_sub_status, prm2_sub_legal_status, prm2_sub_nb_employees, prm2_sub_no_rna, prm2_sub_no_siren, prm2_sub_no_siret, prm2_sub_code_naf_ape, prm2_sub_no_tva_intracom, prm2_sub_selected, updated_at, created_at) FROM stdin;
7	Bleue - sub2	2		\N				\N			\N	\N			\N	dept	active		\N		\N	\N		\N	\N	2025-04-27 14:06:50.828697+02	2025-04-27 14:06:50.828697+02
8	Bleue - sub3	2		\N				\N			\N	\N			\N	dept	active		\N		\N	\N		\N	\N	2025-04-27 14:07:01.711187+02	2025-04-27 14:07:01.711187+02
9	Jaune - sub1	5		\N				\N			\N	\N			\N	dept	active		\N		\N	\N		\N	\N	2025-04-27 14:07:22.637434+02	2025-04-27 14:07:22.637434+02
6	Jaune - sub0	5		\N				\N			\N	\N			\N	main	active		\N		\N	\N		\N	\N	2025-04-27 14:07:44.904138+02	2025-04-27 14:06:14.001851+02
10	Jaune - sub2	5		\N				\N			\N	\N			\N	dept	active		\N		\N	\N		\N	\N	2025-04-27 14:08:01.554483+02	2025-04-27 14:08:01.554483+02
5	Bleue - sub1	2		\N				\N			\N	\N			\N	dept	active		\N		\N	\N		\N	\N	2025-12-04 18:18:28.502535+01	2025-04-22 12:16:54.821832+02
11	test	6		\N				\N			\N	\N			\N	main	active		\N		\N	\N		\N	f	2025-12-11 10:04:48.650885+01	2025-12-11 10:04:48.650885+01
\.


--
-- TOC entry 4213 (class 0 OID 22247)
-- Dependencies: 326
-- Data for Name: prm2_sub_docs; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm2_sub_docs (prm2_sub_doc_id, prm2_sub_id, prm2_sub_doc_title, prm2_sub_doc_author, prm2_sub_doc_url, prm2_sub_doc_summary, prm2_sub_doc_keywords, prm2_sub_doc_date_publication, prm2_sub_doc_date_period, prm2_sub_doc_lang, prm2_sub_doc_format, prm2_sub_doc_category, prm2_sub_doc_type, prm2_sub_doc_selected, prm2_sub_doc_status, created_at, updated_at) FROM stdin;
5	5	dsds		/x_docs/2025-12-04_17h19m04s_bsYBRDkG.pdf			\N	\N	FR				f	active	2025-12-04 18:19:04.675974+01	2025-12-04 18:31:46.435208+01
\.


--
-- TOC entry 4215 (class 0 OID 22270)
-- Dependencies: 328
-- Data for Name: prm2_sub_employees; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm2_sub_employees (employee_id, prm1_id, prm2_sub_id, employee_title, employee_function, employee_category, employee_status, employee_selected, employee_since, created_at, updated_at) FROM stdin;
9	10	5				active	f	\N	2025-04-27 12:27:18.935386+02	2025-04-27 12:27:18.935386+02
10	11	5				active	f	\N	2025-06-09 21:12:14.661907+02	2025-06-09 21:13:15.034589+02
8	9	5				active	f	\N	2025-04-23 11:02:00.858912+02	2025-06-09 21:13:33.435928+02
\.


--
-- TOC entry 4151 (class 0 OID 21369)
-- Dependencies: 264
-- Data for Name: prm3; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm3 (prm3_id, prm3_name, prm3_summary, prm3_category, prm3_status, prm3_selected, prm3_formal, prm3_nb_participants, prm3_type, prm3_date_creation, created_at, updated_at) FROM stdin;
4	test			active	\N		\N		\N	2025-06-09 21:14:12.751471+02	2025-06-09 21:14:12.751471+02
3	Team01	xwxw\r\n		active	\N		\N	prm1-prm1	\N	2025-04-22 18:12:06.645505+02	2025-12-05 09:50:37.130987+01
\.


--
-- TOC entry 4217 (class 0 OID 22294)
-- Dependencies: 330
-- Data for Name: prm3_docs; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm3_docs (prm3_doc_id, prm3_id, prm3_doc_title, prm3_doc_url, prm3_doc_summary, prm3_doc_keywords, prm3_doc_status, prm3_doc_category, prm3_doc_format, prm3_doc_selected, prm3_doc_date_publication, prm3_doc_type, created_at, updated_at) FROM stdin;
4	3	dds	/x_docs/2025-12-05_09h05m21s_hdF2SMR5.pdf			active			f	\N		2025-12-05 10:05:21.694719+01	2025-12-05 10:28:29.556284+01
\.


--
-- TOC entry 4153 (class 0 OID 21380)
-- Dependencies: 266
-- Data for Name: prm3_participants; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.prm3_participants (prm3_participant_id, prm3_id, prm1_id, prm2_sub_id, employee_id, prm3_participant_role, prm3_participant_type, prm3_participant_status, created_at, updated_at) FROM stdin;
4	3	\N	2	\N	participant	\N	\N	2025-04-23 11:00:02.014988+02	2025-04-23 11:00:02.014988+02
5	3	\N	2	\N	participant	\N	\N	2025-04-23 11:02:19.177253+02	2025-04-23 11:02:19.177253+02
6	3	\N	5	\N	participant	\N	\N	2025-04-23 11:02:29.199247+02	2025-04-23 11:02:29.199247+02
7	3	\N	5	\N	participant	\N	\N	2025-04-23 11:31:22.586578+02	2025-04-23 11:31:22.586578+02
8	3	\N	5	\N	participant	\N	\N	2025-04-23 11:43:45.59568+02	2025-04-23 11:43:45.59568+02
9	3	\N	5	\N	participant	\N	\N	2025-04-23 11:47:51.786287+02	2025-04-23 11:47:51.786287+02
10	3	\N	5	\N	participant	\N	\N	2025-04-23 11:49:05.314737+02	2025-04-23 11:49:05.314737+02
11	3	\N	5	\N	participant	\N	\N	2025-04-23 11:51:39.023573+02	2025-04-23 11:51:39.023573+02
12	3	\N	5	\N	participant	\N	\N	2025-04-23 11:52:53.845079+02	2025-04-23 11:52:53.845079+02
13	3	\N	5	\N	participant	\N	\N	2025-04-23 11:53:50.144416+02	2025-04-23 11:53:50.144416+02
14	3	\N	5	\N	participant	\N	\N	2025-04-23 11:54:25.03625+02	2025-04-23 11:54:25.03625+02
18	3	\N	5	9		employee	active	2025-04-27 14:10:04.112863+02	2025-04-27 14:10:04.112863+02
15	3	\N	5	\N		corporate	active	2025-04-23 13:16:27.811835+02	2025-06-10 10:03:05.237768+02
19	3	\N	7	\N		corporate	active	2025-04-27 14:14:13.490824+02	2025-12-05 10:04:30.577272+01
17	3	9	\N	\N		person	active	2025-04-27 14:09:39.069135+02	2025-12-05 10:04:36.016425+01
\.


--
-- TOC entry 4113 (class 0 OID 21080)
-- Dependencies: 226
-- Data for Name: process; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.process (process_id, process_title, process_description, process_category, process_status, process_publication_status, process_selected, created_at, updated_at) FROM stdin;
4	Purge_docs	Etape pour assurer l'effacement des fichiers inutiles	admin	active	\N	\N	2025-01-21 14:00:48+01	2025-01-21 14:00:48+01
5	Import Employees	importation en 2 étapes à partir de 2 tables liées	supervisor	active	\N	\N	2025-02-05 09:07:09+01	2025-04-15 15:28:44.774886+02
3	Rédaction d'un article	Rédaction d'un article	editor	active	online	\N	2024-12-20 10:40:16+01	2025-04-16 13:57:20.460333+02
6	Purger le serveur des fichiers orphelins	des documents et des photos liés à des personnes, des entreprises, des projets, des arcticles sont stockés sur le serveur dans les répetoires x_docs, x_news_pictures, x_pictures_events, x_pictures_persons, x_pictures_spaces. Quand une fiche projet ou personne est supprimée, l'url menant au fichier est supprimé. Le fichier est orphelin et encombre le serveur. Le processus explique la arche à suivre pour éliminer ces fichiers sur un système linux.	admin	active	\N	\N	2025-05-01 10:57:32.483055+02	2025-05-01 10:57:32.483055+02
\.


--
-- TOC entry 4115 (class 0 OID 21091)
-- Dependencies: 228
-- Data for Name: process_steps; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.process_steps (process_step_id, process_id, process_step_number, process_step_author, process_step_title, process_step_icon, process_step_link, process_step_description, process_step_selected, updated_at, created_at) FROM stdin;
1	3	1	\N	Rédaction		/b_news/news_main_form_3.sql	Rédaction de l'article	\N	2025-01-03 14:49:42+01	2024-12-20 11:13:31+01
2	3	2	\N	Information Superviseur		/c_chat/chat_main_display_1.sql	Informer le superviseur qu'un article est en attente de validation	\N	2025-01-03 15:39:54+01	2024-12-20 11:16:32+01
3	3	3	\N	Validation  par le superviseur		/b_news/news_main_edit_4.sql	Validation par le superviseur	\N	2025-01-03 15:40:43+01	2024-12-20 11:18:52+01
4	3	4	\N	Publication		/b_news/news_private_display_1.sql	Mise en ligne de l'article	\N	2025-01-03 14:51:05+01	2025-01-03 14:51:05+01
5	4	1	\N	Download csv file			Téléchager le fichier CSV contenant l'url des fichiers à effacer : doc_purge_full_list.csv 	\N	2025-01-21 14:04:38+01	2025-01-21 14:02:03+01
6	4	2	\N	Delet Colonne name			Pour supprimer l'en tête de la colonne file_url : sed '1d' doc_purge_full_list.csv > doc_purge_full_list_headless.csv	\N	2025-01-21 14:04:28+01	2025-01-21 14:04:28+01
7	4	3	\N	Delete files			effacer les fichiers en ligne de commande : cat doc_purge_full_list_headless.csv | xargs rm -f	\N	2025-01-21 14:08:39+01	2025-01-21 14:05:35+01
8	5	1	\N	Import personnes physiques	upload	/d_prm1/prm1_import_csv_4.sql	import des personnes dans la table pmr1	\N	2025-02-05 18:13:51+01	2025-02-05 09:08:38+01
9	5	2	\N	Récupération des id des personnes créées	download	/d_prm1/prm1_csv_full_0.sql	on récupère les prm1_id à partir du fichier télécharger	\N	2025-02-05 18:14:17+01	2025-02-05 09:09:59+01
10	5	3	\N	préparation du fichier d'import des employés	table-import	/x_docs/prm2_employee_upload_template2.csv	dans le fichier gabarit on complète les colonnes prm2_id (structure mère), prm2_sub_id(structure employeuse) et les prm1_id(pour le lien avec la table prm1)	\N	2025-02-05 18:15:34+01	2025-02-05 09:12:19+01
11	5	4	\N	Ajout des employés	upload	/d_prm2_sub_employees/prm2_sub_employee_csv_full_0.sql	 importer les employés dans la table prm2_sub_employees	\N	2025-02-05 18:14:46+01	2025-02-05 09:13:41+01
12	5	5	\N	contrôle	filter-check	/d_prm2_sub_employees/prm2_sub_employee_main_display_4.sql	On controle la présence des employés dans la liste	\N	2025-02-05 18:16:14+01	2025-02-05 09:14:52+01
13	5	0	\N	Essai dans la base bac à sable	sandbox		l'importation doit être d'abord testé dans une base test avant de lancer l'opération dans une base de production	\N	2025-02-05 18:17:21+01	2025-02-05 09:15:57+01
17	6	4	\N	Supprimer les fichiers orphelins	file-x		Suppression des fichiers orphelins avec la commande : \r\n\r\n**while read file; do\r\n    rm "/var/www/html/photos/$file"\r\ndone < orphaned_files.txt**	\N	2025-05-01 11:23:48.755211+02	2025-05-01 11:15:39.75194+02
15	6	2	\N	lister tous les fichiers présents 	database		lister tous les fichiers présents dans les répertoires où les photos sont stockées avec des commandes récursives sur tous les dossiers de stockage et créer un fichier avec la liste des images ou documents dans ces dossiers :\r\n\r\n**ls  /var/www/sqlpage/x_docs > existing_files.txt**	\N	2025-05-01 11:28:05.088342+02	2025-05-01 11:08:16.205152+02
14	6	1	\N	Repérer les fichiers référencés dans la base de données	folder		pour lister les fichiers référencés, il faut appliquer de manière récursive sur tous les dossiers de stockage, une requête du type :\r\n\r\n**SELECT photo_url FROM employees WHERE photo_url IS NOT NULL;**\r\n	\N	2025-05-01 11:21:38.852495+02	2025-05-01 10:59:54.029549+02
16	6	3	\N	Comparer les fichiers référencés et les fichiers existants	git-compare		On compare la liste des  fichiers référencés et les fichiers existants pour produire un liste des fichiers orphelins qui sont existants dans les dossiers mais non référencés dans la base de données :\r\n\r\n**comm -13 <(sort existing_files.txt) <(sort urls_from_db.txt) > orphaned_files.txt**	\N	2025-05-01 11:22:18.472676+02	2025-05-01 11:14:01.204384+02
\.


--
-- TOC entry 4175 (class 0 OID 21575)
-- Dependencies: 288
-- Data for Name: project; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project (project_id, project_name, project_summary, project_category, project_nb_participants, project_status, project_date_start_scheduled, project_date_start_actual, project_date_end_scheduled, project_date_end_actual, project_duration_scheduled, project_duration_actual, project_completion_percentage, created_at, updated_at, project_date_creation) FROM stdin;
19	Projet001		small_heritage_restoration	\N	active	2025-04-17	\N	\N	\N	90	9	\N	2025-04-17 10:46:00.579845+02	2025-06-10 10:24:57.469871+02	2025-05-09
20	Projet002		building_creation	\N	active	2022-12-17	2021-12-17	\N	\N	30	45	\N	2025-04-17 11:41:58.155777+02	2025-12-30 16:15:44.415844+01	2021-12-17
\.


--
-- TOC entry 4185 (class 0 OID 21667)
-- Dependencies: 298
-- Data for Name: project_building; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_building (building_id, project_id, building_name, building_status, building_summary, building_adress, building_postal_code, building_town, building_country, building_latitude, building_longitude, building_contact_phone, building_contact_mail, building_type, building_accessibility, building_capacity_seats, building_capacity_standup, building_selected, created_at, updated_at) FROM stdin;
3	20	Serre géodésique	active	Serre de 4 m de diamètre, 20m2\r\n	277 route de Bias	40170	Mézos	France	44.082600	-1.171860	0767756009	sqlpage.dornano@boucaou.eu	building	accessible	\N	\N	\N	2025-04-19 16:47:29.301392+02	2025-06-21 09:38:34.942487+02
4	19	bat005	active			\N			44.577700	-1.166670				accessible	\N	\N	\N	2025-04-19 18:17:53.599374+02	2025-12-13 12:08:24.740086+01
\.


--
-- TOC entry 4187 (class 0 OID 21683)
-- Dependencies: 300
-- Data for Name: project_building_rooms; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_building_rooms (room_id, building_id, room_name, room_rank, room_type, room_summary, room_todo, room_access, room_accessibility, room_capacity_seats, room_capacity_standup, room_status, room_selected, room_width, room_length, room_height, room_wall_material, room_floor_material, room_quality_level, updated_at, created_at) FROM stdin;
3	3	Serre géodésique	\N	Main_Building	serre diamètre 4 m, 20m2\r\n	* décaissement zone centrale\r\n* sol en pavés auto bloquants\r\n* poteaux d'appui en rondin diam 10\r\n* sciage des tasseaux selon les côtes du fabricant de connecteur\r\n* réalisation de la structure de la géode avec des connecteurs Hubs et des tasseaux\r\n* installation d'une porte de récupération\r\n* bardage en volige horizontale à clins\r\n* mise en place de la bâche en plastique agricole\r\n* installation mobilier intérieur : étagères... à partir de bois de récup\r\n			\N	\N	active	\N	\N	\N	\N	bâche agricole	sol brut et zone centrale en pavés béton		2025-06-21 09:56:59.982161+02	2025-04-19 16:47:29.363349+02
8	3	Serre2	\N	N			\N		\N	\N	active	\N	\N	\N	\N		\N		2025-06-22 12:16:09.827898+02	2025-06-22 12:16:09.827898+02
4	4	bat005	\N						\N	\N	active	\N	\N	\N	\N				2025-12-13 12:08:24.793018+01	2025-04-19 18:17:53.670999+02
\.


--
-- TOC entry 4189 (class 0 OID 21699)
-- Dependencies: 302
-- Data for Name: project_building_rooms_pictures; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_building_rooms_pictures (room_picture_id, building_id, project_id, room_id, room_picture_url, room_picture_title, room_picture_summary, room_picture_format, room_picture_status, room_picture_selected, created_at, updated_at, workpackage_id, worksequence_id) FROM stdin;
39	3	20	3	/x_pictures_spaces/2025-06-21_08h06m01s_lVUhIrey.JPG	serre_essai_montage_14	\N	jpeg	active	\N	2025-06-21 10:06:01.27454+02	2025-06-21 18:03:29.068629+02	21	\N
41	3	20	3	/x_pictures_spaces/2025-06-21_08h08m20s_d31xlBAC.JPG	serre_essai_montage_16	\N	jpeg	active	\N	2025-06-21 10:08:20.018457+02	2025-06-21 18:03:52.606529+02	21	\N
42	3	20	3	/x_pictures_spaces/2025-06-21_08h09m17s_NDRP0O7D.JPG	serre_essai_montage_17	\N	jpeg	active	\N	2025-06-21 10:09:17.207236+02	2025-06-21 18:04:04.401763+02	21	\N
44	3	20	3	/x_pictures_spaces/2025-06-21_08h09m56s_JKmPLPFc.JPG	serre_essai_montage_19	\N	jpeg	active	\N	2025-06-21 10:09:56.947576+02	2025-06-21 18:04:28.501013+02	21	\N
45	3	20	3	/x_pictures_spaces/2025-06-21_08h10m48s_iY5oPcMR.JPG	serre_essai_montage_20	\N	jpeg	active	\N	2025-06-21 10:10:48.06173+02	2025-06-21 18:04:40.88082+02	21	\N
26	3	20	3	/x_pictures_spaces/2025-06-21_07h58m43s_tajDwO6g.JPG	serre_essai_montage_02	test test\r\n	jpeg	active	\N	2025-06-21 09:58:43.283654+02	2025-06-22 11:03:30.703854+02	21	9
27	3	20	3	/x_pictures_spaces/2025-06-21_07h59m00s_jAuv2PqG.JPG	serre_essai_montage_03		jpeg	active	\N	2025-06-21 09:59:00.8049+02	2025-06-22 11:03:40.326526+02	21	8
28	3	20	3	/x_pictures_spaces/2025-06-21_07h59m23s_1SdHcCvY.JPG	serre_essai_montage_04		jpeg	active	\N	2025-06-21 09:59:23.067074+02	2025-06-22 11:03:56.785565+02	21	9
36	3	20	3	/x_pictures_spaces/2025-06-21_08h04m35s_Ot8cuM9d.JPG	serre_essai_montage_11	\N	jpeg	active	\N	2025-06-21 10:04:35.490364+02	2025-06-21 18:02:51.664691+02	21	\N
37	3	20	3	/x_pictures_spaces/2025-06-21_08h05m15s_7z5TTBAn.JPG	serre_essai_montage_12	\N	jpeg	active	\N	2025-06-21 10:05:15.088558+02	2025-06-21 18:03:02.637132+02	21	\N
38	3	20	3	/x_pictures_spaces/2025-06-21_08h05m37s_hJ3C9OWF.JPG	serre_essai_montage_13	\N	jpeg	active	\N	2025-06-21 10:05:37.363475+02	2025-06-21 18:03:15.497574+02	21	\N
70	3	20	\N	/x_pictures_spaces/2025-06-22_09h38m46s_Bvv9Lywe.JPG	test	\N		active	\N	2025-06-22 11:35:58.24646+02	2025-06-22 11:35:58.24646+02	21	\N
72	3	20	3	/x_pictures_spaces/2025-06-22_09h45m47s_CbeXdDnH.JPG	test	\N		active	\N	2025-06-22 11:45:02.111802+02	2025-06-22 11:45:02.111802+02	\N	\N
43	3	20	3	/x_pictures_spaces/2025-06-21_08h09m38s_xUwH250y.JPG	serre_essai_montage_18		jpeg	active	\N	2025-06-21 10:09:38.75874+02	2025-06-22 12:15:27.288571+02	21	\N
74	4	19	4	/x_pictures_spaces/2025-12-03_15h58m41s_NapqxUn2.png	dsds			active	\N	2025-12-03 16:58:41.365789+01	2025-12-03 17:38:41.037119+01	\N	\N
40	3	20	3	/x_pictures_spaces/2025-06-21_08h06m48s_JfBuuDMk.JPG	serre_essai_montage_15	\N	jpeg	active	\N	2025-06-21 10:06:48.503186+02	2025-06-21 18:03:40.533029+02	21	\N
68	3	20	3	/x_pictures_spaces/2025-06-21_10h05m33s_nKsE7QJo.JPG	serre_essai_montage_21	\N	jpeg	active	\N	2025-06-21 11:53:20.346626+02	2025-06-21 18:04:50.98745+02	21	\N
29	3	20	3	/x_pictures_spaces/2025-06-21_07h59m48s_0RwlzOYD.JPG	serre_essai_montage_05		jpeg	active	\N	2025-06-21 09:59:48.159564+02	2025-06-22 11:04:06.853413+02	21	10
30	3	20	3	/x_pictures_spaces/2025-06-21_08h00m09s_RlGpLB5m.JPG	serre_essai_montage_07		jpeg	active	\N	2025-06-21 10:00:09.441736+02	2025-06-22 11:29:29.732539+02	21	10
71	3	20	\N	\N	\N	\N	\N	\N	\N	2025-06-22 11:43:51.502089+02	2025-06-22 11:43:51.502089+02	\N	\N
33	3	20	3	/x_pictures_spaces/2025-06-21_08h03m19s_IRlskF7t.JPG	serre_essai_montage_08	\N	jpeg	active	\N	2025-06-21 10:03:19.13076+02	2025-06-21 18:02:22.500169+02	21	\N
34	3	20	3	/x_pictures_spaces/2025-06-21_08h03m41s_IVEB8EF0.JPG	serre_essai_montage_09	\N	jpeg	active	\N	2025-06-21 10:03:41.824768+02	2025-06-21 18:02:30.208937+02	21	\N
35	3	20	3	/x_pictures_spaces/2025-06-21_08h04m07s_7qwKWiBM.JPG	serre_essai_montage_10	\N	jpeg	active	\N	2025-06-21 10:04:07.999362+02	2025-06-21 18:02:41.256722+02	21	\N
73	3	20	3	/x_pictures_spaces/2025-06-22_10h02m04s_HGotqnsf.JPG	testtt	\N		active	\N	2025-06-22 12:01:48.160157+02	2025-06-22 12:01:48.160157+02	21	\N
25	3	20	3	/x_pictures_spaces/2025-06-21_07h58m18s_ZNLppRL4.JPG	serre_essai_montage_01		jpeg	active	\N	2025-06-21 09:58:18.053364+02	2025-06-22 12:14:12.263816+02	\N	\N
75	4	19	4	/x_pictures_spaces/2025-12-03_16h44m02s_viaQAoOg.png	dsds	\N		active	\N	2025-12-03 17:39:06.708942+01	2025-12-03 17:39:06.708942+01	23	7
\.


--
-- TOC entry 4205 (class 0 OID 21932)
-- Dependencies: 318
-- Data for Name: project_docs; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_docs (project_doc_id, project_id, project_doc_title, project_doc_author, project_doc_url, project_doc_cloud_url, project_doc_summary, project_doc_keywords, project_doc_date_publication, project_doc_date_period, project_doc_lang, project_doc_format, project_doc_category, project_doc_type, project_doc_local_cloud, project_doc_cloud_format, project_doc_selected, project_doc_status, created_at, updated_at, project_forum_message_id, project_doc_title_link) FROM stdin;
53	\N	ddd	\N	/x_project_docs/2025-12-10_08h09m59s_BavNhnJV.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-10 09:09:59.310276+01	2025-12-10 09:09:59.310276+01	57	\N
54	\N	\N	\N	\N	https://sql-page.com/documentation.sql	\N	\N	\N	\N	\N	\N	\N	\N	cloud	\N	f	active	2025-12-10 09:09:59.378673+01	2025-12-10 09:09:59.378673+01	57	w<
55	\N	true	\N	/x_project_docs/2025-12-10_09h00m36s_oKFe9DTu.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-10 10:00:36.393538+01	2025-12-10 10:00:36.393538+01	58	\N
56	\N		\N	/x_project_docs/2025-12-10_09h02m33s_mlLt9IYv.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-10 10:02:33.848273+01	2025-12-10 10:02:33.848273+01	59	\N
57	\N	no title	\N	/x_project_docs/2025-12-10_09h06m51s_D6UVMl7q.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-10 10:06:51.010111+01	2025-12-10 10:06:51.010111+01	60	\N
58	\N	fdfds	\N	/x_project_docs/2025-12-11_13h45m00s_9oTuIHXo.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-11 14:45:00.882867+01	2025-12-11 14:45:00.882867+01	62	\N
59	\N	fdfds	\N	/x_project_docs/2025-12-11_13h46m38s_3r5YM7We.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-11 14:46:38.475605+01	2025-12-11 14:46:38.475605+01	63	\N
60	\N	fdfds	\N	/x_project_docs/2025-12-11_13h51m43s_5O4hWk9F.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-11 14:51:43.874245+01	2025-12-11 14:51:43.874245+01	64	\N
61	\N	\N	\N	\N	https://sql-page.com/documentation.sql	\N	\N	\N	\N	\N	\N	\N	\N	cloud	\N	f	active	2025-12-11 14:51:43.881876+01	2025-12-11 14:51:43.881876+01	64	no title
50	\N	ddd	\N	/x_project_docs/2025-12-10_08h06m00s_sET2mZeK.pdf	\N	\N	\N	\N	\N	\N	\N	\N	\N	local	\N	f	active	2025-12-10 09:06:00.314689+01	2025-12-10 09:06:00.314689+01	\N	\N
\.


--
-- TOC entry 4183 (class 0 OID 21655)
-- Dependencies: 296
-- Data for Name: project_forum_messages; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_forum_messages (project_forum_message_id, project_forum_topic_id, project_forum_message_recipient_id, project_forum_message_author_id, project_forum_message_content, project_forum_message_status, project_forum_message_rank, created_at, updated_at) FROM stdin;
72	47	\N	19	Votre post :\r\n	active	post	2025-12-12 09:35:37.949705+01	2025-12-12 09:41:26.379222+01
73	47	\N	19	Votre post :\r\n	active	post	2025-12-12 09:47:55.645494+01	2025-12-12 14:08:01.102186+01
50	45	\N	19	Votre message :xxw\r\n	active	main	2025-12-06 11:01:19.896669+01	2025-12-06 11:01:19.896669+01
52	47	\N	19	Votre message :sd\r\n	active	main	2025-12-06 11:29:54.603217+01	2025-12-06 11:29:54.603217+01
53	47	\N	19	Votre post :   vnvnvnnv\r\n	active	post	2025-12-06 14:30:05.914027+01	2025-12-06 14:30:05.914027+01
54	47	\N	19	Votre post : cxccxxc\r\n	active	post	2025-12-07 16:11:23.671659+01	2025-12-07 16:11:23.671659+01
55	47	\N	19	Votre post :ccccccc\r\n	active	post	2025-12-10 09:06:00.158577+01	2025-12-10 09:06:00.158577+01
56	47	\N	19	Votre post :ccccccc\r\n	active	post	2025-12-10 09:09:38.143773+01	2025-12-10 09:09:38.143773+01
66	47	\N	3	Votre post :ssqsq\r\n	active	post	2025-12-11 14:55:04.503614+01	2025-12-11 14:55:04.503614+01
67	47	\N	3	Votre posttest\r\n	active	post	2025-12-11 16:24:59.514025+01	2025-12-11 16:24:59.514025+01
68	47	\N	3	Votre post :xwxw\r\n	active	post	2025-12-11 16:25:23.212838+01	2025-12-11 16:25:23.212838+01
69	47	\N	3	Votre post :fdd\r\n	active	post	2025-12-11 16:25:40.001891+01	2025-12-11 16:25:40.001891+01
70	47	\N	19	Votre post :xwxw\r\n	active	post	2025-12-11 16:28:12.092406+01	2025-12-11 16:28:12.092406+01
71	47	\N	19	1222\r\n	active	post	2025-12-11 16:48:32.984599+01	2025-12-12 09:34:15.224454+01
\.


--
-- TOC entry 4181 (class 0 OID 21642)
-- Dependencies: 294
-- Data for Name: project_forum_topics; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_forum_topics (project_forum_topic_id, project_id, project_forum_topic_author_id, project_forum_topic_name, project_forum_topic_category, debug_target, forum_type, number_messages, forum_group, project_forum_topic_status, project_forum_topic_selected, created_at, updated_at) FROM stdin;
47	19	19	dssd	general	\N	forum	18	G0	archived	\N	2025-12-06 11:29:54.500711+01	2025-12-16 17:30:28.838229+01
45	19	19	dssd	general	\N	forum	1	G0	archived	\N	2025-12-06 11:01:19.831026+01	2025-12-18 13:03:16.129655+01
\.


--
-- TOC entry 4207 (class 0 OID 22046)
-- Dependencies: 320
-- Data for Name: project_meeting; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_meeting (project_meeting_id, project_meeting_place_id, project_id, project_meeting_title, project_meeting_agenda, project_meeting_visio, project_meeting_visio_url, project_meeting_visio_code, project_meeting_date, project_meeting_hour_start, project_meeting_hour_end, project_meeting_duration, project_meeting_type, project_meeting_participants_nb, project_meeting_alert, project_meeting_status, created_at, updated_at) FROM stdin;
1	2	19	dsds		visio			2025-04-27	02:15:00	02:30:00	02:30:00	concert	1	alert_end	active	2025-04-20 16:15:05.991075+02	2025-04-20 18:44:10.644123+02
3	\N	19	dsds		visio			2025-04-25	\N	\N	\N		1	alert_end	active	2025-04-20 16:18:49.463372+02	2025-04-20 18:48:54.567326+02
4	\N	19	test	test\r\n	visio			2025-06-28	02:15:00	02:45:00	02:45:00	concert	1	alert_end	active	2025-06-02 12:08:13.836931+02	2025-06-02 12:08:14.099013+02
7	\N	19	sqsqsq		false			2025-12-26	03:00:00	\N	\N		6	alert_end	active	2025-12-03 10:02:43.806926+01	2025-12-03 15:42:19.59788+01
5	\N	20	dsds		false			2025-06-29	02:30:00	\N	\N	concert	1	alert_end	active	2025-06-10 15:34:44.028516+02	2025-06-11 17:18:58.935302+02
6	\N	20	test		false			2025-07-06	\N	\N	\N	concert	8	alert_end	active	2025-06-11 16:59:57.296821+02	2025-06-12 15:18:19.031684+02
\.


--
-- TOC entry 4179 (class 0 OID 21631)
-- Dependencies: 292
-- Data for Name: project_meeting_participants; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_meeting_participants (project_meeting_participant_id, project_meeting_id, user_id, prm1_id, prm2_sub_id, employee_id, project_meeting_participant_role, project_meeting_participant_type, project_meeting_participant_status, created_at, updated_at) FROM stdin;
2	1	19	\N	\N	\N	coordinator	orga_member	\N	2025-04-20 16:15:06.119366+02	2025-04-20 16:15:06.119366+02
3	3	19	\N	\N	\N	coordinator	orga_member	\N	2025-04-20 16:18:49.523574+02	2025-04-20 16:18:49.523574+02
4	4	19	\N	\N	\N	coordinator	orga_member	\N	2025-06-02 12:08:14.011482+02	2025-06-02 12:08:14.011482+02
11	5	\N	9	\N	\N	coordinator	person	active	2025-06-11 17:18:58.921455+02	2025-06-11 17:18:58.921455+02
15	6	\N	10	\N	\N	co_coordinator	person	active	2025-06-11 17:57:43.738655+02	2025-06-11 17:57:43.738655+02
19	6	\N	11	\N	\N	participant	person	active	2025-06-11 18:15:18.649849+02	2025-06-11 18:15:18.649849+02
20	6	\N	11	5	10	co_coordinator	employee	active	2025-06-11 18:17:04.128171+02	2025-06-11 18:17:04.128171+02
21	6	\N	11	5	10	participant	employee	active	2025-06-12 15:18:12.032599+02	2025-06-12 15:18:12.032599+02
14	6	19	\N	\N	\N	co_coordinator	orga_member	\N	2025-06-11 17:57:35.778176+02	2025-06-12 15:21:05.392923+02
30	7	19	\N	\N	\N	coordinator	orga_member	\N	2025-12-03 15:42:19.431447+01	2025-12-03 15:42:26.471062+01
\.


--
-- TOC entry 4177 (class 0 OID 21620)
-- Dependencies: 290
-- Data for Name: project_meeting_places; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_meeting_places (project_meeting_place_id, project_meeting_place_name, project_meeting_place_status, project_meeting_place_summary, project_meeting_place_adress, project_meeting_place_postal_code, project_meeting_place_town, project_meeting_place_country, project_meeting_place_latitude, project_meeting_place_longitude, project_meeting_place_contact_phone, project_meeting_place_contact_mail, project_meeting_place_type, project_meeting_place_accessibility, project_meeting_place_capacity_seats, project_meeting_place_capacity_standup, project_meeting_place_selected, created_at, updated_at) FROM stdin;
3	place 5	active			\N			44.950000	-1.080000					\N	\N	\N	2025-06-10 19:50:28.356135+02	2025-06-10 19:50:28.356135+02
2	meeting place 01	active			\N			44.900000	-1.050000					\N	\N	\N	2025-04-17 09:36:55.915261+02	2025-12-03 15:54:56.919387+01
\.


--
-- TOC entry 4193 (class 0 OID 21726)
-- Dependencies: 306
-- Data for Name: project_products; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_products (product_id, product_category_id, product_name, product_summary, product_ienes_url, product_functional_unit, product_unit, product_climate_change_indicator, product_status, created_at, updated_at) FROM stdin;
5	\N	test		dsds			\N	archived	2025-06-12 19:01:30.234664+02	2025-12-03 16:07:01.645811+01
7	42	xwx		xwxw			\N	active	2025-12-03 16:10:46.017041+01	2025-12-03 16:14:19.920422+01
4	42	Tuile de terre cuite à emboitement 		https://base-inies.fr/consultation/infos-produit/29820	Assurer la fonction de couverture sur 1 m² sur une durée de vie de référence de 100 ans.\r\n	1 m2	13.8	active	2025-04-17 18:30:53.328181+02	2025-12-03 16:20:34.032069+01
\.


--
-- TOC entry 4191 (class 0 OID 21710)
-- Dependencies: 304
-- Data for Name: project_products_categories; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_products_categories (product_category_id, product_category_parent_id, product_category_name, product_category_status, product_category_summary, created_at, updated_at) FROM stdin;
2	\N	Voirie, TP	active		2025-03-24 16:52:41+01	2025-03-24 16:52:41+01
3	\N	Assainissement	active		2025-03-24 16:53:06+01	2025-03-24 16:53:06+01
4	\N	 Planchers, dallages, chapes	active		2025-03-24 16:53:22+01	2025-03-24 16:53:22+01
5	\N	 Plâtre, isolation, plafonds	active		2025-03-24 16:53:37+01	2025-03-24 16:53:37+01
6	\N	Toiture	active		2025-03-24 16:53:52+01	2025-03-24 16:53:52+01
7	\N	Carrelage intérieur	active		2025-03-24 16:54:06+01	2025-03-24 16:54:06+01
8	\N	 Autres revêtements sol et mur	active		2025-03-24 16:54:20+01	2025-03-24 16:54:20+01
9	\N	Salle de bain, WC, sanitaires	active		2025-03-24 16:54:38+01	2025-03-24 16:54:38+01
10	\N	Terrasses et extérieurs	active		2025-03-24 16:54:54+01	2025-03-24 16:54:54+01
11	\N	 Portes, fenêtres, menuiserie	active		2025-03-24 16:55:08+01	2025-03-24 16:55:08+01
12	\N	Bois et panneaux	active		2025-03-24 16:55:30+01	2025-03-24 16:55:30+01
13	\N	Outillage	active		2025-03-24 16:55:44+01	2025-03-24 16:55:44+01
14	\N	Matériel de chantier	active		2025-03-24 16:56:00+01	2025-03-24 16:56:00+01
15	\N	Equipement de protection, sécurité	active		2025-03-24 16:56:14+01	2025-03-24 16:56:14+01
16	\N	Quincaillerie	active		2025-03-24 16:56:28+01	2025-03-24 16:56:28+01
17	\N	Peinture, mastic, droguerie	active		2025-03-24 16:56:43+01	2025-03-24 16:56:43+01
18	\N	Electricité, ventilation	active		2025-03-24 16:56:56+01	2025-03-24 16:56:56+01
19	\N	Plomberie	active		2025-03-24 16:57:08+01	2025-03-24 16:57:08+01
20	\N	 Matériaux naturels	active		2025-03-24 16:57:24+01	2025-03-24 16:57:24+01
21	20	Terre crue	active		2025-03-24 16:57:55+01	2025-03-24 16:57:55+01
22	20	Torchis	active		2025-03-24 16:59:04+01	2025-03-24 16:59:04+01
23	20	Enduit terre crue	active		2025-03-24 16:59:42+01	2025-03-24 16:59:42+01
24	20	Terre paille	active		2025-03-24 17:00:06+01	2025-03-24 17:00:06+01
25	20	chaux chanvre	active		2025-03-24 17:00:42+01	2025-03-24 17:00:42+01
26	20	botte de paille	active		2025-03-24 17:01:05+01	2025-03-24 17:01:05+01
27	20	miscanthus	active		2025-03-24 17:01:21+01	2025-03-24 17:01:21+01
28	20	chenevotte	active		2025-03-24 17:01:37+01	2025-03-24 17:01:37+01
29	1	Parpaings	active		2025-03-24 17:10:19+01	2025-03-24 17:10:19+01
30	1	Briques	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
31	1	Blocs béton cellulaire	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
32	1	Ciment chaux	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
33	1	Mortiers bétons secs BPE	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
34	1	Plâtres & enduits	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
35	1	Agrégats : sable gravier gravillons	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
36	1	Aciers : treillis soudé rond à béton armature	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
37	1	Appuis de fenêtre seuils produits béton préfabriqués	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
38	1	Coffrage : bois panneaux et carton de coffrage	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
39	1	Chimie du bâtiment : ragréage mortier de réparation	active	\N	2025-03-25 12:40:34+01	2025-03-25 12:40:34+01
41	6	tuiles à emboitement en terre cuite	active	\N	2025-03-29 13:24:54+01	2025-03-29 13:24:54+01
42	2	Fonte de voirie	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
43	2	Bordures et caniveaux	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
44	2	Regards et boîtes	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
45	2	Tuyaux -  raccords et drains	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
46	2	Réseaux secs	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
47	2	Géotextiles voirie TP	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
48	2	Adduction d'eau	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
49	2	Produits de mise en oeuvre VRD	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
50	3	Caniveaux bâtiment	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
51	3	Drainage -  épandage et filtration	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
52	3	Equipement des sols PVC	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
53	3	Fosses -  microstations et filtres compacts	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
54	3	Récupération des eaux pluviales	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
55	3	Regards et buses d'assainissement	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
56	3	Traitement des eaux	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
57	3	Tubes et raccords PVC pour l'assainissement	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
58	4	Poutrelles précontraintes	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
59	4	Entrevous - hourdis	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
60	4	Planelles	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
61	4	Poutres béton	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
62	4	Chapes allégées	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
63	5	Plaques de plâtre et cloisons	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
64	5	Ossatures métalliques et accessoires	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
65	5	ITE (Isolation Thermique par l'Extérieur)	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
66	5	ITI ( Isolation Thermique par l'Intérieur)	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
67	5	Isolation des toitures	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
68	5	Isolation des sols	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
69	5	Etanchéité à l'air	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
70	5	Isolation phonique des murs	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
71	5	Isolants biosourcés et naturels	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
72	5	Plafonds	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
73	5	Plâtres -  enduits -  mortiers	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
74	5	Trappes de visite	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
75	6	Tuiles	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
76	6	Ardoises -  bardeaux	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
77	6	Toitures métalliques	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
78	6	Plaques de toiture	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
79	6	Etanchéité -  traitement de toiture	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
80	6	Gouttières -  zinguerie	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
81	6	Fenêtres de toit -Velux et autres marques	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
82	6	Composants de toiture	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
83	6	Conduits de fumée et tubage	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
84	6	ITE -  isolation des toitures	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
85	6	Bardage -  clins -  panneaux	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
86	6	Photovoltaïque	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
87	7	Carrelage sol intérieur	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
88	7	Carrelage mur salle de bain -crédence cuisine -faïence	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
89	7	Mosaïque -  galet -  listel	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
90	7	Carrelage grand format et XXL	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
91	7	Carreaux ciment	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
93	7	Produits de mise en oeuvre carrelage	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
92	7	Plinthes et accessoires carrelage	active		2025-03-31 13:50:00+02	2025-04-17 17:02:23.456063+02
40	1	Etanchéité et protection	active		2025-03-25 12:40:34+01	2025-04-17 17:14:44.71619+02
94	8	Parquet	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
95	8	Sol stratifié	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
96	8	Vinyles (PVC -  lino)	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
97	8	Moquette	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
98	8	Plinthes et accessoires autres revêtements	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
99	8	Lambris	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
100	8	Produits de mise en œuvre intérieur	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
101	9	Meubles salle de bain	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
102	9	Lavabo et vasque	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
103	9	Robinetterie	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
104	9	Baignoire	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
105	9	Douche	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
106	9	Cuisine	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
107	9	Accessibilité et sécurité de la salle de bain	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
108	9	Sèche-serviette	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
109	9	Collectivité	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
110	10	Terrasse bois -  carrelage -  sol extérieur	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
111	10	Décoration du jardin	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
112	10	Murs extérieurs	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
113	10	Clôtures	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
114	10	Portails	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
115	10	Produits de mise en oeuvre extérieur	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
116	11	Portes d'intérieur -  bloc-portes	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
117	11	Portes d'entrée et de service	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
118	11	Fenêtres et portes-fenêtres sur mesure	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
119	11	Huisseries	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
120	11	Portes coulissantes -  systèmes coulissants	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
121	11	Placards -  dressing	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
122	11	Escaliers et échelles	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
123	11	Portails	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
124	11	Portes de garage	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
125	11	Verrières d'atelier	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
126	11	Grilles -  stores -  marquises	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
127	11	Serrurerie -  fermeture	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
128	11	Fenêtres de toit - Velux et et autres marques	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
129	12	Panneau et dalle bois brut	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
130	12	Panneau décoratif -  menuiserie et agencement	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
131	12	Bois de construction	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
132	12	Bois de menuiserie	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
133	13	Outillage électroportatif	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
134	13	Consommable électroportatif	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
135	13	Outillage à main	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
136	13	Outillage spécialisé	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
137	14	Bétonnières & accessoires	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
138	14	Brouettes	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
139	14	Diables -  transpalettes	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
140	14	Compresseurs & accessoires	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
141	14	Vibration -  décapage & compactage béton	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
142	14	Découpeuses béton	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
143	14	Chauffage & traitement de l'air	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
144	14	Protection de chantier	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
145	14	Aménagement et équipement d'atelier	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
146	14	Accès -  travail en hauteur	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
147	14	Alimentation et éclairage de chantier	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
148	14	Nettoyage de chantier	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
149	14	Sableuse -  aérogommeuse	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
150	14	Téléphones -  tablettes de chantier & accessoires	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
151	14	Abris de chantier -  remorques	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
152	15	Casque de chantier -  bonnet	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
153	15	Bouchon d'oreille -  casque antibruit	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
154	15	Lunettes de protection	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
155	15	Masque de protection	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
156	15	Gants de protection	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
157	15	Vêtements & pantalon de travail	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
158	15	Vêtements haute visibilité	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
159	15	Chaussures de sécurité -  chaussettes	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
160	15	Harnais & kit antichute	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
161	15	Hygiène	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
162	15	Soins -  sécurité	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
163	16	Visserie -  fixation	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
164	16	Serrurerie -  fermeture	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
165	16	Connecteur charpente	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
166	16	Boîte aux lettres -  colis	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
167	17	Peinture	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
168	17	Mastics -  colles -  mousses	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
169	17	Droguerie et entretien	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
170	18	Radiateur électrique	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
171	18	Eclairage	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
172	18	Matériel électrique	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
173	18	Gaines et câbles électriques	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
174	18	Appareillage électrique	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
175	18	Outils électricien -  multimètre	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
176	18	Domotique -  connectique	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
177	18	Ventilation	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
178	19	Raccords laiton	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
179	19	Tubes et raccords PER	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
180	19	Tubes et raccords multicouches	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
181	19	Tubes et raccords cuivre	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
182	19	Tubes et raccords PE	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
183	19	Tubes et raccords PVC Evacuation d'eau	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
184	19	Accessoires plomberie	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
185	19	Plomberie sanitaires	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
186	19	Accessoires chauffe-eaux	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
187	19	Raccordement gaz	active	\N	2025-03-31 13:50:00+02	2025-03-31 13:50:00+02
1	\N	Matériaux de construction	active		2025-03-24 16:52:03+01	2025-12-03 16:32:13.660677+01
\.


--
-- TOC entry 4195 (class 0 OID 21742)
-- Dependencies: 308
-- Data for Name: project_workpackage; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_workpackage (workpackage_id, workpackage_parent_id, project_id, workpackage_name, workpackage_summary, workpackage_todo, workpackage_type, workpackage_cost_estimated, workpackage_cost_actual, workpackage_nb_participants, workpackage_status, workpackage_date_start_scheduled, workpackage_date_start_actual, workpackage_rank, workpackage_mode, workpackage_date_end_scheduled, workpackage_date_end_actual, workpackage_duration_scheduled, workpackage_completion_percentage, workpackage_duration_actual, updated_at, created_at) FROM stdin;
22	\N	19	wkp005			plumbing	\N	983.00	\N	active	2025-04-25	\N	\N	diy	2025-07-01	\N	67	\N	\N	2025-12-13 12:17:17.975793+01	2025-04-20 18:51:33.858695+02
21	\N	20	001_SerreGeode			woodwork	\N	550.00	\N	active	2021-12-30	2021-12-17	\N	diy	2022-02-28	\N	60	\N	45	2025-11-18 13:44:05.156831+01	2025-04-18 18:11:01.140411+02
26	\N	20	test wkp2			plumbing	\N	\N	\N	active	2023-03-19	\N	\N	diy	2023-03-26	\N	7	\N	\N	2025-11-18 13:44:05.156831+01	2025-11-13 17:00:53.882933+01
23	\N	19	wkp002			woodwork	\N	\N	\N	active	2025-04-16	\N	\N	work_pro	2025-07-05	\N	80	\N	\N	2025-12-13 12:16:09.868894+01	2025-04-24 18:06:01.997339+02
\.


--
-- TOC entry 4219 (class 0 OID 22321)
-- Dependencies: 332
-- Data for Name: project_workpackage_expenses; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_workpackage_expenses (expense_id, workpackage_id, provider_id, expense_category, expense_name, expense_summary, expense_unit, expense_value, expense_quantity, expense_invoice_url, expense_invoice_date, expense_invoice_ref, expense_status, expense_tax_rate, expense_saving, expense_material_origin, created_at, updated_at) FROM stdin;
10	22	\N	contracts	xw			100.00	\N	\N	2025-03-05	\N	active	\N	\N	\N	2025-04-23 18:07:48.912175+02	2025-04-24 10:05:16.324717+02
9	22	\N	materials	xw			100.00	\N	\N	2025-07-24	\N	active	\N	\N	\N	2025-04-23 18:07:26.160726+02	2025-04-24 10:05:27.884269+02
12	22	\N	tools	xw			250.00	\N	\N	2025-05-15	\N	active	\N	\N	\N	2025-04-24 10:29:30.55154+02	2025-04-24 10:29:52.296644+02
13	21	7	materials	test		m3	100.00	5	\N	2025-06-20	\N	active	\N	\N	\N	2025-06-13 09:39:17.848383+02	2025-06-13 09:40:31.525222+02
14	21	\N	contracts	test2		N	450.00	\N	\N	2025-06-26	\N	active	\N	\N	\N	2025-06-13 09:40:58.157828+02	2025-06-13 09:40:58.157828+02
15	22	\N	materials	dsds	dsds\r\n		199.00	\N	/x_docs/2025-12-02_16h10m10s_67H5U8JB.pdf	2025-12-08	\N	active	\N	\N	\N	2025-12-02 17:10:10.311296+01	2025-12-02 17:10:10.311296+01
16	22	\N	materials	xwxw	xwxw\r\n		34.00	\N	\N	2026-01-01	\N	active	\N	\N	\N	2025-12-02 17:47:45.235042+01	2025-12-02 17:47:45.235042+01
11	22	\N	materials	NN			800.00	\N	\N	2025-05-07	\N	archived	\N	\N	\N	2025-04-23 18:08:21.258926+02	2025-12-02 18:30:40.66367+01
\.


--
-- TOC entry 4199 (class 0 OID 21774)
-- Dependencies: 312
-- Data for Name: project_workpackage_materials; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_workpackage_materials (material_id, product_id, workpackage_id, material_summary, material_unit, material_quantity, material_status, material_volume1, material_volume2, material_area, material_length, material_heigth, material_width, material_weigth, material_thickness, material_equiv_fonctional_units, material_carbon_footprint, updated_at, created_at) FROM stdin;
2	4	22		m2	150	active	\N	\N	\N	\N	\N	\N	\N	\N	150	2070	2025-04-24 13:30:08.99742+02	2025-04-24 12:25:10.487602+02
3	4	21		ml	5	active	\N	\N	\N	\N	\N	\N	\N	\N	6	82.80000000000001	2025-06-13 11:55:59.744765+02	2025-06-13 11:53:18.727275+02
4	4	21			\N	active	\N	\N	\N	\N	\N	\N	\N	\N	9	124.2	2025-06-13 11:56:51.677985+02	2025-06-13 11:54:15.904089+02
\.


--
-- TOC entry 4201 (class 0 OID 21811)
-- Dependencies: 314
-- Data for Name: project_workpackage_participants; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_workpackage_participants (workpackage_participant_id, workpackage_id, prm1_id, prm2_sub_id, employee_id, prm3_id, workpackage_participant_role, workpackage_participant_type, workpackage_participant_status, created_at, updated_at) FROM stdin;
5	\N	\N	\N	8	\N		employee	active	2025-04-23 14:14:00.364854+02	2025-04-23 14:14:00.364854+02
10	21	\N	7	\N	\N	funder	corporate	active	2025-06-13 12:08:33.969692+02	2025-06-13 12:08:33.969692+02
11	21	\N	5	10	\N	participant	employee	active	2025-06-13 12:09:02.0745+02	2025-06-13 12:09:02.0745+02
12	21	\N	\N	\N	4	builder	group	active	2025-06-13 12:09:44.456089+02	2025-06-13 12:09:44.456089+02
9	21	9	\N	\N	\N	participant	person	active	2025-06-13 12:08:11.265626+02	2025-06-13 12:10:04.035257+02
14	22	\N	6	\N	\N		corporate	active	2025-12-02 19:22:25.389843+01	2025-12-02 19:22:25.389843+01
15	22	\N	\N	\N	3		group	active	2025-12-02 19:22:34.086905+01	2025-12-02 19:22:34.086905+01
\.


--
-- TOC entry 4197 (class 0 OID 21758)
-- Dependencies: 310
-- Data for Name: project_workpackage_waste; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_workpackage_waste (waste_id, workpackage_id, recipiend_id, waste_name, waste_summary, waste_ienes_url, waste_category_id, waste_value, waste_destination, waste_functional_unit, waste_unit, waste_quantity, waste_status, updated_at, created_at) FROM stdin;
4	21	\N	test			50	150	reused		kg	4	active	2025-06-13 12:02:06.320645+02	2025-06-13 12:00:59.321012+02
3	22	\N	dsds			50	500	reused			\N	active	2025-12-02 18:54:01.945515+01	2025-04-24 14:53:23.09489+02
\.


--
-- TOC entry 4209 (class 0 OID 22064)
-- Dependencies: 322
-- Data for Name: project_worksequence; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_worksequence (worksequence_id, workpackage_id, room_id, worksequence_name, worksequence_summary, worksequence_todo, worksequence_type, worksequence_nb_participants, worksequence_start_date_scheduled, worksequence_start_date_actual, worksequence_start_hour_scheduled, worksequence_start_hour_actual, worksequence_end_hour_scheduled, worksequence_end_hour_actual, worksequence_duration_scheduled, worksequence_duration_actual, worksequence_completion_percentage, worksequence_status, created_at, updated_at) FROM stdin;
4	21	\N	Carrelage sol serre			prod	6	2021-12-25	2021-12-25	14:00:00	14:00:00	17:00:00	17:30:00	03:00:00	03:30:00	100	active	2025-04-24 18:07:04.00917+02	2025-06-21 14:44:08.212391+02
8	21	\N	Montage structure géode			training	0	2022-01-06	2022-01-06	14:00:00	14:00:00	17:00:00	17:00:00	03:00:00	03:00:00	50	active	2025-06-13 12:43:34.96199+02	2025-06-21 14:45:57.49757+02
9	21	\N	Montage structure géode 2			training	0	2022-01-11	\N	14:00:00	\N	17:00:00	\N	03:00:00	\N	\N	active	2025-06-21 14:47:35.386716+02	2025-06-21 14:47:35.386716+02
10	21	\N	Mise en place de la porte			prod	0	2022-01-20	\N	14:00:00	\N	17:00:00	\N	03:00:00	\N	\N	active	2025-06-21 14:49:10.410946+02	2025-06-21 14:49:10.410946+02
2	22	4	seq001			prod	3	2025-05-01	\N	00:00:00	00:00:00	02:00:00	06:00:00	\N	\N	100	active	2025-04-21 09:52:47.134968+02	2025-12-02 19:33:51.171289+01
3	22	4	seq002			training	1	2025-04-26	\N	08:00:00	09:30:00	10:00:00	12:45:00	02:00:00	03:30:00	\N	active	2025-04-24 17:42:37.18938+02	2025-04-27 11:21:08.11082+02
7	23	\N	wks003			postprod	1	2025-04-24	\N	07:00:00	\N	15:00:00	\N	07:00:00	\N	\N	active	2025-04-26 18:05:13.067732+02	2025-04-27 11:21:25.421973+02
\.


--
-- TOC entry 4211 (class 0 OID 22206)
-- Dependencies: 324
-- Data for Name: project_worksequence_participants; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.project_worksequence_participants (worksequence_participant_id, worksequence_id, prm1_id, prm2_sub_id, employee_id, prm3_id, worksequence_participant_role, worksequence_participant_type, worksequence_participant_status, created_at, updated_at) FROM stdin;
6	3	9	\N	\N	\N		person	active	2025-04-24 17:56:34.871831+02	2025-04-24 17:56:34.871831+02
8	4	9	\N	\N	\N		person	active	2025-04-25 18:17:31.896034+02	2025-04-25 18:17:31.896034+02
11	7	\N	\N	\N	3	coach	group	active	2025-04-26 18:05:29.618659+02	2025-04-26 18:05:29.618659+02
7	4	\N	5	\N	\N		corporate	active	2025-04-24 18:07:16.158572+02	2025-06-13 12:50:44.854492+02
16	4	11	\N	\N	\N	coach	person	active	2025-06-13 12:50:54.252653+02	2025-06-13 12:50:54.252653+02
17	4	\N	6	\N	\N	technical_advisor	corporate	active	2025-06-13 12:51:02.202634+02	2025-06-13 12:51:02.202634+02
18	4	\N	5	10	\N	technical_advisor	employee	active	2025-06-13 12:53:03.29224+02	2025-06-13 12:53:03.29224+02
19	4	\N	\N	\N	4	coach	group	active	2025-06-13 12:54:03.685966+02	2025-06-13 12:54:03.685966+02
14	2	\N	5	9	\N		employee	active	2025-04-27 12:27:43.519567+02	2025-12-02 19:33:43.709229+01
4	2	\N	\N	\N	3		group	archived	2025-04-23 14:27:18.066601+02	2025-12-02 19:33:58.720237+01
\.


--
-- TOC entry 4155 (class 0 OID 21392)
-- Dependencies: 268
-- Data for Name: regex; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.regex (regex_id, regex_name, regex_value, regex_description, regex_comment, regex_status, created_at, updated_at) FROM stdin;
1	email	^[a-zA-Z0-9\\.]+@[a-zA-Z0-9]+\\.[a-zA-Z0-9]{2,4}$	'xxxxx@xxxx.xx ou yyyy.xxx@dxxxx.yy'		active	2025-02-17 12:58:07+01	2025-02-17 13:40:26+01
2	phone	^(?:(?:\\+|00)33|0)\\s*[1-9] (?:[\\s.-]*\\d{2}){4}$	'format +33 6 00 00 00 00'		active	2025-02-17 13:33:09+01	2025-02-17 13:33:09+01
3	password	^(?=.{8,}$)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\\W).*$	  Le mot de passe doit contenir au moins 8 caractères, une majuscule, un chiffre, un cractère spécial : #?!@$%^&*-		active	2025-02-17 13:40:16+01	2025-02-17 14:01:26+01
5	hour	^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$	hh:mm (ex : 12:30)		active	2025-02-17 16:25:58+01	2025-02-17 16:25:58+01
4	date	^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$	format : DD-MM-YYYY		active	2025-02-17 16:24:11+01	2025-04-16 14:18:37.528585+02
6	year	^(19|20)\\d{2}$	format : YYYY entre 1900 et 2099		active	2025-02-17 16:49:51+01	2025-04-19 17:42:28.543947+02
7	latitude	^-?([0-8]?[0-9]|90)(\\.[0-9]{1,10})$	ex :56.3847    (max 6 décimales)		active	2025-02-18 10:49:47+01	2025-02-18 10:49:47+01
8	longitude	^(\\+|-)?(?:180(?:(?:\\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\\.[0-9]{1,6})?))$	ex : -1.171809 (max 6 décimales)	=> 9 digits	active	2025-02-18 10:59:49+01	2025-02-18 11:15:56+01
\.


--
-- TOC entry 4119 (class 0 OID 21123)
-- Dependencies: 232
-- Data for Name: rss; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.rss (rss_id, rss_title, rss_feed, rss_link, rss_description, rss_status, rss_category, rss_item_title, rss_item_link, rss_item_description, rss_item_table, created_at, updated_at) FROM stdin;
2	FAQ	http://localhost:8080/a_rss_feed/rss_faq_4.sql	  http://localhost:8080/b_faq/faq_main_display_4.sql	Nouvelles questions reçues	active	supervisor	USERS	http://localhost:8080/b_faq/faq_main_display_4.sql	Nouvelles questions reçues	faq_questions	2024-12-20 14:28:46+01	2025-01-22 18:44:37+01
3	Agenda	http://localhost:8080/a_rss_feed/rss_agenda.sql	http://localhost:8080/b_events/event_main_list.sql	Prochain événement :	active	public	agenda	http://localhost:8080/b_events/event_main_list.sql	Prochain événement :	\N	2024-12-21 13:31:52+01	2024-12-21 13:59:49+01
4	BUG REPORT	http://localhost:8080/a_rss_feed/rss_bugreport_5.sql	http://localhost:8080/c_debug/debug_main_display_5.sql		active	admin	topic_name	http://localhost:8080/c_debug/debug_main_display_5.sql	topic_category	forum_topics	2024-12-29 15:39:42+01	2025-01-22 18:37:06+01
5	NEWS private	http://localhost:8080/a_rss_feed/rss_news_1.sql	http://localhost:8080/b_news/news_private_display_1.sql		active	editor	Actus internes	http://localhost:8080/b_news/news_private_display_1.sql	actus internes	news	2025-01-03 10:37:56+01	2025-01-22 18:45:42+01
6	NEWS public	http://localhost:8080/a_rss_feed/rss_news.sql	http://localhost:8080/b_news/news_public_display.sql	Toutes les nouvelles du site CO-OP	active	public	Actus	http://localhost:8080/b_news/news_public_display.sql	Toutes les nouvelles du site CO-OP	news	2025-01-03 14:06:48+01	2025-01-22 18:45:59+01
7	FORUM	http://localhost:8080/a_rss_feed/rss_forum_5.sql	http://localhost:8080/c_forum/forum_main_display_5.sql	Nouvelles discussions sur le forum 	active	admin	topic_name 	http://localhost:8080/c_forum/forum_main_display_5.sql	Nouvelles discussions sur le forum 	forum_topics	2025-01-22 18:35:21+01	2025-01-22 18:36:45+01
1	USERS new	http://localhost:8080/a_rss_feed/rss_new_users_5.sql	http://localhost:8080/a_users/users_new_display_5.sql	USERS : notification nouveau compte	active	admin	USERS	http://localhost:8080/a_users/users_new_display_5.sql	USERS : notification nouveau compte	users	2024-12-20 14:28:40+01	2025-04-16 13:46:52.90539+02
\.


--
-- TOC entry 4203 (class 0 OID 21892)
-- Dependencies: 316
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.sessions (session_id, username, user_id, session_token, created_at, logout_at, session_duration) FROM stdin;
2	supervisor1	19	qgm6CWRCXgo2nT3ODnKG1QsNruBeFNA8	2025-04-08 07:17:56+02	2025-04-08 07:17:56+02	\N
4	admin	17	jw8KKh0AOup8zEjMdaVYMOuSMALL8baR	2025-01-07 12:35:39+01	\N	45
5	editor	3	vntm8rFTw1P4wq6gzCNICOQF4gctLBl3	2025-01-07 17:07:53+01	\N	45
6	editor	3	fWDVLXljfmcQV3AuNe6uferNjg77VAKJ	2025-01-08 13:58:12+01	\N	67
7	editor	3	Tu6cCnAFuKjaXc9B3u8VmRDFQMafzumd	2025-01-09 13:48:24+01	\N	67
8	editor	3	4sXNeof4kOuLT607ERmM610c644qstds	2025-01-09 18:28:12+01	\N	67
9	editor	3	ME8qm7OgDORCdtDXn3yljXzZY18wwh2z	2025-01-10 08:40:56+01	\N	68
10	admin	17	TYMwlacAPy1NKxAO0rLPeGpDdf2WzOin	2025-01-10 14:17:27+01	\N	45
11	admin	17	RDWkRb9xZmbSaeTyH9DvdODNjbYRI57W	2025-01-10 14:18:22+01	\N	45
12	admin	17	fjAS9eTvAk9xphZgRkfBceiiZ2xPJsa1	2025-01-10 14:21:32+01	\N	45
13	editor3	21	tDwDQlWUUvxTmZXKhBj0JBIKigORY9Mu	2025-01-10 14:26:53+01	\N	45
14	admin	17	jdVETi0A53eEchoPMqBl9LWga8Wh4CVf	2025-01-10 14:39:39+01	\N	45
15	admin	17	FEw1Lj0PhQmgaIRZ1UurJrf60RhInYGg	2025-01-10 14:44:24+01	\N	45
16	supervisor	19	oh1TZkCL7EAcYIPsXzrVkzvHX7n6qe71	2025-01-10 14:44:39+01	\N	564
17	supervisor	19	ixTfFDWZBVYQ5vq7gFRgz7UYtf8w7vnq	2024-06-10 14:45:34+02	\N	90
18	editor	3	UiSrvKF4u4ZyDcRPtmuaLSJicFZUOmpr	2025-01-10 14:45:49+01	\N	67
19	editor	3	H3pOicaSjuKIJJaNKBBXkoqyKiSwEecH	2025-01-10 14:46:03+01	\N	67
20	editor	3	t6AOiAujEVYBZmWmKC3ipW0tHbTtKq6J	2025-01-10 14:46:50+01	\N	67
21	editor3	21	9uuhzo8vRZy6pcCSDBQSl2sxH3f843H6	2025-01-10 14:47:03+01	\N	12
22	editor3	21	OpzCGMJz38wxRF5TXDoJkSteimp98ucT	2025-01-10 14:47:41+01	\N	12
24	admin	17	12IYUeSICVlU5JEo9Bk75SaTvXuKGx3O	2025-01-11 09:18:19+01	2025-01-11 09:19:08+01	45
25	admin	17	A2o1DCYTVXOWxWOKNbxmVUB5CBFWjacj	2025-01-11 09:47:56+01	2025-01-11 10:08:03+01	90
26	admin	17	x5VECt9GO0seB0NMbZqwJC5CQBFsbEZn	2025-01-11 10:08:33+01	2025-01-11 10:08:39+01	87
27	admin	17	o2nfdlcEVBvIPRGT5BPxmszGoQOQKJ6I	2025-01-11 10:09:21+01	2025-01-11 10:09:24+01	56
28	admin	17	6eXnsIv30kGNleHrRcam61n1v4E56HUk	2025-01-11 10:09:40+01	2025-01-11 10:11:07+01	32
29	admin	17	umlFogAZFmdwRwYN0avodjgZY0FRaqN1	2025-01-11 10:12:11+01	2025-01-11 10:12:14+01	45
30	admin	17	w3t86QjjdUTZMirNGUvknlrBf7lQ677U	2025-01-11 10:16:39+01	2025-01-11 10:16:42+01	3
31	admin	17	DhK5PvEMjPgoHGZwPSZFfasrf76qTaHS	2025-01-11 10:18:13+01	2025-01-11 10:19:13+01	60
32	admin	17	xiDvtWrjdQOG4sMrwqi0dgx1wbNlCwoi	2025-01-11 10:19:44+01	2025-01-11 10:19:44+01	\N
33	admin	17	P09Uz4cG7GwLj4WddAkUAjSuBKEB7kYS	2025-01-11 12:42:38+01	2025-01-11 12:42:38+01	\N
34	admin	17	v1FmSebMrxy54L1smIlHz6v6WguC3JDu	2025-01-11 12:49:56+01	2025-01-11 12:49:56+01	\N
35	admin	17	wHBwqimTmB5EDEAwLU6Enew3l5m2TUHw	2025-01-11 15:05:44+01	2025-01-11 15:05:44+01	\N
36	editor3	21	ZmRe4UulVxV3B0f5YNzlnEVIWRMMbgql	2025-01-12 10:39:03+01	2025-01-12 10:39:03+01	\N
37	editor3	21	7CZB2akpvg2yBvPfpgQYoy4O4IbWqGtG	2025-01-13 17:44:51+01	2025-01-13 17:44:51+01	\N
38	editor3	21	H55KiOFcm3Olga2ZzfL8pGK0jEYi76o5	2025-01-13 18:35:00+01	2025-01-13 18:35:00+01	\N
39	editor3	21	bgqSzHdqt7SJVDGDsh5AV5aM64rTSc3j	2025-01-14 09:06:40+01	2025-01-14 09:06:40+01	\N
40	editor3	21	JBiuPuqbKvBk9wWNAlReqe8n3o8hsFVy	2025-01-14 14:24:35+01	2025-01-14 14:24:35+01	\N
41	editor3	21	LYSqMUZgutH8CjmGZdjceBinnChyiwd5	2025-01-15 14:12:36+01	2025-01-15 16:45:06+01	9150
42	supervisor	19	FVxD74khLhK0Nw1z0vJk2s3NnhL7DyB8	2025-01-15 16:45:15+01	2025-01-15 16:45:43+01	28
43	editor	3	4MnKZ1sNdudIrUv2Se9DlZowjNwDObjm	2025-01-15 16:45:52+01	2025-01-15 16:47:44+01	112
44	editor3	21	BshHQObKrKvE5bHpeh8itTLe0TFMpKxh	2025-01-15 16:48:02+01	2025-01-15 16:48:02+01	\N
45	editor3	21	EYn8pZ6bQryIkPAautdKSovsiAo5wT2z	2025-01-16 09:12:45+01	2025-01-16 09:12:45+01	\N
46	editor3	21	B9zozwNwzQUvKVJRjUnBUYDjdvveei7H	2025-01-16 13:39:13+01	2025-01-16 15:18:10+01	5937
47	editor3	21	s4q4oRtIdSyYXiGX69Bf0VJljfojDHv2	2025-01-16 15:24:09+01	2025-01-16 16:31:58+01	4069
48	supervisor	19	4HVh65sDgvbzAxhHoxVN1Y7lr4bj717A	2025-01-16 16:32:04+01	2025-01-16 16:57:28+01	1524
49	supervisor	19	NKWuGlJsFGZRKGZrPNHqWGZ6Q3CYl6pD	2025-01-16 16:57:34+01	2025-01-16 16:57:34+01	\N
50	supervisor	19	xYPVNVhq9kcJTmupfgfjikkUJcKalYs4	2025-01-17 09:12:39+01	2025-01-17 09:12:39+01	\N
51	supervisor	19	rOmu5EYSpi0D6MfwGm2GG4uaykkUUn1E	2025-01-17 09:19:47+01	2025-01-17 09:19:47+01	\N
52	supervisor	19	jR57fJ44tR06Utuppyhx9RsgmdiytydG	2025-01-17 15:51:23+01	2025-01-17 15:51:23+01	\N
53	supervisor	19	rGEV9Ke5zH90cfnVPJVAFrT9uvvzdQRJ	2025-01-18 09:24:18+01	2025-01-18 09:24:18+01	\N
54	supervisor	19	fWyx9uX1usmlp79bPewIUjDNiTuXjG03	2025-01-18 17:12:22+01	2025-01-18 17:12:22+01	\N
55	supervisor	19	GH4PtiLMQELnCbbwQ8qS0ZBHpqmW4JK2	2025-01-19 08:37:30+01	2025-01-19 08:51:15+01	825
56	admin	17	WbfVIvNF8LI9IR9aihGZRT65PKwJiWmn	2025-01-19 08:51:22+01	2025-01-19 11:32:06+01	9644
57	editor3	21	136WgIqZrYGjOkJfaVndcm25rRoCeIrr	2025-01-19 11:32:15+01	2025-01-19 11:35:17+01	182
58	admin	17	6tkRqXjBxJcaSrXwaNoY0u6qAHVSlkLp	2025-01-19 11:35:23+01	2025-01-19 11:36:08+01	45
59	editor3	21	DzsRNHAyjB1BUOdhfYLxH0qVbUIKXJYe	2025-01-19 11:36:14+01	2025-01-19 11:37:14+01	60
60	editor	3	yDTX9fLGOK7WV38egRjxF5CJAUvCJK9r	2025-01-19 11:37:21+01	2025-01-19 11:37:21+01	\N
61	supervisor	19	goEGLAnnJM93q1DNDVm4FTLj3oCDybR6	2025-01-20 10:24:25+01	2025-01-20 10:24:25+01	\N
62	editor3	21	ztonJgBTi9qXSl9lAlGNLQOnQZMS3JLO	2025-01-20 15:51:28+01	2025-01-20 15:57:15+01	347
63	editor	3	qi9h2j4rEbOYH4cZzWiathKMTetAtiav	2025-01-20 15:57:22+01	2025-01-20 16:27:48+01	1826
64	supervisor	19	yXfEQApb5IdgCinJahCxUthy38QscVWD	2025-01-20 16:27:54+01	2025-01-20 16:48:54+01	1260
65	editor3	21	sDdZ2uGh8bQN1vi2jCaHJKKtTL77aNXU	2025-01-20 16:48:59+01	2025-01-20 16:54:57+01	358
66	viewer	5	EjCNhCkDcxZZ0PylEweCA0SoN75n3jK8	2025-01-20 16:55:06+01	2025-01-20 16:56:49+01	103
67	editor3	21	Pnbx8Wy3yKwGFD0g0iZSfu8v3wKQrYwe	2025-01-20 16:56:56+01	2025-01-20 17:02:10+01	314
68	editor3	21	xPuTJMpZzLD2GMV20lg91WPdAb85DAZm	2025-01-20 17:02:16+01	2025-01-20 17:02:16+01	\N
69	supervisor	19	AOPqL5OYtGv39vjhyxL7jfIo8rQL2Vec	2025-01-21 08:32:25+01	2025-01-21 13:14:19+01	16914
70	admin	17	LKNOoKeaUW87JChupiuzuqxDu7zyMEPc	2025-01-21 13:14:25+01	2025-01-21 14:22:49+01	4104
71	supervisor	19	zEbyuTUoPZbNamj0kr4SQ5SG3jk0O4Dz	2025-01-21 14:22:56+01	2025-01-21 14:22:56+01	\N
72	supervisor	19	QBOpwxEFjvUQDdh6sFYzlNVj9q40kfSb	2025-01-21 16:01:44+01	2025-01-21 16:01:44+01	\N
73	admin	17	KwGGqEEONJGmLp1ETiuHHv0An4keXtzL	2025-01-22 11:22:01+01	2025-01-22 11:25:26+01	205
74	supervisor	19	vR9wl30I3YFn0vsZwNK2p98sKaoDLlj9	2025-01-22 11:25:32+01	2025-01-22 11:33:31+01	479
75	supervisor	19	IUb0nZ0h3CxFhdXlfMpgNQQFGAFBEjn5	2025-01-22 11:35:07+01	2025-01-22 11:35:43+01	36
76	admin	17	kPRuBSQ1zSUo1DTzfhjim5x7k8fUglT1	2025-01-22 11:35:50+01	2025-01-22 11:36:26+01	36
77	editor3	21	kXZeFvavSvqkDFcUpo1k6z5IE7cSETs8	2025-01-22 11:36:44+01	2025-01-22 11:36:44+01	\N
78	editor3	21	VHdTR3UrzL1LS5RZV7gz3l7H71jUudpi	2025-01-22 11:36:55+01	2025-01-22 11:37:26+01	31
314	supervisor1	19	mAMHV8A2zpNFynipIJKecDNZkwkcbUFL	2025-04-02 07:01:38+02	2025-04-02 07:01:38+02	\N
1	admin1	17	kmOMpYEHQtnG6rVa566SS2KTWEQwSNOG	2025-04-16 11:43:07.552097+02	2025-04-16 11:51:28.293159+02	501
79	editor	3	nLoXCMoHTguH2QmPeNBeOtwahAIj2DLJ	2025-01-22 11:37:45+01	2025-01-22 11:38:14+01	29
80	viewer	5	uQNFav6BRTwEghY9ZKVQwEpI4dVj3jud	2025-01-22 11:38:26+01	2025-01-22 12:54:49+01	4583
81	admin	17	rEahQtcwsnObUf8dzWGDuQ6mgC5IILl6	2025-01-22 12:55:11+01	2025-01-22 13:00:00+01	289
82	admin	17	MplsDkfuJwN9JCJuQlEyZkZSkOe6cBqg	2025-01-22 13:07:46+01	2025-01-22 13:15:15+01	449
83	admin	17	VguEu59VVtSQvrzV1Iy1R7Zl8Kd0ERjt	2025-01-22 13:18:54+01	2025-01-22 13:19:14+01	20
84	admin	17	bRXaHCJNL8fQ5lzw3bo8MfHvzq5pRDjq	2025-01-22 13:26:33+01	2025-01-22 15:04:34+01	5881
85	admin	17	6STxuF8DFfhZaXpltPXHFxxgLBWzpqJ3	2025-01-22 17:55:28+01	2025-01-22 18:41:35+01	2767
86	supervisor	19	lWZaBt4y9Vo6JJ1udjrgfw6R7WSUXR05	2025-01-22 18:41:43+01	2025-01-22 18:42:46+01	63
87	admin	17	Bv7IwJ9muzBAsRrq9LIi0kMlu5MeJVYx	2025-01-22 18:42:52+01	2025-01-22 18:42:52+01	\N
88	supervisor	19	OqnbOZdaj06LrVLBUX0gT2zsnBAsnJD9	2025-01-23 10:14:22+01	2025-01-23 10:15:39+01	77
89	supervisor1	19	qqfnzEdyz7OfuCdHJNnPg0fh31o3jEqn	2025-01-23 10:16:28+01	2025-01-23 10:17:09+01	41
90	supervisor1	19	qjoXYJExaJLjfMCgVRmwVwyBOHoUrWhS	2025-01-23 10:17:16+01	2025-01-23 10:17:21+01	5
91	admin	17	GL0831zJS5oUpujPxzYlYDpfyn7bqECh	2025-01-23 10:17:29+01	2025-01-23 10:19:11+01	102
92	supervisor1	19	XHiKHigaNprVa8GMirxbV8jQEWCl7Suy	2025-01-23 10:30:32+01	2025-01-23 10:31:08+01	36
93	admin1	17	OilePQqeNvDVN6sBSgx7qrLbLAT5a9bL	2025-01-23 10:31:27+01	2025-01-23 10:31:32+01	5
94	admin2	26	jCBzLdhvWzNXVzYJyeOYMTM8KbMKEvnd	2025-01-23 10:31:42+01	2025-01-23 10:31:42+01	\N
95	admin2	26	KjsKdlliAWao0iO1v6K7eKhKMGV2utMR	2025-01-23 10:32:02+01	2025-01-23 10:32:02+01	\N
96	admin3	27	DdHowsWFw4agOc7cMMN12zyhbYMUdNCY	2025-01-23 10:37:54+01	2025-01-23 10:37:54+01	\N
97	admin3	27	vb5hrrUBf1Iady2UnaSSrE9oUcXlqgtB	2025-01-23 10:38:21+01	2025-01-23 10:38:21+01	\N
98	admin3	27	1fJloV3fDhH5x59RJSGuIbVi4tulMkpr	2025-01-23 10:38:38+01	2025-01-23 10:38:38+01	\N
99	admin3	27	WifrSR6spGIMwpGoTJMcZG93i7H1b3pO	2025-01-23 10:39:00+01	2025-01-23 10:39:00+01	\N
100	admin3	27	SLpK4q042z7sCOSXjPWqx2kfYp0Gha4Y	2025-01-23 10:40:33+01	2025-01-23 10:40:33+01	\N
101	admin3	27	L5Elc0JfcsF9FGdoleQ9wkoud9lpDx6L	2025-01-23 10:40:56+01	2025-01-23 10:40:56+01	\N
102	admin3	27	LTmoMxycGRo31xJC1QL0sCBgeGIzy3pe	2025-01-23 10:41:16+01	2025-01-23 10:41:16+01	\N
103	admin3	27	F9TtLv0GrcoH6fmHfuR5jknKolgA5Hdw	2025-01-23 10:42:05+01	2025-01-23 10:42:05+01	\N
104	admin3	27	Ys9ivgq8PKIzOZbV97NWR6INSOYoGpF8	2025-01-23 10:42:56+01	2025-01-23 10:42:56+01	\N
105	admin3	27	Sl5PtO7t8ZtmC7zwJ292yecf6X3oE8g5	2025-01-23 10:43:39+01	2025-01-23 10:43:39+01	\N
106	admin3	27	TKm2Tg4NAFsiDRKLAzWQMAY361qxgSOE	2025-01-23 10:44:13+01	2025-01-23 10:44:13+01	\N
107	admin3	27	i0x8sDXtrBEF0H0Gjx6KHHUMbUxmFHGs	2025-01-23 10:44:43+01	2025-01-23 10:44:43+01	\N
108	admin2	26	rtUzNYgqvl9GoUGkruZEv7FKjQIb7bEL	2025-01-23 10:45:47+01	2025-01-23 10:45:47+01	\N
109	viewer1	5	lsesm7Gh0Xbqv0PyQjq2KKVPL6kZ2rvZ	2025-01-23 10:46:59+01	2025-01-23 10:51:11+01	252
110	editor	3	aQNKSxrOMZJlJbzUoO6F18fRmWCE0td3	2025-01-23 10:52:06+01	2025-01-23 11:06:30+01	864
111	admin1	17	bxrYUUtq6wdQnP5CR0C30DAQxwFR8XRP	2025-01-23 11:06:36+01	2025-01-23 11:06:36+01	\N
112	supervisor1	19	3M8rK2gekjuy3wdlclBvdGP0NBy0ZCGA	2025-01-23 16:36:22+01	2025-01-23 16:36:22+01	\N
113	admin1	17	qWh7kJphVK2L9Ja4XCDcK8zTYeK2kxz0	2025-01-24 08:50:11+01	2025-01-24 08:50:11+01	\N
114	supervisor1	19	ENOOr5jw5oeGBnxLx2jSic3wj84Ti0SL	2025-01-28 09:00:37+01	2025-01-28 13:51:06+01	17429
115	supervisor1	19	Ke0bhxBWoU41Vq5oyKL93AtsuyYvMjUf	2025-01-28 13:51:13+01	2025-01-28 13:51:13+01	\N
116	supervisor1	19	qqNGdf43sqL7wW7skKOOtoRtHmJTsOr3	2025-01-28 17:33:11+01	2025-01-28 17:33:11+01	\N
117	supervisor1	19	lAswGzcNgxyFmpf51Sfp7a1AzpDmI6OC	2025-01-29 11:16:46+01	2025-01-29 17:05:01+01	20895
118	editor1	3	duAL35COz6pk8XQt008F3Pc3MALm53Rd	2025-01-29 17:05:59+01	2025-01-29 17:05:59+01	\N
119	editor1	3	JNQrrcmvtkxIHNZjUFOgZOV763nMRFmf	2025-01-30 09:37:22+01	2025-01-30 09:37:22+01	\N
120	editor1	3	7VpSHCnnkXUaszWNDueXVwZPTZ2QH2DX	2025-01-30 13:36:15+01	2025-01-30 13:55:59+01	1184
121	supervisor1	19	X0UL18n2T9EGGlPqWqGCIsIOm8rYl9pD	2025-01-30 13:56:06+01	2025-01-30 14:10:24+01	858
122	editor1	3	w7OHBVPx1tbgxhaAfU27Wm4EimI8uBlV	2025-01-30 14:10:30+01	2025-01-30 15:29:02+01	4712
123	supervisor1	19	V0SkMHAhLAbEurBLuS7obaTJ4ALzWVEn	2025-01-30 15:29:09+01	2025-01-30 16:23:52+01	3283
124	editor1	3	W21kALkjAsdcHqEU0Jc7RJ7oNAHYyTaS	2025-01-30 16:24:00+01	2025-01-30 16:24:00+01	\N
125	supervisor1	19	jY7dh8y0zGiWA2SwO86HuMp8g3EkHLlX	2025-01-31 09:43:03+01	2025-01-31 09:52:52+01	589
126	editor1	3	10qNdP1lvVYfM7RTBWFzEF4OhoVHukbA	2025-01-31 09:52:59+01	2025-01-31 09:53:36+01	37
127	supervisor1	19	mnh4MwQQKPCkdzskGSMnnKJEK0jmZvWL	2025-01-31 09:53:44+01	2025-01-31 09:53:44+01	\N
128	supervisor1	19	CEKrlrJX3bnmstqtiin6vOIQJ8YWAtry	2025-02-01 10:52:45+01	2025-02-01 10:52:45+01	\N
129	supervisor1	19	jzcFijLtGEnHuQ3dUOMVOBR2SdKW7peU	2025-02-02 09:41:19+01	2025-02-02 09:41:19+01	\N
130	supervisor1	19	E9g7Mted8MVEKqGz1PtilCYldbkjKTqb	2025-02-02 18:10:46+01	2025-02-02 18:10:46+01	\N
131	supervisor1	19	4cX2cpI3TZWwLM1K1BZe1WHU7GAO5QKK	2025-02-03 10:50:11+01	2025-02-03 10:50:11+01	\N
132	supervisor1	19	oPq9oKFuIPP8NfIAJsEYoAiUocpQc6rh	2025-02-04 08:52:30+01	2025-02-04 08:52:30+01	\N
133	supervisor1	19	AUcejcEVvMUeGEQoaUPFvK21nIiAvmI9	2025-02-04 10:50:49+01	2025-02-04 10:50:49+01	\N
134	supervisor1	19	oO0qS9cu3pbvaZRd4EkojUzAGeH8PFgJ	2025-02-04 13:10:11+01	2025-02-04 13:10:11+01	\N
135	supervisor1	19	aK5ZIN3qg66VBo1EkGFuLq4uibw1zYZC	2025-02-05 08:50:14+01	2025-02-05 09:06:05+01	951
136	admin1	17	c6zPKkhK5rJfCBGJV8WCEH5GLu7JBM9Z	2025-02-05 09:06:13+01	2025-02-05 09:24:30+01	1097
137	supervisor1	19	OOAbBtX2DKdEWBnL3GgKJMVsvYI4TVH4	2025-02-05 09:24:38+01	2025-02-05 09:24:38+01	\N
138	admin1	17	CjWgc4GAoBYH9A09dfE5p6RUDrg8lTDZ	2025-02-05 18:12:28+01	2025-02-05 18:12:28+01	\N
139	editor1	3	5RdWQQckV0jsTiAseVzvmxcSo9mCwaON	2025-02-07 09:00:32+01	2025-02-07 17:11:22+01	29450
140	supervisor1	19	bLCxEbImbyHs8BOK0jt41bXGl6pJ4mls	2025-02-07 17:11:35+01	2025-02-07 17:12:29+01	54
141	editor1	3	6M2bL6UGdpyJZ0GqYVNDcDzvFLXUaZOG	2025-02-07 17:12:39+01	2025-02-07 17:12:39+01	\N
142	editor1	3	VJzp2ttN8YARMbPsz8IYDrEv6Tf7FDbT	2025-02-07 17:52:37+01	2025-02-07 17:52:37+01	\N
143	editor1	3	Y62XY0dLM9MFobGbxlllLCCjHVSTgMIa	2025-02-08 08:57:48+01	2025-02-08 08:57:48+01	\N
144	editor1	3	0pog3JJoh9uM47FxiFRvUQ5Nbb9ceyxg	2025-02-09 10:07:17+01	2025-02-09 10:07:17+01	\N
145	supervisor1	19	XNRLLo26emolnv1Y2clI5mTzI2WsFpnY	2025-02-10 08:42:40+01	2025-02-10 08:42:40+01	\N
146	editor1	3	DBgRXIvprvQXsW1XciZWeZvy9h76w0y2	2025-02-11 08:41:04+01	2025-02-11 08:41:04+01	\N
147	supervisor1	19	4PY1itNFqwQg8XsKYbRqhw2cIBeQMqL1	2025-02-11 14:05:57+01	2025-02-11 14:05:57+01	\N
148	supervisor1	19	k3UzjtpsSvYkt9MfCw1JQLWgKkY7x8bF	2025-02-11 16:26:29+01	2025-02-11 16:26:29+01	\N
149	supervisor1	19	XrcWysxkmYni1hdfKQMszu8iwd8UB2kX	2025-02-12 08:40:56+01	2025-02-12 08:40:56+01	\N
150	supervisor1	19	w8WOaeUsT1SAd50xMf9OMLdrFF6HGSH8	2025-02-13 08:23:41+01	2025-02-13 08:23:41+01	\N
151	supervisor1	19	ZqHMAAPJlQ4dovCcmdt8FpQsAQP1JTVx	2025-02-14 08:49:59+01	2025-02-14 09:01:02+01	663
152	editor1	3	1625rUS288ydD0ifTFJ2WWwR53MCd1sW	2025-02-14 09:01:08+01	2025-02-14 09:01:08+01	\N
153	supervisor1	19	FuEjzdQ2O3DAv4EgwoM2BbvQ3oYOX3eG	2025-02-14 10:19:36+01	2025-02-14 10:19:36+01	\N
154	admin1	17	YXxd37WbDBlvSN3ZEjD5U9uJdVKXnIso	2025-02-14 14:10:06+01	2025-02-14 14:10:06+01	\N
155	admin1	17	c4V6faNSa0HBvVkhebFUUMyiopWRYbLl	2025-02-14 16:58:08+01	2025-02-14 16:58:08+01	\N
156	admin1	17	0kj0dvtP3y80IX4nxvoSKDwptMeFGLPK	2025-02-15 10:01:23+01	2025-02-15 11:11:04+01	4181
157	supervisor1	19	nSvdBz3a7865k29cTV4yl5ptgAAPQGIw	2025-02-15 11:11:11+01	2025-02-15 11:11:11+01	\N
158	admin1	17	H7xvmVMtUse5VETcIRUMDUePfSDf0e8y	2025-02-15 13:28:04+01	2025-02-15 13:38:32+01	628
159	supervisor1	19	9V2tv0IhsDaYYedG3n6XCGgPdMZ8eTaQ	2025-02-15 13:38:40+01	2025-02-15 13:43:49+01	309
160	admin1	17	TkHV7eDaSF9VdjXuh52Ez7Hp52ObKhKO	2025-02-15 13:43:55+01	2025-02-15 13:43:55+01	\N
161	admin1	17	EuHGgYxrhWrdDP7AS7ZwJE7fVHdUHuHJ	2025-02-16 08:40:42+01	2025-02-16 08:40:42+01	\N
162	admin1	17	FfUQ8PbgYak2ScdqANQ3M6NT1tHFzZWP	2025-02-17 08:33:31+01	2025-02-17 09:07:00+01	2009
163	supervisor1	19	FGpomlNgCxBHXMGTG1HpoGVHnzP9fD40	2025-02-17 09:07:07+01	2025-02-17 09:14:44+01	457
164	admin1	17	5PhQGINBLAfyBZiKwILWsHDqQcTtKcoA	2025-02-17 09:14:51+01	2025-02-17 12:59:45+01	13494
165	admin1	17	CVQQVJKJUdZXjw29THTXvpWt39IIv5Og	2025-02-17 13:10:16+01	2025-02-17 13:42:09+01	1913
166	admin1	17	Wca9WF4iFD9XOf4HuvEfFKxbcchoNWoX	2025-02-17 14:00:05+01	2025-02-17 14:01:31+01	86
167	admin1	17	tov2MSB4p9lRHFP4ghqzTP1CWTBBhBmv	2025-02-17 16:23:31+01	2025-02-17 17:12:13+01	2922
168	supervisor1	19	ISE2XQl238i5ZeL86jGEufoLGu63eEnS	2025-02-17 17:12:19+01	2025-02-17 18:04:59+01	3160
169	editor1	3	zr212dkieMh7YdspQ3YwjeW7IbT25sNa	2025-02-17 18:05:05+01	2025-02-17 18:13:45+01	520
170	admin1	17	NFa3RTmLt0AVmrEnhuIUIK26K32bzbEQ	2025-02-17 18:13:56+01	2025-02-17 18:22:37+01	521
171	supervisor1	19	tKfQVkF1qyA7YOlKqfzs0H8R3ZNCKLCC	2025-02-17 18:22:43+01	2025-02-17 18:22:43+01	\N
172	supervisor1	19	eQPJWTV3Aj5YK2YUMn8xqVbJH1g0SB6d	2025-02-18 08:33:02+01	2025-02-18 10:48:51+01	8149
173	admin1	17	AJQumowESz0KN5kKPqeFJWn4hU0vkV0M	2025-02-18 10:48:59+01	2025-02-18 11:10:57+01	1318
174	admin2	26	ATKohz7d8gYo7Oo7pNOUiCP4JlPT87QX	2025-02-18 11:11:04+01	2025-02-18 11:11:04+01	\N
175	supervisor1	19	xZNWz9rUO0AcU3Qlm0iHtnDzSEvlhlry	2025-02-18 11:11:14+01	2025-02-18 11:13:07+01	113
176	admin1	17	bKs1iAYeWxVWt94hvWz1ihLuv8Rxu76H	2025-02-18 11:13:14+01	2025-02-18 11:15:59+01	165
177	supervisor1	19	8QX7Jr3EmkdXAucv2OCPbNwWCLWGTImj	2025-02-18 11:16:05+01	2025-02-18 11:16:05+01	\N
178	supervisor1	19	bs2onOg43lAAUOGH1njQIoGrjy3TYZZd	2025-02-18 14:43:50+01	2025-02-18 15:40:02+01	3372
179	admin1	17	ZyF2ViYMpKIsuSKQ51xq9Qg8NH3FgZOm	2025-02-18 15:40:08+01	2025-02-18 15:48:50+01	522
180	supervisor1	19	IySk4lzuu9ohUU9PA086nEFbwIJtsqsM	2025-02-18 15:48:57+01	2025-02-18 17:53:47+01	7490
181	admin1	17	EdabcvM7kNmKpJRxRBUb7XQvHCNYF3y7	2025-02-18 17:53:53+01	2025-02-18 18:00:31+01	398
182	supervisor1	19	k2YgpuPV6tSPbeKXkMO5hap0bJJ5qBg8	2025-02-18 18:00:37+01	2025-02-18 18:00:37+01	\N
183	supervisor1	19	HPdDeYb7LJ2Wu2d4GhnzvsC7rgHAX9uG	2025-02-19 12:45:16+01	2025-02-19 14:17:03+01	5507
184	admin1	17	o0a6DkRCiBBFkHLaI5vBT4HHTGKy03jy	2025-02-19 14:17:08+01	2025-02-19 14:22:03+01	295
185	supervisor1	19	W2Y7E1Twqq9zFUpikbrGjzJ0pnxEUZS9	2025-02-19 14:22:09+01	2025-02-19 17:28:13+01	11164
186	admin1	17	uUQvlvhUTdPFEUl1qmg7MM6wMRLnjvAl	2025-02-19 17:28:20+01	2025-02-19 17:32:30+01	250
187	admin1	17	Tn4ahvX0A9nuQiMtmxKdnhyVFrOGbtEK	2025-02-19 17:32:36+01	2025-02-19 17:32:39+01	3
188	supervisor1	19	k1BnBhqLFGMlO5BN5MBaaPOtKeQSp9oY	2025-02-19 17:32:46+01	2025-02-19 17:32:46+01	\N
189	supervisor1	19	qE9L7iYv0MEMocAoLUC1oVIzKa8UMdLd	2025-02-20 07:18:37+01	2025-02-20 07:18:37+01	\N
190	supervisor1	19	Qf2jbfX7XxyjmY0XUJSA9bOVojSpta5m	2025-02-20 09:39:41+01	2025-02-20 09:39:41+01	\N
191	supervisor1	19	fFwngspgZY5NUbqOjqdtFr5dQ009GTZl	2025-02-20 09:46:51+01	2025-02-20 13:28:56+01	13325
192	admin1	17	aJSKAm4kFplUWHkQYiQrU5ZsMgaj2QSr	2025-02-20 13:29:01+01	2025-02-20 13:32:50+01	229
193	supervisor1	19	axElOjSW1i9tR17Jr3w6zeaqRiOfhw2X	2025-02-20 13:32:56+01	2025-02-20 13:32:56+01	\N
194	supervisor1	19	i8ysLKHOzfJ3ItQjwdIAD057C6Pl43eu	2025-02-20 17:31:20+01	2025-02-20 17:31:20+01	\N
195	supervisor1	19	gz7rQ0xzyY67nuDEMxSB2veA4ZgeYRXt	2025-02-21 08:23:37+01	2025-02-21 08:42:26+01	1129
196	admin1	17	XqeB9ZTLVCg2k8xjS73JNIBZbfT4Tuog	2025-02-21 08:42:32+01	2025-02-21 08:44:25+01	113
197	supervisor1	19	fO8cocHvApnN7qTNJGH02JSrCL5W0x2N	2025-02-21 08:44:31+01	2025-02-21 08:50:03+01	332
198	admin1	17	2F0EKK4Ylc2C4rZGnApJkFPqipg1GPJP	2025-02-21 08:50:08+01	2025-02-21 08:51:57+01	109
199	supervisor1	19	GoSTGcGktBkjrPPxNyy4FYQWWJZjec5x	2025-02-21 08:52:02+01	2025-02-21 08:52:02+01	\N
200	admin1	17	Cok0Ovjyo5WdpRKZFXVGYCAMHRpWKjGZ	2025-02-22 08:35:14+01	2025-02-22 08:35:14+01	\N
201	admin1	17	IzMk89NTu1ST9u0STjJK76neoBSa2Gmx	2025-02-22 16:05:49+01	2025-02-22 16:05:49+01	\N
202	supervisor1	19	RTEv8Vo3sYfCl7uQk2V9jAG3AnLP3lrG	2025-02-22 16:29:06+01	2025-02-22 16:29:06+01	\N
203	supervisor1	19	XpuKSVypxSA5IHA3Fbs2Rh5fGPgR3xLL	2025-02-23 10:34:08+01	2025-02-23 10:34:08+01	\N
204	supervisor1	19	FtQu7XpH4EoQsJ4RdqBgZ0rpa9Xyk3HW	2025-02-23 16:55:33+01	2025-02-23 16:55:33+01	\N
205	supervisor1	19	HsxuqC5CCjysDscF9nH6jbtl37LHD25X	2025-02-24 08:16:35+01	2025-02-24 08:16:35+01	\N
206	supervisor1	19	VDwZPBHWzoVX2tWKOWjdRF7iwBoqTxgd	2025-02-24 14:54:37+01	2025-02-24 14:54:37+01	\N
207	supervisor1	19	geN4HW2PJZ86xKEmogTJ1Mf81jYJhG9Z	2025-02-25 08:04:50+01	2025-02-25 08:04:50+01	\N
208	admin1	17	JpmLIwgfmPhh40TDXI5MVJFfn51nFCRD	2025-02-25 17:59:30+01	2025-02-25 17:59:37+01	7
209	supervisor1	19	tAtBksfdyotEINkW8QpLNEOJU3VqKkJ8	2025-02-25 17:59:43+01	2025-02-25 17:59:43+01	\N
210	supervisor1	19	uDS2QtFU6kdpv3gpljpb4yIvcrtM2MlV	2025-02-26 08:11:11+01	2025-02-26 08:11:11+01	\N
211	supervisor1	19	HRMd99f0poVCUTz0djDquqcdZHVoBLFP	2025-02-27 08:23:02+01	2025-02-27 09:18:27+01	3325
212	admin1	17	GqIT15lmfJmyXKRADS5NOAi2JaHrHhHN	2025-02-27 09:18:33+01	2025-02-27 09:30:55+01	742
213	supervisor1	19	LESIAoZBTiXjcJnXQbjgqsuDq2GwF35W	2025-02-27 09:31:01+01	2025-02-27 16:39:17+01	25696
214	admin1	17	pp8aJHDVD3eWJGbv74tHMUyI2HIPzG4s	2025-02-27 16:39:25+01	2025-02-27 16:42:17+01	172
215	supervisor1	19	pC1957UVSrySonatCjpmP0KSOAluzOEP	2025-02-27 16:42:23+01	2025-02-27 16:42:23+01	\N
216	supervisor1	19	KR2OMMgBT19CrVfZwdD2UPbKTyBt2EEy	2025-02-28 08:50:12+01	2025-02-28 08:50:12+01	\N
217	supervisor1	19	xXOF2awIk8BtA1AaCTkOsoG3LaZyqdwn	2025-02-28 10:42:05+01	2025-02-28 17:19:57+01	23872
218	supervisor1	19	HdLMzARyHNO8DThqoxVkL0cKZh4bxXBU	2025-02-28 17:20:16+01	2025-02-28 17:20:16+01	\N
219	supervisor1	19	sI3s41qKM6W4wfRUifhORT3FI3F2A6MR	2025-03-01 08:17:53+01	2025-03-01 08:17:53+01	\N
220	supervisor1	19	DqahigU7rEHFWXFm8C58DyVq04AbfNHO	2025-03-02 08:58:48+01	2025-03-02 08:58:48+01	\N
221	supervisor1	19	et1wOQ6nAdcpFjfJyrxIyKV9r7mQZHkq	2025-03-02 11:17:17+01	2025-03-02 11:17:17+01	\N
222	supervisor1	19	fqfEANTz8hAmH8clqFgSZpCJQLU640dM	2025-03-02 12:48:54+01	2025-03-02 12:48:54+01	\N
223	supervisor1	19	gOzndOub6Vc0pz3ue9kQZQ9r3R9jks9g	2025-03-02 16:22:49+01	2025-03-02 16:22:49+01	\N
224	supervisor1	19	US87pyTSVtm42W6V3LFIyu2svDjdIfOt	2025-03-02 18:34:10+01	2025-03-02 18:34:10+01	\N
225	supervisor1	19	A6nVfzfrnpe2kDU0eZCsslmixHDnuqGH	2025-03-03 08:04:37+01	2025-03-03 09:12:34+01	4077
226	admin1	17	vyI6ZJbgAkN1lTn0RS8E7NfGpKneOd54	2025-03-03 09:12:42+01	2025-03-03 10:28:46+01	4564
227	supervisor1	19	N1h2m6ZmL13oUW1eNEsMHRmfOrgLdWLS	2025-03-03 10:28:52+01	2025-03-03 13:01:00+01	9128
228	editor1	3	2x3c2mZz1HDiKFg8uZLt8BURr9JaMPA4	2025-03-03 13:01:08+01	2025-03-03 13:24:33+01	1405
229	admin1	17	Q5fGffLj2pZbroosjR8nqcVx4bYXXTgX	2025-03-03 13:25:28+01	2025-03-03 13:26:50+01	82
230	admin3	27	HrfIgy9Kx5IJHbOos7UjohmeocPxpFyG	2025-03-03 13:27:08+01	2025-03-03 13:27:08+01	\N
231	admin3	27	B5oFm5A8nb70YcBwMkvH1PyoYGf2wYSM	2025-03-03 13:28:30+01	2025-03-03 13:28:30+01	\N
232	admin1	17	fK693d72MbanGlPUMsme23Meqt8N7zpG	2025-03-03 13:28:48+01	2025-03-03 13:29:06+01	18
233	editor3	21	9F678b7vglep83kjpgO7uyxI1NPKSs65	2025-03-03 13:29:51+01	2025-03-03 13:30:26+01	35
234	editor3	21	jj9QzikrHmMcFJkt6BQm9QOHH0hE0AJC	2025-03-03 13:31:06+01	2025-03-03 13:31:09+01	3
235	admin1	17	sAw6b3s6TMRiPN4Syo4xuQZQEIiv2BRt	2025-03-03 13:31:14+01	2025-03-03 13:31:18+01	4
236	editor1	3	3bvYGMx6HcXpKGt5vNmWs5QXeLgJwRJl	2025-03-03 13:31:25+01	2025-03-03 13:55:33+01	1448
237	supervisor1	19	jvdq8UMpeGANJhw0EKOE4365YB559bIR	2025-03-03 13:55:40+01	2025-03-03 13:55:40+01	\N
238	supervisor1	19	La9b59xefj5P3gd9ExcRiJRxMaBiUiqF	2025-03-04 08:11:40+01	2025-03-04 08:11:40+01	\N
239	admin1	17	QuBF8RtC8PmBeeTMOMPjheJi0okKSIqa	2025-03-05 15:52:04+01	2025-03-05 16:50:00+01	3476
240	supervisor1	19	Gj3pujyZJ1QfPXKOtJZY0ffSWqxaTELp	2025-03-05 16:50:09+01	2025-03-05 16:50:29+01	20
241	admin1	17	pDlx3xOr2eNyOTwnxtvTTz08Bwage5K3	2025-03-05 16:50:34+01	2025-03-05 16:54:07+01	213
242	supervisor1	19	wMc9WVcuIATZj3hb6A2m6lUzlvhBMQer	2025-03-05 16:54:15+01	2025-03-05 17:20:44+01	1589
243	admin1	17	AbCPWNb3zsYWgSOkcue4kGcSq8pmJ7fW	2025-03-05 17:20:50+01	2025-03-05 17:26:10+01	320
244	supervisor1	19	GSDZUMe9k8Fj9jeYKJJO6fdfYw2RTTMY	2025-03-05 17:26:18+01	2025-03-05 17:35:38+01	560
245	supervisor1	19	9aemUx2ai1ul4t8H0cpMaCHXQjJJqIxP	2025-03-06 08:30:09+01	2025-03-06 08:30:09+01	\N
246	supervisor1	19	Bu5II9uSo182kK4SQ1m2WLlbIELKcMKV	2025-03-06 18:06:33+01	2025-03-06 18:06:33+01	\N
247	supervisor1	19	KlocO3j42DItC267HezSRIbfRrbGP12A	2025-03-07 08:02:09+01	2025-03-07 11:07:24+01	11115
248	admin1	17	lCoEuOpi9ueEypiOhey2bpg6798MyaIq	2025-03-07 11:07:30+01	2025-03-07 11:09:31+01	121
249	supervisor1	19	ki0yaNFidYg20NABiEEQE7zDMEdHSAzy	2025-03-07 11:09:36+01	2025-03-07 11:09:36+01	\N
250	supervisor1	19	JWOPzrViqbnPYMKeQBeLfD5mwM2RTDkc	2025-03-08 15:51:39+01	2025-03-08 15:51:39+01	\N
251	supervisor1	19	IDJa7E7cMLej84CaSKfsttp5tAVhvI8y	2025-03-08 18:19:39+01	2025-03-08 18:19:39+01	\N
252	supervisor1	19	iXxisxX3QvOdrbzC03oUB0Ki3yfjA1BB	2025-03-09 08:45:50+01	2025-03-09 08:45:50+01	\N
253	supervisor1	19	mZ8ErltbTetN95vKfq4eyitCrPbM55Rf	2025-03-09 14:13:07+01	2025-03-09 14:13:07+01	\N
254	supervisor1	19	BhjtLa2LiIOtqsdIpT9ZEOJOIfWxba5q	2025-03-10 08:07:59+01	2025-03-10 14:44:42+01	23803
255	admin1	17	VEGfkROGXO8K4R5eVaB4oD5hDPqotTo6	2025-03-10 14:44:49+01	2025-03-10 14:56:38+01	709
256	supervisor1	19	9TI9nmXowKaKP7y3gBrMLM01dSzue3ZJ	2025-03-10 14:56:45+01	2025-03-10 14:56:45+01	\N
257	supervisor1	19	hRG5cg53R0tPD15tgKrYfsd0u4mbbZSn	2025-03-11 07:59:45+01	2025-03-11 07:59:45+01	\N
258	supervisor1	19	4kyVYlMSac8VSkgK6bOyrebw51UurBfL	2025-03-11 08:20:29+01	2025-03-11 08:20:29+01	\N
259	editor1	3	HOkhJcLLvSNRnzacS7KuUAXIRscM6XWz	2025-03-11 10:57:53+01	2025-03-11 14:12:16+01	11663
260	supervisor1	19	py1CMG3ODTCPPkFVcRb3f8qqPUU3NnLV	2025-03-11 14:12:22+01	2025-03-11 14:12:36+01	14
261	editor1	3	oYk9cn3FB0MPeHFWzTGnTATxXqYsPcIw	2025-03-11 14:12:42+01	2025-03-11 18:14:05+01	14483
262	admin1	17	m9qXldFn66nJ4L1fqmauvyG7ob0biRGg	2025-03-11 18:14:12+01	2025-03-11 18:14:56+01	44
263	editor1	3	xDxxJwKm2VKx4Jm3B5eDdy1YNnTwQ5c4	2025-03-11 18:15:02+01	2025-03-11 18:20:59+01	357
264	supervisor1	19	3irlkUPWYia6wM96j1A8SXRwdd2lW0Ay	2025-03-11 18:21:04+01	2025-03-11 18:24:05+01	181
265	admin1	17	5z2n9i1nJZJIEww3nU9RAQeakDymNmuF	2025-03-11 18:24:11+01	2025-03-11 18:24:11+01	\N
266	editor1	3	40jIOKPwda3Hs5JtwwJUZbWsb50KCTaZ	2025-03-12 08:29:42+01	2025-03-12 08:45:50+01	968
267	admin1	17	K9hG1PSQhx1T59BLY9e2TrCBlCHSa7ae	2025-03-12 08:45:56+01	2025-03-12 08:46:05+01	9
268	supervisor1	19	mgxDZv1l1mVS7dZNXU7nNKGgJvRRYsPF	2025-03-12 08:46:11+01	2025-03-12 08:46:11+01	\N
269	supervisor1	19	9rrT9qEDUKVxqRT8E6N0CHbf95ymnvR7	2025-03-12 09:11:05+01	2025-03-12 10:05:57+01	3292
270	admin1	17	3Hpqi5tQItNY8NICAM52wmhsXNAAdWu3	2025-03-12 10:06:03+01	2025-03-12 10:08:19+01	136
271	supervisor1	19	I27HqY3P9kugmrtUYM55DFAIfxm5LdUa	2025-03-12 10:08:25+01	2025-03-12 10:21:09+01	764
272	viewer1	5	B4luBqc6K38fRRdL3Qf5ynkpzwg6HeD7	2025-03-12 10:21:28+01	2025-03-12 10:23:19+01	111
273	supervisor1	19	PZ4T9zPy89WIpCN9idtTmDRO09wcpOIv	2025-03-12 10:24:25+01	2025-03-12 10:25:31+01	66
274	supervisor1	19	zsfXMNpLdd3EeZhZYQeJrg42eOCpXgTp	2025-03-12 10:25:51+01	2025-03-12 10:28:52+01	181
275	supervisor1	19	vsScQGnBCB72u04bmm0xvzacEIgE835D	2025-03-12 13:26:13+01	2025-03-12 14:02:46+01	2193
276	admin1	17	ayxshrgOsaTfsmbL6DITCIUBaV0Nvb1Z	2025-03-12 14:02:53+01	2025-03-12 14:02:53+01	\N
277	supervisor1	19	sahLBLYGp24Yh7NcxnVf6kSwu2s4Waez	2025-03-16 15:13:47+01	2025-03-16 15:49:55+01	2168
278	admin1	17	f1DbGlFVnVG930r96BDm33X57fUmspLr	2025-03-16 15:50:03+01	2025-03-16 16:05:59+01	956
279	supervisor1	19	AZSt8pIgxf2eptCW5XZhWOey33cj9ANR	2025-03-16 16:06:05+01	2025-03-16 16:06:05+01	\N
280	supervisor1	19	ZVdYSWPz0N27qI8bGJ6NH8AsWoKvtOOW	2025-03-17 08:24:18+01	2025-03-17 08:31:24+01	426
281	admin1	17	UkSHGg3FmOfWipiT614XKcG4N07kF05N	2025-03-17 08:31:29+01	2025-03-17 08:33:28+01	119
282	supervisor1	19	2aG2tBXUPIwr4FUmZjuGRJRkxA93uAQS	2025-03-17 08:33:34+01	2025-03-17 15:39:51+01	25577
283	admin1	17	uLIW50AfUFhOlyuAlvxnrySCKzb87xH2	2025-03-17 15:39:57+01	2025-03-17 15:53:16+01	799
284	supervisor1	19	nchlvZ7K2bCoScP0pGlbGhggTLgEzHk8	2025-03-17 15:53:28+01	2025-03-17 15:53:28+01	\N
285	supervisor1	19	C8W5YqmUrEF0Ido3WegB0KMyFSdC9CJl	2025-03-17 19:35:59+01	2025-03-17 19:48:31+01	752
286	admin1	17	CQpwqAM570ZQnC3BwZeOUvEexhNsRt63	2025-03-17 19:48:37+01	2025-03-17 19:52:12+01	215
287	supervisor1	19	5zIJrAKIeJLslfiNnw6jKt3BaWWaPf1s	2025-03-17 19:52:18+01	2025-03-17 19:52:18+01	\N
288	supervisor1	19	OrU3zKM0r4Sqi16iwHzFAr9fi3RozXJd	2025-03-18 08:03:09+01	2025-03-18 08:21:51+01	1122
289	supervisor1	19	Z05Uux1wFeTdLUwavDIRUgTe3yd4kML4	2025-03-18 08:21:58+01	2025-03-18 08:21:58+01	\N
290	admin1	17	6OkWd4kWfx1hhKXeEYUAfjKf0HMTBHar	2025-03-21 08:14:50+01	2025-03-21 08:24:10+01	560
291	supervisor1	19	9ssAXh0rAnnRnWesXbNLjApYXEKSKd7X	2025-03-21 08:24:16+01	2025-03-21 08:24:16+01	\N
292	supervisor1	19	z2arUgrHpb4c0X6wC292ghYZ2saLAGUv	2025-03-21 11:01:25+01	2025-03-21 11:01:25+01	\N
293	supervisor1	19	2CGrKOLtrB0YFsEudfMgC5pFVzi6lZme	2025-03-22 16:21:46+01	2025-03-22 16:21:46+01	\N
294	supervisor1	19	eKzQTzjr3JHSV35bYERUBmr3qfxMbIvw	2025-03-23 11:53:08+01	2025-03-23 16:09:00+01	15352
295	admin1	17	g9l9h10nEaeZFCQVRS84jgLBc98pP1uB	2025-03-23 16:09:07+01	2025-03-23 17:35:19+01	5172
296	supervisor1	19	pXyEAJ1ArIQ4RYqQk3Wv86cNu5DAK0lt	2025-03-23 17:35:26+01	2025-03-23 17:35:26+01	\N
297	supervisor1	19	wFywh6sziuKdHfjF7LDlbNgApdkzlwwy	2025-03-24 16:44:11+01	2025-03-24 16:44:11+01	\N
298	supervisor1	19	hKi457D2EoqtxDi8O6dNA4xG4FzSsngz	2025-03-25 08:26:04+01	2025-03-25 08:26:04+01	\N
299	supervisor1	19	qmBk7zXCe0fEKfvk7VgrErKgbqXjWDjX	2025-03-26 11:19:50+01	2025-03-26 11:19:50+01	\N
300	supervisor1	19	lonpQvaOFKTKyroxqGTihg0GxUHZRmz7	2025-03-27 09:20:05+01	2025-03-27 09:20:05+01	\N
301	supervisor1	19	LlcMfZMFWRfVuaz4weZJocPsd3trwzyC	2025-03-28 08:38:11+01	2025-03-28 08:38:11+01	\N
302	supervisor1	19	XDzjUb0hTvl21RlJD1fRsJ1Hsc1x19sF	2025-03-29 07:02:33+01	2025-03-29 14:05:35+01	25382
303	admin1	17	wW0dSCPpnKBODKAl4dgyRhd0TOWeuILh	2025-03-29 14:05:40+01	2025-03-29 14:05:40+01	\N
304	admin1	17	kIaE8zw6FruCgtbZjSP4dkbicO4chVEA	2025-03-29 14:15:42+01	2025-03-29 14:32:32+01	1010
305	supervisor1	19	s0uq5bErFlebPizXYH4aOkmlYTLbqIEN	2025-03-29 14:32:38+01	2025-03-29 14:33:41+01	63
306	admin1	17	B7J78a851Jwl0CdOT25e4eUIZpRKqBoN	2025-03-29 14:33:46+01	2025-03-29 14:43:22+01	576
307	supervisor1	19	P16kngj4nhPiTzS6s5cjaqnkiOee9lvy	2025-03-29 14:43:33+01	2025-03-29 14:43:33+01	\N
308	supervisor1	19	hgD8XlmRbGXqzyOqDgHKcHYM8CGCfCfl	2025-03-30 08:19:53+02	2025-03-30 08:19:53+02	\N
309	supervisor1	19	t4r1kjQ6Nv6dFsk78cKWUmQnp0CkNJaQ	2025-03-31 07:29:17+02	2025-03-31 07:29:17+02	\N
310	supervisor1	19	DIgvLsDiePqC1cjUKCZqxx0CByuWigZb	2025-04-01 06:46:41+02	2025-04-01 06:46:41+02	\N
311	supervisor1	19	Jwc7IWfk6t98xGKopERAXrc1A3j5yblk	2025-04-01 07:28:24+02	2025-04-01 07:28:24+02	\N
312	supervisor1	19	nDtBWobPOqmiHuaSj3BOWEwzQb7XSBPn	2025-04-01 11:52:16+02	2025-04-01 11:52:16+02	\N
313	supervisor1	19	lD5IgRIZvVa5SSPyGJPjDHcpPQhiLRyg	2025-04-01 15:35:45+02	2025-04-01 15:35:45+02	\N
315	supervisor1	19	LMzEMDPua7fazlBk2n2r9nXLCq1mL4Mh	2025-04-03 07:13:07+02	2025-04-03 07:13:07+02	\N
316	supervisor1	19	v6ERTTfxzc1KQA1lKNTVaoYO7WbeYsZ0	2025-04-03 07:50:29+02	2025-04-03 07:50:29+02	\N
317	supervisor1	19	AWvBCJmLTbwT8h9ZQttxVFep8jw7ECJU	2025-04-04 07:32:41+02	2025-04-04 07:32:41+02	\N
318	supervisor1	19	JwHVKaSLtLF8tOkIUfBZW3Dkjx0qlU7R	2025-04-06 07:35:30+02	2025-04-06 07:35:30+02	\N
319	supervisor1	19	Rfd6huHL3bb9qmsbvdqJlaYYSZLEVIRr	2025-04-07 06:53:12+02	2025-04-07 06:53:12+02	\N
320	supervisor1	19	H77dWVKhyvf0IDIYoN0sKLRgqYgp9Ruw	2025-04-07 16:26:12+02	2025-04-07 16:26:12+02	\N
321	supervisor1	19	qgm6CWRCXgo2nT3ODnKG1QsNruBeFNA8	2025-04-08 07:17:56+02	2025-04-08 07:17:56+02	\N
3	editor	3	rTi1M3NwRBK0Itm8L0oLHrcP6STnDVDp	2025-01-07 08:29:43+01	\N	45
23	admin	17	hmd2Ze8cob3ZMPHvJ9hffXb2jrPEVqov	2024-11-11 09:16:13+01	2025-01-11 09:16:13+01	45
354	supervisor1	19	2gP5VIH0s5ko2S7tZYqQYjpS09sTqU77	2025-04-29 20:31:21.88031+02	2025-04-29 20:31:21.88031+02	\N
322	admin1	17	eJFKG8Yp2pvInLBe8d9sWUasoCiSAe4T	2025-04-16 11:51:33.769135+02	2025-04-16 17:17:25.980624+02	19552
355	supervisor1	19	TbrsqWyrMkFGedybQfFUFAxNNiVsnKBs	2025-04-30 09:16:07.691012+02	2025-04-30 09:16:07.691012+02	\N
323	viewer1	5	GgqttKOyr4m9N1hMAfAyFyPV4xumaZZ1	2025-04-16 17:17:32.696276+02	2025-04-16 17:36:02.687826+02	1110
324	admin1	17	JwtWmi2fHgGq2PUmFcB1AGfwb3Y9XNtZ	2025-04-16 17:36:08.227482+02	2025-04-16 17:47:50.590653+02	702
325	supervisor1	19	idoBofPP2jUJlVZvC156I6F2yVzvl6DS	2025-04-16 17:47:59.00513+02	2025-04-16 17:47:59.00513+02	\N
326	supervisor1	19	gesTP1h4j8BI0471BUN0DNOwPEea65s9	2025-04-17 08:45:46.143601+02	2025-04-17 09:04:09.643238+02	1103
356	supervisor1	19	QByHBt0Q6zaZ6f8Pg5lYVUoHBy869kfG	2025-05-01 09:02:48.345089+02	2025-05-01 10:43:32.37914+02	6044
327	admin1	17	P3wErNIlqDbKikXj4oFS8Gj6nYtWRiCc	2025-04-17 09:04:15.60137+02	2025-04-17 09:07:10.608409+02	175
328	supervisor1	19	wP849OSRiI9ZDis2kLe2Bqi6M5vbDfWP	2025-04-17 09:07:16.814526+02	2025-04-17 09:07:16.814526+02	\N
329	supervisor1	19	3hQKPUrqbMFJ5jJIhXxYxTXrVIJImOpl	2025-04-17 11:56:22.172932+02	2025-04-17 11:56:22.172932+02	\N
330	supervisor1	19	YCZDg2wNDB0P2HdLE74uhm13AvvofF78	2025-04-18 09:55:24.973132+02	2025-04-18 09:55:24.973132+02	\N
331	supervisor1	19	qeBzVJZuarHv28u9Fl4NhQlfEhWS7z0Y	2025-04-19 12:43:07.496436+02	2025-04-19 17:38:37.593841+02	17730
376	supervisor1	19	ddgTy95t6KLSFLmGoy1KgSnXKFkf7e09	2025-05-25 10:42:14.145685+02	2025-05-25 18:41:02.140161+02	28728
332	admin1	17	d5xjmigDzzKWiQZ6jL4f7hfNknghelfB	2025-04-19 17:38:42.768023+02	2025-04-19 17:42:31.970619+02	229
333	supervisor1	19	vcYP5d0XuiRsgCkCLlCheJxwQpVcJw4W	2025-04-19 17:42:37.40073+02	2025-04-19 17:42:37.40073+02	\N
334	supervisor1	19	N7ru5JRaO9cFdtt5q1zEciDFkBQfN6oM	2025-04-20 09:33:27.314154+02	2025-04-20 09:33:27.314154+02	\N
335	supervisor1	19	OTWT4Y76rBMknyUtjxYBRVhY3t7aNHXa	2025-04-21 09:31:49.18752+02	2025-04-21 09:31:49.18752+02	\N
357	admin1	17	y9G0nDrFkHilZyptnN9MMeFheT4th29Q	2025-05-01 10:43:40.97547+02	2025-05-01 11:29:11.963494+02	2731
336	supervisor1	19	OrJKnRPqqrHJEmAw7BxhVl5eWwfPNUp9	2025-04-23 09:17:17.556093+02	2025-04-23 17:59:43.395024+02	31346
337	admin1	17	dFcRHIGI8p3uzx7060MupWKYEG5xhCgq	2025-04-23 17:59:49.181235+02	2025-04-23 18:00:43.763774+02	55
338	supervisor1	19	IgimV0kpq4jSCb1oxSBab7RNrJWaHN3b	2025-04-23 18:00:49.425765+02	2025-04-23 18:00:49.425765+02	\N
372	admin1	17	GPGVbtabRHfZovDCBb4poxq4jMn1SjWw	2025-05-24 11:30:23.635053+02	2025-05-24 11:30:28.860713+02	5
339	supervisor1	19	MfnsQLVZ1kDk0RF3f1INTmN7DiT2fT7q	2025-04-24 09:34:58.140312+02	2025-04-24 16:08:45.756234+02	23628
358	supervisor1	19	t6nXcCouiQK00MaN64BTquxfnPzkXvG9	2025-05-01 11:29:18.118153+02	2025-05-01 13:54:36.262694+02	8718
340	supervisor1	19	rtrwojblLNJ7dm2CfpQWDhE0P2jBmfPX	2025-04-24 16:08:51.165251+02	2025-04-24 16:37:40.47299+02	1729
359	supervisor1	19	uet4Qog5eVThyXly96ocR9kGQEyhwiOn	2025-05-01 13:54:44.170522+02	2025-05-01 13:54:44.170522+02	\N
341	admin1	17	aZKMUbMHLWcok6oui53gMuqEVeF5uPKp	2025-04-24 16:37:47.294883+02	2025-04-24 16:56:53.299082+02	1146
342	supervisor1	19	1BsO1lXrax56ISyI4arFQXYz6Gclk4c1	2025-04-24 16:56:58.615904+02	2025-04-24 16:56:58.615904+02	\N
343	supervisor1	19	YrcGnXS2t04r0zogwoEJXVMFykw7oi3T	2025-04-25 17:45:31.118739+02	2025-04-25 17:45:31.118739+02	\N
344	supervisor1	19	mAVBGfZZsawIqOfyEpBMu7AFX9CPi8Ie	2025-04-26 12:47:10.340238+02	2025-04-26 12:47:10.340238+02	\N
345	supervisor1	19	95Tc7YsENuqAMN2u2LMVbTOLvl0opKbI	2025-04-26 18:14:00.774411+02	2025-04-26 18:14:00.774411+02	\N
360	supervisor1	19	P3DHveHfd33t2v1OfLYDSp9zNUifZQO2	2025-05-01 16:02:34.084695+02	2025-05-01 16:02:34.084695+02	\N
346	supervisor1	19	lETcV1eLtMyEYU4Wq0s8XtfDsB52tnc2	2025-04-27 09:19:35.812321+02	2025-04-27 09:38:55.642209+02	1160
361	supervisor1	19	2UQSD3sFNG02pgdVmpbkV0teJeUldPI3	2025-05-11 18:06:58.498756+02	2025-05-11 18:06:58.498756+02	\N
347	admin1	17	s6OH4ptOsUSYmzEyY5Y8Q8dcYooTTxvq	2025-04-27 09:39:00.722016+02	2025-04-27 09:44:45.353482+02	345
348	supervisor1	19	56DezcztOqUKwWoNkvWjr02K1G8OJCjR	2025-04-27 09:44:52.800211+02	2025-04-27 09:44:52.800211+02	\N
349	supervisor1	19	c8oI6AXbiqQdG2DXzxYWa4pBB586Emco	2025-04-28 08:59:29.693145+02	2025-04-28 08:59:29.693145+02	\N
350	supervisor1	19	xmPsDiiNxTgKXCqLYMD0waFwN1yXUbAv	2025-04-28 16:30:00.777675+02	2025-04-28 16:30:00.777675+02	\N
351	supervisor1	19	2O2lzk5kxICWcriEUVEUpT3VydIwIWzB	2025-04-28 19:46:07.15086+02	2025-04-28 19:46:07.15086+02	\N
362	supervisor1	19	9780ByQxAA5b4cXEp5Ye6czIrT76VNf1	2025-05-12 16:26:58.408111+02	2025-05-12 16:26:58.408111+02	\N
352	supervisor1	19	ESHJwH8jTU9mXgFSZb3sToZeYG5muKjO	2025-04-29 16:30:10.207886+02	2025-04-29 20:30:15.011176+02	14405
363	supervisor1	19	9Q9tiLmdI9m8nkpMFLzK4sSPpNho7Bpu	2025-05-19 09:43:24.276865+02	2025-05-19 09:43:24.276865+02	\N
353	supervisor1	19	NZI1kAiK7XbacNZ592r6fmLcladgbNu0	2025-04-29 20:30:22.743724+02	2025-04-29 20:31:14.401628+02	52
364	supervisor1	19	lomNnCX1JPAoJnGqedaGWgxC9nQHDX4B	2025-05-19 15:25:11.776648+02	2025-05-19 15:25:11.776648+02	\N
365	supervisor1	19	bHSETlxvxrQiMA3UkxzDAwLV2PWq11fC	2025-05-20 09:36:30.886435+02	2025-05-20 09:36:30.886435+02	\N
366	supervisor1	19	sCC4x3a9ErmKieRziuwpaeftWs1bzWxj	2025-05-20 16:57:20.903504+02	2025-05-20 16:57:20.903504+02	\N
367	supervisor1	19	vxRuRm3qezHbzTDbDze5egwVk6PhBXL0	2025-05-21 19:28:41.680778+02	2025-05-21 19:28:41.680778+02	\N
373	supervisor1	19	qmkZmBWXxtDOvCncMWgH8ihalDVpa9AB	2025-05-24 11:30:35.308502+02	2025-05-24 11:30:35.308502+02	\N
368	admin1	17	aNFL3wqjLlJL3vs9H5i3JWruzHdmDjhQ	2025-05-22 18:39:53.345665+02	2025-05-22 18:41:54.517616+02	121
369	supervisor1	19	ibUn2qpUWcAnsc4EE56NyUEzQsvI5xt8	2025-05-22 18:42:03.396704+02	2025-05-22 18:42:03.396704+02	\N
370	admin1	17	bnA2RxXeANVD60GefzRYAwjusIVRyQRM	2025-05-24 09:41:05.427921+02	2025-05-24 09:48:30.134383+02	445
371	supervisor1	19	MWcxupw6LfgMBBu8Qf1yMAuNVv4DvJ8M	2025-05-24 09:48:37.407977+02	2025-05-24 11:30:18.843779+02	6101
374	supervisor1	19	VxKybHRBrHtuPt5bkAmRMev6tz32QkzH	2025-05-25 09:14:57.504192+02	2025-05-25 10:41:35.062802+02	5198
379	supervisor1	19	0A6ulRkuWfCJQ0XNOCViR9VCCD8Am72W	2025-05-25 19:07:38.710301+02	2025-05-25 19:07:38.710301+02	\N
375	supervisor1	19	i4eujSj0ZtgCECCqghNPcetGmmRHcezh	2025-05-25 10:41:41.945712+02	2025-05-25 10:42:08.263011+02	26
377	supervisor1	19	zjfkCbUbotJxTJvao78xd52pTOvIwZZP	2025-05-25 18:58:25.365607+02	2025-05-25 18:58:48.065096+02	23
381	supervisor1	19	OgujlqZ57bWYLoGXzfWq99degNUmbfLU	2025-05-26 09:13:17.561465+02	2025-05-26 09:13:17.561465+02	\N
378	supervisor1	19	TMdlJyfTE1FxOWIiaEypvFXAr4G74DC4	2025-05-25 19:00:53.475736+02	2025-05-25 19:02:02.912108+02	69
380	admin1	17	Jw5Qjp2Q5nRmBQxEEcj8BynyzNZQwEzR	2025-05-26 09:13:07.2259+02	2025-05-26 09:13:11.825773+02	5
382	supervisor1	19	gELEBY59zsqAdJYdHlqu36mIr81Oqw0J	2025-05-27 13:35:34.815764+02	2025-05-27 13:35:34.815764+02	\N
383	supervisor1	19	Ko0hmUA1CSqVAwf4gdgiwRPXxxp3E91y	2025-05-29 12:30:09.879356+02	2025-05-29 12:30:09.879356+02	\N
385	supervisor1	19	vkY7pIjkamSqrp215pGNDYWI7ms8xQlm	2025-05-30 15:43:32.137422+02	2025-05-30 15:43:32.137422+02	\N
384	supervisor1	19	tluGhIL653NPoXAgGp6QrCE3CI8wbryR	2025-05-30 15:29:35.432063+02	2025-05-30 15:36:28.769407+02	413
386	admin1	17	fEPiy8B5cNdj4rVDxSqbmReP4amoTc67	2025-05-31 10:15:08.687793+02	2025-05-31 10:15:12.577435+02	4
387	supervisor1	19	RC5iEJi0aBcOfAsiIMKKBUJ88Dp1OsMR	2025-06-01 09:27:07.160093+02	2025-06-01 10:53:44.389484+02	5197
389	supervisor1	19	drCXi9uW0Gm3lV4tqHPQnz8DkRiyaEiY	2025-06-01 10:54:40.448434+02	2025-06-01 10:54:40.448434+02	\N
388	admin1	17	SJVUNFhrrOyFyZoOCaziYsQbYhnQ7r7c	2025-06-01 10:53:50.369237+02	2025-06-01 10:54:34.917189+02	45
390	supervisor1	19	Rh0vQKW1IlMYc11SiWhNGxP0ys2DB14z	2025-06-01 11:42:48.055211+02	2025-06-01 11:42:48.055211+02	\N
391	supervisor1	19	UYVnULLZIEbuvGxSqyj0qcOlLBMc2Ey3	2025-06-02 12:05:47.890374+02	2025-06-02 12:05:47.890374+02	\N
392	admin1	17	oOrusraoG32QLGSEUgdEDK8cNgV4kmVE	2025-06-03 09:09:53.967859+02	2025-06-03 09:09:58.630091+02	5
393	supervisor1	19	WK4RfLdBD657q9SvxwScMxhuKfnXrNuX	2025-06-03 09:11:51.609471+02	2025-06-03 09:11:51.609471+02	\N
421	supervisor2	24	00tHR7bLxtvWFZEKsw1zd7oT6omNDDLL	2025-06-09 15:02:47.930969+02	2025-06-09 15:03:34.12509+02	46
394	admin1	17	x64rkf1ExksMFuBsFQ4JoIDUQiwg93hV	2025-06-03 20:14:41.79673+02	2025-06-03 20:14:50.687266+02	9
395	supervisor1	19	7cAraLGzfTCz5YeHExbzKEhfzRyzRr69	2025-06-03 20:14:56.018026+02	2025-06-03 20:15:26.892397+02	31
396	supervisor1	19	QRWEjI50NbdETwLHEyWBscIQo80Vi3gE	2025-06-04 09:29:03.935454+02	2025-06-04 09:29:03.935454+02	\N
397	supervisor1	19	WVAsqz78W9DbEVHfJEBUl6ZPm0Z8dTwn	2025-06-04 14:05:18.702793+02	2025-06-04 14:05:18.702793+02	\N
398	supervisor1	19	V2OGJh6WyeCpn8KS7O5UCVyNMRTJ7h48	2025-06-04 15:34:04.255467+02	2025-06-04 15:34:04.255467+02	\N
399	supervisor1	19	sZZHx7b8ssCUcNcoB80a0RyE7giCx157	2025-06-04 16:00:10.42343+02	2025-06-04 16:00:10.42343+02	\N
400	supervisor1	19	c42CfK3DPOBNbHMFoI2egkC33aLDNNww	2025-06-04 16:17:54.860926+02	2025-06-04 17:49:59.229509+02	5524
401	admin1	17	BrvWcWeHQyH58uGH2bZdPXdivhALkHdN	2025-06-04 17:50:05.65308+02	2025-06-04 17:50:05.65308+02	\N
402	supervisor1	19	jNG9c9tV6JvsraQOxHLM2yWs9Nny4Rx0	2025-06-05 09:08:39.692635+02	2025-06-05 09:08:39.692635+02	\N
422	supervisor2	24	PL9Yn5t14JeFJaVJd7XEBr23G7TF3BO4	2025-06-09 15:04:05.924654+02	2025-06-09 15:04:09.162648+02	3
403	supervisor1	19	7Of3D1autV5S9c3Arl73HRiSrQTvOaKD	2025-06-08 16:09:15.365718+02	2025-06-08 16:15:49.795063+02	394
404	editor1	3	ntoZ2Bys3Xr88knqkQnzw9oqe6rfr7hJ	2025-06-08 16:16:16.624284+02	2025-06-08 16:16:35.765257+02	19
405	supervisor1	19	qLA2ZgMgliNIKkBHEElq7skuiTwJgnDq	2025-06-08 16:19:10.521148+02	2025-06-08 16:19:10.521148+02	\N
435	viewer3	23	FlhmaAAB7rkCTiyaL2apoume00wZUHt1	2025-06-09 15:16:02.28526+02	2025-06-09 15:18:28.199124+02	146
406	supervisor1	19	FCMiG1UcLHRGqSwAgOb9DqGpi1wokKEb	2025-06-09 10:05:58.163463+02	2025-06-09 11:39:23.125311+02	5605
423	supervisor3	25	zZVZMDuM8eJ5285TsEkIxcvkF3EDUckU	2025-06-09 15:04:36.260841+02	2025-06-09 15:05:09.471725+02	33
407	viewer1	5	ZNpxfMhXEMecb5H8qnGfW1IoXAP6DwaW	2025-06-09 11:39:30.647588+02	2025-06-09 11:48:22.711821+02	532
408	supervisor1	19	UoeudeMgpsWPyKDSKtAlZcwAP0FIcBR5	2025-06-09 11:52:24.863208+02	2025-06-09 12:01:14.157297+02	529
409	admin1	17	3XXADtGSzWdWkKC8tQuTex5kOZpscrpr	2025-06-09 12:01:19.942178+02	2025-06-09 12:01:40.266719+02	20
410	admin2	26	gvvUoh14cUoRLYweAhf1cK1rKLmBx6y5	2025-06-09 12:01:50.025872+02	2025-06-09 12:01:50.025872+02	\N
424	supervisor3	25	wJcZ3OPYTAMCJQ8GAFaMFLyrBrdCe3te	2025-06-09 15:06:23.510455+02	2025-06-09 15:06:42.24618+02	19
411	admin2	26	h9rfp7wbSGA14Y7cNSXyQNHezHTdphUL	2025-06-09 12:15:42.167234+02	2025-06-09 12:16:45.968515+02	64
412	admin1	17	Y1tp75EN7j02m7DUyJdTzWV6ridenqlH	2025-06-09 12:20:09.235182+02	2025-06-09 12:20:22.277352+02	13
444	editor1	3	PCargsCrHlcZNpeK9Dx7Iw1avVOlEllI	2025-06-10 08:35:43.66593+02	2025-06-10 10:59:07.487735+02	8604
413	supervisor1	19	rD0FYPaZylCv1mEhpLXychiNPSF9lisp	2025-06-09 12:20:37.280295+02	2025-06-09 12:21:54.967092+02	78
425	editor1	3	jetJQ1h7HV3VO6yc7MrUFf95jUdGY7eF	2025-06-09 15:06:52.989238+02	2025-06-09 15:07:48.624537+02	56
414	supervisor1	19	xOSox8dwDVxFyRXodn6nXbUJ7BnfdHqN	2025-06-09 12:22:47.487749+02	2025-06-09 12:22:52.669338+02	5
415	admin2	26	5vAMFLsa13D1DdhKamMeUFzoRdFEgd3S	2025-06-09 12:22:59.603841+02	2025-06-09 12:24:44.606782+02	105
436	viewer2	22	YHatebC5eRPTNbAcmhQKngX8HuoDt52i	2025-06-09 15:18:59.067515+02	2025-06-09 15:19:02.938832+02	4
416	admin2	26	na1HiqlltSFWrm0KydnHZ7As4FFQ6fzd	2025-06-09 12:26:41.955562+02	2025-06-09 12:27:27.321139+02	45
426	editor1	3	IzVn1h06x2tQEIKeVcoGng1XM9rC33UU	2025-06-09 15:07:55.040852+02	2025-06-09 15:07:57.976148+02	3
417	admin2	26	0X4a9zbnQMD2gTrJBmlKebhjHqvS5w4r	2025-06-09 12:27:37.688467+02	2025-06-09 12:27:46.765786+02	9
418	admin3	27	6WjxOnggbQstYaIsHckEiIX0G6N5QjLU	2025-06-09 12:27:54.236802+02	2025-06-09 12:28:35.671259+02	41
419	admin3	27	1F4XaFKNzAe3wJX2W9bs4Z1maeK9jcuk	2025-06-09 12:28:53.572593+02	2025-06-09 15:01:00.59189+02	9127
427	editor2	28	7Uvn9tBhv6AegQN9CAZW3OaTuvagZOLg	2025-06-09 15:08:18.094841+02	2025-06-09 15:08:54.349961+02	36
420	admin3	27	6L4eeIMUWtSPNzYlVQHx34GRPlFTuWOw	2025-06-09 15:01:09.290439+02	2025-06-09 15:01:12.744954+02	3
428	editor2	28	zYJsus5mtf4OZUeA9YcFz7p0n3YBNMlp	2025-06-09 15:09:14.076495+02	2025-06-09 15:09:25.674144+02	12
437	viewer3	23	PRXswAjFcPrrxWYkiKH3hBsJUE95Ty4K	2025-06-09 15:19:14.764231+02	2025-06-09 15:19:19.076835+02	4
429	editor3	21	t7bLp6kBZ2vZgOG4j36X2vdN4EArtug5	2025-06-09 15:09:40.775163+02	2025-06-09 15:10:46.983193+02	66
430	editor3	21	MRFeN7DRTOmiJfjYbqDGLsQXbg5Cup6A	2025-06-09 15:10:57.665762+02	2025-06-09 15:11:00.472901+02	3
456	editor1	3	PnQNuE0XcSbxmOsEXQLHZKkFEAxSA4D4	2025-06-12 12:12:51.224228+02	2025-06-12 12:12:51.224228+02	\N
431	viewer1	5	C7Y6k1pD8BFvOLlzNhx0kynJozi4TOXV	2025-06-09 15:12:54.211941+02	2025-06-09 15:13:18.169314+02	24
438	editor1	3	9xORhVBarMGmqgBy0LVqjfTf4JKnrWHm	2025-06-09 15:20:44.032625+02	2025-06-09 16:56:59.721354+02	5776
432	viewer1	5	0Epbk47nhxtJCxs23bI3MQujKQ9iSmVC	2025-06-09 15:13:30.272112+02	2025-06-09 15:13:59.909556+02	30
433	viewer2	22	lyo1u5yuyl3qJJAlkUadWzPwzPlHSyAG	2025-06-09 15:14:15.289704+02	2025-06-09 15:14:44.952675+02	30
434	viewer3	23	Z6GIyMlCbA054glCGTfP9gxUvMI9Jflz	2025-06-09 15:15:00.575789+02	2025-06-09 15:15:00.575789+02	\N
445	supervisor1	19	hfHxOjYUJ0N7uQDyXWKNDHMv2O9kXyga	2025-06-10 10:59:13.823925+02	2025-06-10 11:06:10.250978+02	416
439	supervisor1	19	S6Z2hH04NWhFmWGlKLDQgAbBSUv7sW8h	2025-06-09 16:57:05.110691+02	2025-06-09 17:03:19.632011+02	375
440	editor1	3	PULk25asnAT8fbM9FEoFsZ0Xk8kkk8xS	2025-06-09 17:03:24.573155+02	2025-06-09 17:46:05.64623+02	2561
449	admin1	17	OmgmV8Gswdp4TCjctKAnV42D2qmGbYNu	2025-06-10 11:38:24.849116+02	2025-06-10 11:48:35.324146+02	610
441	supervisor1	19	O5yp6dJmbggYFKOnrBIMiAGW0VcYCyDY	2025-06-09 17:46:12.835097+02	2025-06-09 17:52:42.234272+02	389
442	editor1	3	FC8kIBxUN2GTaW8TZTkOlsGH4rdDB4H3	2025-06-09 17:52:49.620798+02	2025-06-09 17:52:49.620798+02	\N
443	editor1	3	5FKRBwaYxH6PJIb4FH4ahiU3d5szgPSP	2025-06-09 20:28:52.91424+02	2025-06-09 20:28:52.91424+02	\N
446	editor1	3	Cj0ZqlJeuutGO4pXTOiJzSxv2jPydg5V	2025-06-10 11:06:18.617966+02	2025-06-10 11:06:47.269519+02	29
450	editor1	3	VBZ5ssGlyXlZXCXiafd0UcrYdEBlMaRw	2025-06-10 11:48:41.444285+02	2025-06-10 11:48:41.444285+02	\N
447	supervisor1	19	hYIHSm8jysMKZPIS7VmrlkrLVUAe6Ehb	2025-06-10 11:06:54.076743+02	2025-06-10 11:14:14.220663+02	440
451	editor1	3	6DY0xjk7aoUKqewbpQtcuIGsMZeIbmJU	2025-06-10 18:59:46.550662+02	2025-06-10 18:59:46.550662+02	\N
448	editor1	3	cdC6AuMA4dF21GFHAX052f1XGcfhqozq	2025-06-10 11:14:20.847843+02	2025-06-10 11:38:18.983975+02	1438
453	supervisor1	19	B1dUQmViW7jiTSMsfzyL8gMd5KDjRSZs	2025-06-11 17:56:28.582688+02	2025-06-11 18:14:32.879411+02	1084
452	editor1	3	CZRpJDwuuhmVHYFZiOr6GF6QQ2cY0wsc	2025-06-11 16:54:11.819109+02	2025-06-11 17:56:20.134231+02	3728
454	editor1	3	6jIcjKwuGITOnyD5CPs8MX5RxSvhKINs	2025-06-11 18:14:39.543241+02	2025-06-11 18:14:39.543241+02	\N
455	editor1	3	UbuzPdQiEnJSe2iU2IZfDoz8W77dOyth	2025-06-11 18:27:44.832388+02	2025-06-11 18:27:44.832388+02	\N
457	\N	\N	j58XJn6RZHq0hLNen3m7UDOhCPW1k9Do	2025-06-12 13:52:33.528109+02	2025-06-12 13:52:33.528109+02	\N
459	\N	\N	iLn72FTFsZR7crmf0GywyhqzDMyE7oWz	2025-06-12 14:10:15.463122+02	2025-06-12 14:10:15.463122+02	\N
458	admin1	17	RkUjDAqzU4OSuAQkSIVtvmPgimB73GP7	2025-06-12 13:58:01.029596+02	2025-06-12 13:58:03.608022+02	3
460	admin1	17	7HZBPFRtZZ6AEew8hivw0RWiqFWDTcsM	2025-06-12 15:17:17.509522+02	2025-06-12 15:17:51.553752+02	34
461	editor1	3	TXKQoiJTqAadsWHGeHrOSppIPhDC0iEr	2025-06-12 15:17:58.296967+02	2025-06-12 15:25:00.881127+02	423
464	editor1	3	JOcNVHQAUFYeA9Fi2A3nJ0pPj9TDMH6P	2025-06-13 09:20:17.881936+02	2025-06-13 09:20:17.881936+02	\N
462	supervisor1	19	tVompnGTXMZWWsVAhFoJk1LlvjxA4HuC	2025-06-12 15:25:07.263031+02	2025-06-12 18:30:27.274089+02	11120
463	editor1	3	u5JHvY8OdiPp3AYDgA3Boj6iR8pFh0xC	2025-06-12 18:30:34.406857+02	2025-06-12 18:30:34.406857+02	\N
465	editor1	3	dNSMNTT0ripBYG0pErOvc8fc1VKR7Prv	2025-06-13 11:20:42.166728+02	2025-06-13 12:59:57.826655+02	5956
485	admin1	17	jSxGCWZ1i6Cy8BwsileDggUISbOXyEYf	2025-06-17 17:38:59.018222+02	2025-06-17 17:40:35.783705+02	97
466	editor1	3	yuzPgl0zi9m2bjH2H6sKkRfC6EHu2gPT	2025-06-13 13:15:47.619811+02	2025-06-13 13:23:30.292542+02	463
486	supervisor1	19	qnBqbZ9JJbjyifG8gVxj65FnQDQu8vzL	2025-06-17 17:40:43.266212+02	2025-06-17 17:40:43.266212+02	\N
467	editor1	3	Zrk1u4vlRk4yAjv3ajxjcXdawY0K2CBy	2025-06-13 13:23:36.110019+02	2025-06-13 13:24:56.992985+02	81
487	supervisor1	19	0HXjJY7xxeCMhsPYR3D7d0hw2sDK5bRg	2025-06-21 09:31:57.471253+02	2025-06-21 09:31:57.471253+02	\N
468	editor1	3	XahRsAyumILVrxKU3DH7uTTVghbraV22	2025-06-13 13:25:11.738187+02	2025-06-13 13:27:19.8656+02	128
469	editor1	3	BcI6MYC5FjG30fioItqqP2Y2lSGpEJ1H	2025-06-13 13:30:54.059475+02	2025-06-13 13:30:54.059475+02	\N
470	editor1	3	52juXLoeIsZaX6FNA1nfCVtOdFY9bE4B	2025-06-13 15:28:05.860336+02	2025-06-13 15:28:05.860336+02	\N
471	editor1	3	gWxu3YKgphCUCJ3C2oBFIyYaNGd6V3gu	2025-06-13 15:30:48.093096+02	2025-06-13 15:30:48.093096+02	\N
472	editor1	3	Tm84qxyJvvO9y015vs8qjFlQux9sKks9	2025-06-13 15:33:39.268317+02	2025-06-13 15:33:39.268317+02	\N
488	supervisor1	19	rcSPZ2DDB3oa8PqdJQGcRvUygB234EUD	2025-06-21 14:09:55.125621+02	2025-06-21 14:09:55.125621+02	\N
473	supervisor1	19	QdhTOTb1yfaJGGo6tVGoSIVXKFLgyBQH	2025-06-13 17:59:44.093131+02	2025-06-13 18:32:35.962805+02	1972
489	supervisor1	19	TFtPtyiXJF3uMNcGrbgoibtmbV6QXpzP	2025-06-21 17:38:45.091499+02	2025-06-21 17:38:45.091499+02	\N
474	admin1	17	KSAG33A1f24aLQ1icY4ABr1JkBgjUk2C	2025-06-13 18:32:40.985074+02	2025-06-13 18:33:05.539599+02	25
490	supervisor1	19	fdJMcWuwl0YL9J6zio488BvAo4Utr4PJ	2025-06-22 10:34:43.547969+02	2025-06-22 10:34:43.547969+02	\N
475	admin1	17	M6sqqhAktndLR94b5NWhXyMzcN5NQZnQ	2025-06-14 11:55:16.643256+02	2025-06-14 12:10:43.628546+02	927
491	supervisor1	19	29iulG4YWCdEAqHqM6e41NDmlPbuoZLP	2025-06-22 15:36:38.282198+02	2025-06-22 15:36:38.282198+02	\N
476	admin1	17	6u8udegnuqlX1yJgSQIWKHGw3PZ7FS5v	2025-06-15 11:19:58.081198+02	2025-06-15 11:20:13.773702+02	16
477	admin1	17	WLxrAuvgwSGlre2A3hAVrcAK6XqfKVFT	2025-06-15 12:10:41.204905+02	2025-06-15 12:10:41.204905+02	\N
492	supervisor1	19	bjgG2rUj1JbZ9RPppTFcn9x2FrBUfMNe	2025-06-24 15:46:25.004812+02	2025-06-24 15:46:25.004812+02	\N
478	admin1	17	1MwWR7rglMYswmARb8FIQfBJM5DH3PAv	2025-06-17 09:53:36.61515+02	2025-06-17 10:19:17.049276+02	1540
479	admin1	17	Uv7LoatzJOzcW3RlKt95hp2bHhwxOppL	2025-06-17 10:33:14.383557+02	2025-06-17 10:45:52.025483+02	758
480	supervisor1	19	R8mHn5tEz8dFz6pxn2m1fQnjIb4Yfe3S	2025-06-17 10:45:58.325359+02	2025-06-17 10:45:58.325359+02	\N
514	supervisor1	19	UX1vABH9SsZYJJRJlDwpI7wVKB89k3Uc	2025-10-29 18:42:01.143323+01	2025-10-29 18:42:01.143323+01	\N
481	supervisor1	19	1qNr8nsj8rE9twEC7lHihWkcOopwnTY8	2025-06-17 10:48:14.194101+02	2025-06-17 11:57:31.950354+02	4158
482	admin1	17	dBEDq9FvB7gDJhnvjCqgcFYRgMl6IPQy	2025-06-17 11:57:40.862502+02	2025-06-17 11:57:40.862502+02	\N
483	admin1	17	eQSSETbNngzH5Sd37DD2M9fJQ5wyfSIm	2025-06-17 12:21:46.035276+02	2025-06-17 12:21:46.035276+02	\N
493	admin1	17	oKSbO44K7itGWTT6PtandUsqMy0biBpl	2025-07-12 14:41:08.879451+02	2025-07-12 14:42:07.599284+02	59
484	supervisor1	19	AjF4LHREbZWjOhU64bKswc9ge8K6La9P	2025-06-17 15:56:07.672383+02	2025-06-17 15:56:50.189038+02	43
515	supervisor1	19	j0564OsyjDouzKOxj3UGwfCF8cEekCSD	2025-10-29 19:29:49.673909+01	2025-10-29 19:29:49.673909+01	\N
494	supervisor1	19	5c30u3X45lsAVqvZesbijgpQqLEzljlG	2025-07-12 14:42:49.661+02	2025-07-12 14:42:54.888755+02	5
516	\N	\N	r1bEDTiT5jRxLHD3IWQQREQqS68DIO6K	2025-10-30 16:37:47.156783+01	2025-10-30 16:37:47.156783+01	\N
495	editor1	3	Us1xY7X47tptx6nSicGTC19GfBKjgDfv	2025-07-12 14:43:20.154653+02	2025-07-12 14:43:27.088598+02	7
496	viewer1	5	rUFKkZV0YJTCQvV1zYS0b8UJoVs1JhM0	2025-07-12 14:43:42.694577+02	2025-07-12 14:43:49.676214+02	7
497	supervisor1	19	ugXaqQWNnH3toEObJ4fqsuhWtC9ClfGp	2025-07-12 14:43:55.891085+02	2025-07-12 14:53:59.274781+02	603
517	admin1	17	aZCCDh2sQ91GxIOErOhlJ3us3R59D2AH	2025-10-30 16:40:35.425132+01	2025-10-30 16:40:41.02113+01	6
498	admin1	17	U2LQcSz5z3kzFHK4GVqsQwKEHLflW6cw	2025-07-12 14:54:05.30544+02	2025-07-12 14:55:07.929954+02	63
518	admin1	17	2q7Udr24ODOGknxbLFE5XZBYzAIZpdAT	2025-11-08 18:54:47.722687+01	2025-11-08 18:54:47.722687+01	\N
499	admin1	17	YrIB9ySHTeofPUuMwhTYczpsievBqrDR	2025-07-12 14:55:57.068596+02	2025-07-12 14:56:02.11186+02	5
500	admin1	17	6YYSKPepk3ETN7RODgDmh1IOMPWMnZlq	2025-07-12 14:56:19.572648+02	2025-07-12 14:56:19.572648+02	\N
501	admin1	17	N3sOj1whXhxZIHaO626GaSDNuJdSUeOH	2025-07-12 14:57:37.320008+02	2025-07-12 14:57:37.320008+02	\N
502	admin1	17	4xeVVw4HK8QgXJ4ftBgHT8SRnyOwe4Zp	2025-08-02 18:06:44.124689+02	2025-08-02 18:08:09.621977+02	85
503	supervisor1	19	1ODJWRtioobeV5rVA9kJshbqVAdwVlsx	2025-08-02 18:08:16.137248+02	2025-08-02 18:08:16.137248+02	\N
504	supervisor1	19	jvwwaUnlzIv9dblffHSGeJwtEKJtpLTE	2025-08-07 21:22:45.108821+02	2025-08-07 21:22:45.108821+02	\N
505	supervisor1	19	JkWMyT8bKDS9pC2mpoYeKW2hhsMveHmN	2025-08-07 21:24:09.181103+02	2025-08-07 21:28:23.074019+02	254
519	admin1	17	tH3rMS3TF21Mlda4dN4ykU9Cu1kDG7Im	2025-11-10 15:49:02.752685+01	2025-11-10 16:35:13.34547+01	2771
506	supervisor1	19	ySUlbhugsIBTgFKHbc8JK0Mx6tgtkYC2	2025-08-07 21:29:26.81428+02	2025-08-07 21:29:50.106217+02	23
507	admin1	17	Gk0vAHanOaU0Voyhjxf3n8H4vukUCR3J	2025-08-07 21:29:55.846359+02	2025-08-07 21:29:55.846359+02	\N
508	admin1	17	ZuOOD97PGVj9AM7DwDsCH7oa8WFYUuwh	2025-08-23 08:37:10.044615+02	2025-08-23 08:37:10.044615+02	\N
509	admin1	17	Gz2c1YSQDSQIktPMnxvaQiqQQqoWFVgC	2025-09-08 18:53:15.27926+02	2025-09-08 18:53:15.27926+02	\N
510	supervisor1	19	UKkseGSJE9vDJcaCHbnNvXtwnrV6Ql1J	2025-10-13 16:30:21.749715+02	2025-10-13 16:30:21.749715+02	\N
511	admin1	17	uvcPlRUP8Lqy3guiEmiykVfTpiC6MMDk	2025-10-15 09:20:47.045013+02	2025-10-15 09:20:47.045013+02	\N
512	admin1	17	iK8oXORhW2s6Q6q5XMdepKqxG5l99F3e	2025-10-29 17:52:26.17448+01	2025-10-29 17:54:19.427683+01	113
513	supervisor1	19	ZwrF5TMI6iEnhlvqISRYqlXMilpf99v9	2025-10-29 17:58:45.986552+01	2025-10-29 17:58:45.986552+01	\N
524	editor3	21	Po5NC6JoEGxVHqZtxtpwK7mVLVmCjpN1	2025-11-10 17:05:17.650587+01	2025-11-10 17:11:55.106485+01	397
520	supervisor1	19	qgGSlT1lj8MRvs2bxTMLc34bQAySlU4k	2025-11-10 16:35:20.535936+01	2025-11-10 16:35:48.277374+01	28
525	supervisor1	19	Nz7SyGyimqxAPgeX4XVy6MIy7O1O3a2C	2025-11-10 17:12:02.891124+01	2025-11-10 17:12:02.891124+01	\N
521	admin1	17	R5CVYajETfZi5fIWScD2so1BhXqxpsnj	2025-11-10 16:35:52.330397+01	2025-11-10 16:38:27.456062+01	155
522	supervisor1	19	OTHQ1pNTjMVnx8xFB5NczCrZs1p6ELGm	2025-11-10 16:43:02.108198+01	2025-11-10 16:43:11.984281+01	10
533	supervisor1	19	99SMOWcgTG8jU7VepIvCLTVNKnUwoilu	2025-11-14 18:31:40.174268+01	2025-11-14 18:31:40.174268+01	\N
523	admin1	17	imGgrrXgLqtJspOjiQuZ3EuGk7GG6O81	2025-11-10 16:43:18.692054+01	2025-11-10 17:04:57.578416+01	1299
526	supervisor1	19	RrxH1ARiUUM4ZAXCUgC3T5jYhSXlyxeX	2025-11-11 10:00:17.879791+01	2025-11-11 16:06:46.892559+01	21989
527	supervisor1	19	tL1K59HQGVrcW2JuYnSE354ARMWEw6l2	2025-11-11 16:08:52.607327+01	2025-11-11 16:08:52.607327+01	\N
528	supervisor1	19	1Aslm6MaP3xGIsaHgOj0ThtkVvFIiE8f	2025-11-12 12:15:57.555393+01	2025-11-12 12:15:57.555393+01	\N
529	supervisor1	19	ehTRD8P5r6ZNVc3836mJ5U4QXC6cv2lp	2025-11-13 16:30:35.350378+01	2025-11-13 16:30:35.350378+01	\N
530	supervisor1	19	FuKZOgxCnOb8P2PdkPYvvd2SZZBX8YbH	2025-11-14 08:40:55.904211+01	2025-11-14 08:40:55.904211+01	\N
531	supervisor1	19	faWFse7lnN1QHmny4FJD20x1B7vFOs5r	2025-11-14 10:02:42.496131+01	2025-11-14 10:33:04.656174+01	1822
532	supervisor1	19	2TDFCS1zeMQQfRdVFpPb8mjtVZmqPjKm	2025-11-14 10:33:15.132006+01	2025-11-14 10:33:15.132006+01	\N
534	supervisor1	19	oGRigHTGOuPUgE5SdsLBh5aSdhoQM896	2025-11-15 12:22:43.47344+01	2025-11-15 12:22:43.47344+01	\N
535	supervisor1	19	Jq8LnvV3OUXf3C9FThybfo6VaMQOQEyC	2025-11-15 17:51:28.269061+01	2025-11-15 17:51:28.269061+01	\N
536	supervisor1	19	soiPq0TFXSczKftLmGvQcYw0CLDtCLwu	2025-11-16 09:10:07.162498+01	2025-11-16 09:10:07.162498+01	\N
537	supervisor1	19	b2S1a8bHFZMBWci3F4Hxh8wwUHQ53QVt	2025-11-16 19:41:19.97292+01	2025-11-16 19:41:19.97292+01	\N
538	supervisor1	19	gapMfFgBH7kUxfzzneZYeSmw1WFIqfZ3	2025-11-16 21:04:16.966267+01	2025-11-16 21:04:16.966267+01	\N
539	supervisor1	19	W5HRAJjPU2YYJzkubde9MTgEOt2MRPOk	2025-11-17 09:19:10.491227+01	2025-11-17 09:19:10.491227+01	\N
541	supervisor1	19	C2t2Hc79TlYKwZMh2KTciagViceQkrW3	2025-11-18 12:03:21.833993+01	2025-11-18 12:03:21.833993+01	\N
540	admin1	17	U32Jt3D5FBinEKMAtetjVV41g3VKT7nl	2025-11-18 12:02:17.138291+01	2025-11-18 12:03:05.11316+01	48
542	supervisor1	19	7C5SWFZftUKJoBQT0tgiKiB3uI527r6d	2025-11-18 12:05:30.569577+01	2025-11-18 12:05:30.569577+01	\N
545	supervisor1	19	ZljfNVVMufbGJDSHrSmS2VhIqy9h7ODO	2025-11-18 12:24:56.250712+01	2025-11-18 12:24:56.250712+01	\N
543	supervisor1	19	dORCWUIohF7v7LwAdaiAVq4TlIihEyw0	2025-11-18 12:23:03.30371+01	2025-11-18 12:23:03.30371+01	\N
544	supervisor1	19	D5aNgvxi5ltT1kCTDqtJV14EQL9bCeFa	2025-11-18 12:23:52.696432+01	2025-11-18 12:23:52.696432+01	\N
546	supervisor1	19	gfxJyOKe4pHGjLBBvz3KkSUjvN6DYfcq	2025-11-18 12:26:47.133071+01	2025-11-18 12:26:47.133071+01	\N
547	supervisor1	19	MthfQgH1IjC54JpKTlu2DIiJuDgzrk8O	2025-11-18 13:39:59.970267+01	2025-11-18 13:39:59.970267+01	\N
548	supervisor1	19	GbJbsE9Z98wxJdwc1ABJchupUApR0Oin	2025-11-18 15:48:52.941413+01	2025-11-18 15:48:52.941413+01	\N
549	supervisor1	19	5DubSI3a4CEB3Z7q0LyWLAu3z8ACGjiB	2025-11-19 09:19:28.299309+01	2025-11-19 09:19:28.299309+01	\N
550	supervisor1	19	f3PjKgkpcX4pp5TdtzQAXXb13yKZnGME	2025-11-20 09:34:22.938021+01	2025-11-20 09:34:22.938021+01	\N
551	supervisor1	19	BIw19K2tL6c361ivO3CXWWsPa2qwC6lZ	2025-11-20 16:35:01.244933+01	2025-11-20 16:35:01.244933+01	\N
552	supervisor1	19	1WG0tKIklnMZhiKu9NKaHncMZCeDJs97	2025-11-20 17:59:40.660544+01	2025-11-20 17:59:40.660544+01	\N
553	supervisor1	19	xKAAAxzouqGGHZUtLPVuhPV1401GKJqt	2025-11-21 09:05:32.705709+01	2025-11-21 09:05:32.705709+01	\N
554	supervisor1	19	OqJwWVYzkZR0hgBoADcMKW9qbTVrH1Rn	2025-11-21 09:11:09.828489+01	2025-11-21 09:11:09.828489+01	\N
555	supervisor1	19	WecgAlT8p0Q8ODW9f1KJR89DKDxEsEOm	2025-11-21 18:31:31.07684+01	2025-11-21 18:31:31.07684+01	\N
556	supervisor1	19	pG6B7rN7aQbmMNXeQxkuczVuWCZClj2s	2025-11-21 18:42:04.210303+01	2025-11-21 18:42:04.210303+01	\N
557	supervisor1	19	B4oyBtBXzOdhqc4X7bX7wrvWjA0NWXyP	2025-11-22 09:16:55.156777+01	2025-11-22 09:16:55.156777+01	\N
558	supervisor1	19	F9yKtMYw85LQPIMWAqN4fSeKSTleQf7V	2025-11-22 17:47:16.328637+01	2025-11-22 17:47:16.328637+01	\N
559	supervisor1	19	RvBYOBNSbpzGAdnBlyJ2vcYlQ8Z6Nmo4	2025-11-23 18:21:16.106106+01	2025-11-23 18:21:16.106106+01	\N
560	supervisor1	19	q9A1buW3X1U5vL5HDonncB3EkHag6qUE	2025-11-24 17:15:52.555852+01	2025-11-24 17:15:52.555852+01	\N
561	supervisor1	19	7pNxeFrqJvmjUTBC3RW0kbvvRU0zD7aE	2025-11-25 09:23:01.210822+01	2025-11-25 09:23:01.210822+01	\N
562	supervisor1	19	vVKJNd5rE0gq3fPJ6dQWBwEhOdGphqZG	2025-11-26 12:03:43.034433+01	2025-11-26 12:03:43.034433+01	\N
563	supervisor1	19	aII62aaGxbic0q0yOTUztjmhqkB862MR	2025-11-27 18:42:28.537341+01	2025-11-27 18:42:28.537341+01	\N
564	supervisor1	19	blM6EjMIur3IhBhSQPbN1d9pzAEXtKaY	2025-11-28 12:06:55.220231+01	2025-11-28 12:06:55.220231+01	\N
596	supervisor1	19	w1M4CqI5XWNpzQokk0DCesylkqXsIGgR	2025-12-13 12:06:17.429212+01	2025-12-13 12:17:34.535036+01	677
565	admin1	17	UBYJMBQBwRjBtkxrlbrBmBPj0vd0VJHB	2025-11-29 10:01:35.95156+01	2025-11-29 10:01:40.587089+01	5
566	supervisor1	19	3K9etVbfJ9cPobqcTNbiK1CJzwwdS79x	2025-11-29 10:01:46.004884+01	2025-11-29 10:01:46.004884+01	\N
567	supervisor1	19	NaVALckTv3SlgKHpOeDLUaotFH8fvTXf	2025-11-30 10:08:00.430136+01	2025-11-30 10:08:00.430136+01	\N
597	editor1	3	8MA9k27xbQqlsJgD0rtI6Y4FB3wEuLfR	2025-12-13 12:17:41.421756+01	2025-12-13 12:17:41.421756+01	\N
568	supervisor1	19	dr2pgL4P71FxlbQ7OgYCv4L4XuAFu9K1	2025-12-01 09:43:06.082067+01	2025-12-01 17:53:49.143436+01	29443
569	admin1	17	j6YipsJJLe99HIzAK6zvePY7m2wGkVm1	2025-12-01 17:53:54.480037+01	2025-12-01 17:53:54.480037+01	\N
598	supervisor1	19	ZGUViSfMP0RNEPpJNAthB2ibqHx5ixtG	2025-12-13 13:52:56.972096+01	2025-12-13 13:52:56.972096+01	\N
570	admin1	17	7DOXTZFGuUg6E9v69j1v9J1NdU1ib6hc	2025-12-02 09:28:41.662624+01	2025-12-02 15:11:08.933328+01	20547
599	supervisor1	19	aeyC12Y7xG8kjZxPGDEMVIA2pNQdkSLL	2025-12-14 11:03:23.281142+01	2025-12-14 11:03:23.281142+01	\N
571	admin1	17	KUJkz3G2MJSH8qFf8MGLTyvuf91XVpRw	2025-12-02 15:11:21.970252+01	2025-12-02 15:11:37.63245+01	16
600	supervisor1	19	0zRI8TAUWXbT9zxLw9XPIAwafSeT6sKn	2025-12-15 08:17:44.851382+01	2025-12-15 08:17:44.851382+01	\N
572	admin1	17	Q6gsDPHaHq6fX3O58KFVCDrYQAvIOyh5	2025-12-02 15:11:49.652345+01	2025-12-02 15:12:09.116895+01	19
573	supervisor1	19	ifXlWHgS4SamJXMPs8FX6EFVvFZn6BWA	2025-12-02 15:12:14.221147+01	2025-12-02 15:12:14.221147+01	\N
601	supervisor1	19	n2AGRyE7vi9rNXCumUKrvttHdZbDrVZx	2025-12-16 09:41:41.439907+01	2025-12-16 09:41:41.439907+01	\N
574	admin1	17	czVSk8BREB4CcfQjyBnr3zY3gZZwvfF4	2025-12-03 09:21:33.229832+01	2025-12-03 09:35:02.830224+01	810
575	supervisor1	19	ixDVI7xo6oZheFxZiEukevQopLnj8O7y	2025-12-03 09:35:09.561111+01	2025-12-03 09:35:09.561111+01	\N
576	supervisor1	19	RTcuB8uEOYZQcTubGWikbycWHhxhMCSJ	2025-12-04 10:18:52.383407+01	2025-12-04 10:18:52.383407+01	\N
577	supervisor1	19	miuYU5rDUNya9RFD9tEgRoGD7kaxPVQ3	2025-12-05 09:45:52.248907+01	2025-12-05 09:45:52.248907+01	\N
578	supervisor1	19	CAyxrvrg7n6JkwwLFrau9I5E1wYc9Msv	2025-12-06 10:20:03.265648+01	2025-12-06 10:20:03.265648+01	\N
579	supervisor1	19	PP8eeAvoclw0VDjO9cR3CCgfketNV6PX	2025-12-06 15:25:22.017026+01	2025-12-06 15:25:22.017026+01	\N
580	supervisor1	19	KYna0CXoGvuqQobpBFml2Of0nTg9Htgu	2025-12-06 19:36:30.598994+01	2025-12-06 19:36:30.598994+01	\N
581	supervisor1	19	iRBdOLlvaz9A3nuC2a4QxNdhwEuihium	2025-12-07 10:11:57.577816+01	2025-12-07 10:11:57.577816+01	\N
582	supervisor1	19	AIxzEvzUHCDe7Ylc8DQUvNuxX6nTm7fn	2025-12-07 16:18:15.176064+01	2025-12-07 16:18:15.176064+01	\N
602	supervisor1	19	Af7Oog6L1IDACFwJeifw9gZWm6Im93ab	2025-12-16 17:17:17.773563+01	2025-12-16 17:17:17.773563+01	\N
583	admin1	17	I1cCIShdckSZU0rSiMaenfLPGlYMtdRl	2025-12-08 17:12:14.577753+01	2025-12-08 17:12:26.68412+01	12
584	supervisor1	19	4NDbw0WdJTnUSZvrSWjhmQ1yhy3dxgK3	2025-12-08 17:12:37.235745+01	2025-12-08 17:12:37.235745+01	\N
585	supervisor1	19	c2F0iN23T0HrhYmEXrD7uusVXBc1I7w4	2025-12-08 19:06:37.68899+01	2025-12-08 19:06:37.68899+01	\N
586	supervisor1	19	h97KVgu1GV6pecZk6uc1Qy8VxEKvE01m	2025-12-09 12:18:39.768446+01	2025-12-09 12:18:39.768446+01	\N
587	supervisor1	19	qHAQNdtGSxBLRPXYNh9JeBH8PS2KI5Qy	2025-12-09 18:37:01.076919+01	2025-12-09 18:37:01.076919+01	\N
603	supervisor1	19	DgMnxSqJTwIKhlmi0rtueD1rVUhGS8fj	2025-12-16 17:38:40.354594+01	2025-12-16 17:38:40.354594+01	\N
588	supervisor1	19	d2tNc16JvPgi3CwFFyb4BpNa8Jar7HhC	2025-12-10 09:03:44.956744+01	2025-12-10 14:21:16.099335+01	19051
589	admin1	17	0FcH8uK4Nm8ESU4OLDuBXM2hoQ3TYadQ	2025-12-10 14:21:21.553788+01	2025-12-10 14:21:21.553788+01	\N
590	supervisor1	19	I9jTxXD30KiB5yC38ajh56KOYtaPQBHP	2025-12-10 16:58:00.885016+01	2025-12-10 16:58:00.885016+01	\N
604	supervisor1	19	7dKhK3tangSUuBN6rZfF6u8UfdfisSjJ	2025-12-16 19:36:24.740147+01	2025-12-16 19:36:24.740147+01	\N
591	supervisor1	19	F7U0vzvox7XPXZAmoKsphyV2cSi9PWtv	2025-12-11 09:24:34.791852+01	2025-12-11 14:40:25.501772+01	18951
605	supervisor1	19	qliNu41wxNariR4ulzhglUlNv8dGLWF7	2025-12-17 09:27:01.630461+01	2025-12-17 09:27:01.630461+01	\N
592	editor1	3	2b0iejxbKKVfZHRJ3e9Xem9cA4H8IcTw	2025-12-11 14:40:31.637049+01	2025-12-11 16:27:34.263231+01	6423
593	supervisor1	19	pnwlHR6Bkh1akkHzEUilct9sHgFLuxib	2025-12-11 16:27:42.035048+01	2025-12-11 16:27:42.035048+01	\N
594	supervisor1	19	SqdCwnr5WLFVr0nRDEIDZ0ssZPjZe5Im	2025-12-12 08:45:16.775233+01	2025-12-12 08:45:16.775233+01	\N
595	supervisor1	19	1DLtYRurS4dx7LRYiONtR7lQ1rRA3ddL	2025-12-13 08:43:01.965996+01	2025-12-13 08:43:01.965996+01	\N
615	supervisor1	19	SWu13g1VNL6XZV6y4T9upTdeIVbobeqa	2025-12-21 18:16:02.473847+01	2025-12-21 18:16:02.473847+01	\N
606	supervisor1	19	efCSVg9h0JTMJgBvAFhgFwfuVGtZXUjd	2025-12-18 10:16:50.150561+01	2025-12-18 10:16:50.150561+01	\N
607	supervisor1	19	4c5UwQR6TUOCUgOQ7mMP6v66UBfDfcbd	2025-12-19 08:51:50.411153+01	2025-12-19 08:51:50.411153+01	\N
608	supervisor1	19	8OF7rFpKor5VxK6zFr1O1Xu9NN2Sjrb4	2025-12-19 12:29:35.193561+01	2025-12-19 12:29:35.193561+01	\N
609	supervisor1	19	OFDmcdqhSNTwqQKnLge6eRwlpkvNEGh3	2025-12-21 09:14:39.401593+01	2025-12-21 09:14:39.401593+01	\N
616	supervisor1	19	sy1ZS2BkAgNOx062ljmn1jfslEAUIObH	2025-12-21 18:17:14.383552+01	2025-12-21 18:17:14.383552+01	\N
610	supervisor1	19	lhYJkiU0vX1ifxcZZ6SKkBGqcRAv1dVZ	2025-12-21 10:12:23.678844+01	2025-12-21 10:14:25.600758+01	122
611	supervisor1	19	T9LWu5PWrL8f6gpDBrHxbYK8NOFdXekA	2025-12-21 10:15:58.483779+01	2025-12-21 10:15:58.483779+01	\N
612	supervisor1	19	ia5PEhpxDMMd0FDKWDaau3odge3LXTR8	2025-12-21 18:12:41.806603+01	2025-12-21 18:12:41.806603+01	\N
613	supervisor1	19	GuUTM06gqJhOfsfTH887alDuddqBD65F	2025-12-21 18:14:09.545515+01	2025-12-21 18:14:09.545515+01	\N
614	supervisor1	19	sSPudTuCTC2bVIgCwIed385Ny2EAe7YR	2025-12-21 18:14:58.21682+01	2025-12-21 18:14:58.21682+01	\N
617	supervisor1	19	ILeWZGmPwKvCHFCBoBiEanS5jcVB5WXt	2025-12-21 18:21:41.292698+01	2025-12-21 18:21:41.292698+01	\N
618	supervisor1	19	NW9JOiXCZhpbG1mzJt4pY4IlzV5PRKCQ	2025-12-21 18:23:24.729435+01	2025-12-21 18:23:24.729435+01	\N
619	supervisor1	19	2qmgmoXE92ShAL87RWa5ezBDcy2F59Uq	2025-12-22 15:20:55.452453+01	2025-12-22 15:20:55.452453+01	\N
621	supervisor1	19	8sHYq1cjYS08tvTM952uO5iHSPsGeWr7	2025-12-22 15:24:23.52491+01	2025-12-22 15:24:23.52491+01	\N
622	supervisor1	19	wTFbnLSvqi3BcEeAe7i2Q09yttGClTcf	2025-12-22 15:25:12.653904+01	2025-12-22 15:25:12.653904+01	\N
620	supervisor1	19	tnyYtQfYBszUtIV0lVk48KZLgunBSITj	2025-12-22 15:22:03.321305+01	2025-12-22 15:29:45.59691+01	462
623	admin1	17	oTVldBgULzAUeBLyYs9aWd0CC6Vfi4No	2025-12-22 15:29:50.482539+01	2025-12-22 15:30:25.843936+01	35
624	supervisor1	19	oQ5JinTDavcLiBqnP9M6XMOucTYeOiVd	2025-12-22 15:30:34.249663+01	2025-12-22 15:30:34.249663+01	\N
625	supervisor1	19	Ss5lht9IZPkaUMoqFHunbzijKa4bXfcj	2025-12-22 16:41:23.775538+01	2025-12-22 16:41:23.775538+01	\N
626	supervisor1	19	vc5pouXUfqOpxwMXQCfmBZHT8zv5oYXo	2025-12-22 17:06:40.713671+01	2025-12-22 17:06:40.713671+01	\N
627	supervisor1	19	jbbToG2KOKKZF7u594dniIdX3Sqltg5E	2025-12-22 17:10:23.291753+01	2025-12-22 17:10:23.291753+01	\N
628	supervisor1	19	842dXQNO22fmcaim2YJZxkpm7v4m0fYc	2025-12-22 17:10:34.803904+01	2025-12-22 17:10:34.803904+01	\N
629	supervisor1	19	YFDuWctp6Q3D3nvufDYBTqoMmbFD7tAZ	2025-12-22 17:14:46.51728+01	2025-12-22 17:14:46.51728+01	\N
630	supervisor1	19	TEidV4S9IDvkj0w77DkaoW5Q1iBrgSIi	2025-12-22 17:15:21.460264+01	2025-12-22 17:15:21.460264+01	\N
631	supervisor1	19	dyekeu6xg0URn2NMO3mgxZXlERkS18nB	2025-12-22 17:19:36.257128+01	2025-12-22 17:21:57.187842+01	141
632	supervisor1	19	dDq4mzG2x0iAQJHiprWOLt6nL8jchprB	2025-12-22 17:22:09.50283+01	2025-12-22 17:22:09.50283+01	\N
633	supervisor1	19	u9Qk5lroQvb4JWTdiYktKB6yZ93GdqsN	2025-12-22 17:22:56.014494+01	2025-12-22 17:22:56.014494+01	\N
634	supervisor1	19	ECLFBPaSBUXbbv4rAuqIzCBT8LzMFFo3	2025-12-22 17:25:20.561045+01	2025-12-22 17:25:20.561045+01	\N
635	supervisor1	19	0EPLqw8amrNThRrKPqXpTKOVFX9KyPPs	2025-12-22 17:30:10.156484+01	2025-12-22 17:30:10.156484+01	\N
636	supervisor1	19	p3ansJjNWC05oVa4Tq6fVfscWwOpLUpA	2025-12-24 14:04:54.782222+01	2025-12-24 14:04:54.782222+01	\N
637	supervisor1	19	Ij1KHSCXWeZDQkwoB6HP98EcnuQlUaKm	2025-12-24 14:51:50.113039+01	2025-12-24 14:51:50.113039+01	\N
638	supervisor1	19	x3DPbJX68SgvK85GnUjcs6IyhmFvlKzU	2025-12-24 14:53:43.829267+01	2025-12-24 14:53:43.829267+01	\N
639	supervisor1	19	EWDg1VY3antOpDFWoiol4WGNDrHSBHEq	2025-12-25 11:56:00.852569+01	2025-12-25 11:56:00.852569+01	\N
640	admin1	17	Wpj65kxRA3681p3U1GnUsHYq9qHpKIrM	2025-12-28 09:58:15.719613+01	2025-12-28 09:58:15.719613+01	\N
641	supervisor1	19	ikxHiUIVFHCe8K2lSskseB4RcDoEIku6	2025-12-28 10:14:04.448381+01	2025-12-28 10:14:04.448381+01	\N
642	supervisor1	19	7K0F1MciEF6EhYVMD9iAJCvp1Kzq0AM0	2025-12-30 16:07:10.677318+01	2025-12-30 16:07:10.677318+01	\N
\.


--
-- TOC entry 4143 (class 0 OID 21312)
-- Dependencies: 256
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.users (user_id, username, password_hash, user_gender, user_first_name, user_last_name, user_email, user_phone, user_short_cv, user_role, user_lang, user_level, user_group, rgpd_validation, user_selected, user_status, created_at, updated_at) FROM stdin;
17	admin1	$argon2id$v=19$m=19456,t=2,p=1$TP1fnmadHlqxzgoOFVGeBQ$p3SGpsCA5AmVenvXHuWGBsX/LkGCqY355U0hKwx4s70	M	Matteo	Palotta	admin1@coopcoop.net	+(33) 7 00 00 00 00	admin !	admin	FR	L0	G0	t	f	active	2024-11-16 18:21:53+01	2025-07-12 14:54:59.82509+02
28	editor2	$argon2id$v=19$m=19456,t=2,p=1$hgjczk+DYD+eS9JblZqpgw$ZAXVTuSfNDioBEb/oYZ0rVGg3loB/EHNJDOHyi8LWRQ	M	Baldassare 	Galuppi 	editor2@coopcoop.net	+33 6000000000	editeur	editor	FR	L0	G0	t	f	active	2025-01-23 10:24:24+01	2025-06-09 15:08:39.694117+02
21	editor3	$argon2id$v=19$m=19456,t=2,p=1$+TKZv9G8Ih9ghLLh71Fc+w$1cUETzv+Vc8Yx2NvXFZwzFB+vcRObPAmytWOvsyaS90	M	editor3	editor3	editor3@coopcoop.net	0000000000	editor3	editor	FR	L0	G0	t	f	active	2025-01-10 14:21:15+01	2025-06-09 15:10:08.244087+02
19	supervisor1	$argon2id$v=19$m=19456,t=2,p=1$gu8l9YU4LY3J/rxTSXBP5A$8dbf+K4OwcuhVzGMtUZgVewvmuLqiO80e5BI627S/pE	M	Domenico 	Sarro	supervisor1@coopcoop.net	+(33) 7 00 00 00 00	supeviseur	supervisor	FR	L0	G0	t	f	active	2024-11-18 08:11:41+01	2025-06-09 12:00:55.993537+02
5	viewer1	$argon2id$v=19$m=19456,t=2,p=1$3auU9vUPsbyJ2rTuy5CdSA$Guc24FemWm7Un9q8BqzKh55mIU5E8zst7+Nr6P2Ra4w	M	John	Doe	viewer1@coopcoop.net	+(33)70000000	simple amateur\r\n	viewer		L0	G1	t	f	active	2024-10-18 11:54:22+02	2025-06-09 15:13:14.362555+02
22	viewer2	$argon2id$v=19$m=19456,t=2,p=1$Wb5kZkDjz6MRRjCIUurGDw$zeIWZEW8q64Avt+C3C82IxaaCCH2kDrXiM2ZNQUYPwQ	M	Michael 	Praetorius 	viewer2@coopcoop.net	+33 600000000	compositeur de musique baroque	viewer	FR	L0	G0	t	f	active	2025-01-22 17:53:00+01	2025-06-09 15:14:39.389082+02
25	supervisor3	$argon2id$v=19$m=19456,t=2,p=1$yHZTkaqXC1hVSFQhW++3Fw$m5npc2jzCkWDJwx7a7Y3mhchcKT8ALhyTZvWzzdhTyg	M	Cristofaro	Caresana 	supervisor3@coopcoop.net	+33 6000000000	compositeur musique baroque	supervisor	FR	L0	G0	t	f	active	2025-01-23 10:13:47+01	2025-06-09 15:05:03.824501+02
26	admin2	$argon2id$v=19$m=19456,t=2,p=1$qCMa+6cOeo4f7PNbaBbrFg$OoG8RaoWCQ+zMrLfHYuhI+enrfwj7gqgNKTFVPIc5Zc	M	Vandini	Antonio	admin2@coopcoop.net	+33 6000000000	FALSEuvel admin	admin	FR	L0	G0	t	f	active	2025-01-23 10:20:37+01	2025-06-09 12:27:20.95411+02
24	supervisor2	$argon2id$v=19$m=19456,t=2,p=1$In5zS5rtPRtS8Q8MjAk6Jw$+zx4vfWvLIGrgu2tMkVJ91sj+4UkRMngbxyBnVKB2eU	M	Isabella	Leonarda 	supervisor2@coopcoop.net	+33 6	compositrice musique baroque	supervisor	FR	L0	G0	t	f	active	2025-01-23 10:10:06+01	2025-06-09 15:03:24.164454+02
23	viewer3	$argon2id$v=19$m=19456,t=2,p=1$D3S0Y7Il0iPkmbDj2JTAbQ$3WZPaKIH395TTno37yXqALEfxMM2ReMCmf/cHMTnMl0	F	Johann 	Pachelbel	viewer3@coopcoop.net	+33 600000000	un autre compositeur allemand	viewer	FR	L0	G0	t	f	active	2025-01-22 17:55:12+01	2025-06-09 15:16:26.918924+02
27	admin3	$argon2id$v=19$m=19456,t=2,p=1$wH/NqeX3Bw8h39mszzfQOw$SWdFWBdJV2lMGUPMiOfDs+OeYJo6KjmiBwOpO6UV12s	F	Maria Margherita	 Grimani 	admin3@coopcoop.net	+33 6000000000	administratice	admin	FR	L0	G0	t	f	archived	2025-01-23 10:22:20+01	2025-06-09 12:28:29.020901+02
3	editor1	$argon2id$v=19$m=19456,t=2,p=1$oYnl6FIImiM7CwjHe4IgWg$vdLp4eu1BfTGILMNkIH+otuGfy3PDk38PbCai8E4ScY	F	Barbara 	Strozzi 	editor1@coopcoop.net		éditrice\r\n	editor		L0	G1	t	f	active	2024-10-18 08:20:51+02	2025-06-13 12:59:46.412555+02
29	\N	\N	\N	\N	\N	\N	\N	\N	\N	FR	L0	G0	t	\N	active	2025-12-30 15:36:57.282953+01	2025-12-30 15:36:57.282953+01
\.


--
-- TOC entry 4139 (class 0 OID 21277)
-- Dependencies: 252
-- Data for Name: workdocs; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.workdocs (workdoc_id, workspace_id, message_id, workdoc_url, workdoc_title, workdoc_summary, workdoc_author, workdoc_category, workdoc_format, workdoc_status, workdoc_version, workdoc_type, workdoc_lang, created_at, updated_at) FROM stdin;
72	4	342	/x_workspace_docs/2025-12-01_12h47m39s_aBIqZPmw.pdf	\N	\N	\N	\N	\N	active	0	\N	\N	2025-12-01 13:47:39.071679+01	2025-12-01 13:47:39.071679+01
\.


--
-- TOC entry 4159 (class 0 OID 21414)
-- Dependencies: 272
-- Data for Name: workdocs_cloud; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.workdocs_cloud (workdoc_cloud_id, workspace_id, message_id, workdoc_cloud_url, workdoc_cloud_title, workdoc_cloud_summary, workdoc_cloud_author, workdoc_cloud_category, workdoc_cloud_format, workdoc_cloud_status, workdoc_cloud_type, workdoc_cloud_lang, created_at, updated_at) FROM stdin;
59	4	338		\N	\N	\N	\N	\N	active	\N	\N	2025-12-01 11:37:19.8562+01	2025-12-01 11:37:19.8562+01
60	4	339		\N	\N	\N	\N	\N	active	\N	\N	2025-12-01 11:38:36.828167+01	2025-12-01 11:38:36.828167+01
61	4	343	https://dbeaver.io/download/?start&os=linux&arch=x86_64&dist=deb	\N	\N	\N	\N	\N	active	\N	\N	2025-12-01 13:47:58.559202+01	2025-12-01 13:47:58.559202+01
\.


--
-- TOC entry 4157 (class 0 OID 21403)
-- Dependencies: 270
-- Data for Name: workmeeting_participants; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.workmeeting_participants (workmeeting_participant_id, workmeeting_id, workspace_id, user_id, workmeeting_participant_role, workmeeting_participant_status, created_at, updated_at) FROM stdin;
8	\N	4	19	coordinator	active	2025-06-02 14:15:13.937992+02	2025-06-02 14:15:13.937992+02
21	10	6	19	\N	\N	2025-06-04 16:18:15.673822+02	2025-06-04 16:18:15.673822+02
22	11	4	3	coordinator	active	2025-06-09 16:28:38.877624+02	2025-06-09 16:28:38.877624+02
23	12	4	19	coordinator	active	2025-11-22 16:41:53.957928+01	2025-11-22 16:41:53.957928+01
\.


--
-- TOC entry 4165 (class 0 OID 21486)
-- Dependencies: 278
-- Data for Name: workmeetings; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.workmeetings (workmeeting_id, workspace_id, workmeeting_title, workmeeting_agenda, workmeeting_visio, workmeeting_visio_url, workmeeting_visio_code, workmeeting_date, workmeeting_type, space_id, workmeeting_participants_nb, workmeeting_alert, workmeeting_status, created_at, updated_at, workmeeting_hour_start, workmeeting_hour_end, workmeeting_duration) FROM stdin;
7	4	test	sqsq\r\n	visio			2025-06-29	concert	\N	\N	alert_end	active	2025-06-02 14:22:47.158984+02	2025-06-02 14:37:48.951499+02	00:00:00	00:15:00	00:15:00
9	6	test		présentiel			2025-06-27	conference	\N	\N	alert_end	active	2025-06-04 16:10:05.73687+02	2025-06-04 16:10:28.732921+02	02:45:00	02:45:00	02:15:00
10	6	cxcxxccx		présentiel			2025-07-03	concert	\N	\N	alert_end	active	2025-06-04 16:11:38.953371+02	2025-06-04 16:18:15.702063+02	\N	\N	\N
11	4	test	sqqs\r\n	présentiel			2025-06-28	concert	\N	\N	alert_end	active	2025-06-09 16:28:38.757723+02	2025-06-09 16:28:38.934876+02	02:45:00	03:00:00	03:00:00
12	4	test		présentiel			2025-11-29		\N	\N	alert_end	active	2025-11-22 16:41:53.807559+01	2025-11-22 16:41:54.014196+01	02:15:00	\N	\N
13	4	dsds		présentiel			2025-12-27	concert	\N	\N	alert_end	active	2025-12-13 12:30:49.994012+01	2025-12-13 12:31:07.268265+01	16:30:00	\N	\N
\.


--
-- TOC entry 4167 (class 0 OID 21498)
-- Dependencies: 280
-- Data for Name: workspace_participants; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.workspace_participants (workspace_participant_id, workspace_id, user_id, workspace_participant_role, workspace_partcipant_status, created_at, updated_at) FROM stdin;
31	16	3	coordinator	\N	2025-06-09 16:28:09.132625+02	2025-06-09 16:28:09.132625+02
32	4	3	participant	\N	2025-06-09 16:28:12.629923+02	2025-06-09 16:28:12.629923+02
30	4	19	coordinator	\N	2025-06-04 16:21:54.023107+02	2025-06-04 16:21:54.023107+02
\.


--
-- TOC entry 4135 (class 0 OID 21246)
-- Dependencies: 248
-- Data for Name: workspaces; Type: TABLE DATA; Schema: public; Owner: sqlpage
--

COPY public.workspaces (workspace_id, workspace_coordinator_id, workspace_title, workspace_summary, workspace_category, workspace_status, workspace_participants_nb, created_at, updated_at) FROM stdin;
13	3	nouvau group	ez	ez	archived	0	2025-01-09 14:40:53+01	2025-01-10 11:12:17+01
16	3	test		wks_project	active	1	2025-06-09 16:28:09.033236+02	2025-06-13 18:15:23.725947+02
4	3	Workspace 01	test\r\n	project_team	active	2	2025-01-05 18:07:14+01	2025-11-22 16:35:31.854775+01
15	19	workspace67	test\r\n	wks_website	active	0	2025-06-04 15:42:52.058892+02	2025-12-01 13:48:43.993598+01
6	3	Workspace 02	dsds	dssd	active	0	2025-01-06 10:00:47+01	2025-12-01 13:48:46.250712+01
\.


--
-- TOC entry 4286 (class 0 OID 0)
-- Dependencies: 233
-- Name: choices_categories_choice_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.choices_categories_choice_category_id_seq', 58, true);


--
-- TOC entry 4287 (class 0 OID 0)
-- Dependencies: 235
-- Name: choices_items_choice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.choices_items_choice_id_seq', 404, true);


--
-- TOC entry 4288 (class 0 OID 0)
-- Dependencies: 241
-- Name: event_participants_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.event_participants_participant_id_seq', 10, true);


--
-- TOC entry 4289 (class 0 OID 0)
-- Dependencies: 239
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.events_event_id_seq', 4, true);


--
-- TOC entry 4290 (class 0 OID 0)
-- Dependencies: 237
-- Name: faq_contacts_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.faq_contacts_contact_id_seq', 26, true);


--
-- TOC entry 4291 (class 0 OID 0)
-- Dependencies: 281
-- Name: faq_questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.faq_questions_question_id_seq', 13, true);


--
-- TOC entry 4292 (class 0 OID 0)
-- Dependencies: 245
-- Name: forum_messages_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.forum_messages_message_id_seq', 348, true);


--
-- TOC entry 4293 (class 0 OID 0)
-- Dependencies: 243
-- Name: forum_topics_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.forum_topics_topic_id_seq', 125, true);


--
-- TOC entry 4294 (class 0 OID 0)
-- Dependencies: 273
-- Name: info_sections_section_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.info_sections_section_id_seq', 70, true);


--
-- TOC entry 4295 (class 0 OID 0)
-- Dependencies: 217
-- Name: members_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.members_member_id_seq', 32, true);


--
-- TOC entry 4296 (class 0 OID 0)
-- Dependencies: 249
-- Name: news_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.news_news_id_seq', 15, true);


--
-- TOC entry 4297 (class 0 OID 0)
-- Dependencies: 221
-- Name: orga_dept_orga_dept_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.orga_dept_orga_dept_id_seq', 6, true);


--
-- TOC entry 4298 (class 0 OID 0)
-- Dependencies: 285
-- Name: orga_docs_orga_doc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.orga_docs_orga_doc_id_seq', 17, true);


--
-- TOC entry 4299 (class 0 OID 0)
-- Dependencies: 219
-- Name: orga_orga_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.orga_orga_id_seq', 5, true);


--
-- TOC entry 4300 (class 0 OID 0)
-- Dependencies: 253
-- Name: orga_partners_orga_partner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.orga_partners_orga_partner_id_seq', 12, true);


--
-- TOC entry 4301 (class 0 OID 0)
-- Dependencies: 223
-- Name: place_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.place_place_id_seq', 3, true);


--
-- TOC entry 4302 (class 0 OID 0)
-- Dependencies: 283
-- Name: place_spaces_pictures_space_picture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.place_spaces_pictures_space_picture_id_seq', 2, true);


--
-- TOC entry 4303 (class 0 OID 0)
-- Dependencies: 229
-- Name: place_spaces_space_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.place_spaces_space_id_seq', 3, true);


--
-- TOC entry 4304 (class 0 OID 0)
-- Dependencies: 261
-- Name: prm1_doc_prm1_doc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm1_doc_prm1_doc_id_seq', 9, true);


--
-- TOC entry 4305 (class 0 OID 0)
-- Dependencies: 259
-- Name: prm1_prm1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm1_prm1_id_seq', 11, true);


--
-- TOC entry 4306 (class 0 OID 0)
-- Dependencies: 257
-- Name: prm2_prm2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm2_prm2_id_seq', 6, true);


--
-- TOC entry 4307 (class 0 OID 0)
-- Dependencies: 325
-- Name: prm2_sub_docs_prm2_sub_doc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm2_sub_docs_prm2_sub_doc_id_seq', 5, true);


--
-- TOC entry 4308 (class 0 OID 0)
-- Dependencies: 327
-- Name: prm2_sub_employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm2_sub_employees_employee_id_seq', 10, true);


--
-- TOC entry 4309 (class 0 OID 0)
-- Dependencies: 275
-- Name: prm2_sub_prm2_sub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm2_sub_prm2_sub_id_seq', 11, true);


--
-- TOC entry 4310 (class 0 OID 0)
-- Dependencies: 329
-- Name: prm3_docs_prm3_doc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm3_docs_prm3_doc_id_seq', 4, true);


--
-- TOC entry 4311 (class 0 OID 0)
-- Dependencies: 265
-- Name: prm3_participants_prm3_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm3_participants_prm3_participant_id_seq', 19, true);


--
-- TOC entry 4312 (class 0 OID 0)
-- Dependencies: 263
-- Name: prm3_prm3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.prm3_prm3_id_seq', 4, true);


--
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 225
-- Name: process_process_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.process_process_id_seq', 6, true);


--
-- TOC entry 4314 (class 0 OID 0)
-- Dependencies: 227
-- Name: process_steps_process_step_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.process_steps_process_step_id_seq', 17, true);


--
-- TOC entry 4315 (class 0 OID 0)
-- Dependencies: 297
-- Name: project_building_building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_building_building_id_seq', 5, true);


--
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 301
-- Name: project_building_rooms_pictures_room_picture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_building_rooms_pictures_room_picture_id_seq', 75, true);


--
-- TOC entry 4317 (class 0 OID 0)
-- Dependencies: 299
-- Name: project_building_rooms_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_building_rooms_room_id_seq', 8, true);


--
-- TOC entry 4318 (class 0 OID 0)
-- Dependencies: 317
-- Name: project_docs_project_doc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_docs_project_doc_id_seq', 85, true);


--
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 333
-- Name: project_docs_project_forum_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_docs_project_forum_message_id_seq', 6, true);


--
-- TOC entry 4320 (class 0 OID 0)
-- Dependencies: 295
-- Name: project_forum_messages_project_forum_message_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_forum_messages_project_forum_message_id_seq', 78, true);


--
-- TOC entry 4321 (class 0 OID 0)
-- Dependencies: 293
-- Name: project_forum_topics_project_forum_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_forum_topics_project_forum_topic_id_seq', 47, true);


--
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 291
-- Name: project_meeting_participants_project_meeting_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_meeting_participants_project_meeting_participant_id_seq', 30, true);


--
-- TOC entry 4323 (class 0 OID 0)
-- Dependencies: 289
-- Name: project_meeting_places_project_meeting_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_meeting_places_project_meeting_place_id_seq', 3, true);


--
-- TOC entry 4324 (class 0 OID 0)
-- Dependencies: 319
-- Name: project_meeting_project_meeting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_meeting_project_meeting_id_seq', 7, true);


--
-- TOC entry 4325 (class 0 OID 0)
-- Dependencies: 303
-- Name: project_products_categories_product_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_products_categories_product_category_id_seq', 1, true);


--
-- TOC entry 4326 (class 0 OID 0)
-- Dependencies: 305
-- Name: project_products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_products_product_id_seq', 7, true);


--
-- TOC entry 4327 (class 0 OID 0)
-- Dependencies: 287
-- Name: project_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_project_id_seq', 20, true);


--
-- TOC entry 4328 (class 0 OID 0)
-- Dependencies: 331
-- Name: project_workpackage_expenses_expense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_workpackage_expenses_expense_id_seq', 16, true);


--
-- TOC entry 4329 (class 0 OID 0)
-- Dependencies: 311
-- Name: project_workpackage_materials_material_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_workpackage_materials_material_id_seq', 4, true);


--
-- TOC entry 4330 (class 0 OID 0)
-- Dependencies: 313
-- Name: project_workpackage_participants_workpackage_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_workpackage_participants_workpackage_participant_id_seq', 20, true);


--
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 309
-- Name: project_workpackage_waste_waste_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_workpackage_waste_waste_id_seq', 4, true);


--
-- TOC entry 4332 (class 0 OID 0)
-- Dependencies: 307
-- Name: project_workpackage_workpackage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_workpackage_workpackage_id_seq', 26, true);


--
-- TOC entry 4333 (class 0 OID 0)
-- Dependencies: 323
-- Name: project_worksequence_participan_worksequence_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_worksequence_participan_worksequence_participant_id_seq', 19, true);


--
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 321
-- Name: project_worksequence_worksequence_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.project_worksequence_worksequence_id_seq', 10, true);


--
-- TOC entry 4335 (class 0 OID 0)
-- Dependencies: 267
-- Name: regex_regex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.regex_regex_id_seq', 8, true);


--
-- TOC entry 4336 (class 0 OID 0)
-- Dependencies: 231
-- Name: rss_rss_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.rss_rss_id_seq', 7, true);


--
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 315
-- Name: sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.sessions_session_id_seq', 642, true);


--
-- TOC entry 4338 (class 0 OID 0)
-- Dependencies: 255
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.users_user_id_seq', 29, true);


--
-- TOC entry 4339 (class 0 OID 0)
-- Dependencies: 271
-- Name: workdocs_cloud_workdoc_cloud_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.workdocs_cloud_workdoc_cloud_id_seq', 61, true);


--
-- TOC entry 4340 (class 0 OID 0)
-- Dependencies: 251
-- Name: workdocs_workdoc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.workdocs_workdoc_id_seq', 72, true);


--
-- TOC entry 4341 (class 0 OID 0)
-- Dependencies: 269
-- Name: workmeeting_participants_workmeeting_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.workmeeting_participants_workmeeting_participant_id_seq', 25, true);


--
-- TOC entry 4342 (class 0 OID 0)
-- Dependencies: 277
-- Name: workmeetings_workmeeting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.workmeetings_workmeeting_id_seq', 13, true);


--
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 279
-- Name: workspace_participants_workspace_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.workspace_participants_workspace_participant_id_seq', 34, true);


--
-- TOC entry 4344 (class 0 OID 0)
-- Dependencies: 247
-- Name: workspaces_workspace_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqlpage
--

SELECT pg_catalog.setval('public.workspaces_workspace_id_seq', 16, true);


--
-- TOC entry 3824 (class 2606 OID 21143)
-- Name: choices_categories choices_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.choices_categories
    ADD CONSTRAINT choices_categories_pkey PRIMARY KEY (choice_category_id);


--
-- TOC entry 3826 (class 2606 OID 21154)
-- Name: choices_items choices_items_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.choices_items
    ADD CONSTRAINT choices_items_pkey PRIMARY KEY (choice_id);


--
-- TOC entry 3832 (class 2606 OID 21209)
-- Name: event_participants event_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_pkey PRIMARY KEY (participant_id);


--
-- TOC entry 3830 (class 2606 OID 21187)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3828 (class 2606 OID 21172)
-- Name: faq_contacts faq_contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.faq_contacts
    ADD CONSTRAINT faq_contacts_pkey PRIMARY KEY (contact_id);


--
-- TOC entry 3874 (class 2606 OID 21519)
-- Name: faq_questions faq_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.faq_questions
    ADD CONSTRAINT faq_questions_pkey PRIMARY KEY (question_id);


--
-- TOC entry 3836 (class 2606 OID 21239)
-- Name: forum_messages forum_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.forum_messages
    ADD CONSTRAINT forum_messages_pkey PRIMARY KEY (message_id);


--
-- TOC entry 3834 (class 2606 OID 21227)
-- Name: forum_topics forum_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.forum_topics
    ADD CONSTRAINT forum_topics_pkey PRIMARY KEY (topic_id);


--
-- TOC entry 3866 (class 2606 OID 21434)
-- Name: info_sections info_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.info_sections
    ADD CONSTRAINT info_sections_pkey PRIMARY KEY (section_id);


--
-- TOC entry 3805 (class 2606 OID 21039)
-- Name: orga_dept_members members_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_members
    ADD CONSTRAINT members_pkey PRIMARY KEY (member_id);


--
-- TOC entry 3807 (class 2606 OID 22517)
-- Name: orga_dept_members members_unique; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_members
    ADD CONSTRAINT members_unique UNIQUE (member_email);


--
-- TOC entry 3840 (class 2606 OID 21275)
-- Name: news news_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (news_id);


--
-- TOC entry 3812 (class 2606 OID 21062)
-- Name: orga_dept orga_dept_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept
    ADD CONSTRAINT orga_dept_pkey PRIMARY KEY (orga_dept_id);


--
-- TOC entry 3878 (class 2606 OID 21568)
-- Name: orga_dept_docs orga_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_docs
    ADD CONSTRAINT orga_docs_pkey PRIMARY KEY (orga_doc_id);


--
-- TOC entry 3844 (class 2606 OID 21305)
-- Name: orga_dept_partners orga_partners_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_partners
    ADD CONSTRAINT orga_partners_pkey PRIMARY KEY (orga_partner_id);


--
-- TOC entry 3809 (class 2606 OID 21051)
-- Name: orga orga_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga
    ADD CONSTRAINT orga_pkey PRIMARY KEY (orga_id);


--
-- TOC entry 3814 (class 2606 OID 21078)
-- Name: place place_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place
    ADD CONSTRAINT place_pkey PRIMARY KEY (place_id);


--
-- TOC entry 3876 (class 2606 OID 21535)
-- Name: place_spaces_pictures place_spaces_pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place_spaces_pictures
    ADD CONSTRAINT place_spaces_pictures_pkey PRIMARY KEY (space_picture_id);


--
-- TOC entry 3820 (class 2606 OID 21116)
-- Name: place_spaces place_spaces_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place_spaces
    ADD CONSTRAINT place_spaces_pkey PRIMARY KEY (space_id);


--
-- TOC entry 3854 (class 2606 OID 21362)
-- Name: prm1_doc prm1_doc_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm1_doc
    ADD CONSTRAINT prm1_doc_pkey PRIMARY KEY (prm1_doc_id);


--
-- TOC entry 3852 (class 2606 OID 21351)
-- Name: prm1 prm1_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm1
    ADD CONSTRAINT prm1_pkey PRIMARY KEY (prm1_id);


--
-- TOC entry 3850 (class 2606 OID 21339)
-- Name: prm2 prm2_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2
    ADD CONSTRAINT prm2_pkey PRIMARY KEY (prm2_id);


--
-- TOC entry 3920 (class 2606 OID 22256)
-- Name: prm2_sub_docs prm2_sub_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub_docs
    ADD CONSTRAINT prm2_sub_docs_pkey PRIMARY KEY (prm2_sub_doc_id);


--
-- TOC entry 3922 (class 2606 OID 22281)
-- Name: prm2_sub_employees prm2_sub_employees_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub_employees
    ADD CONSTRAINT prm2_sub_employees_pkey PRIMARY KEY (employee_id);


--
-- TOC entry 3868 (class 2606 OID 21445)
-- Name: prm2_sub prm2_sub_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub
    ADD CONSTRAINT prm2_sub_pkey PRIMARY KEY (prm2_sub_id);


--
-- TOC entry 3924 (class 2606 OID 22303)
-- Name: prm3_docs prm3_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm3_docs
    ADD CONSTRAINT prm3_docs_pkey PRIMARY KEY (prm3_doc_id);


--
-- TOC entry 3858 (class 2606 OID 21390)
-- Name: prm3_participants prm3_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm3_participants
    ADD CONSTRAINT prm3_participants_pkey PRIMARY KEY (prm3_participant_id);


--
-- TOC entry 3856 (class 2606 OID 21378)
-- Name: prm3 prm3_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm3
    ADD CONSTRAINT prm3_pkey PRIMARY KEY (prm3_id);


--
-- TOC entry 3816 (class 2606 OID 21089)
-- Name: process process_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.process
    ADD CONSTRAINT process_pkey PRIMARY KEY (process_id);


--
-- TOC entry 3818 (class 2606 OID 21100)
-- Name: process_steps process_steps_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.process_steps
    ADD CONSTRAINT process_steps_pkey PRIMARY KEY (process_step_id);


--
-- TOC entry 3892 (class 2606 OID 21676)
-- Name: project_building project_building_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building
    ADD CONSTRAINT project_building_pkey PRIMARY KEY (building_id);


--
-- TOC entry 3896 (class 2606 OID 21708)
-- Name: project_building_rooms_pictures project_building_rooms_pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building_rooms_pictures
    ADD CONSTRAINT project_building_rooms_pictures_pkey PRIMARY KEY (room_picture_id);


--
-- TOC entry 3894 (class 2606 OID 21692)
-- Name: project_building_rooms project_building_rooms_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building_rooms
    ADD CONSTRAINT project_building_rooms_pkey PRIMARY KEY (room_id);


--
-- TOC entry 3912 (class 2606 OID 21941)
-- Name: project_docs project_docs_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_docs
    ADD CONSTRAINT project_docs_pkey PRIMARY KEY (project_doc_id);


--
-- TOC entry 3890 (class 2606 OID 21665)
-- Name: project_forum_messages project_forum_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_forum_messages
    ADD CONSTRAINT project_forum_messages_pkey PRIMARY KEY (project_forum_message_id);


--
-- TOC entry 3888 (class 2606 OID 21653)
-- Name: project_forum_topics project_forum_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_forum_topics
    ADD CONSTRAINT project_forum_topics_pkey PRIMARY KEY (project_forum_topic_id);


--
-- TOC entry 3884 (class 2606 OID 21640)
-- Name: project_meeting_participants project_meeting_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting_participants
    ADD CONSTRAINT project_meeting_participants_pkey PRIMARY KEY (project_meeting_participant_id);


--
-- TOC entry 3886 (class 2606 OID 22751)
-- Name: project_meeting_participants project_meeting_participants_unique; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting_participants
    ADD CONSTRAINT project_meeting_participants_unique UNIQUE (user_id, project_meeting_id);


--
-- TOC entry 3914 (class 2606 OID 22057)
-- Name: project_meeting project_meeting_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting
    ADD CONSTRAINT project_meeting_pkey PRIMARY KEY (project_meeting_id);


--
-- TOC entry 3882 (class 2606 OID 21629)
-- Name: project_meeting_places project_meeting_places_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting_places
    ADD CONSTRAINT project_meeting_places_pkey PRIMARY KEY (project_meeting_place_id);


--
-- TOC entry 3880 (class 2606 OID 21584)
-- Name: project project_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project
    ADD CONSTRAINT project_pkey PRIMARY KEY (project_id);


--
-- TOC entry 3898 (class 2606 OID 21719)
-- Name: project_products_categories project_products_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_products_categories
    ADD CONSTRAINT project_products_categories_pkey PRIMARY KEY (product_category_id);


--
-- TOC entry 3900 (class 2606 OID 21735)
-- Name: project_products project_products_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_products
    ADD CONSTRAINT project_products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 3926 (class 2606 OID 22330)
-- Name: project_workpackage_expenses project_workpackage_expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_expenses
    ADD CONSTRAINT project_workpackage_expenses_pkey PRIMARY KEY (expense_id);


--
-- TOC entry 3906 (class 2606 OID 21783)
-- Name: project_workpackage_materials project_workpackage_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_materials
    ADD CONSTRAINT project_workpackage_materials_pkey PRIMARY KEY (material_id);


--
-- TOC entry 3908 (class 2606 OID 21821)
-- Name: project_workpackage_participants project_workpackage_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_participants
    ADD CONSTRAINT project_workpackage_participants_pkey PRIMARY KEY (workpackage_participant_id);


--
-- TOC entry 3902 (class 2606 OID 21751)
-- Name: project_workpackage project_workpackage_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage
    ADD CONSTRAINT project_workpackage_pkey PRIMARY KEY (workpackage_id);


--
-- TOC entry 3904 (class 2606 OID 21767)
-- Name: project_workpackage_waste project_workpackage_waste_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_waste
    ADD CONSTRAINT project_workpackage_waste_pkey PRIMARY KEY (waste_id);


--
-- TOC entry 3918 (class 2606 OID 22216)
-- Name: project_worksequence_participants project_worksequence_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_worksequence_participants
    ADD CONSTRAINT project_worksequence_participants_pkey PRIMARY KEY (worksequence_participant_id);


--
-- TOC entry 3916 (class 2606 OID 22074)
-- Name: project_worksequence project_worksequence_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_worksequence
    ADD CONSTRAINT project_worksequence_pkey PRIMARY KEY (worksequence_id);


--
-- TOC entry 3860 (class 2606 OID 21401)
-- Name: regex regex_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.regex
    ADD CONSTRAINT regex_pkey PRIMARY KEY (regex_id);


--
-- TOC entry 3822 (class 2606 OID 21132)
-- Name: rss rss_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.rss
    ADD CONSTRAINT rss_pkey PRIMARY KEY (rss_id);


--
-- TOC entry 3910 (class 2606 OID 21901)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- TOC entry 3846 (class 2606 OID 21325)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3848 (class 2606 OID 21327)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3864 (class 2606 OID 21423)
-- Name: workdocs_cloud workdocs_cloud_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workdocs_cloud
    ADD CONSTRAINT workdocs_cloud_pkey PRIMARY KEY (workdoc_cloud_id);


--
-- TOC entry 3842 (class 2606 OID 21287)
-- Name: workdocs workdocs_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workdocs
    ADD CONSTRAINT workdocs_pkey PRIMARY KEY (workdoc_id);


--
-- TOC entry 3862 (class 2606 OID 21412)
-- Name: workmeeting_participants workmeeting_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workmeeting_participants
    ADD CONSTRAINT workmeeting_participants_pkey PRIMARY KEY (workmeeting_participant_id);


--
-- TOC entry 3870 (class 2606 OID 21496)
-- Name: workmeetings workmeetings_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workmeetings
    ADD CONSTRAINT workmeetings_pkey PRIMARY KEY (workmeeting_id);


--
-- TOC entry 3872 (class 2606 OID 21507)
-- Name: workspace_participants workspace_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workspace_participants
    ADD CONSTRAINT workspace_participants_pkey PRIMARY KEY (workspace_participant_id);


--
-- TOC entry 3838 (class 2606 OID 21256)
-- Name: workspaces workspaces_pkey; Type: CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_pkey PRIMARY KEY (workspace_id);


--
-- TOC entry 3810 (class 1259 OID 22743)
-- Name: orga_dept_orga_dept_master_idx; Type: INDEX; Schema: public; Owner: sqlpage
--

CREATE UNIQUE INDEX orga_dept_orga_dept_master_idx ON public.orga_dept USING btree (orga_dept_master) WHERE (orga_dept_master IS NOT NULL);


--
-- TOC entry 3931 (class 2606 OID 21155)
-- Name: choices_items choices_items_choice_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.choices_items
    ADD CONSTRAINT choices_items_choice_category_id_fkey FOREIGN KEY (choice_category_id) REFERENCES public.choices_categories(choice_category_id);


--
-- TOC entry 3933 (class 2606 OID 21210)
-- Name: event_participants event_participants_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.event_participants
    ADD CONSTRAINT event_participants_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id);


--
-- TOC entry 3932 (class 2606 OID 21193)
-- Name: events events_space_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_space_id_fkey FOREIGN KEY (space_id) REFERENCES public.place_spaces(space_id);


--
-- TOC entry 3941 (class 2606 OID 21520)
-- Name: faq_questions faq_questions_contact_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.faq_questions
    ADD CONSTRAINT faq_questions_contact_id_fkey FOREIGN KEY (contact_id) REFERENCES public.faq_contacts(contact_id);


--
-- TOC entry 3934 (class 2606 OID 21240)
-- Name: forum_messages forum_messages_topic_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.forum_messages
    ADD CONSTRAINT forum_messages_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.forum_topics(topic_id);


--
-- TOC entry 3927 (class 2606 OID 22499)
-- Name: orga_dept_members members_orga_dept_fk; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_members
    ADD CONSTRAINT members_orga_dept_fk FOREIGN KEY (orga_dept_id) REFERENCES public.orga_dept(orga_dept_id);


--
-- TOC entry 3928 (class 2606 OID 21063)
-- Name: orga_dept orga_dept_orga_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept
    ADD CONSTRAINT orga_dept_orga_id_fkey FOREIGN KEY (orga_id) REFERENCES public.orga(orga_id);


--
-- TOC entry 3943 (class 2606 OID 21569)
-- Name: orga_dept_docs orga_docs_orga_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_docs
    ADD CONSTRAINT orga_docs_orga_dept_id_fkey FOREIGN KEY (orga_dept_id) REFERENCES public.orga_dept(orga_dept_id);


--
-- TOC entry 3936 (class 2606 OID 22465)
-- Name: orga_dept_partners orga_partners_orga_dept_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.orga_dept_partners
    ADD CONSTRAINT orga_partners_orga_dept_id_fkey FOREIGN KEY (orga_dept_id) REFERENCES public.orga_dept(orga_dept_id) ON DELETE CASCADE;


--
-- TOC entry 3942 (class 2606 OID 21536)
-- Name: place_spaces_pictures place_spaces_pictures_space_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place_spaces_pictures
    ADD CONSTRAINT place_spaces_pictures_space_id_fkey FOREIGN KEY (space_id) REFERENCES public.place_spaces(space_id);


--
-- TOC entry 3930 (class 2606 OID 21117)
-- Name: place_spaces place_spaces_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.place_spaces
    ADD CONSTRAINT place_spaces_place_id_fkey FOREIGN KEY (place_id) REFERENCES public.place(place_id);


--
-- TOC entry 3937 (class 2606 OID 22102)
-- Name: prm1_doc prm1_doc_prm1_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm1_doc
    ADD CONSTRAINT prm1_doc_prm1_id_fkey FOREIGN KEY (prm1_id) REFERENCES public.prm1(prm1_id) ON DELETE CASCADE;


--
-- TOC entry 3957 (class 2606 OID 22309)
-- Name: prm2_sub_docs prm2_sub_docs_prm2_sub_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub_docs
    ADD CONSTRAINT prm2_sub_docs_prm2_sub_id_fkey FOREIGN KEY (prm2_sub_id) REFERENCES public.prm2_sub(prm2_sub_id) ON DELETE CASCADE;


--
-- TOC entry 3958 (class 2606 OID 22282)
-- Name: prm2_sub_employees prm2_sub_employees_prm2_sub_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub_employees
    ADD CONSTRAINT prm2_sub_employees_prm2_sub_id_fkey FOREIGN KEY (prm2_sub_id) REFERENCES public.prm2_sub(prm2_sub_id);


--
-- TOC entry 3938 (class 2606 OID 22097)
-- Name: prm2_sub prm2_sub_prm2_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm2_sub
    ADD CONSTRAINT prm2_sub_prm2_id_fkey FOREIGN KEY (prm2_id) REFERENCES public.prm2(prm2_id) ON DELETE CASCADE;


--
-- TOC entry 3959 (class 2606 OID 22304)
-- Name: prm3_docs prm3_docs_prm3_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.prm3_docs
    ADD CONSTRAINT prm3_docs_prm3_id_fkey FOREIGN KEY (prm3_id) REFERENCES public.prm3(prm3_id);


--
-- TOC entry 3929 (class 2606 OID 22162)
-- Name: process_steps process_steps_process_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.process_steps
    ADD CONSTRAINT process_steps_process_id_fkey FOREIGN KEY (process_id) REFERENCES public.process(process_id) ON DELETE CASCADE;


--
-- TOC entry 3944 (class 2606 OID 22157)
-- Name: project_building project_building_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building
    ADD CONSTRAINT project_building_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id) ON DELETE CASCADE;


--
-- TOC entry 3945 (class 2606 OID 22152)
-- Name: project_building_rooms project_building_rooms_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_building_rooms
    ADD CONSTRAINT project_building_rooms_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.project_building(building_id) ON DELETE CASCADE;


--
-- TOC entry 3953 (class 2606 OID 22147)
-- Name: project_docs project_docs_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_docs
    ADD CONSTRAINT project_docs_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id) ON DELETE CASCADE;


--
-- TOC entry 3954 (class 2606 OID 22058)
-- Name: project_meeting project_meeting_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_meeting
    ADD CONSTRAINT project_meeting_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id);


--
-- TOC entry 3946 (class 2606 OID 21720)
-- Name: project_products_categories project_products_categories_product_category_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_products_categories
    ADD CONSTRAINT project_products_categories_product_category_parent_id_fkey FOREIGN KEY (product_category_parent_id) REFERENCES public.project_products_categories(product_category_id);


--
-- TOC entry 3947 (class 2606 OID 21736)
-- Name: project_products project_products_product_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_products
    ADD CONSTRAINT project_products_product_category_id_fkey FOREIGN KEY (product_category_id) REFERENCES public.project_products_categories(product_category_id);


--
-- TOC entry 3960 (class 2606 OID 22331)
-- Name: project_workpackage_expenses project_workpackage_expenses_workpackage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_expenses
    ADD CONSTRAINT project_workpackage_expenses_workpackage_id_fkey FOREIGN KEY (workpackage_id) REFERENCES public.project_workpackage(workpackage_id);


--
-- TOC entry 3950 (class 2606 OID 22132)
-- Name: project_workpackage_materials project_workpackage_materials_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_materials
    ADD CONSTRAINT project_workpackage_materials_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.project_products(product_id) ON DELETE CASCADE;


--
-- TOC entry 3951 (class 2606 OID 22127)
-- Name: project_workpackage_materials project_workpackage_materials_workpackage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_materials
    ADD CONSTRAINT project_workpackage_materials_workpackage_id_fkey FOREIGN KEY (workpackage_id) REFERENCES public.project_workpackage(workpackage_id) ON DELETE CASCADE;


--
-- TOC entry 3952 (class 2606 OID 22122)
-- Name: project_workpackage_participants project_workpackage_participants_workpackage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_participants
    ADD CONSTRAINT project_workpackage_participants_workpackage_id_fkey FOREIGN KEY (workpackage_id) REFERENCES public.project_workpackage(workpackage_id) ON DELETE CASCADE;


--
-- TOC entry 3948 (class 2606 OID 22142)
-- Name: project_workpackage project_workpackage_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage
    ADD CONSTRAINT project_workpackage_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.project(project_id) ON DELETE CASCADE;


--
-- TOC entry 3949 (class 2606 OID 22117)
-- Name: project_workpackage_waste project_workpackage_waste_workpackage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_workpackage_waste
    ADD CONSTRAINT project_workpackage_waste_workpackage_id_fkey FOREIGN KEY (workpackage_id) REFERENCES public.project_workpackage(workpackage_id) ON DELETE CASCADE;


--
-- TOC entry 3956 (class 2606 OID 22698)
-- Name: project_worksequence_participants project_worksequence_participants_worksequence_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_worksequence_participants
    ADD CONSTRAINT project_worksequence_participants_worksequence_id_fkey FOREIGN KEY (worksequence_id) REFERENCES public.project_worksequence(worksequence_id) ON DELETE CASCADE;


--
-- TOC entry 3955 (class 2606 OID 22112)
-- Name: project_worksequence project_worksequence_workpackage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.project_worksequence
    ADD CONSTRAINT project_worksequence_workpackage_id_fkey FOREIGN KEY (workpackage_id) REFERENCES public.project_workpackage(workpackage_id) ON DELETE CASCADE;


--
-- TOC entry 3935 (class 2606 OID 22559)
-- Name: workdocs workdocs_workspaces_fk; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workdocs
    ADD CONSTRAINT workdocs_workspaces_fk FOREIGN KEY (workspace_id) REFERENCES public.workspaces(workspace_id) ON DELETE CASCADE;


--
-- TOC entry 3939 (class 2606 OID 22544)
-- Name: workmeetings workmeetings_place_spaces_fk; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workmeetings
    ADD CONSTRAINT workmeetings_place_spaces_fk FOREIGN KEY (space_id) REFERENCES public.place_spaces(space_id);


--
-- TOC entry 3940 (class 2606 OID 22554)
-- Name: workmeetings workmeetings_workspaces_fk; Type: FK CONSTRAINT; Schema: public; Owner: sqlpage
--

ALTER TABLE ONLY public.workmeetings
    ADD CONSTRAINT workmeetings_workspaces_fk FOREIGN KEY (workspace_id) REFERENCES public.workspaces(workspace_id) ON DELETE CASCADE;


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 7
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT ALL ON SCHEMA public TO sqlpage;


-- Completed on 2025-12-30 16:27:05 CET

--
-- PostgreSQL database dump complete
--

\unrestrict 0S4peqq25NrTUbmc9HaUcScOBhSt2uJRormg7IvAhzbnCmTdeum33dzL9M0Wd6p

