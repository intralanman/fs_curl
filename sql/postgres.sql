--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE accounts (
    id bigint NOT NULL,
    name character varying(256),
    cash double precision NOT NULL
);


ALTER TABLE public.accounts OWNER TO freeswitch;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO freeswitch;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: acl_lists; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE acl_lists (
    id integer NOT NULL,
    acl_name character varying(128) NOT NULL,
    default_policy character varying(48) NOT NULL
);


ALTER TABLE public.acl_lists OWNER TO freeswitch;

--
-- Name: acl_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE acl_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acl_lists_id_seq OWNER TO freeswitch;

--
-- Name: acl_lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE acl_lists_id_seq OWNED BY acl_lists.id;


--
-- Name: acl_nodes; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE acl_nodes (
    id integer NOT NULL,
    cidr character varying(48) NOT NULL,
    type character varying(16) NOT NULL,
    list_id integer NOT NULL
);


ALTER TABLE public.acl_nodes OWNER TO freeswitch;

--
-- Name: acl_nodes_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE acl_nodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.acl_nodes_id_seq OWNER TO freeswitch;

--
-- Name: acl_nodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE acl_nodes_id_seq OWNED BY acl_nodes.id;


--
-- Name: carrier_gateway; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE carrier_gateway (
    id integer NOT NULL,
    carrier_id integer,
    prefix character varying(128) DEFAULT ''::character varying NOT NULL,
    suffix character varying(128) DEFAULT ''::character varying NOT NULL,
    codec character varying(128) DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.carrier_gateway OWNER TO freeswitch;

--
-- Name: carrier_gateway_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE carrier_gateway_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carrier_gateway_id_seq OWNER TO freeswitch;

--
-- Name: carrier_gateway_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE carrier_gateway_id_seq OWNED BY carrier_gateway.id;


--
-- Name: carriers; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE carriers (
    id integer NOT NULL,
    carrier_name character varying(255) NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE public.carriers OWNER TO freeswitch;

--
-- Name: carriers_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE carriers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carriers_id_seq OWNER TO freeswitch;

--
-- Name: carriers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE carriers_id_seq OWNED BY carriers.id;


--
-- Name: cdr; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE cdr (
    id integer NOT NULL,
    caller_id_name character varying NOT NULL,
    caller_id_number character varying NOT NULL,
    destination_number character varying NOT NULL,
    context character varying NOT NULL,
    start_stamp character varying NOT NULL,
    answer_stamp character varying NOT NULL,
    end_stamp character varying NOT NULL,
    duration character varying NOT NULL,
    billsec character varying NOT NULL,
    hangup_cause character(128) NOT NULL,
    uuid character varying NOT NULL,
    bleg_uuid character varying NOT NULL,
    accountcode character(128) NOT NULL,
    read_codec character varying NOT NULL,
    write_codec character varying NOT NULL
);


ALTER TABLE public.cdr OWNER TO freeswitch;

--
-- Name: cdr_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE cdr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cdr_id_seq OWNER TO freeswitch;

--
-- Name: cdr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE cdr_id_seq OWNED BY cdr.id;


--
-- Name: conference_advertise; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE conference_advertise (
    id integer NOT NULL,
    room character varying(64) NOT NULL,
    status character varying(128) NOT NULL
);


ALTER TABLE public.conference_advertise OWNER TO freeswitch;

--
-- Name: conference_advertise_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE conference_advertise_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conference_advertise_id_seq OWNER TO freeswitch;

--
-- Name: conference_advertise_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE conference_advertise_id_seq OWNED BY conference_advertise.id;


--
-- Name: conference_controls; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE conference_controls (
    id integer NOT NULL,
    conf_group character varying(64) NOT NULL,
    action character varying(64) NOT NULL,
    digits character varying(16) NOT NULL
);


ALTER TABLE public.conference_controls OWNER TO freeswitch;

--
-- Name: conference_controls_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE conference_controls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conference_controls_id_seq OWNER TO freeswitch;

--
-- Name: conference_controls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE conference_controls_id_seq OWNED BY conference_controls.id;


--
-- Name: conference_profiles; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE conference_profiles (
    id integer NOT NULL,
    profile_name character varying(64) NOT NULL,
    param_name character varying(64) NOT NULL,
    param_value character varying(64) NOT NULL
);


ALTER TABLE public.conference_profiles OWNER TO freeswitch;

--
-- Name: conference_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE conference_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conference_profiles_id_seq OWNER TO freeswitch;

--
-- Name: conference_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE conference_profiles_id_seq OWNED BY conference_profiles.id;


--
-- Name: dialplan; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dialplan (
    dialplan_id integer NOT NULL,
    domain character varying(128) NOT NULL,
    ip_address character varying(16) NOT NULL
);


ALTER TABLE public.dialplan OWNER TO freeswitch;

--
-- Name: dialplan_actions; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dialplan_actions (
    action_id integer NOT NULL,
    condition_id integer NOT NULL,
    application character varying(256) NOT NULL,
    data character varying(256) NOT NULL,
    type character varying(32) NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.dialplan_actions OWNER TO freeswitch;

--
-- Name: dialplan_actions_action_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dialplan_actions_action_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dialplan_actions_action_id_seq OWNER TO freeswitch;

--
-- Name: dialplan_actions_action_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dialplan_actions_action_id_seq OWNED BY dialplan_actions.action_id;


--
-- Name: dialplan_condition; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dialplan_condition (
    condition_id integer NOT NULL,
    extension_id integer NOT NULL,
    field character varying(128) NOT NULL,
    expression character varying(128) NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.dialplan_condition OWNER TO freeswitch;

--
-- Name: dialplan_condition_condition_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dialplan_condition_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dialplan_condition_condition_id_seq OWNER TO freeswitch;

--
-- Name: dialplan_condition_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dialplan_condition_condition_id_seq OWNED BY dialplan_condition.condition_id;


--
-- Name: dialplan_context; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dialplan_context (
    context_id integer NOT NULL,
    dialplan_id integer NOT NULL,
    context character varying(64) NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.dialplan_context OWNER TO freeswitch;

--
-- Name: dialplan_context_context_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dialplan_context_context_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dialplan_context_context_id_seq OWNER TO freeswitch;

--
-- Name: dialplan_context_context_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dialplan_context_context_id_seq OWNED BY dialplan_context.context_id;


--
-- Name: dialplan_dialplan_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dialplan_dialplan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dialplan_dialplan_id_seq OWNER TO freeswitch;

--
-- Name: dialplan_dialplan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dialplan_dialplan_id_seq OWNED BY dialplan.dialplan_id;


--
-- Name: dialplan_extension; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dialplan_extension (
    extension_id integer NOT NULL,
    context_id integer NOT NULL,
    name character varying(128) NOT NULL,
    continue character varying(32) NOT NULL,
    weight integer NOT NULL
);


ALTER TABLE public.dialplan_extension OWNER TO freeswitch;

--
-- Name: dialplan_extension_extension_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dialplan_extension_extension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dialplan_extension_extension_id_seq OWNER TO freeswitch;

--
-- Name: dialplan_extension_extension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dialplan_extension_extension_id_seq OWNED BY dialplan_extension.extension_id;


--
-- Name: dialplan_special; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dialplan_special (
    id integer NOT NULL,
    context character varying(256) NOT NULL,
    class_file character varying(256) NOT NULL
);


ALTER TABLE public.dialplan_special OWNER TO freeswitch;

--
-- Name: dialplan_special_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dialplan_special_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dialplan_special_id_seq OWNER TO freeswitch;

--
-- Name: dialplan_special_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dialplan_special_id_seq OWNED BY dialplan_special.id;


--
-- Name: dingaling_profile_params; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dingaling_profile_params (
    id integer NOT NULL,
    dingaling_id integer NOT NULL,
    param_name character varying(64) NOT NULL,
    param_value character varying(64) NOT NULL
);


ALTER TABLE public.dingaling_profile_params OWNER TO freeswitch;

--
-- Name: dingaling_profile_params_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dingaling_profile_params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dingaling_profile_params_id_seq OWNER TO freeswitch;

--
-- Name: dingaling_profile_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dingaling_profile_params_id_seq OWNED BY dingaling_profile_params.id;


--
-- Name: dingaling_profiles; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dingaling_profiles (
    id integer NOT NULL,
    profile_name character varying(64) NOT NULL,
    type character varying(64) NOT NULL
);


ALTER TABLE public.dingaling_profiles OWNER TO freeswitch;

--
-- Name: dingaling_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dingaling_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dingaling_profiles_id_seq OWNER TO freeswitch;

--
-- Name: dingaling_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dingaling_profiles_id_seq OWNED BY dingaling_profiles.id;


--
-- Name: dingaling_settings; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE dingaling_settings (
    id integer NOT NULL,
    param_name character varying(64) NOT NULL,
    param_value character varying(64) NOT NULL
);


ALTER TABLE public.dingaling_settings OWNER TO freeswitch;

--
-- Name: dingaling_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE dingaling_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dingaling_settings_id_seq OWNER TO freeswitch;

--
-- Name: dingaling_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE dingaling_settings_id_seq OWNED BY dingaling_settings.id;


--
-- Name: directory; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory (
    id integer NOT NULL,
    username character varying(256) NOT NULL,
    domain_id integer NOT NULL,
    cache integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.directory OWNER TO freeswitch;

--
-- Name: directory_domains; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_domains (
    id integer NOT NULL,
    domain_name character varying(128) NOT NULL
);


ALTER TABLE public.directory_domains OWNER TO freeswitch;

--
-- Name: directory_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_domains_id_seq OWNER TO freeswitch;

--
-- Name: directory_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_domains_id_seq OWNED BY directory_domains.id;


--
-- Name: directory_gateway_params; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_gateway_params (
    id integer NOT NULL,
    d_gw_id integer NOT NULL,
    param_name character varying(64) NOT NULL,
    param_value character varying(64) NOT NULL
);


ALTER TABLE public.directory_gateway_params OWNER TO freeswitch;

--
-- Name: directory_gateway_params_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_gateway_params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_gateway_params_id_seq OWNER TO freeswitch;

--
-- Name: directory_gateway_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_gateway_params_id_seq OWNED BY directory_gateway_params.id;


--
-- Name: directory_gateways; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_gateways (
    id integer NOT NULL,
    directory_id integer NOT NULL,
    gateway_name character varying(128) NOT NULL
);


ALTER TABLE public.directory_gateways OWNER TO freeswitch;

--
-- Name: directory_gateways_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_gateways_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_gateways_id_seq OWNER TO freeswitch;

--
-- Name: directory_gateways_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_gateways_id_seq OWNED BY directory_gateways.id;


--
-- Name: directory_global_params; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_global_params (
    id integer NOT NULL,
    param_name character varying(64) NOT NULL,
    param_value character varying(128) NOT NULL,
    domain_id integer NOT NULL
);


ALTER TABLE public.directory_global_params OWNER TO freeswitch;

--
-- Name: directory_global_params_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_global_params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_global_params_id_seq OWNER TO freeswitch;

--
-- Name: directory_global_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_global_params_id_seq OWNED BY directory_global_params.id;


--
-- Name: directory_global_vars; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_global_vars (
    id integer NOT NULL,
    var_name character varying(64) NOT NULL,
    var_value character varying(128) NOT NULL,
    domain_id integer NOT NULL
);


ALTER TABLE public.directory_global_vars OWNER TO freeswitch;

--
-- Name: directory_global_vars_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_global_vars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_global_vars_id_seq OWNER TO freeswitch;

--
-- Name: directory_global_vars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_global_vars_id_seq OWNED BY directory_global_vars.id;


--
-- Name: directory_group_user_map; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_group_user_map (
    map_id integer NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.directory_group_user_map OWNER TO freeswitch;

--
-- Name: directory_group_user_map_map_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_group_user_map_map_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_group_user_map_map_id_seq OWNER TO freeswitch;

--
-- Name: directory_group_user_map_map_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_group_user_map_map_id_seq OWNED BY directory_group_user_map.map_id;


--
-- Name: directory_groups; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_groups (
    group_id integer NOT NULL,
    group_name character varying(256) NOT NULL
);


ALTER TABLE public.directory_groups OWNER TO freeswitch;

--
-- Name: directory_groups_group_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_groups_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_groups_group_id_seq OWNER TO freeswitch;

--
-- Name: directory_groups_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_groups_group_id_seq OWNED BY directory_groups.group_id;


--
-- Name: directory_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_id_seq OWNER TO freeswitch;

--
-- Name: directory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_id_seq OWNED BY directory.id;


--
-- Name: directory_params; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_params (
    id integer NOT NULL,
    directory_id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.directory_params OWNER TO freeswitch;

--
-- Name: directory_params_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_params_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_params_id_seq OWNER TO freeswitch;

--
-- Name: directory_params_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_params_id_seq OWNED BY directory_params.id;


--
-- Name: directory_vars; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE directory_vars (
    id integer NOT NULL,
    directory_id integer NOT NULL,
    var_name character varying(256) NOT NULL,
    var_value character varying(256) NOT NULL
);


ALTER TABLE public.directory_vars OWNER TO freeswitch;

--
-- Name: directory_vars_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE directory_vars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directory_vars_id_seq OWNER TO freeswitch;

--
-- Name: directory_vars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE directory_vars_id_seq OWNED BY directory_vars.id;


--
-- Name: easyroute_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE easyroute_conf (
    id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.easyroute_conf OWNER TO freeswitch;

--
-- Name: easyroute_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE easyroute_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easyroute_conf_id_seq OWNER TO freeswitch;

--
-- Name: easyroute_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE easyroute_conf_id_seq OWNED BY easyroute_conf.id;


--
-- Name: easyroute_data; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE easyroute_data (
    id integer NOT NULL,
    gateway character varying(128) NOT NULL,
    "group" character varying(128) NOT NULL,
    call_limit character varying(16) NOT NULL,
    tech_prefix character varying(128) NOT NULL,
    acctcode character varying(128) NOT NULL,
    destination_number character varying(128) NOT NULL
);


ALTER TABLE public.easyroute_data OWNER TO freeswitch;

--
-- Name: easyroute_data_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE easyroute_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easyroute_data_id_seq OWNER TO freeswitch;

--
-- Name: easyroute_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE easyroute_data_id_seq OWNED BY easyroute_data.id;


--
-- Name: iax_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE iax_conf (
    id integer NOT NULL,
    profile_name character varying(256) NOT NULL
);


ALTER TABLE public.iax_conf OWNER TO freeswitch;

--
-- Name: iax_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE iax_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.iax_conf_id_seq OWNER TO freeswitch;

--
-- Name: iax_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE iax_conf_id_seq OWNED BY iax_conf.id;


--
-- Name: iax_settings; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE iax_settings (
    id integer NOT NULL,
    iax_id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.iax_settings OWNER TO freeswitch;

--
-- Name: iax_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE iax_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.iax_settings_id_seq OWNER TO freeswitch;

--
-- Name: iax_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE iax_settings_id_seq OWNED BY iax_settings.id;


--
-- Name: ivr_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE ivr_conf (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    greet_long character varying(256) NOT NULL,
    greet_short character varying(256) NOT NULL,
    invalid_sound character varying(256) NOT NULL,
    exit_sound character varying(256) NOT NULL,
    max_failures integer NOT NULL,
    timeout integer NOT NULL,
    tts_engine character varying(64) NOT NULL,
    tts_voice character varying(64) NOT NULL
);


ALTER TABLE public.ivr_conf OWNER TO freeswitch;

--
-- Name: ivr_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE ivr_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ivr_conf_id_seq OWNER TO freeswitch;

--
-- Name: ivr_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE ivr_conf_id_seq OWNED BY ivr_conf.id;


--
-- Name: ivr_entries; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE ivr_entries (
    id integer NOT NULL,
    ivr_id integer NOT NULL,
    action character varying(64) NOT NULL,
    digits character varying(64) NOT NULL,
    params character varying(256) NOT NULL
);


ALTER TABLE public.ivr_entries OWNER TO freeswitch;

--
-- Name: ivr_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE ivr_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ivr_entries_id_seq OWNER TO freeswitch;

--
-- Name: ivr_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE ivr_entries_id_seq OWNED BY ivr_entries.id;


--
-- Name: lcr; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE lcr (
    id integer NOT NULL,
    digits numeric(20,0),
    rate numeric(11,5) NOT NULL,
    intrastate_rate numeric(11,5) NOT NULL,
    intralata_rate numeric(11,5) NOT NULL,
    carrier_id integer NOT NULL,
    lead_strip integer DEFAULT 0 NOT NULL,
    trail_strip integer DEFAULT 0 NOT NULL,
    prefix character varying(16) DEFAULT ''::character varying NOT NULL,
    suffix character varying(16) DEFAULT ''::character varying NOT NULL,
    lcr_profile integer DEFAULT 0 NOT NULL,
    date_start timestamp with time zone DEFAULT '1970-01-01 00:00:00-05'::timestamp with time zone NOT NULL,
    date_end timestamp with time zone DEFAULT '2030-12-31 00:00:00-05'::timestamp with time zone NOT NULL,
    quality numeric(10,6) DEFAULT 0 NOT NULL,
    reliability numeric(10,6) DEFAULT 0 NOT NULL,
    cid character varying(32) DEFAULT ''::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    lrn boolean DEFAULT false NOT NULL
);


ALTER TABLE public.lcr OWNER TO freeswitch;

--
-- Name: lcr_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE lcr_conf (
    id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.lcr_conf OWNER TO freeswitch;

--
-- Name: lcr_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE lcr_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lcr_conf_id_seq OWNER TO freeswitch;

--
-- Name: lcr_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE lcr_conf_id_seq OWNED BY lcr_conf.id;


--
-- Name: lcr_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE lcr_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lcr_id_seq OWNER TO freeswitch;

--
-- Name: lcr_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE lcr_id_seq OWNED BY lcr.id;


--
-- Name: lcr_profiles; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE lcr_profiles (
    id integer NOT NULL,
    profile_name character varying(128) NOT NULL
);


ALTER TABLE public.lcr_profiles OWNER TO freeswitch;

--
-- Name: lcr_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE lcr_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lcr_profiles_id_seq OWNER TO freeswitch;

--
-- Name: lcr_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE lcr_profiles_id_seq OWNED BY lcr_profiles.id;


--
-- Name: lcr_settings; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE lcr_settings (
    id integer NOT NULL,
    lcr_id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.lcr_settings OWNER TO freeswitch;

--
-- Name: lcr_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE lcr_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lcr_settings_id_seq OWNER TO freeswitch;

--
-- Name: lcr_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE lcr_settings_id_seq OWNED BY lcr_settings.id;


--
-- Name: limit_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE limit_conf (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    value character varying(256) NOT NULL
);


ALTER TABLE public.limit_conf OWNER TO freeswitch;

--
-- Name: limit_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE limit_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.limit_conf_id_seq OWNER TO freeswitch;

--
-- Name: limit_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE limit_conf_id_seq OWNED BY limit_conf.id;


--
-- Name: limit_data; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE limit_data (
    hostname character varying(255) DEFAULT NULL::character varying,
    realm character varying(255) DEFAULT NULL::character varying,
    id character varying(255) DEFAULT NULL::character varying,
    uuid character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.limit_data OWNER TO freeswitch;

--
-- Name: local_stream_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE local_stream_conf (
    id integer NOT NULL,
    directory_name character varying(256) NOT NULL,
    directory_path text NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.local_stream_conf OWNER TO freeswitch;

--
-- Name: local_stream_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE local_stream_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.local_stream_conf_id_seq OWNER TO freeswitch;

--
-- Name: local_stream_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE local_stream_conf_id_seq OWNED BY local_stream_conf.id;


--
-- Name: modless_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE modless_conf (
    id integer NOT NULL,
    conf_name character varying(64) NOT NULL
);


ALTER TABLE public.modless_conf OWNER TO freeswitch;

--
-- Name: modless_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE modless_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modless_conf_id_seq OWNER TO freeswitch;

--
-- Name: modless_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE modless_conf_id_seq OWNED BY modless_conf.id;


--
-- Name: npa_nxx_company_ocn; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE npa_nxx_company_ocn (
    npa smallint NOT NULL,
    nxx smallint NOT NULL,
    company_type text,
    ocn text,
    company_name text,
    lata integer,
    ratecenter text,
    state text
);


ALTER TABLE public.npa_nxx_company_ocn OWNER TO freeswitch;

--
-- Name: post_load_modules_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE post_load_modules_conf (
    id integer NOT NULL,
    module_name character varying(64) NOT NULL,
    load_module boolean DEFAULT true NOT NULL,
    priority integer DEFAULT 1000 NOT NULL
);


ALTER TABLE public.post_load_modules_conf OWNER TO freeswitch;

--
-- Name: post_load_modules_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE post_load_modules_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.post_load_modules_conf_id_seq OWNER TO freeswitch;

--
-- Name: post_load_modules_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE post_load_modules_conf_id_seq OWNED BY post_load_modules_conf.id;


--
-- Name: rss_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE rss_conf (
    id integer NOT NULL,
    directory_id integer NOT NULL,
    feed text NOT NULL,
    local_file text NOT NULL,
    description text NOT NULL,
    priority integer DEFAULT 1000 NOT NULL
);


ALTER TABLE public.rss_conf OWNER TO freeswitch;

--
-- Name: rss_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE rss_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rss_conf_id_seq OWNER TO freeswitch;

--
-- Name: rss_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE rss_conf_id_seq OWNED BY rss_conf.id;


--
-- Name: sip_authentication; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sip_authentication (
    nonce character varying(255),
    expires integer,
    profile_name character varying(255),
    hostname character varying(255)
);


ALTER TABLE public.sip_authentication OWNER TO freeswitch;

--
-- Name: sip_dialogs; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sip_dialogs (
    call_id character varying(255),
    uuid character varying(255),
    sip_to_user character varying(255),
    sip_to_host character varying(255),
    sip_from_user character varying(255),
    sip_from_host character varying(255),
    contact_user character varying(255),
    contact_host character varying(255),
    state character varying(255),
    direction character varying(255),
    user_agent character varying(255),
    profile_name character varying(255),
    hostname character varying(255)
);


ALTER TABLE public.sip_dialogs OWNER TO freeswitch;

--
-- Name: sip_presence; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sip_presence (
    sip_user character varying(255),
    sip_host character varying(255),
    status character varying(255),
    rpid character varying(255),
    expires integer,
    user_agent character varying(255),
    profile_name character varying(255),
    hostname character varying(255),
    network_ip character varying(255),
    network_port character varying(6)
);


ALTER TABLE public.sip_presence OWNER TO freeswitch;

--
-- Name: sip_registrations; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sip_registrations (
    call_id character varying(255),
    sip_user character varying(255),
    sip_host character varying(255),
    presence_hosts character varying(255),
    contact character varying(1024),
    status character varying(255),
    rpid character varying(255),
    expires integer,
    user_agent character varying(255),
    server_user character varying(255),
    server_host character varying(255),
    profile_name character varying(255),
    hostname character varying(255),
    network_ip character varying(255),
    network_port character varying(6),
    sip_username character varying(255),
    sip_realm character varying(255),
    mwi_user character varying(255),
    mwi_host character varying(255)
);


ALTER TABLE public.sip_registrations OWNER TO freeswitch;

--
-- Name: sip_shared_appearance_dialogs; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sip_shared_appearance_dialogs (
    profile_name character varying(255),
    hostname character varying(255),
    contact_str character varying(255),
    call_id character varying(255),
    network_ip character varying(255),
    expires integer
);


ALTER TABLE public.sip_shared_appearance_dialogs OWNER TO freeswitch;

--
-- Name: sip_shared_appearance_subscriptions; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sip_shared_appearance_subscriptions (
    subscriber character varying(255),
    call_id character varying(255),
    aor character varying(255),
    profile_name character varying(255),
    hostname character varying(255),
    contact_str character varying(255),
    network_ip character varying(255)
);


ALTER TABLE public.sip_shared_appearance_subscriptions OWNER TO freeswitch;

--
-- Name: sip_subscriptions; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sip_subscriptions (
    proto character varying(255),
    sip_user character varying(255),
    sip_host character varying(255),
    sub_to_user character varying(255),
    sub_to_host character varying(255),
    presence_hosts character varying(255),
    event character varying(255),
    contact character varying(1024),
    call_id character varying(255),
    full_from character varying(255),
    full_via character varying(255),
    expires integer,
    user_agent character varying(255),
    accept character varying(255),
    profile_name character varying(255),
    hostname character varying(255),
    network_port character varying(6),
    network_ip character varying(255)
);


ALTER TABLE public.sip_subscriptions OWNER TO freeswitch;

--
-- Name: sofia_aliases; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sofia_aliases (
    id integer NOT NULL,
    sofia_id integer NOT NULL,
    alias_name character varying(256) NOT NULL
);


ALTER TABLE public.sofia_aliases OWNER TO freeswitch;

--
-- Name: sofia_aliases_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE sofia_aliases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sofia_aliases_id_seq OWNER TO freeswitch;

--
-- Name: sofia_aliases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE sofia_aliases_id_seq OWNED BY sofia_aliases.id;


--
-- Name: sofia_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sofia_conf (
    id integer NOT NULL,
    profile_name character varying(256) NOT NULL
);


ALTER TABLE public.sofia_conf OWNER TO freeswitch;

--
-- Name: sofia_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE sofia_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sofia_conf_id_seq OWNER TO freeswitch;

--
-- Name: sofia_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE sofia_conf_id_seq OWNED BY sofia_conf.id;


--
-- Name: sofia_domains; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sofia_domains (
    id integer NOT NULL,
    sofia_id integer NOT NULL,
    domain_name character varying(256) NOT NULL,
    parse boolean DEFAULT false NOT NULL
);


ALTER TABLE public.sofia_domains OWNER TO freeswitch;

--
-- Name: sofia_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE sofia_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sofia_domains_id_seq OWNER TO freeswitch;

--
-- Name: sofia_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE sofia_domains_id_seq OWNED BY sofia_domains.id;


--
-- Name: sofia_gateways; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sofia_gateways (
    id integer NOT NULL,
    sofia_id integer NOT NULL,
    gateway_name character varying(256) NOT NULL,
    gateway_param character varying(256) NOT NULL,
    gateway_value character varying(256) NOT NULL
);


ALTER TABLE public.sofia_gateways OWNER TO freeswitch;

--
-- Name: sofia_gateways_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE sofia_gateways_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sofia_gateways_id_seq OWNER TO freeswitch;

--
-- Name: sofia_gateways_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE sofia_gateways_id_seq OWNED BY sofia_gateways.id;


--
-- Name: sofia_settings; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE sofia_settings (
    id integer NOT NULL,
    sofia_id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.sofia_settings OWNER TO freeswitch;

--
-- Name: sofia_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE sofia_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sofia_settings_id_seq OWNER TO freeswitch;

--
-- Name: sofia_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE sofia_settings_id_seq OWNED BY sofia_settings.id;


--
-- Name: voicemail_conf; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE voicemail_conf (
    id integer NOT NULL,
    vm_profile character varying(256) NOT NULL
);


ALTER TABLE public.voicemail_conf OWNER TO freeswitch;

--
-- Name: voicemail_conf_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE voicemail_conf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voicemail_conf_id_seq OWNER TO freeswitch;

--
-- Name: voicemail_conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE voicemail_conf_id_seq OWNED BY voicemail_conf.id;


--
-- Name: voicemail_email; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE voicemail_email (
    id integer NOT NULL,
    voicemail_id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.voicemail_email OWNER TO freeswitch;

--
-- Name: voicemail_email_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE voicemail_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voicemail_email_id_seq OWNER TO freeswitch;

--
-- Name: voicemail_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE voicemail_email_id_seq OWNED BY voicemail_email.id;


--
-- Name: voicemail_msgs; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE voicemail_msgs (
    created_epoch integer,
    read_epoch integer,
    username character varying(255),
    domain character varying(255),
    uuid character varying(255),
    cid_name character varying(255),
    cid_number character varying(255),
    in_folder character varying(255),
    file_path character varying(255),
    message_len integer,
    flags character varying(255),
    read_flags character varying(255)
);


ALTER TABLE public.voicemail_msgs OWNER TO freeswitch;

--
-- Name: voicemail_prefs; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE voicemail_prefs (
    username character varying(255),
    domain character varying(255),
    name_path character varying(255),
    greeting_path character varying(255),
    password character varying(255)
);


ALTER TABLE public.voicemail_prefs OWNER TO freeswitch;

--
-- Name: voicemail_settings; Type: TABLE; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE TABLE voicemail_settings (
    id integer NOT NULL,
    voicemail_id integer NOT NULL,
    param_name character varying(256) NOT NULL,
    param_value character varying(256) NOT NULL
);


ALTER TABLE public.voicemail_settings OWNER TO freeswitch;

--
-- Name: voicemail_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: freeswitch
--

CREATE SEQUENCE voicemail_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voicemail_settings_id_seq OWNER TO freeswitch;

--
-- Name: voicemail_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freeswitch
--

ALTER SEQUENCE voicemail_settings_id_seq OWNED BY voicemail_settings.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY acl_lists ALTER COLUMN id SET DEFAULT nextval('acl_lists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY acl_nodes ALTER COLUMN id SET DEFAULT nextval('acl_nodes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY carrier_gateway ALTER COLUMN id SET DEFAULT nextval('carrier_gateway_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY carriers ALTER COLUMN id SET DEFAULT nextval('carriers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY cdr ALTER COLUMN id SET DEFAULT nextval('cdr_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY conference_advertise ALTER COLUMN id SET DEFAULT nextval('conference_advertise_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY conference_controls ALTER COLUMN id SET DEFAULT nextval('conference_controls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY conference_profiles ALTER COLUMN id SET DEFAULT nextval('conference_profiles_id_seq'::regclass);


--
-- Name: dialplan_id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan ALTER COLUMN dialplan_id SET DEFAULT nextval('dialplan_dialplan_id_seq'::regclass);


--
-- Name: action_id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_actions ALTER COLUMN action_id SET DEFAULT nextval('dialplan_actions_action_id_seq'::regclass);


--
-- Name: condition_id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_condition ALTER COLUMN condition_id SET DEFAULT nextval('dialplan_condition_condition_id_seq'::regclass);


--
-- Name: context_id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_context ALTER COLUMN context_id SET DEFAULT nextval('dialplan_context_context_id_seq'::regclass);


--
-- Name: extension_id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_extension ALTER COLUMN extension_id SET DEFAULT nextval('dialplan_extension_extension_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_special ALTER COLUMN id SET DEFAULT nextval('dialplan_special_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dingaling_profile_params ALTER COLUMN id SET DEFAULT nextval('dingaling_profile_params_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dingaling_profiles ALTER COLUMN id SET DEFAULT nextval('dingaling_profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dingaling_settings ALTER COLUMN id SET DEFAULT nextval('dingaling_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory ALTER COLUMN id SET DEFAULT nextval('directory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_domains ALTER COLUMN id SET DEFAULT nextval('directory_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_gateway_params ALTER COLUMN id SET DEFAULT nextval('directory_gateway_params_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_gateways ALTER COLUMN id SET DEFAULT nextval('directory_gateways_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_global_params ALTER COLUMN id SET DEFAULT nextval('directory_global_params_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_global_vars ALTER COLUMN id SET DEFAULT nextval('directory_global_vars_id_seq'::regclass);


--
-- Name: map_id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_group_user_map ALTER COLUMN map_id SET DEFAULT nextval('directory_group_user_map_map_id_seq'::regclass);


--
-- Name: group_id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_groups ALTER COLUMN group_id SET DEFAULT nextval('directory_groups_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_params ALTER COLUMN id SET DEFAULT nextval('directory_params_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_vars ALTER COLUMN id SET DEFAULT nextval('directory_vars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY easyroute_conf ALTER COLUMN id SET DEFAULT nextval('easyroute_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY easyroute_data ALTER COLUMN id SET DEFAULT nextval('easyroute_data_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY iax_conf ALTER COLUMN id SET DEFAULT nextval('iax_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY iax_settings ALTER COLUMN id SET DEFAULT nextval('iax_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY ivr_conf ALTER COLUMN id SET DEFAULT nextval('ivr_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY ivr_entries ALTER COLUMN id SET DEFAULT nextval('ivr_entries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY lcr ALTER COLUMN id SET DEFAULT nextval('lcr_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY lcr_conf ALTER COLUMN id SET DEFAULT nextval('lcr_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY lcr_profiles ALTER COLUMN id SET DEFAULT nextval('lcr_profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY lcr_settings ALTER COLUMN id SET DEFAULT nextval('lcr_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY limit_conf ALTER COLUMN id SET DEFAULT nextval('limit_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY local_stream_conf ALTER COLUMN id SET DEFAULT nextval('local_stream_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY modless_conf ALTER COLUMN id SET DEFAULT nextval('modless_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY post_load_modules_conf ALTER COLUMN id SET DEFAULT nextval('post_load_modules_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY rss_conf ALTER COLUMN id SET DEFAULT nextval('rss_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_aliases ALTER COLUMN id SET DEFAULT nextval('sofia_aliases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_conf ALTER COLUMN id SET DEFAULT nextval('sofia_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_domains ALTER COLUMN id SET DEFAULT nextval('sofia_domains_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_gateways ALTER COLUMN id SET DEFAULT nextval('sofia_gateways_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_settings ALTER COLUMN id SET DEFAULT nextval('sofia_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY voicemail_conf ALTER COLUMN id SET DEFAULT nextval('voicemail_conf_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY voicemail_email ALTER COLUMN id SET DEFAULT nextval('voicemail_email_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY voicemail_settings ALTER COLUMN id SET DEFAULT nextval('voicemail_settings_id_seq'::regclass);


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY accounts (id, name, cash) FROM stdin;
\.


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('accounts_id_seq', 1, false);


--
-- Data for Name: acl_lists; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY acl_lists (id, acl_name, default_policy) FROM stdin;
\.


--
-- Name: acl_lists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('acl_lists_id_seq', 1, false);


--
-- Data for Name: acl_nodes; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY acl_nodes (id, cidr, type, list_id) FROM stdin;
\.


--
-- Name: acl_nodes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('acl_nodes_id_seq', 1, false);


--
-- Data for Name: carrier_gateway; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY carrier_gateway (id, carrier_id, prefix, suffix, codec, enabled) FROM stdin;
1	1	sofia/internal/	@conference.freeswitch.org		t
\.


--
-- Name: carrier_gateway_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('carrier_gateway_id_seq', 1, true);


--
-- Data for Name: carriers; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY carriers (id, carrier_name, enabled) FROM stdin;
1	FreeSWITCH Conference	t
\.


--
-- Name: carriers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('carriers_id_seq', 1, true);


--
-- Data for Name: cdr; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY cdr (id, caller_id_name, caller_id_number, destination_number, context, start_stamp, answer_stamp, end_stamp, duration, billsec, hangup_cause, uuid, bleg_uuid, accountcode, read_codec, write_codec) FROM stdin;
\.


--
-- Name: cdr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('cdr_id_seq', 1, false);


--
-- Data for Name: conference_advertise; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY conference_advertise (id, room, status) FROM stdin;
\.


--
-- Name: conference_advertise_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('conference_advertise_id_seq', 1, false);


--
-- Data for Name: conference_controls; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY conference_controls (id, conf_group, action, digits) FROM stdin;
\.


--
-- Name: conference_controls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('conference_controls_id_seq', 1, false);


--
-- Data for Name: conference_profiles; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY conference_profiles (id, profile_name, param_name, param_value) FROM stdin;
\.


--
-- Name: conference_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('conference_profiles_id_seq', 1, false);


--
-- Data for Name: dialplan; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dialplan (dialplan_id, domain, ip_address) FROM stdin;
2	192.168.86.198	192.168.86.198
\.


--
-- Data for Name: dialplan_actions; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dialplan_actions (action_id, condition_id, application, data, type, weight) FROM stdin;
1	1	transfer	lcr $1	action	0
\.


--
-- Name: dialplan_actions_action_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dialplan_actions_action_id_seq', 1, true);


--
-- Data for Name: dialplan_condition; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dialplan_condition (condition_id, extension_id, field, expression, weight) FROM stdin;
1	1	destination_number	^1[2-9]\\d{2}[2-9]\\d{6}$	0
\.


--
-- Name: dialplan_condition_condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dialplan_condition_condition_id_seq', 1, true);


--
-- Data for Name: dialplan_context; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dialplan_context (context_id, dialplan_id, context, weight) FROM stdin;
1	2	default	0
\.


--
-- Name: dialplan_context_context_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dialplan_context_context_id_seq', 1, true);


--
-- Name: dialplan_dialplan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dialplan_dialplan_id_seq', 2, true);


--
-- Data for Name: dialplan_extension; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dialplan_extension (extension_id, context_id, name, continue, weight) FROM stdin;
1	1	lcr	false	0
\.


--
-- Name: dialplan_extension_extension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dialplan_extension_extension_id_seq', 1, true);


--
-- Data for Name: dialplan_special; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dialplan_special (id, context, class_file) FROM stdin;
\.


--
-- Name: dialplan_special_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dialplan_special_id_seq', 1, false);


--
-- Data for Name: dingaling_profile_params; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dingaling_profile_params (id, dingaling_id, param_name, param_value) FROM stdin;
\.


--
-- Name: dingaling_profile_params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dingaling_profile_params_id_seq', 1, false);


--
-- Data for Name: dingaling_profiles; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dingaling_profiles (id, profile_name, type) FROM stdin;
\.


--
-- Name: dingaling_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dingaling_profiles_id_seq', 1, false);


--
-- Data for Name: dingaling_settings; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY dingaling_settings (id, param_name, param_value) FROM stdin;
\.


--
-- Name: dingaling_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('dingaling_settings_id_seq', 1, false);


--
-- Data for Name: directory; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory (id, username, domain_id, cache) FROM stdin;
1	1010	1	300000
2	1010	2	300000
3	1010	3	300000
\.


--
-- Data for Name: directory_domains; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_domains (id, domain_name) FROM stdin;
1	rc-vaio.intralanman.com
2	192.168.86.198
3	10.66.29.101
\.


--
-- Name: directory_domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_domains_id_seq', 3, true);


--
-- Data for Name: directory_gateway_params; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_gateway_params (id, d_gw_id, param_name, param_value) FROM stdin;
\.


--
-- Name: directory_gateway_params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_gateway_params_id_seq', 1, false);


--
-- Data for Name: directory_gateways; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_gateways (id, directory_id, gateway_name) FROM stdin;
\.


--
-- Name: directory_gateways_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_gateways_id_seq', 1, false);


--
-- Data for Name: directory_global_params; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_global_params (id, param_name, param_value, domain_id) FROM stdin;
\.


--
-- Name: directory_global_params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_global_params_id_seq', 1, false);


--
-- Data for Name: directory_global_vars; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_global_vars (id, var_name, var_value, domain_id) FROM stdin;
\.


--
-- Name: directory_global_vars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_global_vars_id_seq', 1, false);


--
-- Data for Name: directory_group_user_map; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_group_user_map (map_id, group_id, user_id) FROM stdin;
\.


--
-- Name: directory_group_user_map_map_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_group_user_map_map_id_seq', 1, false);


--
-- Data for Name: directory_groups; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_groups (group_id, group_name) FROM stdin;
\.


--
-- Name: directory_groups_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_groups_group_id_seq', 1, false);


--
-- Name: directory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_id_seq', 3, true);


--
-- Data for Name: directory_params; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_params (id, directory_id, param_name, param_value) FROM stdin;
1	1	password	1234
2	2	password	1234
3	3	password	1234
\.


--
-- Name: directory_params_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_params_id_seq', 6, true);


--
-- Data for Name: directory_vars; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY directory_vars (id, directory_id, var_name, var_value) FROM stdin;
\.


--
-- Name: directory_vars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('directory_vars_id_seq', 1, false);


--
-- Data for Name: easyroute_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY easyroute_conf (id, param_name, param_value) FROM stdin;
\.


--
-- Name: easyroute_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('easyroute_conf_id_seq', 1, false);


--
-- Data for Name: easyroute_data; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY easyroute_data (id, gateway, "group", call_limit, tech_prefix, acctcode, destination_number) FROM stdin;
\.


--
-- Name: easyroute_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('easyroute_data_id_seq', 1, false);


--
-- Data for Name: iax_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY iax_conf (id, profile_name) FROM stdin;
\.


--
-- Name: iax_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('iax_conf_id_seq', 1, false);


--
-- Data for Name: iax_settings; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY iax_settings (id, iax_id, param_name, param_value) FROM stdin;
\.


--
-- Name: iax_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('iax_settings_id_seq', 1, false);


--
-- Data for Name: ivr_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY ivr_conf (id, name, greet_long, greet_short, invalid_sound, exit_sound, max_failures, timeout, tts_engine, tts_voice) FROM stdin;
\.


--
-- Name: ivr_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('ivr_conf_id_seq', 1, false);


--
-- Data for Name: ivr_entries; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY ivr_entries (id, ivr_id, action, digits, params) FROM stdin;
\.


--
-- Name: ivr_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('ivr_entries_id_seq', 1, false);


--
-- Data for Name: lcr; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY lcr (id, digits, rate, intrastate_rate, intralata_rate, carrier_id, lead_strip, trail_strip, prefix, suffix, lcr_profile, date_start, date_end, quality, reliability, cid, enabled, lrn) FROM stdin;
2	1	11.00000	11.00000	11.00000	1	11	0	888		1	1970-01-01 00:00:00-05	2030-12-31 00:00:00-05	0.000000	0.000000		t	f
\.


--
-- Data for Name: lcr_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY lcr_conf (id, param_name, param_value) FROM stdin;
1	odbc-dsn	pgsql://hostaddr=127.0.0.1 dbname=freeswitch user=freeswitch password=Fr33Sw1tch
\.


--
-- Name: lcr_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('lcr_conf_id_seq', 1, true);


--
-- Name: lcr_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('lcr_id_seq', 2, true);


--
-- Data for Name: lcr_profiles; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY lcr_profiles (id, profile_name) FROM stdin;
1	default
\.


--
-- Name: lcr_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('lcr_profiles_id_seq', 1, true);


--
-- Data for Name: lcr_settings; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY lcr_settings (id, lcr_id, param_name, param_value) FROM stdin;
\.


--
-- Name: lcr_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('lcr_settings_id_seq', 1, false);


--
-- Data for Name: limit_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY limit_conf (id, name, value) FROM stdin;
\.


--
-- Name: limit_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('limit_conf_id_seq', 1, false);


--
-- Data for Name: limit_data; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY limit_data (hostname, realm, id, uuid) FROM stdin;
\.


--
-- Data for Name: local_stream_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY local_stream_conf (id, directory_name, directory_path, param_name, param_value) FROM stdin;
\.


--
-- Name: local_stream_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('local_stream_conf_id_seq', 1, false);


--
-- Data for Name: modless_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY modless_conf (id, conf_name) FROM stdin;
1	post_load_switch.conf
2	console.conf
\.


--
-- Name: modless_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('modless_conf_id_seq', 2, true);


--
-- Data for Name: npa_nxx_company_ocn; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY npa_nxx_company_ocn (npa, nxx, company_type, ocn, company_name, lata, ratecenter, state) FROM stdin;
\.


--
-- Data for Name: post_load_modules_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY post_load_modules_conf (id, module_name, load_module, priority) FROM stdin;
1	mod_commands	t	1000
2	mod_sofia	t	1000
3	mod_cdr_csv	t	1000
4	mod_translate	t	1000
5	mod_db	t	1000
\.


--
-- Name: post_load_modules_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('post_load_modules_conf_id_seq', 5, true);


--
-- Data for Name: rss_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY rss_conf (id, directory_id, feed, local_file, description, priority) FROM stdin;
\.


--
-- Name: rss_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('rss_conf_id_seq', 1, false);


--
-- Data for Name: sip_authentication; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sip_authentication (nonce, expires, profile_name, hostname) FROM stdin;
\.


--
-- Data for Name: sip_dialogs; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sip_dialogs (call_id, uuid, sip_to_user, sip_to_host, sip_from_user, sip_from_host, contact_user, contact_host, state, direction, user_agent, profile_name, hostname) FROM stdin;
\.


--
-- Data for Name: sip_presence; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sip_presence (sip_user, sip_host, status, rpid, expires, user_agent, profile_name, hostname, network_ip, network_port) FROM stdin;
\.


--
-- Data for Name: sip_registrations; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sip_registrations (call_id, sip_user, sip_host, presence_hosts, contact, status, rpid, expires, user_agent, server_user, server_host, profile_name, hostname, network_ip, network_port, sip_username, sip_realm, mwi_user, mwi_host) FROM stdin;
\.


--
-- Data for Name: sip_shared_appearance_dialogs; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sip_shared_appearance_dialogs (profile_name, hostname, contact_str, call_id, network_ip, expires) FROM stdin;
\.


--
-- Data for Name: sip_shared_appearance_subscriptions; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sip_shared_appearance_subscriptions (subscriber, call_id, aor, profile_name, hostname, contact_str, network_ip) FROM stdin;
\.


--
-- Data for Name: sip_subscriptions; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sip_subscriptions (proto, sip_user, sip_host, sub_to_user, sub_to_host, presence_hosts, event, contact, call_id, full_from, full_via, expires, user_agent, accept, profile_name, hostname, network_port, network_ip) FROM stdin;
\.


--
-- Data for Name: sofia_aliases; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sofia_aliases (id, sofia_id, alias_name) FROM stdin;
\.


--
-- Name: sofia_aliases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('sofia_aliases_id_seq', 1, false);


--
-- Data for Name: sofia_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sofia_conf (id, profile_name) FROM stdin;
1	internal
\.


--
-- Name: sofia_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('sofia_conf_id_seq', 1, true);


--
-- Data for Name: sofia_domains; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sofia_domains (id, sofia_id, domain_name, parse) FROM stdin;
\.


--
-- Name: sofia_domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('sofia_domains_id_seq', 1, false);


--
-- Data for Name: sofia_gateways; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sofia_gateways (id, sofia_id, gateway_name, gateway_param, gateway_value) FROM stdin;
\.


--
-- Name: sofia_gateways_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('sofia_gateways_id_seq', 1, false);


--
-- Data for Name: sofia_settings; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY sofia_settings (id, sofia_id, param_name, param_value) FROM stdin;
1	1	dialplan	translate,XML
2	1	inbound-codec-prefs	OPUS,G722.1,G722,PCMU,speex
3	1	outbound-codec-prefs	OPUS,G722.1,G722,PCMU,speex
4	1	sip-trace	yes
\.


--
-- Name: sofia_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('sofia_settings_id_seq', 4, true);


--
-- Data for Name: voicemail_conf; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY voicemail_conf (id, vm_profile) FROM stdin;
\.


--
-- Name: voicemail_conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('voicemail_conf_id_seq', 1, false);


--
-- Data for Name: voicemail_email; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY voicemail_email (id, voicemail_id, param_name, param_value) FROM stdin;
\.


--
-- Name: voicemail_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('voicemail_email_id_seq', 1, false);


--
-- Data for Name: voicemail_msgs; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY voicemail_msgs (created_epoch, read_epoch, username, domain, uuid, cid_name, cid_number, in_folder, file_path, message_len, flags, read_flags) FROM stdin;
\.


--
-- Data for Name: voicemail_prefs; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY voicemail_prefs (username, domain, name_path, greeting_path, password) FROM stdin;
\.


--
-- Data for Name: voicemail_settings; Type: TABLE DATA; Schema: public; Owner: freeswitch
--

COPY voicemail_settings (id, voicemail_id, param_name, param_value) FROM stdin;
\.


--
-- Name: voicemail_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freeswitch
--

SELECT pg_catalog.setval('voicemail_settings_id_seq', 1, false);


--
-- Name: acl_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY acl_lists
    ADD CONSTRAINT acl_lists_pkey PRIMARY KEY (id);


--
-- Name: acl_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY acl_nodes
    ADD CONSTRAINT acl_nodes_pkey PRIMARY KEY (id);


--
-- Name: carrier_gateway_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY carrier_gateway
    ADD CONSTRAINT carrier_gateway_pkey PRIMARY KEY (id);


--
-- Name: carriers_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY carriers
    ADD CONSTRAINT carriers_pkey PRIMARY KEY (id);


--
-- Name: cdr_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY cdr
    ADD CONSTRAINT cdr_pkey PRIMARY KEY (id);


--
-- Name: conference_advertise_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY conference_advertise
    ADD CONSTRAINT conference_advertise_pkey PRIMARY KEY (id);


--
-- Name: conference_controls_conf_group_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY conference_controls
    ADD CONSTRAINT conference_controls_conf_group_key UNIQUE (conf_group, action);


--
-- Name: conference_controls_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY conference_controls
    ADD CONSTRAINT conference_controls_pkey PRIMARY KEY (id);


--
-- Name: conference_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY conference_profiles
    ADD CONSTRAINT conference_profiles_pkey PRIMARY KEY (id);


--
-- Name: conference_profiles_profile_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY conference_profiles
    ADD CONSTRAINT conference_profiles_profile_name_key UNIQUE (profile_name, param_name);


--
-- Name: dialplan_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dialplan_actions
    ADD CONSTRAINT dialplan_actions_pkey PRIMARY KEY (action_id);


--
-- Name: dialplan_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dialplan_condition
    ADD CONSTRAINT dialplan_condition_pkey PRIMARY KEY (condition_id);


--
-- Name: dialplan_context_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dialplan_context
    ADD CONSTRAINT dialplan_context_pkey PRIMARY KEY (context_id);


--
-- Name: dialplan_extension_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dialplan_extension
    ADD CONSTRAINT dialplan_extension_pkey PRIMARY KEY (extension_id);


--
-- Name: dialplan_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dialplan
    ADD CONSTRAINT dialplan_pkey PRIMARY KEY (dialplan_id);


--
-- Name: dialplan_special_context_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dialplan_special
    ADD CONSTRAINT dialplan_special_context_key UNIQUE (context);


--
-- Name: dialplan_special_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dialplan_special
    ADD CONSTRAINT dialplan_special_pkey PRIMARY KEY (id);


--
-- Name: dingaling_profile_params_dingaling_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dingaling_profile_params
    ADD CONSTRAINT dingaling_profile_params_dingaling_id_key UNIQUE (dingaling_id, param_name);


--
-- Name: dingaling_profile_params_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dingaling_profile_params
    ADD CONSTRAINT dingaling_profile_params_pkey PRIMARY KEY (id);


--
-- Name: dingaling_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dingaling_profiles
    ADD CONSTRAINT dingaling_profiles_pkey PRIMARY KEY (id);


--
-- Name: dingaling_profiles_profile_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dingaling_profiles
    ADD CONSTRAINT dingaling_profiles_profile_name_key UNIQUE (profile_name);


--
-- Name: dingaling_settings_param_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dingaling_settings
    ADD CONSTRAINT dingaling_settings_param_name_key UNIQUE (param_name);


--
-- Name: dingaling_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY dingaling_settings
    ADD CONSTRAINT dingaling_settings_pkey PRIMARY KEY (id);


--
-- Name: directory_domains_domain_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_domains
    ADD CONSTRAINT directory_domains_domain_name_key UNIQUE (domain_name);


--
-- Name: directory_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_domains
    ADD CONSTRAINT directory_domains_pkey PRIMARY KEY (id);


--
-- Name: directory_gateway_params_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_gateway_params
    ADD CONSTRAINT directory_gateway_params_pkey PRIMARY KEY (id);


--
-- Name: directory_gateways_gateway_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_gateways
    ADD CONSTRAINT directory_gateways_gateway_name_key UNIQUE (gateway_name);


--
-- Name: directory_gateways_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_gateways
    ADD CONSTRAINT directory_gateways_pkey PRIMARY KEY (id);


--
-- Name: directory_global_params_directory_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_global_params
    ADD CONSTRAINT directory_global_params_directory_id_key UNIQUE (domain_id, param_name);


--
-- Name: directory_global_params_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_global_params
    ADD CONSTRAINT directory_global_params_pkey PRIMARY KEY (id);


--
-- Name: directory_global_vars_directory_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_global_vars
    ADD CONSTRAINT directory_global_vars_directory_id_key UNIQUE (domain_id, var_name);


--
-- Name: directory_global_vars_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_global_vars
    ADD CONSTRAINT directory_global_vars_pkey PRIMARY KEY (id);


--
-- Name: directory_group_user_map_group_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_group_user_map
    ADD CONSTRAINT directory_group_user_map_group_id_key UNIQUE (group_id, user_id);


--
-- Name: directory_group_user_map_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_group_user_map
    ADD CONSTRAINT directory_group_user_map_pkey PRIMARY KEY (map_id);


--
-- Name: directory_groups_group_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_groups
    ADD CONSTRAINT directory_groups_group_name_key UNIQUE (group_name);


--
-- Name: directory_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_groups
    ADD CONSTRAINT directory_groups_pkey PRIMARY KEY (group_id);


--
-- Name: directory_params_directory_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_params
    ADD CONSTRAINT directory_params_directory_id_key UNIQUE (directory_id, param_name);


--
-- Name: directory_params_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_params
    ADD CONSTRAINT directory_params_pkey PRIMARY KEY (id);


--
-- Name: directory_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory
    ADD CONSTRAINT directory_pkey PRIMARY KEY (id);


--
-- Name: directory_username_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory
    ADD CONSTRAINT directory_username_key UNIQUE (username, domain_id);


--
-- Name: directory_vars_directory_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_vars
    ADD CONSTRAINT directory_vars_directory_id_key UNIQUE (directory_id, var_name);


--
-- Name: directory_vars_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY directory_vars
    ADD CONSTRAINT directory_vars_pkey PRIMARY KEY (id);


--
-- Name: easyroute_conf_param_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY easyroute_conf
    ADD CONSTRAINT easyroute_conf_param_name_key UNIQUE (param_name);


--
-- Name: easyroute_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY easyroute_conf
    ADD CONSTRAINT easyroute_conf_pkey PRIMARY KEY (id);


--
-- Name: easyroute_data_destination_number_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY easyroute_data
    ADD CONSTRAINT easyroute_data_destination_number_key UNIQUE (destination_number);


--
-- Name: easyroute_data_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY easyroute_data
    ADD CONSTRAINT easyroute_data_pkey PRIMARY KEY (id);


--
-- Name: iax_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY iax_conf
    ADD CONSTRAINT iax_conf_pkey PRIMARY KEY (id);


--
-- Name: iax_conf_profile_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY iax_conf
    ADD CONSTRAINT iax_conf_profile_name_key UNIQUE (profile_name);


--
-- Name: iax_settings_iax_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY iax_settings
    ADD CONSTRAINT iax_settings_iax_id_key UNIQUE (iax_id, param_name);


--
-- Name: iax_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY iax_settings
    ADD CONSTRAINT iax_settings_pkey PRIMARY KEY (id);


--
-- Name: ivr_conf_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY ivr_conf
    ADD CONSTRAINT ivr_conf_name_key UNIQUE (name);


--
-- Name: ivr_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY ivr_conf
    ADD CONSTRAINT ivr_conf_pkey PRIMARY KEY (id);


--
-- Name: ivr_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY ivr_entries
    ADD CONSTRAINT ivr_entries_pkey PRIMARY KEY (id);


--
-- Name: lcr_conf_param_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY lcr_conf
    ADD CONSTRAINT lcr_conf_param_name_key UNIQUE (param_name);


--
-- Name: lcr_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY lcr_conf
    ADD CONSTRAINT lcr_conf_pkey PRIMARY KEY (id);


--
-- Name: lcr_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY lcr
    ADD CONSTRAINT lcr_pkey PRIMARY KEY (id);


--
-- Name: lcr_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY lcr_profiles
    ADD CONSTRAINT lcr_profiles_pkey PRIMARY KEY (id);


--
-- Name: lcr_profiles_profile_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY lcr_profiles
    ADD CONSTRAINT lcr_profiles_profile_name_key UNIQUE (profile_name);


--
-- Name: lcr_settings_lcr_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY lcr_settings
    ADD CONSTRAINT lcr_settings_lcr_id_key UNIQUE (lcr_id, param_name);


--
-- Name: lcr_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY lcr_settings
    ADD CONSTRAINT lcr_settings_pkey PRIMARY KEY (id);


--
-- Name: limit_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY limit_conf
    ADD CONSTRAINT limit_conf_pkey PRIMARY KEY (id);


--
-- Name: local_stream_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY local_stream_conf
    ADD CONSTRAINT local_stream_conf_pkey PRIMARY KEY (id);


--
-- Name: modless_conf_conf_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY modless_conf
    ADD CONSTRAINT modless_conf_conf_name_key UNIQUE (conf_name);


--
-- Name: modless_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY modless_conf
    ADD CONSTRAINT modless_conf_pkey PRIMARY KEY (id);


--
-- Name: npa_nxx_company_ocn_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY npa_nxx_company_ocn
    ADD CONSTRAINT npa_nxx_company_ocn_pkey PRIMARY KEY (npa, nxx);


--
-- Name: post_load_modules_conf_module_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY post_load_modules_conf
    ADD CONSTRAINT post_load_modules_conf_module_name_key UNIQUE (module_name);


--
-- Name: post_load_modules_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY post_load_modules_conf
    ADD CONSTRAINT post_load_modules_conf_pkey PRIMARY KEY (id);


--
-- Name: rss_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY rss_conf
    ADD CONSTRAINT rss_conf_pkey PRIMARY KEY (id);


--
-- Name: sofia_aliases_alias_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_aliases
    ADD CONSTRAINT sofia_aliases_alias_name_key UNIQUE (alias_name);


--
-- Name: sofia_aliases_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_aliases
    ADD CONSTRAINT sofia_aliases_pkey PRIMARY KEY (id);


--
-- Name: sofia_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_conf
    ADD CONSTRAINT sofia_conf_pkey PRIMARY KEY (id);


--
-- Name: sofia_conf_profile_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_conf
    ADD CONSTRAINT sofia_conf_profile_name_key UNIQUE (profile_name);


--
-- Name: sofia_domains_domain_name_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_domains
    ADD CONSTRAINT sofia_domains_domain_name_key UNIQUE (domain_name);


--
-- Name: sofia_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_domains
    ADD CONSTRAINT sofia_domains_pkey PRIMARY KEY (id);


--
-- Name: sofia_gateways_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_gateways
    ADD CONSTRAINT sofia_gateways_pkey PRIMARY KEY (id);


--
-- Name: sofia_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_settings
    ADD CONSTRAINT sofia_settings_pkey PRIMARY KEY (id);


--
-- Name: sofia_settings_sofia_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY sofia_settings
    ADD CONSTRAINT sofia_settings_sofia_id_key UNIQUE (sofia_id, param_name);


--
-- Name: voicemail_conf_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY voicemail_conf
    ADD CONSTRAINT voicemail_conf_pkey PRIMARY KEY (id);


--
-- Name: voicemail_conf_vm_profile_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY voicemail_conf
    ADD CONSTRAINT voicemail_conf_vm_profile_key UNIQUE (vm_profile);


--
-- Name: voicemail_email_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY voicemail_email
    ADD CONSTRAINT voicemail_email_pkey PRIMARY KEY (id);


--
-- Name: voicemail_email_voicemail_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY voicemail_email
    ADD CONSTRAINT voicemail_email_voicemail_id_key UNIQUE (voicemail_id, param_name);


--
-- Name: voicemail_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY voicemail_settings
    ADD CONSTRAINT voicemail_settings_pkey PRIMARY KEY (id);


--
-- Name: voicemail_settings_voicemail_id_key; Type: CONSTRAINT; Schema: public; Owner: freeswitch; Tablespace: 
--

ALTER TABLE ONLY voicemail_settings
    ADD CONSTRAINT voicemail_settings_voicemail_id_key UNIQUE (voicemail_id, param_name);


--
-- Name: digits_rate; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX digits_rate ON lcr USING btree (digits, rate);


--
-- Name: fki_; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX fki_ ON acl_nodes USING btree (list_id);


--
-- Name: fki_lcr_profile; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX fki_lcr_profile ON lcr USING btree (lcr_profile);


--
-- Name: gateway; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE UNIQUE INDEX gateway ON carrier_gateway USING btree (prefix, suffix);


--
-- Name: profile_digits_15; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX profile_digits_15 ON lcr USING btree (digits, lcr_profile);


--
-- Name: sa_hostname; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sa_hostname ON sip_authentication USING btree (hostname);


--
-- Name: sa_nonce; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sa_nonce ON sip_authentication USING btree (nonce);


--
-- Name: sd_hostname; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sd_hostname ON sip_dialogs USING btree (hostname);


--
-- Name: sd_uuid; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sd_uuid ON sip_dialogs USING btree (uuid);


--
-- Name: sp_hostname; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sp_hostname ON sip_presence USING btree (hostname);


--
-- Name: sr_call_id; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_call_id ON sip_registrations USING btree (call_id);


--
-- Name: sr_contact; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_contact ON sip_registrations USING btree (contact);


--
-- Name: sr_expires; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_expires ON sip_registrations USING btree (expires);


--
-- Name: sr_hostname; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_hostname ON sip_registrations USING btree (hostname);


--
-- Name: sr_network_ip; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_network_ip ON sip_registrations USING btree (network_ip);


--
-- Name: sr_network_port; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_network_port ON sip_registrations USING btree (network_port);


--
-- Name: sr_presence_hosts; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_presence_hosts ON sip_registrations USING btree (presence_hosts);


--
-- Name: sr_profile_name; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_profile_name ON sip_registrations USING btree (profile_name);


--
-- Name: sr_sip_host; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_sip_host ON sip_registrations USING btree (sip_host);


--
-- Name: sr_sip_realm; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_sip_realm ON sip_registrations USING btree (sip_realm);


--
-- Name: sr_sip_user; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_sip_user ON sip_registrations USING btree (sip_user);


--
-- Name: sr_sip_username; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_sip_username ON sip_registrations USING btree (sip_username);


--
-- Name: sr_status; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX sr_status ON sip_registrations USING btree (status);


--
-- Name: ss_call_id; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_call_id ON sip_subscriptions USING btree (call_id);


--
-- Name: ss_event; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_event ON sip_subscriptions USING btree (event);


--
-- Name: ss_hostname; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_hostname ON sip_subscriptions USING btree (hostname);


--
-- Name: ss_presence_hosts; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_presence_hosts ON sip_subscriptions USING btree (presence_hosts);


--
-- Name: ss_proto; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_proto ON sip_subscriptions USING btree (proto);


--
-- Name: ss_sip_host; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_sip_host ON sip_subscriptions USING btree (sip_host);


--
-- Name: ss_sip_user; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_sip_user ON sip_subscriptions USING btree (sip_user);


--
-- Name: ss_sub_to_host; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_sub_to_host ON sip_subscriptions USING btree (sub_to_host);


--
-- Name: ss_sub_to_user; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ss_sub_to_user ON sip_subscriptions USING btree (sub_to_user);


--
-- Name: ssa_aor; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssa_aor ON sip_shared_appearance_subscriptions USING btree (aor);


--
-- Name: ssa_hostname; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssa_hostname ON sip_shared_appearance_subscriptions USING btree (hostname);


--
-- Name: ssa_profile_name; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssa_profile_name ON sip_shared_appearance_subscriptions USING btree (profile_name);


--
-- Name: ssa_subscriber; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssa_subscriber ON sip_shared_appearance_subscriptions USING btree (subscriber);


--
-- Name: ssd_call_id; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssd_call_id ON sip_shared_appearance_dialogs USING btree (call_id);


--
-- Name: ssd_contact_str; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssd_contact_str ON sip_shared_appearance_dialogs USING btree (contact_str);


--
-- Name: ssd_expires; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssd_expires ON sip_shared_appearance_dialogs USING btree (expires);


--
-- Name: ssd_hostname; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssd_hostname ON sip_shared_appearance_dialogs USING btree (hostname);


--
-- Name: ssd_profile_name; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX ssd_profile_name ON sip_shared_appearance_dialogs USING btree (profile_name);


--
-- Name: unique_route; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX unique_route ON lcr USING btree (digits, carrier_id);


--
-- Name: voicemail_msgs_idx1; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_msgs_idx1 ON voicemail_msgs USING btree (created_epoch);


--
-- Name: voicemail_msgs_idx2; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_msgs_idx2 ON voicemail_msgs USING btree (username);


--
-- Name: voicemail_msgs_idx3; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_msgs_idx3 ON voicemail_msgs USING btree (domain);


--
-- Name: voicemail_msgs_idx4; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_msgs_idx4 ON voicemail_msgs USING btree (uuid);


--
-- Name: voicemail_msgs_idx5; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_msgs_idx5 ON voicemail_msgs USING btree (in_folder);


--
-- Name: voicemail_msgs_idx6; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_msgs_idx6 ON voicemail_msgs USING btree (read_flags);


--
-- Name: voicemail_prefs_idx1; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_prefs_idx1 ON voicemail_prefs USING btree (username);


--
-- Name: voicemail_prefs_idx2; Type: INDEX; Schema: public; Owner: freeswitch; Tablespace: 
--

CREATE INDEX voicemail_prefs_idx2 ON voicemail_prefs USING btree (domain);


--
-- Name: acl_nodes_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY acl_nodes
    ADD CONSTRAINT acl_nodes_list_id_fkey FOREIGN KEY (list_id) REFERENCES acl_lists(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: carrier_gateway_carrier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY carrier_gateway
    ADD CONSTRAINT carrier_gateway_carrier_id_fkey FOREIGN KEY (carrier_id) REFERENCES carriers(id);


--
-- Name: dialplan_actions_condition_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_actions
    ADD CONSTRAINT dialplan_actions_condition_id_fkey FOREIGN KEY (condition_id) REFERENCES dialplan_condition(condition_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dialplan_condition_extension_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_condition
    ADD CONSTRAINT dialplan_condition_extension_id_fkey FOREIGN KEY (extension_id) REFERENCES dialplan_extension(extension_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dialplan_context_dialplan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_context
    ADD CONSTRAINT dialplan_context_dialplan_id_fkey FOREIGN KEY (dialplan_id) REFERENCES dialplan(dialplan_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dialplan_extension_context_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dialplan_extension
    ADD CONSTRAINT dialplan_extension_context_id_fkey FOREIGN KEY (context_id) REFERENCES dialplan_context(context_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dingaling_profile_params_dingaling_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY dingaling_profile_params
    ADD CONSTRAINT dingaling_profile_params_dingaling_id_fkey FOREIGN KEY (dingaling_id) REFERENCES dingaling_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_gateway_params_d_gw_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_gateway_params
    ADD CONSTRAINT directory_gateway_params_d_gw_id_fkey FOREIGN KEY (d_gw_id) REFERENCES directory_gateways(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_gateways_directory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_gateways
    ADD CONSTRAINT directory_gateways_directory_id_fkey FOREIGN KEY (directory_id) REFERENCES directory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_global_params_directory_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_global_params
    ADD CONSTRAINT directory_global_params_directory_id_fkey1 FOREIGN KEY (domain_id) REFERENCES directory_domains(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_global_vars_directory_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_global_vars
    ADD CONSTRAINT directory_global_vars_directory_id_fkey1 FOREIGN KEY (domain_id) REFERENCES directory_domains(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_group_user_map_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_group_user_map
    ADD CONSTRAINT directory_group_user_map_group_id_fkey FOREIGN KEY (group_id) REFERENCES directory_groups(group_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_group_user_map_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_group_user_map
    ADD CONSTRAINT directory_group_user_map_user_id_fkey FOREIGN KEY (user_id) REFERENCES directory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_params_directory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_params
    ADD CONSTRAINT directory_params_directory_id_fkey FOREIGN KEY (directory_id) REFERENCES directory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: directory_vars_directory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY directory_vars
    ADD CONSTRAINT directory_vars_directory_id_fkey FOREIGN KEY (directory_id) REFERENCES directory(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: iax_settings_iax_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY iax_settings
    ADD CONSTRAINT iax_settings_iax_id_fkey FOREIGN KEY (iax_id) REFERENCES iax_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ivr_entries_ivr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY ivr_entries
    ADD CONSTRAINT ivr_entries_ivr_id_fkey FOREIGN KEY (ivr_id) REFERENCES ivr_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lcr_carrier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY lcr
    ADD CONSTRAINT lcr_carrier_id_fkey FOREIGN KEY (carrier_id) REFERENCES carriers(id);


--
-- Name: lcr_profile; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY lcr
    ADD CONSTRAINT lcr_profile FOREIGN KEY (lcr_profile) REFERENCES lcr_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: lcr_settings_lcr_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY lcr_settings
    ADD CONSTRAINT lcr_settings_lcr_id_fkey FOREIGN KEY (lcr_id) REFERENCES lcr_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sofia_aliases_sofia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_aliases
    ADD CONSTRAINT sofia_aliases_sofia_id_fkey FOREIGN KEY (sofia_id) REFERENCES sofia_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sofia_domains_sofia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_domains
    ADD CONSTRAINT sofia_domains_sofia_id_fkey FOREIGN KEY (sofia_id) REFERENCES sofia_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sofia_gateways_sofia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_gateways
    ADD CONSTRAINT sofia_gateways_sofia_id_fkey FOREIGN KEY (sofia_id) REFERENCES sofia_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sofia_settings_sofia_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY sofia_settings
    ADD CONSTRAINT sofia_settings_sofia_id_fkey FOREIGN KEY (sofia_id) REFERENCES sofia_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: voicemail_email_voicemail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY voicemail_email
    ADD CONSTRAINT voicemail_email_voicemail_id_fkey FOREIGN KEY (voicemail_id) REFERENCES voicemail_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: voicemail_settings_voicemail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freeswitch
--

ALTER TABLE ONLY voicemail_settings
    ADD CONSTRAINT voicemail_settings_voicemail_id_fkey FOREIGN KEY (voicemail_id) REFERENCES voicemail_conf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

