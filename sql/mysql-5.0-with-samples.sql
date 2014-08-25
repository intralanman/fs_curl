-- phpMyAdmin SQL Dump
-- version 3.1.2deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 15, 2009 at 09:35 PM
-- Server version: 5.0.75
-- PHP Version: 5.2.6-3ubuntu2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `freeswitch`
--

-- --------------------------------------------------------

--
-- Table structure for table `acl_lists`
--

CREATE TABLE IF NOT EXISTS `acl_lists` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `acl_name` varchar(128) NOT NULL,
  `default_policy` varchar(45) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `acl_lists`
--

INSERT INTO `acl_lists` (`id`, `acl_name`, `default_policy`) VALUES
(1, 'rfc1918', 'deny'),
(2, 'lan', 'allow'),
(3, 'default', 'allow');

-- --------------------------------------------------------

--
-- Table structure for table `acl_nodes`
--

CREATE TABLE IF NOT EXISTS `acl_nodes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `cidr` varchar(45) NOT NULL,
  `type` varchar(16) NOT NULL,
  `list_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `acl_nodes`
--

INSERT INTO `acl_nodes` (`id`, `cidr`, `type`, `list_id`) VALUES
(1, '192.168.0.0/16', 'allow', 1),
(2, '10.0.0.0/8', 'allow', 1),
(3, '172.16.0.0/12', 'allow', 1);

-- --------------------------------------------------------

--
-- Table structure for table `cdr`
--

