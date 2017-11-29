--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.13
-- Dumped by pg_dump version 9.5.10

-- Started on 2017-11-29 14:39:45 CET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 11861)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2027 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 25494)
-- Name: retweets; Type: TABLE; Schema: public; Owner: BotUser
--

CREATE TABLE retweets (
    id integer NOT NULL,
    retweet_id bigint NOT NULL,
    retweet_date timestamp without time zone DEFAULT now()
);


ALTER TABLE retweets OWNER TO "BotUser";

--
-- TOC entry 173 (class 1259 OID 25492)
-- Name: Retweets_Id_seq; Type: SEQUENCE; Schema: public; Owner: BotUser
--

CREATE SEQUENCE "Retweets_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Retweets_Id_seq" OWNER TO "BotUser";

--
-- TOC entry 2028 (class 0 OID 0)
-- Dependencies: 173
-- Name: Retweets_Id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: BotUser
--

ALTER SEQUENCE "Retweets_Id_seq" OWNED BY retweets.id;


--
-- TOC entry 176 (class 1259 OID 25566)
-- Name: tags; Type: TABLE; Schema: public; Owner: BotUser
--

CREATE TABLE tags (
    id integer NOT NULL,
    tag character varying(64) NOT NULL
);


ALTER TABLE tags OWNER TO "BotUser";

--
-- TOC entry 175 (class 1259 OID 25564)
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: BotUser
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_id_seq OWNER TO "BotUser";

--
-- TOC entry 2029 (class 0 OID 0)
-- Dependencies: 175
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: BotUser
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- TOC entry 178 (class 1259 OID 25574)
-- Name: tweets; Type: TABLE; Schema: public; Owner: BotUser
--

CREATE TABLE tweets (
    id integer NOT NULL,
    message character varying(256) NOT NULL,
    is_sended boolean DEFAULT false NOT NULL,
    send_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE tweets OWNER TO "BotUser";

--
-- TOC entry 177 (class 1259 OID 25572)
-- Name: tweets_id_seq; Type: SEQUENCE; Schema: public; Owner: BotUser
--

CREATE SEQUENCE tweets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tweets_id_seq OWNER TO "BotUser";

--
-- TOC entry 2030 (class 0 OID 0)
-- Dependencies: 177
-- Name: tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: BotUser
--

ALTER SEQUENCE tweets_id_seq OWNED BY tweets.id;


--
-- TOC entry 1897 (class 2604 OID 25497)
-- Name: id; Type: DEFAULT; Schema: public; Owner: BotUser
--

ALTER TABLE ONLY retweets ALTER COLUMN id SET DEFAULT nextval('"Retweets_Id_seq"'::regclass);


--
-- TOC entry 1899 (class 2604 OID 25569)
-- Name: id; Type: DEFAULT; Schema: public; Owner: BotUser
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- TOC entry 1900 (class 2604 OID 25577)
-- Name: id; Type: DEFAULT; Schema: public; Owner: BotUser
--

ALTER TABLE ONLY tweets ALTER COLUMN id SET DEFAULT nextval('tweets_id_seq'::regclass);


--
-- TOC entry 1904 (class 2606 OID 25500)
-- Name: Key_Retweets; Type: CONSTRAINT; Schema: public; Owner: BotUser
--

ALTER TABLE ONLY retweets
    ADD CONSTRAINT "Key_Retweets" PRIMARY KEY (id);


--
-- TOC entry 1906 (class 2606 OID 25502)
-- Name: Twitter_RetweetId; Type: CONSTRAINT; Schema: public; Owner: BotUser
--

ALTER TABLE ONLY retweets
    ADD CONSTRAINT "Twitter_RetweetId" UNIQUE (retweet_id);


--
-- TOC entry 1908 (class 2606 OID 25571)
-- Name: tag_id; Type: CONSTRAINT; Schema: public; Owner: BotUser
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tag_id PRIMARY KEY (id);


--
-- TOC entry 1910 (class 2606 OID 25581)
-- Name: tweet_id; Type: CONSTRAINT; Schema: public; Owner: BotUser
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweet_id PRIMARY KEY (id);


--
-- TOC entry 2026 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-11-29 14:39:46 CET

--
-- PostgreSQL database dump complete
--

