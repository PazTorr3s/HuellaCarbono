-- --------------------------------------------------------
-- Host:                         bbchjbmewgmantd0ibzv-mysql.services.clever-cloud.com
-- Versión del servidor:         8.0.22-13 - Exherbo
-- SO del servidor:              Linux
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para bbchjbmewgmantd0ibzv
CREATE DATABASE IF NOT EXISTS `bbchjbmewgmantd0ibzv` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bbchjbmewgmantd0ibzv`;

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.auth_group: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.auth_group_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.auth_permission: ~44 rows (aproximadamente)
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can view log entry', 1, 'view_logentry'),
	(5, 'Can add permission', 2, 'add_permission'),
	(6, 'Can change permission', 2, 'change_permission'),
	(7, 'Can delete permission', 2, 'delete_permission'),
	(8, 'Can view permission', 2, 'view_permission'),
	(9, 'Can add group', 3, 'add_group'),
	(10, 'Can change group', 3, 'change_group'),
	(11, 'Can delete group', 3, 'delete_group'),
	(12, 'Can view group', 3, 'view_group'),
	(13, 'Can add user', 4, 'add_user'),
	(14, 'Can change user', 4, 'change_user'),
	(15, 'Can delete user', 4, 'delete_user'),
	(16, 'Can view user', 4, 'view_user'),
	(17, 'Can add content type', 5, 'add_contenttype'),
	(18, 'Can change content type', 5, 'change_contenttype'),
	(19, 'Can delete content type', 5, 'delete_contenttype'),
	(20, 'Can view content type', 5, 'view_contenttype'),
	(21, 'Can add session', 6, 'add_session'),
	(22, 'Can change session', 6, 'change_session'),
	(23, 'Can delete session', 6, 'delete_session'),
	(24, 'Can view session', 6, 'view_session'),
	(25, 'Can add administrador', 7, 'add_administrador'),
	(26, 'Can change administrador', 7, 'change_administrador'),
	(27, 'Can delete administrador', 7, 'delete_administrador'),
	(28, 'Can view administrador', 7, 'view_administrador'),
	(29, 'Can add analizar', 8, 'add_analizar'),
	(30, 'Can change analizar', 8, 'change_analizar'),
	(31, 'Can delete analizar', 8, 'delete_analizar'),
	(32, 'Can view analizar', 8, 'view_analizar'),
	(33, 'Can add consumo', 9, 'add_consumo'),
	(34, 'Can change consumo', 9, 'change_consumo'),
	(35, 'Can delete consumo', 9, 'delete_consumo'),
	(36, 'Can view consumo', 9, 'view_consumo'),
	(37, 'Can add recurso', 10, 'add_recurso'),
	(38, 'Can change recurso', 10, 'change_recurso'),
	(39, 'Can delete recurso', 10, 'delete_recurso'),
	(40, 'Can view recurso', 10, 'view_recurso'),
	(41, 'Can add recopilacion', 11, 'add_recopilacion'),
	(42, 'Can change recopilacion', 11, 'change_recopilacion'),
	(43, 'Can delete recopilacion', 11, 'delete_recopilacion'),
	(44, 'Can view recopilacion', 11, 'view_recopilacion'),
	(45, 'Can add analisis', 12, 'add_analisis'),
	(46, 'Can change analisis', 12, 'change_analisis'),
	(47, 'Can delete analisis', 12, 'delete_analisis'),
	(48, 'Can view analisis', 12, 'view_analisis');

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.auth_user: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.auth_user_groups: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.auth_user_user_permissions: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.django_admin_log: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.django_content_type: ~11 rows (aproximadamente)
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(6, 'sessions', 'session'),
	(7, 'Sostenibilidad_Empresarial', 'administrador'),
	(12, 'Sostenibilidad_Empresarial', 'analisis'),
	(8, 'Sostenibilidad_Empresarial', 'analizar'),
	(9, 'Sostenibilidad_Empresarial', 'consumo'),
	(11, 'Sostenibilidad_Empresarial', 'recopilacion'),
	(10, 'Sostenibilidad_Empresarial', 'recurso');

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.django_migrations: ~19 rows (aproximadamente)
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'Sostenibilidad_Empresarial', '0001_initial', '2024-10-31 04:54:56.794347'),
	(2, 'contenttypes', '0001_initial', '2024-10-31 04:54:57.445061'),
	(3, 'auth', '0001_initial', '2024-10-31 04:55:03.028715'),
	(4, 'admin', '0001_initial', '2024-10-31 04:55:04.361574'),
	(5, 'admin', '0002_logentry_remove_auto_add', '2024-10-31 04:55:04.575648'),
	(6, 'admin', '0003_logentry_add_action_flag_choices', '2024-10-31 04:55:04.788591'),
	(7, 'contenttypes', '0002_remove_content_type_name', '2024-10-31 04:55:06.105608'),
	(8, 'auth', '0002_alter_permission_name_max_length', '2024-10-31 04:55:06.567982'),
	(9, 'auth', '0003_alter_user_email_max_length', '2024-10-31 04:55:07.038443'),
	(10, 'auth', '0004_alter_user_username_opts', '2024-10-31 04:55:07.250335'),
	(11, 'auth', '0005_alter_user_last_login_null', '2024-10-31 04:55:07.699339'),
	(12, 'auth', '0006_require_contenttypes_0002', '2024-10-31 04:55:07.907075'),
	(13, 'auth', '0007_alter_validators_add_error_messages', '2024-10-31 04:55:08.129307'),
	(14, 'auth', '0008_alter_user_username_max_length', '2024-10-31 04:55:08.599007'),
	(15, 'auth', '0009_alter_user_last_name_max_length', '2024-10-31 04:55:09.065726'),
	(16, 'auth', '0010_alter_group_name_max_length', '2024-10-31 04:55:09.520092'),
	(17, 'auth', '0011_update_proxy_permissions', '2024-10-31 04:55:10.356007'),
	(18, 'auth', '0012_alter_user_first_name_max_length', '2024-10-31 04:55:10.814436'),
	(19, 'sessions', '0001_initial', '2024-10-31 04:55:11.664600'),
	(20, 'Sostenibilidad_Empresarial', '0002_alter_analisis_año', '2024-11-09 02:23:07.073687'),
	(21, 'Sostenibilidad_Empresarial', '0002_alter_analisis_datos', '2024-11-09 02:40:10.460219');

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.django_session: ~16 rows (aproximadamente)
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('04rdhy2h9cbukwl0ncy43pw8t3z32cg0', 'eyJhZG1pbl9pZCI6MX0:1tAVFF:RrlD0QSmjIT4W9uJOPDjICfTut5YnbwkCQMYSTOgF_U', '2024-11-25 14:18:21.495419'),
	('42yrcwkx4zh1uvdurplfcagz15v1puv7', 'eyJhZG1pbl9pZCI6MX0:1tF1OX:v2Kh_IsBzMkvb3YGsb0D_bk9wsK3FgxAqxnVFAOBZek', '2024-12-08 01:26:37.229099'),
	('58h13p8x6cgmd59zj06f2o2zq45bjgwo', 'eyJhZG1pbl9pZCI6MX0:1t86YB:uuGvsjDqd_J0NJbN-q6uTfyEcH4wvPTMmrk3-jiJ1O4', '2024-11-18 23:31:59.756337'),
	('64wpm57pi6kuc4xwpck3rcso4ptl6ect', 'eyJhZG1pbl9pZCI6MX0:1tALBm:Ist5aNr6-bcepUrnkBZVI4olCa52HGDkW1yQkFlkGBI', '2024-11-25 03:34:06.674254'),
	('79q2exmnakl8guztqcxiq7jayrmpr98w', 'eyJhZG1pbl9pZCI6MX0:1tCByK:yNXUkcAN5nBe5uxrQvg2GCjOjpAfb2fFhq5uzczLXS4', '2024-11-30 06:07:52.322384'),
	('7tpizdbz339i6v271l1zjfpe0i7sxr2m', 'eyJhZG1pbl9pZCI6MX0:1tAK0H:Ajrfdi6VWTWKpbq_gatUy8-OrvlEpqMw4MeC8cWxxgo', '2024-11-25 02:18:09.056627'),
	('7y833nk8qnq5ogj2z00jknsco0vgasg8', 'eyJhZG1pbl9pZCI6MX0:1tAHPB:96rG0CrRfFvCh-3Y5kngjhFSVQiJnNnYWanjAvkLrHo', '2024-11-24 23:31:41.904721'),
	('7zblgh73kuixthq5nusfp2yplqicb0bu', 'eyJhZG1pbl9pZCI6MX0:1tAHyV:ByXOpy5-BmkBV3LQLNYqe1PZO2BtVqF7bIClxGT-2iE', '2024-11-25 00:08:11.708945'),
	('jj35puew8jm4n42f4lpe1q6j1f951wjf', 'eyJhZG1pbl9pZCI6MX0:1tDsfX:-C1VpVUywz0tJV1XjirQmZwl-172poxiFw6xh5Euyps', '2024-12-04 21:55:27.716323'),
	('jj6tt0vz50dlegd58ubr7e12lwsfi02a', 'eyJhZG1pbl9pZCI6MX0:1tFM74:8KnOaUEGnddQuG_035tvS5i85uB-BMMVpdTQ9UGl7gY', '2024-12-08 23:33:58.632004'),
	('kix2ceqzu733tn8yip5uirq5p026ahji', 'eyJhZG1pbl9pZCI6Mn0:1t7yji:x2wka4b0bCTSMJhQTyTWPZW8c2BD7nJbDwkeIvAVzUU', '2024-11-18 15:11:22.258699'),
	('lchtydojqcs4rwgxztiuyy7ryfoitryl', 'eyJhZG1pbl9pZCI6MX0:1t8jab:SbVzu-YbXB2lmyLXDkFfW1IBpi0P2okdy62tKmTm9aI', '2024-11-20 17:13:05.220402'),
	('lu8mpnmu4mg53kqzjsgu6akbzaz4m9rq', 'eyJhZG1pbl9pZCI6MX0:1t7yqj:4QpwHg9ZK3xe8ZMyuBidVndgGk6H38ZwpT-__VAIOWM', '2024-11-18 15:18:37.082455'),
	('m5qjfxlstz9ynbesbm5q1pembbem3qrk', 'eyJhZG1pbl9pZCI6MX0:1t9x6Q:Y4BeQ7flZeOY6L_LvIZ-VIc1NeYiswt7_4pyk5lGMdc', '2024-11-24 01:50:58.231945'),
	('pwd0ouqfx4zosbz5bqgih8lr8ar70jjt', 'eyJhZG1pbl9pZCI6MX0:1tBHVK:R9JaV-qRJiraW_3jqR9VNpnDVvvwZMK5kPTMwDoWsK0', '2024-11-27 17:50:10.976978'),
	('zwp3fh3gdub72n1k7j053memasm8prxv', 'eyJhZG1pbl9pZCI6MX0:1tFLlK:XJ4lkQR2wIXEsGll-737OZVM3J8TBVF5fb3Lo7gFtNY', '2024-12-08 23:11:30.017257'),
	('zxla4rns0kgy5i3uye7o6ve4b2wlsngm', 'eyJhZG1pbl9pZCI6Mn0:1tAbaw:AgUZajRooGHBiQvK2Cjc9WxhO2oe002KwVI6LC4JofI', '2024-11-25 21:05:10.417550');

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_administrador
CREATE TABLE IF NOT EXISTS `Sostenibilidad_Empresarial_administrador` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rut` varchar(12) NOT NULL,
  `correo` varchar(254) NOT NULL,
  `contrasena` varchar(128) NOT NULL,
  `estado` varchar(13) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_administrador: ~2 rows (aproximadamente)