CREATE TABLE IF NOT EXISTS `cdr` (
  `id` int(11) NOT NULL auto_increment,
  `caller_id_name` varchar(255) NOT NULL default '',
  `caller_id_number` varchar(255) NOT NULL default '',
  `destination_number` varchar(255) NOT NULL default '',
  `context` varchar(255) NOT NULL default '',
  `start_stamp` varchar(255) NOT NULL default '',
  `answer_stamp` varchar(255) NOT NULL default '',
  `end_stamp` varchar(255) NOT NULL default '',
  `duration` varchar(255) NOT NULL default '',
  `billsec` varchar(255) NOT NULL default '',
  `hangup_cause` varchar(255) NOT NULL default '',
  `uuid` varchar(255) NOT NULL default '',
  `bleg_uuid` varchar(255) NOT NULL default '',
  `accountcode` varchar(255) NOT NULL default '',
  `read_codec` varchar(255) NOT NULL default '',
  `write_codec` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

--
-- Table structure for table `conference_advertise`
--

CREATE TABLE IF NOT EXISTS `conference_advertise` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `room` varchar(64) NOT NULL,
  `status` varchar(128) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_room` (`room`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `conference_advertise`
--

INSERT INTO `conference_advertise` (`id`, `room`, `status`) VALUES
(1, '3000@$${domain}', 'Freeswitch Conference'),
(2, '3001@$${domain}', 'FreeSWITCH Conference 2'),
(3, '3002@$${domain}', 'FreeSWITCH Conference 3');

-- --------------------------------------------------------

--
-- Table structure for table `conference_controls`
--

CREATE TABLE IF NOT EXISTS `conference_controls` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `conf_group` varchar(64) NOT NULL,
  `action` varchar(64) NOT NULL,
  `digits` varchar(16) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_group_action` USING BTREE (`conf_group`,`action`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `conference_controls`
--

INSERT INTO `conference_controls` (`id`, `conf_group`, `action`, `digits`) VALUES
(1, 'default', 'mute', '0'),
(2, 'default', 'deaf_mute', '*'),
(3, 'default', 'energy up', '9'),
(4, 'default', 'energy equ', '8'),
(5, 'default', 'energy dn', '7'),
(6, 'default', 'vol talk up', '3'),
(7, 'default', 'vol talk dn', '1'),
(8, 'default', 'vol talk zero', '2'),
(9, 'default', 'vol listen up', '6'),
(10, 'default', 'vol listen dn', '4'),
(11, 'default', 'vol listen zero', '5'),
(12, 'default', 'hangup', '#');

-- --------------------------------------------------------

--
-- Table structure for table `conference_profiles`
--

CREATE TABLE IF NOT EXISTS `conference_profiles` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `profile_name` varchar(64) NOT NULL,
  `param_name` varchar(64) NOT NULL,
  `param_value` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `unique_profile_param` (`profile_name`,`param_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `conference_profiles`
--

INSERT INTO `conference_profiles` (`id`, `profile_name`, `param_name`, `param_value`) VALUES
(1, 'default', 'domain', '$${domain}'),
(2, 'default', 'rate', '8000'),
(3, 'default', 'interval', '20'),
(4, 'default', 'energy-level', '300'),
(5, 'default', 'moh-sound', '$${moh_uri}'),
(6, 'default', 'caller-id-name', '$${outbound_caller_name}'),
(7, 'default', 'caller-id-number', '$${outbound_caller_number}');

-- --------------------------------------------------------

--
-- Table structure for table `dialplan`
--

CREATE TABLE IF NOT EXISTS `dialplan` (
  `dialplan_id` int(11) NOT NULL auto_increment,
  `domain` varchar(128) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  PRIMARY KEY  (`dialplan_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `dialplan`
--

INSERT INTO `dialplan` (`dialplan_id`, `domain`, `ip_address`) VALUES
(1, 'freeswitch', '127.0.0.1');

-- --------------------------------------------------------

--
-- Table structure for table `dialplan_actions`
--

CREATE TABLE IF NOT EXISTS `dialplan_actions` (
  `action_id` int(11) NOT NULL auto_increment,
  `condition_id` int(11) NOT NULL,
  `application` varchar(256) NOT NULL,
  `data` varchar(256) NOT NULL,
  `type` varchar(32) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY  (`action_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=170 ;

--
-- Dumping data for table `dialplan_actions`
--

INSERT INTO `dialplan_actions` (`action_id`, `condition_id`, `application`, `data`, `type`, `weight`) VALUES
(1, 2, 'deflect', '${destination_number}', 'action', 10),
(2, 5, 'set', 'domain_name=$${domain}', 'action', 20),
(3, 5, 'set', 'domain_name=${sip_auth_realm}', 'anti-action', 30),
(4, 7, 'set', 'domain_name=$${domain}', 'action', 40),
(5, 9, 'set', 'open=true', 'action', 50),
(6, 10, 'answer', '', 'action', 60),
(7, 10, 'intercept', '${db(select/${domain_name}-last_dial/global)}', 'action', 70),
(8, 10, 'sleep', '2000', 'action', 80),
(9, 11, 'answer', '', 'action', 90),
(10, 11, 'intercept', '${db(select/${domain_name}-last_dial/${callgroup})}', 'action', 100),
(11, 11, 'sleep', '2000', 'action', 110),
(12, 12, 'answer', '', 'action', 120),
(13, 12, 'intercept', '${db(select/${domain_name}-last_dial_ext/$1)}', 'action', 130),
(14, 12, 'sleep', '2000', 'action', 140),
(15, 13, 'transfer', '${db(select/${domain_name}-last_dial/${caller_id_number})}', 'action', 150),
(16, 14, 'set', 'use_profile=${cond(${acl($${local_ip_v4} rfc1918)} == true ? nat : default)}', 'action', 160),
(17, 14, 'set', 'use_profile=${cond(${acl(${network_addr} rfc1918)} == true ? nat : default)}', 'anti-action', 170),
(18, 15, 'set_user', 'default@${domain_name}', 'action', 180),
(19, 16, 'info', '', 'action', 190),
(20, 17, 'set', 'sip_secure_media=true', 'action', 200),
(21, 18, 'db', 'insert/${domain_name}-spymap/${caller_id_number}/${uuid}', 'action', 210),
(22, 18, 'db', 'insert/${domain_name}-last_dial/${caller_id_number}/${destination_number}', 'action', 220),
(23, 18, 'db', 'insert/${domain_name}-last_dial/global/${uuid}', 'action', 230),
(24, 19, 'eval', '${snom_bind_key(2 off DND ${sip_from_user} ${sip_from_host} ${sofia_profile_name} message notused)}', 'action', 240),
(25, 19, 'transfer', '3000', 'action', 250),
(26, 20, 'eval', '${snom_bind_key(2 on DND ${sip_from_user} ${sip_from_host} ${sofia_profile_name} message api+uuid_transfer ${uuid} 9001)}', 'action', 260),
(27, 20, 'playback', '$${hold_music}', 'action', 270),
(28, 21, 'answer', '', 'action', 280),
(29, 21, 'eavesdrop', '${db(select/${domain_name}-spymap/$1)}', 'action', 290),
(30, 22, 'answer', '', 'action', 300),
(31, 22, 'set', 'eavesdrop_indicate_failed=tone_stream://%(500, 0, 320)', 'action', 310),
(32, 22, 'set', 'eavesdrop_indicate_new=tone_stream://%(500, 0, 620)', 'action', 320),
(33, 22, 'set', 'eavesdrop_indicate_idle=tone_stream://%(250, 0, 920)', 'action', 330),
(34, 22, 'eavesdrop', 'all', 'action', 340),
(35, 23, 'transfer', '${db(select/${domain_name}-call_return/${caller_id_number})}', 'action', 350),
(36, 24, 'answer', '', 'action', 360),
(37, 24, 'group', 'delete:$1@${domain_name}:${sofia_contact(${sip_from_user}@${domain_name})}', 'action', 370),
(38, 24, 'gentones', '%(1000, 0, 320)', 'action', 380),
(39, 25, 'answer', '', 'action', 390),
(40, 25, 'group', 'insert:$1@${domain_name}:${sofia_contact(${sip_from_user}@${domain_name})}', 'action', 400),
(41, 25, 'gentones', '%(1000, 0, 640)', 'action', 410),
(42, 26, 'bridge', '{ignore_early_media=true}${group(call:$1@${domain_name})}', 'action', 420),
(43, 27, 'set', 'call_timeout=10', 'action', 430),
(44, 27, 'bridge', '{ignore_early_media=true}${group(call:$1@${domain_name}:order)}', 'action', 440),
(45, 28, 'set', 'dialed_extension=$1', 'action', 450),
(46, 28, 'export', 'sip_auto_answer=true', 'action', 460),
(47, 28, 'bridge', 'user/${dialed_extension}@${domain_name}', 'action', 470),
(48, 29, 'set', 'dialed_extension=$1', 'action', 480),
(49, 29, 'export', 'dialed_extension=$1', 'action', 490),
(50, 30, 'set', 'voicemail_authorized=${sip_authorized}', 'action', 500),
(51, 30, 'answer', '', 'action', 510),
(52, 30, 'sleep', '1000', 'action', 520),
(53, 30, 'voicemail', 'check default ${domain_name} ${dialed_extension}', 'action', 530),
(54, 30, 'bind_meta_app', '1 b s execute_extension::dx XML features', 'anti-action', 540),
(55, 30, 'bind_meta_app', '2 b s record_session::$${recordings_dir}/${caller_id_number}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav', 'anti-action', 550),
(56, 30, 'bind_meta_app', '3 b s execute_extension::cf XML features', 'anti-action', 560),
(57, 30, 'set', 'ringback=${us-ring}', 'anti-action', 570),
(58, 30, 'set', 'transfer_ringback=$${hold_music}', 'anti-action', 580),
(59, 30, 'set', 'call_timeout=30', 'anti-action', 590),
(60, 30, 'set', 'hangup_after_bridge=true', 'anti-action', 600),
(61, 30, 'set', 'continue_on_fail=true', 'anti-action', 610),
(62, 30, 'db', 'insert/${domain_name}-call_return/${dialed_extension}/${caller_id_number}', 'anti-action', 620),
(63, 30, 'db', 'insert/${domain_name}-last_dial_ext/${dialed_extension}/${uuid}', 'anti-action', 630),
(64, 30, 'set', 'called_party_callgroup=${user_data(${dialed_extension}@${domain_name} var callgroup)}', 'anti-action', 640),
(65, 30, 'db', 'insert/${domain_name}-last_dial/${called_party_callgroup}/${uuid}', 'anti-action', 650),
(66, 30, 'bridge', 'user/${dialed_extension}@${domain_name}', 'anti-action', 660),
(67, 30, 'answer', '', 'anti-action', 670),
(68, 30, 'sleep', '1000', 'anti-action', 680),
(69, 30, 'voicemail', 'default ${domain_name} ${dialed_extension}', 'anti-action', 690),
(70, 31, 'bridge', '${group_call(sales@${domain_name})}', 'action', 700),
(71, 32, 'bridge', 'group/support@${domain_name}', 'action', 710),
(72, 33, 'bridge', 'group/billing@${domain_name}', 'action', 720),
(73, 34, 'set', 'transfer_ringback=$${hold_music}', 'action', 730),
(74, 34, 'transfer', '1000 XML features', 'action', 740),
(75, 35, 'answer', '', 'action', 750),
(76, 35, 'sleep', '1000', 'action', 760),
(77, 35, 'voicemail', 'check default ${domain_name}', 'action', 770),
(78, 36, 'bridge', 'sofia/${use_profile}/$1', 'action', 780),
(79, 37, 'answer', '', 'action', 790),
(80, 37, 'conference', '$1-${domain_name}@default', 'action', 800),
(81, 38, 'answer', '', 'action', 810),
(82, 38, 'conference', '$1-${domain_name}@wideband', 'action', 820),
(83, 39, 'answer', '', 'action', 830),
(84, 39, 'conference', '$1-${domain_name}@ultrawideband', 'action', 840),
(85, 40, 'answer', '', 'action', 850),
(86, 40, 'conference', '$1-${domain_name}@cdquality', 'action', 860),
(87, 41, 'bridge', 'sofia/${use_profile}/$1@conference.freeswitch.org', 'action', 870),
(88, 42, 'set', 'conference_auto_outcall_caller_id_name=Mad Boss1', 'action', 880),
(89, 42, 'set', 'conference_auto_outcall_caller_id_number=0911', 'action', 890),
(90, 42, 'set', 'conference_auto_outcall_timeout=60', 'action', 900),
(91, 42, 'set', 'conference_auto_outcall_flags=mute', 'action', 910),
(92, 42, 'set', 'conference_auto_outcall_prefix={sip_auto_answer=true,execute_on_answer=''bind_meta_app 2 a s1 intercept::${uuid}''}', 'action', 920),
(93, 42, 'set', 'sip_exclude_contact=${network_addr}', 'action', 930),
(94, 42, 'conference_set_auto_outcall', '${group_call(sales)}', 'action', 940),
(95, 42, 'conference', 'madboss_intercom1@default+flags{endconf|deaf}', 'action', 950),
(96, 43, 'set', 'conference_auto_outcall_caller_id_name=Mad Boss2', 'action', 960),
(97, 43, 'set', 'conference_auto_outcall_caller_id_number=0912', 'action', 970),
(98, 43, 'set', 'conference_auto_outcall_timeout=60', 'action', 980),
(99, 43, 'set', 'conference_auto_outcall_flags=mute', 'action', 990),
(100, 43, 'set', 'conference_auto_outcall_prefix={sip_auto_answer=true,execute_on_answer=''bind_meta_app 2 a s1 intercept::${uuid}''}', 'action', 1000),
(101, 43, 'set', 'sip_exclude_contact=${network_addr}', 'action', 1010),
(102, 43, 'conference_set_auto_outcall', 'loopback/9999', 'action', 1020),
(103, 43, 'conference', 'madboss_intercom2@default+flags{endconf|deaf}', 'action', 1030),
(104, 44, 'set', 'conference_auto_outcall_caller_id_name=Mad Boss', 'action', 1040),
(105, 44, 'set', 'conference_auto_outcall_caller_id_number=0911', 'action', 1050),
(106, 44, 'set', 'conference_auto_outcall_timeout=60', 'action', 1060),
(107, 44, 'set', 'conference_auto_outcall_flags=none', 'action', 1070),
(108, 44, 'conference_set_auto_outcall', 'loopback/9999', 'action', 1080),
(109, 44, 'conference', 'madboss3@default', 'action', 1090),
(110, 45, 'answer', '', 'action', 1100),
(111, 45, 'sleep', '2000', 'action', 1110),
(112, 45, 'ivr', 'demo_ivr', 'action', 1120),
(113, 46, 'conference', 'bridge:mydynaconf:sofia/${use_profile}/1234@conference.freeswitch.org', 'action', 1130),
(114, 47, 'answer', '', 'action', 1140),
(115, 47, 'esf_page_group', '', 'action', 1150),
(116, 48, 'set', 'fifo_music=$${hold_music}', 'action', 1160),
(117, 48, 'fifo', '5900@${domain_name} in', 'action', 1170),
(118, 49, 'answer', '', 'action', 1180),
(119, 49, 'fifo', '5900@${domain_name} out nowait', 'action', 1190),
(120, 51, 'fifo', '$1@${domain_name} in undef $${hold_music}', 'action', 1200),
(121, 54, 'answer', '', 'action', 1210),
(122, 54, 'fifo', '$1@${domain_name} out nowait', 'action', 1220),
(123, 57, '', '', 'expression', 1230),
(124, 57, 'fifo', '$1@${domain_name} in undef $${hold_music}', 'action', 1240),
(125, 60, 'answer', '', 'action', 1250),
(126, 60, 'fifo', '$1@${domain_name} out nowait', 'action', 1260),
(127, 61, 'pre_answer', '', 'action', 1270),
(128, 61, 'sleep', '20000', 'action', 1280),
(129, 61, 'answer', '', 'action', 1290),
(130, 61, 'sleep', '1000', 'action', 1300),
(131, 61, 'playback', 'voicemail/vm-goodbye.wav', 'action', 1310),
(132, 61, 'hangup', '', 'action', 1320),
(133, 62, 'ring_ready', '', 'action', 1330),
(134, 62, 'sleep', '20000', 'action', 1340),
(135, 62, 'answer', '', 'action', 1350),
(136, 62, 'sleep', '1000', 'action', 1360),
(137, 62, 'playback', 'voicemail/vm-goodbye.wav', 'action', 1370),
(138, 62, 'hangup', '', 'action', 1380),
(139, 63, 'set', 'ringback=$${uk-ring}', 'action', 1390),
(140, 63, 'bridge', 'loopback/wait', 'action', 1400),
(141, 64, 'set', 'ringback=$${hold_music}', 'action', 1410),
(142, 64, 'bridge', 'loopback/wait', 'action', 1420),
(143, 65, 'set', 'transfer_ringback=$${uk-ring}', 'action', 1430),
(144, 65, 'answer', '', 'action', 1440),
(145, 65, 'bridge', 'loopback/wait', 'action', 1450),
(146, 66, 'set', 'transfer_ringback=$${hold_music}', 'action', 1460),
(147, 66, 'answer', '', 'action', 1470),
(148, 66, 'bridge', 'loopback/wait', 'action', 1480),
(149, 67, 'answer', '', 'action', 1490),
(150, 67, 'info', '', 'action', 1500),
(151, 67, 'sleep', '250', 'action', 1510),
(152, 67, 'hangup', '', 'action', 1520),
(153, 68, 'answer', '', 'action', 1530),
(154, 68, 'record_fsv', '/tmp/testrecord.fsv', 'action', 1540),
(155, 69, 'answer', '', 'action', 1550),
(156, 69, 'play_fsv', '/tmp/testrecord.fsv', 'action', 1560),
(157, 70, 'answer', '', 'action', 1570),
(158, 70, 'delay_echo', '5000', 'action', 1580),
(159, 71, 'answer', '', 'action', 1590),
(160, 71, 'echo', '', 'action', 1600),
(161, 72, 'answer', '', 'action', 1610),
(162, 72, 'playback', 'tone_stream://%(10000,0,1004);loops=-1', 'action', 1620),
(163, 73, 'answer', '', 'action', 1630),
(164, 73, 'playback', 'tone_stream://path=${base_dir}/conf/tetris.ttml;loops=10', 'action', 1640),
(165, 75, 'answer', '', 'action', 1650),
(166, 75, 'execute_extension', 'is_secure XML features', 'action', 1660),
(167, 75, 'playback', '$${hold_music}', 'action', 1670),
(168, 75, 'answer', '', 'anti-action', 1680),
(169, 75, 'playback', '$${hold_music}', 'anti-action', 1690);

-- --------------------------------------------------------

--
-- Table structure for table `dialplan_condition`
--

CREATE TABLE IF NOT EXISTS `dialplan_condition` (
  `condition_id` int(11) NOT NULL auto_increment,
  `extension_id` int(11) NOT NULL,
  `field` varchar(1238) NOT NULL,
  `expression` varchar(128) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY  (`condition_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=76 ;

--
-- Dumping data for table `dialplan_condition`
--

INSERT INTO `dialplan_condition` (`condition_id`, `extension_id`, `field`, `expression`, `weight`) VALUES
(1, 1, '$${unroll_loops}', '^true$', 10),
(2, 1, '${sip_looped_call}', '^true$', 20),
(3, 2, '${domain_name}', '^$', 30),
(4, 2, 'source', 'mod_sofia', 40),
(5, 2, '${sip_auth_realm}', '^$', 50),
(6, 3, '${domain_name}', '^$', 60),
(7, 3, 'source', 'mod_openzap', 70),
(8, 4, '${strftime(%w)}', '^([1-5])$', 80),
(9, 4, '${strftime(%H%M)}', '^((09|1[0-7])[0-5][0-9]|1800)$', 90),
(10, 5, 'destination_number', '^886$', 100),
(11, 6, 'destination_number', '^\\*8$', 110),
(12, 7, 'destination_number', '^\\*\\*(\\d+)$', 120),
(13, 8, 'destination_number', '^870$', 130),
(14, 9, '${network_addr}', '^$', 140),
(15, 9, '${numbering_plan}', '^$', 150),
(16, 9, '${call_debug}', '^true$', 160),
(17, 9, '${sip_has_crypto}', '^(AES_CM_128_HMAC_SHA1_32|AES_CM_128_HMAC_SHA1_80)$', 170),
(18, 9, '', '', 180),
(19, 10, 'destination_number', '^9001$', 190),
(20, 11, 'destination_number', '^9000$', 200),
(21, 12, 'destination_number', '^88(.*)$|^\\*0(.*)$', 210),
(22, 13, 'destination_number', '^779$', 220),
(23, 14, 'destination_number', '^\\*69$|^869$|^lcr$', 230),
(24, 15, 'destination_number', '^80(\\d{2})$', 240),
(25, 16, 'destination_number', '^81(\\d{2})$', 250),
(26, 17, 'destination_number', '^82(\\d{2})$', 260),
(27, 18, 'destination_number', '^83(\\d{2})$', 270),
(28, 19, 'destination_number', '^8(10[01][0-9])$', 280),
(29, 20, 'destination_number', '^(20[01][0-9])$', 290),
(30, 20, 'destination_number', '^${caller_id_number}$', 300),
(31, 21, 'destination_number', '^3000$', 310),
(32, 22, 'destination_number', '^3001$', 320),
(33, 23, 'destination_number', '^3002$', 330),
(34, 24, 'destination_number', '^operator$|^0$', 340),
(35, 25, 'destination_number', '^vmain|4000$', 350),
(36, 26, 'destination_number', '^sip:(.*)$', 360),
(37, 27, 'destination_number', '^(30\\d{2})$', 370),
(38, 28, 'destination_number', '^(31\\d{2})$', 380),
(39, 29, 'destination_number', '^(32\\d{2})$', 390),
(40, 30, 'destination_number', '^(33\\d{2})$', 400),
(41, 31, 'destination_number', '^9(888|1616|3232)$', 410),
(42, 32, 'destination_number', '^0911$', 420),
(43, 33, 'destination_number', '^0912$', 430),
(44, 34, 'destination_number', '^0913$', 440),
(45, 35, 'destination_number', '^5000$', 450),
(46, 36, 'destination_number', '^5001$', 460),
(47, 37, 'destination_number', '^pagegroup$|^7243', 470),
(48, 38, 'destination_number', '^5900$', 480),
(49, 39, 'destination_number', '^5901$', 490),
(50, 40, 'source', 'mod_sofia', 500),
(51, 40, 'destination_number', 'park\\+(\\d+)', 510),
(52, 41, 'source', 'mod_sofia', 520),
(53, 41, 'destination_number', '^parking$', 530),
(54, 41, '${sip_to_params}', 'fifo\\=(\\d+)', 540),
(55, 42, 'source', 'mod_sofia', 550),
(56, 42, 'destination_number', 'callpark', 560),
(57, 42, '${sip_refer_to}', '', 570),
(58, 43, 'source', 'mod_sofia', 580),
(59, 43, 'destination_number', 'pickup', 590),
(60, 43, '${sip_to_params}', 'orbit\\=(\\d+)', 600),
(61, 44, 'destination_number', '^wait$', 610),
(62, 45, 'destination_number', '^9980$', 620),
(63, 46, 'destination_number', '^9981$', 630),
(64, 47, 'destination_number', '^9982$', 640),
(65, 48, 'destination_number', '^9983$', 650),
(66, 49, 'destination_number', '^9984$', 660),
(67, 50, 'destination_number', '^9992$', 670),
(68, 51, 'destination_number', '^9993$', 680),
(69, 52, 'destination_number', '^9994$', 690),
(70, 53, 'destination_number', '^9995$', 700),
(71, 54, 'destination_number', '^9996$', 710),
(72, 55, 'destination_number', '^9997$', 720),
(73, 56, 'destination_number', '^9998$', 730),
(74, 57, 'destination_number', '^9999$', 740),
(75, 57, '${sip_has_crypto}', '^(AES_CM_128_HMAC_SHA1_32|AES_CM_128_HMAC_SHA1_80)$', 750);

-- --------------------------------------------------------

--
-- Table structure for table `dialplan_context`
--

CREATE TABLE IF NOT EXISTS `dialplan_context` (
  `context_id` int(11) NOT NULL auto_increment,
  `dialplan_id` int(11) NOT NULL,
  `context` varchar(64) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY  (`context_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `dialplan_context`
--

INSERT INTO `dialplan_context` (`context_id`, `dialplan_id`, `context`, `weight`) VALUES
(1, 1, 'default', 10),
(2, 1, 'public', 20);

-- --------------------------------------------------------

--
-- Table structure for table `dialplan_extension`
--

CREATE TABLE IF NOT EXISTS `dialplan_extension` (
  `extension_id` int(11) NOT NULL auto_increment,
  `context_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `continue` varchar(32) NOT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY  (`extension_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=58 ;

--
-- Dumping data for table `dialplan_extension`
--

INSERT INTO `dialplan_extension` (`extension_id`, `context_id`, `name`, `continue`, `weight`) VALUES
(1, 1, 'unloop', '', 10),
(2, 1, 'set_domain', 'true', 20),
(3, 1, 'set_domain_openzap', 'true', 30),
(4, 1, 'tod_example', 'true', 40),
(5, 1, 'global-intercept', '', 50),
(6, 1, 'group-intercept', '', 60),
(7, 1, 'intercept-ext', '', 70),
(8, 1, 'redial', '', 80),
(9, 1, 'global', 'true', 90),
(10, 1, 'snom-demo-2', '', 100),
(11, 1, 'snom-demo-1', '', 110),
(12, 1, 'eavesdrop', '', 120),
(13, 1, 'eavesdrop', '', 130),
(14, 1, 'call_return', '', 140),
(15, 1, 'del-group', '', 150),
(16, 1, 'add-group', '', 160),
(17, 1, 'call-group-simo', '', 170),
(18, 1, 'call-group-order', '', 180),
(19, 1, 'extension-intercom', '', 190),
(20, 1, 'Local_Extension', '', 200),
(21, 1, 'group_dial_sales', '', 210),
(22, 1, 'group_dial_support', '', 220),
(23, 1, 'group_dial_billing', '', 230),
(24, 1, 'operator', '', 240),
(25, 1, 'vmain', '', 250),
(26, 1, 'sip_uri', '', 260),
(27, 1, 'nb_conferences', '', 270),
(28, 1, 'wb_conferences', '', 280),
(29, 1, 'uwb_conferences', '', 290),
(30, 1, 'cdquality_conferences', '', 300),
(31, 1, 'freeswitch_public_conf_via_sip', '', 310),
(32, 1, 'mad_boss_intercom', '', 320),
(33, 1, 'mad_boss_intercom', '', 330),
(34, 1, 'mad_boss', '', 340),
(35, 1, 'ivr_demo', '', 350),
(36, 1, 'dyanmic conference', '', 360),
(37, 1, 'rtp_multicast_page', '', 370),
(38, 1, 'park', '', 380),
(39, 1, 'unpark', '', 390),
(40, 1, 'park', '', 400),
(41, 1, 'unpark', '', 410),
(42, 1, 'park', '', 420),
(43, 1, 'unpark', '', 430),
(44, 1, 'wait', '', 440),
(45, 1, 'ringback_180', '', 450),
(46, 1, 'ringback_183_uk_ring', '', 460),
(47, 1, 'ringback_183_music_ring', '', 470),
(48, 1, 'ringback_post_answer_uk_ring', '', 480),
(49, 1, 'ringback_post_answer_music', '', 490),
(50, 1, 'show_info', '', 500),
(51, 1, 'video_record', '', 510),
(52, 1, 'video_playback', '', 520),
(53, 1, 'delay_echo', '', 530),
(54, 1, 'echo', '', 540),
(55, 1, 'milliwatt', '', 550),
(56, 2, 'tone_stream', '', 560),
(57, 2, 'hold_music', '', 570);

-- --------------------------------------------------------

--
-- Table structure for table `dialplan_special`
--

CREATE TABLE IF NOT EXISTS `dialplan_special` (
  `id` int(11) NOT NULL auto_increment,
  `context` varchar(255) NOT NULL,
  `class_file` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_context` (`context`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `dialplan_special`
--


-- --------------------------------------------------------

--
-- Table structure for table `dingaling_profiles`
--

CREATE TABLE IF NOT EXISTS `dingaling_profiles` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `profile_name` varchar(64) NOT NULL,
  `type` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_name` (`profile_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `dingaling_profiles`
--

INSERT INTO `dingaling_profiles` (`id`, `profile_name`, `type`) VALUES
(1, 'fs.intralanman.servehttp.com', 'component');

-- --------------------------------------------------------

--
-- Table structure for table `dingaling_profile_params`
--

CREATE TABLE IF NOT EXISTS `dingaling_profile_params` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `dingaling_id` int(10) unsigned NOT NULL,
  `param_name` varchar(64) NOT NULL,
  `param_value` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_type_name` (`dingaling_id`,`param_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `dingaling_profile_params`
--

INSERT INTO `dingaling_profile_params` (`id`, `dingaling_id`, `param_name`, `param_value`) VALUES
(1, 1, 'password', 'secret'),
(2, 1, 'dialplan', 'XML,enum'),
(3, 1, 'server', 'example.org'),
(4, 1, 'name', 'fs.example.org');

-- --------------------------------------------------------

--
-- Table structure for table `dingaling_settings`
--

CREATE TABLE IF NOT EXISTS `dingaling_settings` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `param_name` varchar(64) NOT NULL,
  `param_value` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_param` (`param_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `dingaling_settings`
--

INSERT INTO `dingaling_settings` (`id`, `param_name`, `param_value`) VALUES
(1, 'debug', '0'),
(2, 'codec-prefs', '$${global_codec_prefs}');

-- --------------------------------------------------------

--
-- Table structure for table `directory`
--

CREATE TABLE IF NOT EXISTS `directory` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) NOT NULL,
  `domain_id` int(10) NOT NULL,
  `cache` int(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `directory`
--

INSERT INTO `directory` (`id`, `username`, `domain_id`) VALUES
(1, '1000', 1),
(2, '1001', 2),
(3, '1002', 1),
(5, '1003', 2),
(6, '1004', 1),
(7, '1005', 2),
(8, '1006', 1),
(9, '1007', 2),
(10, '2000', 1),
(11, '1009', 2);

-- --------------------------------------------------------

--
-- Table structure for table `directory_domains`
--

CREATE TABLE IF NOT EXISTS `directory_domains` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `domain_name` varchar(128) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `directory_domains`
--

INSERT INTO `directory_domains` (`id`, `domain_name`) VALUES
(1, 'freeswitch.org'),
(2, 'sofaswitch.org');

-- --------------------------------------------------------

--
-- Table structure for table `directory_gateways`
--

CREATE TABLE IF NOT EXISTS `directory_gateways` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `directory_id` int(10) unsigned NOT NULL,
  `gateway_name` varchar(128) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `directory_gateways`
--


-- --------------------------------------------------------

--
-- Table structure for table `directory_gateway_params`
--

CREATE TABLE IF NOT EXISTS `directory_gateway_params` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `d_gw_id` int(10) unsigned NOT NULL,
  `param_name` varchar(64) NOT NULL,
  `param_value` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_gw_param` (`d_gw_id`,`param_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `directory_gateway_params`
--


-- --------------------------------------------------------

--
-- Table structure for table `directory_global_params`
--

CREATE TABLE IF NOT EXISTS `directory_global_params` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `param_name` varchar(64) NOT NULL,
  `param_value` varchar(128) NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `directory_global_params`
--

INSERT INTO `directory_global_params` (`id`, `param_name`, `param_value`, `domain_id`) VALUES
(1, 'default_gateway', 'errors', 1);

-- --------------------------------------------------------

--
-- Table structure for table `directory_global_vars`
--

CREATE TABLE IF NOT EXISTS `directory_global_vars` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `var_name` varchar(64) NOT NULL,
  `var_value` varchar(128) NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `directory_global_vars`
--


-- --------------------------------------------------------

--
-- Table structure for table `directory_params`
--

CREATE TABLE IF NOT EXISTS `directory_params` (
  `id` int(11) NOT NULL auto_increment,
  `directory_id` int(11) default NULL,
  `param_name` varchar(255) default NULL,
  `param_value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `directory_params`
--

INSERT INTO `directory_params` (`id`, `directory_id`, `param_name`, `param_value`) VALUES
(1, 1, 'password', '1234'),
(2, 1, 'vm-password', '861000'),
(3, 2, 'password', '1234'),
(4, 2, 'vm-password', '861001'),
(7, 5, 'password', '1234'),
(8, 6, 'password', '1234'),
(9, 7, 'password', '1234'),
(10, 8, 'password', '123456'),
(11, 9, 'password', '1234'),
(12, 10, 'password', '123456'),
(13, 11, 'password', '1234'),
(14, 3, 'vm-password', '861002'),
(15, 3, 'password', '1234'),
(16, 11, 'vm-password', '861009'),
(17, 10, 'vm-password', '1234'),
(18, 9, 'vm-password', '861007'),
(19, 8, 'vm-password', '861006'),
(20, 7, 'vm-password', '861005'),
(21, 6, 'vm-password', '861004'),
(22, 5, 'vm-password', '861003');

-- --------------------------------------------------------

--
-- Table structure for table `directory_vars`
--

CREATE TABLE IF NOT EXISTS `directory_vars` (
  `id` int(11) NOT NULL auto_increment,
  `directory_id` int(11) default NULL,
  `var_name` varchar(255) default NULL,
  `var_value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `directory_vars`
--

INSERT INTO `directory_vars` (`id`, `directory_id`, `var_name`, `var_value`) VALUES
(1, 1, 'numbering_plan', 'US'),
(2, 2, 'numbering_plan', 'US'),
(3, 3, 'numbering_plan', 'AU'),
(4, 5, 'numbering_plan', 'US'),
(5, 5, 'area_code', '434');

-- --------------------------------------------------------

--
-- Table structure for table `iax_conf`
--

CREATE TABLE IF NOT EXISTS `iax_conf` (
  `id` int(11) NOT NULL auto_increment,
  `profile_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `iax_conf`
--

INSERT INTO `iax_conf` (`id`, `profile_name`) VALUES
(3, 'test_profile');

-- --------------------------------------------------------

--
-- Table structure for table `iax_settings`
--

CREATE TABLE IF NOT EXISTS `iax_settings` (
  `id` int(11) NOT NULL auto_increment,
  `iax_id` int(11) default NULL,
  `param_name` varchar(255) default NULL,
  `param_value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `iax_settings`
--

INSERT INTO `iax_settings` (`id`, `iax_id`, `param_name`, `param_value`) VALUES
(35, 3, 'debug', '1'),
(36, 3, 'ip', '$${local_ip_v4}'),
(37, 3, 'port', '4569'),
(38, 3, 'context', 'public'),
(39, 3, 'dialplan', 'enum,XML'),
(40, 3, 'codec-prefs', '$${global_codec_prefs}'),
(41, 3, 'codec-master', 'us'),
(42, 3, 'codec-rate', '8');

-- --------------------------------------------------------

--
-- Table structure for table `ivr_conf`
--

CREATE TABLE IF NOT EXISTS `ivr_conf` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(64) NOT NULL,
  `greet_long` varchar(255) NOT NULL,
  `greet_short` varchar(255) NOT NULL,
  `invalid_sound` varchar(255) NOT NULL,
  `exit_sound` varchar(255) NOT NULL,
  `max_failures` int(10) unsigned NOT NULL default '3',
  `timeout` int(11) NOT NULL default '5',
  `tts_engine` varchar(64) default NULL,
  `tts_voice` varchar(64) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ivr_conf`
--

INSERT INTO `ivr_conf` (`id`, `name`, `greet_long`, `greet_short`, `invalid_sound`, `exit_sound`, `max_failures`, `timeout`, `tts_engine`, `tts_voice`) VALUES
(1, 'demo', 'soundfiles/ivr/demo/greet-long.wav', 'soundfiles/ivr/demo/greet-short.wav', 'soundfiles/ivr/invalid.wav', 'soundfiles/ivr/exit.wav', 3, 5, 'cepstral', 'allison'),
(2, 'demo2', 'soundfiles/ivr/demo2/greet-long.wav', 'soundfiles/ivr/demo2/greet-short.wav', 'soundfiles/ivr/invalid.wav', 'soundfiles/ivr/exit.wav', 3, 5, NULL, NULL),
(3, 'menu8', 'soundfiles/ivr/menu8/greet-long.wav', 'soundfiles/ivr/menu8/greet-short.wav', 'soundfiles/ivr/menu8/invalid.wav', 'soundfiles/ivr/menu8/exit.wav', 3, 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ivr_entries`
--

CREATE TABLE IF NOT EXISTS `ivr_entries` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `ivr_id` int(10) unsigned NOT NULL,
  `action` varchar(64) NOT NULL,
  `digits` varchar(16) NOT NULL,
  `params` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_ivr_digits` USING BTREE (`ivr_id`,`digits`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `ivr_entries`
--

INSERT INTO `ivr_entries` (`id`, `ivr_id`, `action`, `digits`, `params`) VALUES
(1, 1, 'menu-play-sound', '1', 'soundfiles/features.wav'),
(2, 1, 'menu-exit', '*', NULL),
(3, 1, 'menu-sub', '2', 'demo2'),
(4, 1, 'menu-exec-api', '3', 'bridge sofia/$${domain}/888@conference.freeswtich.org'),
(5, 1, 'menu-call-transfer', '4', '888'),
(6, 2, 'menu-back', '#', NULL),
(7, 2, 'menu-top', '*', NULL),
(8, 3, 'menu-back', '#', NULL),
(9, 3, 'menu-top', '*', NULL),
(10, 3, 'menu-playsound', '4', 'soundfiles/4.wav');

-- --------------------------------------------------------

--
-- Table structure for table `limit_conf`
--

CREATE TABLE IF NOT EXISTS `limit_conf` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `limit_conf`
--


-- --------------------------------------------------------

--
-- Table structure for table `limit_data`
--

CREATE TABLE IF NOT EXISTS `limit_data` (
  `hostname` varchar(255) default NULL,
  `realm` varchar(255) default NULL,
  `id` varchar(255) default NULL,
  `uuid` varchar(255) default NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `limit_data`
--


-- --------------------------------------------------------

--
-- Table structure for table `local_stream_conf`
--

CREATE TABLE IF NOT EXISTS `local_stream_conf` (
  `id` int(11) NOT NULL auto_increment,
  `directory_name` varchar(255) default NULL,
  `directory_path` text,
  `param_name` varchar(255) default NULL,
  `param_value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `local_stream_conf`
--


-- --------------------------------------------------------

--
-- Table structure for table `modless_conf`
--

CREATE TABLE IF NOT EXISTS `modless_conf` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `conf_name` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `modless_conf`
--

INSERT INTO `modless_conf` (`id`, `conf_name`) VALUES
(1, 'acl.conf'),
(2, 'postl_load_switch.conf'),
(3, 'post_load_modules.conf');

-- --------------------------------------------------------

--
-- Table structure for table `post_load_modules_conf`
--

CREATE TABLE IF NOT EXISTS `post_load_modules_conf` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `module_name` varchar(64) NOT NULL,
  `load_module` tinyint(1) NOT NULL default '1',
  `priority` int(10) unsigned NOT NULL default '1000',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_mod` (`module_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Dumping data for table `post_load_modules_conf`
--

INSERT INTO `post_load_modules_conf` (`id`, `module_name`, `load_module`, `priority`) VALUES
(1, 'mod_sofia', 1, 2000),
(2, 'mod_iax', 1, 2000),
(3, 'mod_xml_rpc', 1, 100),
(4, 'mod_portaudio', 1, 1000),
(5, 'mod_enum', 1, 2000),
(6, 'mod_xml_cdr', 1, 1000),
(7, 'mod_spidermonkey', 1, 1000),
(8, 'mod_alsa', 0, 1000),
(9, 'mod_log_file', 1, 0),
(10, 'mod_commands', 1, 1000),
(11, 'mod_voicemail', 1, 1000),
(12, 'mod_dialplan_xml', 1, 150),
(13, 'mod_dialplan_asterisk', 1, 150),
(14, 'mod_openzap', 0, 1000),
(15, 'mod_woomera', 0, 1000),
(17, 'mod_speex', 1, 500),
(18, 'mod_ilbc', 0, 1000),
(20, 'mod_g723_1', 1, 500),
(21, 'mod_g729', 1, 500),
(22, 'mod_g722', 1, 500),
(23, 'mod_g726', 1, 500),
(25, 'mod_amr', 1, 500),
(26, 'mod_fifo', 1, 1000),
(27, 'mod_limit', 1, 1000),
(28, 'mod_syslog', 1, 0),
(29, 'mod_dingaling', 1, 2000),
(30, 'mod_cdr_csv', 1, 1000),
(31, 'mod_event_socket', 1, 100),
(32, 'mod_multicast', 0, 1000),
(33, 'mod_zeroconf', 0, 1000),
(34, 'mod_xmpp_event', 0, 1000),
(35, 'mod_sndfile', 1, 1000),
(36, 'mod_native_file', 1, 1000),
(37, 'mod_shout', 1, 1000),
(38, 'mod_local_stream', 1, 1000),
(39, 'mod_perl', 0, 1000),
(40, 'mod_python', 0, 1000),
(41, 'mod_java', 0, 1000),
(42, 'mod_cepstral', 0, 1000),
(43, 'mod_openmrcp', 0, 1000),
(44, 'mod_lumenvox', 0, 1000),
(45, 'mod_rss', 0, 1000),
(46, 'mod_say_de', 1, 1000),
(47, 'mod_say_fr', 0, 1000),
(48, 'mod_say_en', 1, 1000),
(49, 'mod_conference', 1, 1000),
(50, 'mod_ivr', 0, 1000),
(51, 'mod_console', 1, 0),
(52, 'mod_dptools', 1, 1500),
(53, 'mod_voipcodecs', 1, 500);

-- --------------------------------------------------------

--
-- Table structure for table `rss_conf`
--

CREATE TABLE IF NOT EXISTS `rss_conf` (
  `id` int(11) NOT NULL auto_increment,
  `directory_id` int(11) NOT NULL,
  `feed` text NOT NULL,
  `local_file` text NOT NULL,
  `description` text,
  `priority` int(11) NOT NULL default '1000',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `rss_conf`
--


-- --------------------------------------------------------

--
-- Table structure for table `sip_authentication`
--

CREATE TABLE IF NOT EXISTS `sip_authentication` (
  `nonce` varchar(255) default NULL,
  `expires` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sip_authentication`
--


-- --------------------------------------------------------

--
-- Table structure for table `sip_dialogs`
--

CREATE TABLE IF NOT EXISTS `sip_dialogs` (
  `call_id` varchar(255) default NULL,
  `uuid` varchar(255) default NULL,
  `sip_to_user` varchar(255) default NULL,
  `sip_to_host` varchar(255) default NULL,
  `sip_from_user` varchar(255) default NULL,
  `sip_from_host` varchar(255) default NULL,
  `contact_user` varchar(255) default NULL,
  `contact_host` varchar(255) default NULL,
  `state` varchar(255) default NULL,
  `direction` varchar(255) default NULL,
  `user_agent` varchar(255) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sip_dialogs`
--


-- --------------------------------------------------------

--
-- Table structure for table `sip_registrations`
--

CREATE TABLE IF NOT EXISTS `sip_registrations` (
  `call_id` varchar(255) default NULL,
  `sip_user` varchar(255) default NULL,
  `sip_host` varchar(255) default NULL,
  `contact` varchar(1024) default NULL,
  `status` varchar(255) default NULL,
  `rpid` varchar(255) default NULL,
  `expires` int(11) default NULL,
  `user_agent` varchar(255) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sip_registrations`
--


-- --------------------------------------------------------

--
-- Table structure for table `sip_subscriptions`
--

CREATE TABLE IF NOT EXISTS `sip_subscriptions` (
  `proto` varchar(255) default NULL,
  `sip_user` varchar(255) default NULL,
  `sip_host` varchar(255) default NULL,
  `sub_to_user` varchar(255) default NULL,
  `sub_to_host` varchar(255) default NULL,
  `event` varchar(255) default NULL,
  `contact` varchar(1024) default NULL,
  `call_id` varchar(255) default NULL,
  `full_from` varchar(255) default NULL,
  `full_via` varchar(255) default NULL,
  `expires` int(11) default NULL,
  `user_agent` varchar(255) default NULL,
  `accept` varchar(255) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sip_subscriptions`
--


-- --------------------------------------------------------

--
-- Table structure for table `sofia_aliases`
--

CREATE TABLE IF NOT EXISTS `sofia_aliases` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sofia_id` int(10) unsigned NOT NULL,
  `alias_name` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `sofia_aliases`
--

INSERT INTO `sofia_aliases` (`id`, `sofia_id`, `alias_name`) VALUES
(1, 1, 'default'),
(3, 1, 'sip.example.com');

-- --------------------------------------------------------

--
-- Table structure for table `sofia_conf`
--

CREATE TABLE IF NOT EXISTS `sofia_conf` (
  `id` int(11) NOT NULL auto_increment,
  `profile_name` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `sofia_conf`
--

INSERT INTO `sofia_conf` (`id`, `profile_name`) VALUES
(1, '$${domain}');

-- --------------------------------------------------------

--
-- Table structure for table `sofia_domains`
--

CREATE TABLE IF NOT EXISTS `sofia_domains` (
  `id` int(11) NOT NULL auto_increment,
  `sofia_id` int(11) default NULL,
  `domain_name` varchar(255) default NULL,
  `parse` tinyint(1) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `sofia_domains`
--


-- --------------------------------------------------------

--
-- Table structure for table `sofia_gateways`
--

CREATE TABLE IF NOT EXISTS `sofia_gateways` (
  `id` int(11) NOT NULL auto_increment,
  `sofia_id` int(11) default NULL,
  `gateway_name` varchar(255) default NULL,
  `gateway_param` varchar(255) default NULL,
  `gateway_value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;

--
-- Dumping data for table `sofia_gateways`
--

INSERT INTO `sofia_gateways` (`id`, `sofia_id`, `gateway_name`, `gateway_param`, `gateway_value`) VALUES
(8, 1, 'default', 'proxy', 'asterlink.com'),
(9, 1, 'default', 'realm', 'asterlink.com'),
(10, 1, 'default', 'username', 'USERNAME_HERE'),
(11, 1, 'default', 'register', 'false'),
(12, 1, 'default', 'expire-seconds', '60'),
(13, 1, 'default', 'retry_seconds', '2'),
(14, 1, 'default', 'password', 'PASSWORD_HERE');

-- --------------------------------------------------------

--
-- Table structure for table `sofia_settings`
--

CREATE TABLE IF NOT EXISTS `sofia_settings` (
  `id` int(11) NOT NULL auto_increment,
  `sofia_id` int(11) default NULL,
  `param_name` varchar(255) default NULL,
  `param_value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

--
-- Dumping data for table `sofia_settings`
--

INSERT INTO `sofia_settings` (`id`, `sofia_id`, `param_name`, `param_value`) VALUES
(1, 1, 'user-agent-string', 'RayUA 2.0pre4'),
(2, 1, 'auth-calls', 'true'),
(5, 1, 'debug', '1'),
(6, 1, 'rfc2833-pt', '101'),
(7, 1, 'sip-port', '5060'),
(8, 1, 'dialplan', 'XML'),
(9, 1, 'dtmf-duration', '100'),
(10, 1, 'codec-prefs', '$${global_codec_prefs}'),
(11, 1, 'rtp-timeout-sec', '300'),
(12, 1, 'rtp-ip', '$${local_ip_v4}'),
(13, 1, 'sip-ip', '$${local_ip_v4}'),
(14, 1, 'context', 'default'),
(15, 1, 'manage-presence', 'true'),
(16, 1, 'force-register-domain', 'intralanman.servehttp.com'),
(17, 1, 'inbound-codec-negotiation', 'generous'),
(18, 1, 'rtp-rewrite-timestampes', 'true'),
(19, 1, 'nonce-ttl', '60'),
(20, 1, 'vad', 'out'),
(36, 1, 'odbc-dsn', 'freeswitch-mysql:freeswitch:Fr33Sw1tch');

-- --------------------------------------------------------

--
-- Table structure for table `voicemail_conf`
--

CREATE TABLE IF NOT EXISTS `voicemail_conf` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `vm_profile` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_profile` (`vm_profile`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `voicemail_conf`
--

INSERT INTO `voicemail_conf` (`id`, `vm_profile`) VALUES
(1, 'default');

-- --------------------------------------------------------

--
-- Table structure for table `voicemail_email`
--

CREATE TABLE IF NOT EXISTS `voicemail_email` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `voicemail_id` int(10) unsigned NOT NULL,
  `param_name` varchar(64) NOT NULL,
  `param_value` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `unique_profile_param` (`param_name`,`voicemail_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `voicemail_email`
--

INSERT INTO `voicemail_email` (`id`, `voicemail_id`, `param_name`, `param_value`) VALUES
(1, 1, 'template-file', 'voicemail.tpl'),
(2, 1, 'date-fmt', '%A, %B %d %Y, %I %M %p'),
(3, 1, 'email-from', '${voicemail_account}@${voicemail_domain}');

-- --------------------------------------------------------

--
-- Table structure for table `voicemail_settings`
--

CREATE TABLE IF NOT EXISTS `voicemail_settings` (
  `id` int(11) NOT NULL auto_increment,
  `voicemail_id` int(11) default NULL,
  `param_name` varchar(255) default NULL,
  `param_value` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `voicemail_settings`
--

INSERT INTO `voicemail_settings` (`id`, `voicemail_id`, `param_name`, `param_value`) VALUES
(1, 1, 'file-extension', 'wav'),
(2, 1, 'terminator-key', '#'),
(3, 1, 'max-login-attempts', '3'),
(4, 1, 'digit-timeout', '10000'),
(5, 1, 'max-record-length', '300'),
(6, 1, 'tone-spec', '%(1000, 0, 640)'),
(7, 1, 'callback-dialplan', 'XML'),
(8, 1, 'callback-context', 'default'),
(9, 1, 'play-new-messages-key', '1'),
(10, 1, 'play-saved-messages-key', '2'),
(11, 1, 'main-menu-key', '*'),
(12, 1, 'config-menu-key', '5'),
(13, 1, 'record-greeting-key', '1'),
(14, 1, 'choose-greeting-key', '2'),
(15, 1, 'record-file-key', '3'),
(16, 1, 'listen-file-key', '1'),
(17, 1, 'record-name-key', '3'),
(18, 1, 'save-file-key', '9'),
(19, 1, 'delete-file-key', '7'),
(20, 1, 'undelete-file-key', '8'),
(21, 1, 'email-key', '4'),
(22, 1, 'pause-key', '0'),
(23, 1, 'restart-key', '1'),
(24, 1, 'ff-key', '6'),
(25, 1, 'rew-key', '4'),
(26, 1, 'record-silence-threshold', '200'),
(27, 1, 'record-silence-hits', '2'),
(28, 1, 'web-template-file', 'web-vm.tpl'),
(29, 1, 'operator-extension', 'operator XML default'),
(30, 1, 'operator-key', '9');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dingaling_profile_params`
--
ALTER TABLE `dingaling_profile_params`
  ADD CONSTRAINT `dingaling_profile` FOREIGN KEY (`dingaling_id`) REFERENCES `dingaling_profiles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