INSERT INTO `Sostenibilidad_Empresarial_administrador` (`id`, `rut`, `correo`, `contrasena`, `estado`) VALUES
	(1, '21.765.466-1', 'freddyarellano0410@gmail.com', 'pbkdf2_sha256$870000$FR5MOA8pRPMCZPtvN3EOQ9$PWrGGH4KIgQGA8cILK25dp8/nnae1StIkm3w+MRZ8ms=', 'Autorizado'),
	(2, '19.315.481-6', 'matiacevedom96@gmail.com', 'pbkdf2_sha256$720000$Zl6sVNEBWkCcZQMlDQCoQx$olXHeElpWz1YLMQrptJzmsbKS8J3g4IDQagNIs/VyEc=', 'Autorizado'),
	(7, '20.982.213-K', 'sebanilo8772@gmail.com', 'pbkdf2_sha256$870000$qCTcyILMDgd40Ij3JEAhq7$lJEGJxL+8dSQHjxQ990tSFCwHPKXSELrl28kMypEyyU=', 'Autorizado');

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_analisis
CREATE TABLE IF NOT EXISTS `Sostenibilidad_Empresarial_analisis` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `datos` json DEFAULT NULL,
  `año` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_analisis: ~0 rows (aproximadamente)
INSERT INTO `Sostenibilidad_Empresarial_analisis` (`id`, `datos`, `año`) VALUES
	(16, '{"CO2": 99749.0, "Gas": 2958154.0, "Agua": 678517.0, "Basura": 149951.0, "Diesel": 5694600.0, "Producción": 24842.0, "Electricidad": 162698.0, "Materia prima": 25745.0}', '2024-01-01'),
	(17, '{"CO2": "30", "Gas": "30", "Agua": "30", "Basura": "30", "Diesel": "30", "Producción": "30", "Electricidad": "30", "Materia prima": "30"}', '2025-01-01');

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_consumo
CREATE TABLE IF NOT EXISTS `Sostenibilidad_Empresarial_consumo` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_consumo` date DEFAULT NULL,
  `datos` json NOT NULL,
  `user_consumo` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_consumo: ~11 rows (aproximadamente)
INSERT INTO `Sostenibilidad_Empresarial_consumo` (`id`, `fecha_consumo`, `datos`, `user_consumo`) VALUES
	(77, '2024-03-01', '{"CO2": "1324", "Gas": "34", "Agua": "5625", "Basura": "42", "Diesel": "534", "Producción": "5434", "Electricidad": "2345", "Materia prima": "3214"}', 'freddyarellano0410@gmail.com'),
	(78, '2024-04-01', '{"CO2": "6765", "Gas": "875", "Agua": "423", "Basura": "5465", "Diesel": "5467", "Producción": "5689", "Electricidad": "134", "Materia prima": "765"}', 'freddyarellano0410@gmail.com'),
	(79, '2024-05-01', '{"CO2": "0", "Gas": "0", "Agua": "0", "Basura": "89", "Diesel": "6486", "Producción": "978", "Electricidad": "456", "Materia prima": "486"}', 'freddyarellano0410@gmail.com'),
	(80, '2024-06-01', '{"CO2": "56432", "Gas": "561", "Agua": "884", "Basura": "1235", "Diesel": "1334", "Producción": "32", "Electricidad": "2435", "Materia prima": "321"}', 'freddyarellano0410@gmail.com'),
	(81, '2024-07-01', '{"CO2": "132", "Gas": "566", "Agua": "4654", "Basura": "1223", "Diesel": "566", "Producción": "323", "Electricidad": "2123", "Materia prima": "65"}', 'freddyarellano0410@gmail.com'),
	(82, '2024-08-01', '{"CO2": "6546", "Gas": "231", "Agua": "546", "Basura": "1321", "Diesel": "231", "Producción": "16", "Electricidad": "1231", "Materia prima": "565"}', 'freddyarellano0410@gmail.com'),
	(83, '2024-09-01', '{"CO2": "654", "Gas": "8454", "Agua": "4654", "Basura": "465", "Diesel": "423", "Producción": "31", "Electricidad": "465", "Materia prima": "4131"}', 'freddyarellano0410@gmail.com'),
	(84, '2024-10-01', '{"CO2": "1321", "Gas": "1613", "Agua": "6492", "Basura": "6541", "Diesel": "6151", "Producción": "565", "Electricidad": "2356", "Materia prima": "3165"}', 'freddyarellano0410@gmail.com'),
	(85, '2024-11-01', '{"CO2": "315", "Gas": "651", "Agua": "213", "Basura": "564", "Diesel": "1", "Producción": "15", "Electricidad": "2641", "Materia prima": "6135"}', 'freddyarellano0410@gmail.com'),
	(86, '2024-12-01', '{"CO2": "4153", "Gas": "5353", "Agua": "864", "Basura": "5641", "Diesel": "5641", "Producción": "4153", "Electricidad": "534", "Materia prima": "4135"}', 'freddyarellano0410@gmail.com'),
	(87, '2024-01-01', '{"CO2": "10", "Gas": "10", "Agua": "10", "Basura": "10", "Diesel": "10", "Producción": "10", "Electricidad": "10", "Materia prima": "10"}', 'freddyarellano0410@gmail.com'),
	(88, '2025-01-01', '{"CO2": "30", "Gas": "30", "Agua": "30", "Basura": "30", "Diesel": "30", "Producción": "30", "Electricidad": "30", "Materia prima": "30"}', 'freddyarellano0410@gmail.com');

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_recopilacion
CREATE TABLE IF NOT EXISTS `Sostenibilidad_Empresarial_recopilacion` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `patrones` varchar(255) NOT NULL,
  `tendencias` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_recopilacion: ~0 rows (aproximadamente)

-- Volcando estructura para tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_recurso
CREATE TABLE IF NOT EXISTS `Sostenibilidad_Empresarial_recurso` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `medida` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla bbchjbmewgmantd0ibzv.Sostenibilidad_Empresarial_recurso: ~8 rows (aproximadamente)
INSERT INTO `Sostenibilidad_Empresarial_recurso` (`id`, `nombre`, `tipo`, `medida`) VALUES
	(1, 'Agua', 'number', 'Litro'),
	(2, 'Electricidad', 'number', 'Kwh'),
	(3, 'Basura', 'number', 'Tonelada'),
	(4, 'Diesel', 'number', 'Litro'),
	(5, 'Gas', 'number', 'Metros cubicos'),
	(6, 'CO2', 'number', 'kg'),
	(7, 'Materia prima', 'number', 'N/N'),
	(8, 'Producción', 'number', 'N/N');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
