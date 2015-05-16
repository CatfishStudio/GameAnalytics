-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Май 16 2015 г., 09:05
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `analitics`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ab_testing`
--

CREATE TABLE IF NOT EXISTS `ab_testing` (
  `ab_testing_id` int(10) NOT NULL AUTO_INCREMENT,
  `ab_testing_userid` varchar(255) NOT NULL,
  `ab_testing_datetime` datetime NOT NULL,
  `ab_testing_session` varchar(255) NOT NULL,
  `ab_testing_record` varchar(255) NOT NULL,
  PRIMARY KEY (`ab_testing_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

--
-- Дамп данных таблицы `ab_testing`
--

INSERT INTO `ab_testing` (`ab_testing_id`, `ab_testing_userid`, `ab_testing_datetime`, `ab_testing_session`, `ab_testing_record`) VALUES
(1, '001', '2015-05-10 09:41:59', 'A', 'Buy'),
(2, '001', '2015-05-10 09:42:01', 'A', 'Buy'),
(3, '001', '2015-05-10 09:42:03', 'A', 'Buy'),
(4, '001', '2015-05-10 09:42:05', 'A', 'Buy'),
(5, '001', '2015-05-10 09:42:06', 'A', 'Buy'),
(6, '001', '2015-05-10 09:42:07', 'A', 'Buy'),
(7, '001', '2015-05-10 09:42:09', 'A', 'Buy'),
(8, '001', '2015-05-10 09:42:14', 'B', 'Buy'),
(9, '001', '2015-05-10 09:42:16', 'B', 'Buy'),
(10, '001', '2015-05-10 09:42:21', 'C', 'Buy'),
(11, '001', '2015-05-10 09:42:23', 'C', 'Buy'),
(12, '001', '2015-05-10 09:42:25', 'C', 'Buy'),
(13, '001', '2015-05-10 09:42:26', 'C', 'Buy'),
(14, '002', '2015-05-10 09:42:39', 'A', 'Buy'),
(15, '002', '2015-05-10 09:42:42', 'A', 'Buy'),
(16, '002', '2015-05-10 09:42:43', 'A', 'Buy'),
(17, '002', '2015-05-10 09:42:45', 'A', 'Buy'),
(18, '002', '2015-05-10 09:42:49', 'B', 'Buy'),
(19, '002', '2015-05-10 09:42:52', 'C', 'Buy'),
(20, '002', '2015-05-10 09:42:54', 'C', 'Buy'),
(21, '002', '2015-05-10 09:42:56', 'C', 'Buy'),
(22, '003', '2015-05-10 09:43:10', 'A', 'Buy'),
(23, '003', '2015-05-10 09:43:11', 'A', 'Buy'),
(24, '003', '2015-05-10 09:43:13', 'A', 'Buy'),
(25, '003', '2015-05-10 09:43:14', 'A', 'Buy'),
(26, '003', '2015-05-10 09:43:22', 'B', 'Buy'),
(27, '003', '2015-05-10 09:43:23', 'B', 'Buy'),
(28, '003', '2015-05-10 09:43:25', 'B', 'Buy'),
(29, '003', '2015-05-10 09:43:31', 'C', 'Buy'),
(30, '003', '2015-05-10 09:43:32', 'C', 'Buy'),
(31, '003', '2015-05-10 09:43:34', 'C', 'Buy');

-- --------------------------------------------------------

--
-- Структура таблицы `boosters`
--

CREATE TABLE IF NOT EXISTS `boosters` (
  `boosters_id` int(10) NOT NULL AUTO_INCREMENT,
  `boosters_userid` varchar(255) NOT NULL,
  `boosters_datetime` datetime NOT NULL,
  `boosters_name` varchar(255) NOT NULL,
  `boosters_level` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`boosters_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Дамп данных таблицы `boosters`
--

INSERT INTO `boosters` (`boosters_id`, `boosters_userid`, `boosters_datetime`, `boosters_name`, `boosters_level`) VALUES
(1, '001', '2015-05-09 14:37:05', 'Booster1', 2),
(2, '001', '2015-05-09 14:37:11', 'Booster1', 2),
(3, '001', '2015-05-09 14:37:18', 'Booster3', 3),
(4, '001', '2015-05-09 14:37:23', 'Booster2', 4),
(5, '002', '2015-05-09 15:20:36', 'Booster2', 1),
(6, '002', '2015-05-09 15:21:00', 'Booster3', 3),
(7, '002', '2015-05-09 15:21:10', 'Booster1', 5),
(8, '002', '2015-05-09 15:21:11', 'Booster2', 5),
(9, '002', '2015-05-09 15:21:13', 'Booster2', 5),
(10, '002', '2015-05-09 15:21:14', 'Booster1', 5),
(11, '003', '2015-05-09 15:23:39', 'Booster1', 1),
(12, '003', '2015-05-09 15:23:41', 'Booster2', 3),
(13, '003', '2015-05-09 15:23:50', 'Booster4', 4),
(14, '003', '2015-05-09 15:23:58', 'Booster3', 5),
(15, '003', '2015-05-09 15:25:33', 'Booster2', 5),
(16, '003', '2015-05-09 18:23:00', 'Booster2', 5),
(17, '003', '2015-05-09 18:23:02', 'Booster2', 5),
(18, '003', '2015-05-09 18:23:03', 'Booster2', 5),
(19, '003', '2015-05-09 18:23:04', 'Booster2', 5);

-- --------------------------------------------------------

--
-- Структура таблицы `buys`
--

CREATE TABLE IF NOT EXISTS `buys` (
  `buys_id` int(10) NOT NULL AUTO_INCREMENT,
  `buys_userid` varchar(255) NOT NULL,
  `buys_datetime` datetime NOT NULL,
  `buys_object_name` varchar(255) NOT NULL,
  `buys_number` decimal(18,2) NOT NULL DEFAULT '0.00',
  `buys_price` decimal(18,2) NOT NULL DEFAULT '0.00',
  `buys_sum` decimal(18,2) NOT NULL DEFAULT '0.00',
  `buys_view` varchar(255) NOT NULL,
  `buys_location` varchar(255) NOT NULL,
  PRIMARY KEY (`buys_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Дамп данных таблицы `buys`
--

INSERT INTO `buys` (`buys_id`, `buys_userid`, `buys_datetime`, `buys_object_name`, `buys_number`, `buys_price`, `buys_sum`, `buys_view`, `buys_location`) VALUES
(1, '001', '2015-05-09 19:52:56', 'Booster1', '2.00', '25.00', '50.00', 'gold', 'Ур.2'),
(2, '001', '2015-05-09 19:53:28', 'Booster3', '1.00', '75.00', '75.00', 'gold', 'Ур.3'),
(3, '001', '2015-05-09 19:54:00', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.4'),
(4, '002', '2015-05-09 19:54:32', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.1'),
(5, '002', '2015-05-09 19:54:47', 'Booster3', '1.00', '75.00', '75.00', 'gold', 'Ур.3'),
(6, '002', '2015-05-09 19:55:05', 'Booster1', '1.00', '25.00', '25.00', 'gold', 'Ур.5'),
(7, '002', '2015-05-09 19:55:18', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.5'),
(8, '002', '2015-05-09 19:55:27', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.5'),
(9, '002', '2015-05-09 19:55:45', 'Booster1', '1.00', '25.00', '25.00', 'gold', 'Ур.5'),
(10, '003', '2015-05-09 19:56:34', 'Booster1', '1.00', '25.00', '25.00', 'gold', 'Ур.1'),
(11, '003', '2015-05-09 19:56:46', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.3'),
(12, '003', '2015-05-09 19:57:01', 'Booster4', '1.00', '100.00', '100.00', 'gold', 'Ур.4'),
(13, '003', '2015-05-09 19:57:12', 'Booster3', '1.00', '75.00', '75.00', 'gold', 'Ур.5'),
(14, '003', '2015-05-09 19:57:28', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.5'),
(15, '003', '2015-05-09 19:57:33', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.5'),
(16, '003', '2015-05-09 19:57:36', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.5'),
(17, '003', '2015-05-09 19:57:39', 'Booster2', '1.00', '50.00', '50.00', 'gold', 'Ур.5');

-- --------------------------------------------------------

--
-- Структура таблицы `errors`
--

CREATE TABLE IF NOT EXISTS `errors` (
  `errors_id` int(10) NOT NULL AUTO_INCREMENT,
  `errors_userid` varchar(255) NOT NULL,
  `errors_datetime` datetime NOT NULL,
  `errors_type` varchar(255) NOT NULL,
  `errors_location` varchar(255) NOT NULL,
  PRIMARY KEY (`errors_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `errors`
--

INSERT INTO `errors` (`errors_id`, `errors_userid`, `errors_datetime`, `errors_type`, `errors_location`) VALUES
(1, '004', '2015-05-10 14:24:24', 'urgent', 'Тутор'),
(2, '005', '2015-05-10 14:24:33', 'urgent', 'Тутор'),
(3, '006', '2015-05-10 14:24:44', 'urgent', 'Тутор'),
(4, '002', '2015-05-10 14:25:36', 'normal', 'Ур.2'),
(5, '003', '2015-05-10 14:26:29', 'low', 'Buy'),
(6, '003', '2015-05-10 14:35:41', 'normal', 'Ур.2'),
(7, '003', '2015-05-10 14:36:12', 'normal', 'Ур.2'),
(8, '004', '2015-05-10 14:37:48', 'urgent', 'Тутор'),
(9, '004', '2015-05-10 14:37:53', 'normal', 'Тутор'),
(10, '004', '2015-05-10 14:37:58', 'urgent', 'Тутор');

-- --------------------------------------------------------

--
-- Структура таблицы `levels`
--

CREATE TABLE IF NOT EXISTS `levels` (
  `levels_id` int(10) NOT NULL AUTO_INCREMENT,
  `levels_userid` varchar(255) NOT NULL,
  `levels_datetime` datetime NOT NULL,
  `levels_step_name` varchar(255) NOT NULL,
  `levels_number` int(5) NOT NULL DEFAULT '0',
  `levels_travel_time_minutes` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`levels_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Дамп данных таблицы `levels`
--

INSERT INTO `levels` (`levels_id`, `levels_userid`, `levels_datetime`, `levels_step_name`, `levels_number`, `levels_travel_time_minutes`) VALUES
(1, '001', '2015-05-09 08:53:50', 'Ур.1', 1, 2),
(2, '001', '2015-05-09 08:54:00', 'Ур.2', 2, 3),
(3, '001', '2015-05-09 08:54:07', 'Ур.3', 3, 1),
(4, '001', '2015-05-09 08:54:20', 'Ур.4', 4, 2),
(5, '001', '2015-05-09 08:54:26', 'Ур.5', 5, 5),
(6, '002', '2015-05-09 10:07:10', 'Ур.1', 1, 2),
(7, '002', '2015-05-09 10:07:26', 'Ур.2', 2, 4),
(8, '002', '2015-05-09 10:07:32', 'Ур.2', 2, 2),
(9, '002', '2015-05-09 10:07:48', 'Ур.3', 3, 3),
(10, '002', '2015-05-09 10:07:57', 'Ур.4', 4, 3),
(11, '002', '2015-05-09 10:08:13', 'Ур.5', 5, 4),
(12, '003', '2015-05-09 10:09:28', 'Ур.1', 1, 3),
(13, '003', '2015-05-09 10:09:36', 'Ур.2', 2, 4),
(14, '003', '2015-05-09 10:09:53', 'Ур.3', 3, 6),
(15, '003', '2015-05-09 19:12:15', 'Ур.4', 4, 3),
(16, '003', '2015-05-09 19:12:26', 'Ур.5', 5, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `retention`
--

CREATE TABLE IF NOT EXISTS `retention` (
  `retention_id` int(10) NOT NULL AUTO_INCREMENT,
  `retention_userid` varchar(255) NOT NULL,
  `retention_datetime_begin` datetime NOT NULL,
  `retention_datetime_exit` datetime NOT NULL,
  `retention_datetime_return` datetime NOT NULL,
  PRIMARY KEY (`retention_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Дамп данных таблицы `retention`
--

INSERT INTO `retention` (`retention_id`, `retention_userid`, `retention_datetime_begin`, `retention_datetime_exit`, `retention_datetime_return`) VALUES
(1, '001', '2015-05-10 11:21:37', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(2, '002', '2015-05-10 11:21:51', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(3, '002', '1900-01-01 00:00:00', '2015-05-10 11:21:55', '1900-01-01 00:00:00'),
(4, '002', '1900-01-01 00:00:00', '1900-01-01 00:00:00', '2015-05-10 11:22:00'),
(5, '003', '2015-05-10 11:22:15', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(6, '004', '2015-05-10 11:22:35', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(7, '004', '1900-01-01 00:00:00', '2015-05-10 11:22:39', '1900-01-01 00:00:00'),
(8, '005', '2015-05-10 11:22:51', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(9, '005', '1900-01-01 00:00:00', '2015-05-10 11:22:56', '1900-01-01 00:00:00'),
(10, '006', '2015-05-10 11:23:05', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(11, '006', '1900-01-01 00:00:00', '2015-05-10 11:23:08', '1900-01-01 00:00:00'),
(12, '007', '2015-05-10 11:23:35', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(13, '008', '2015-05-10 11:23:44', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(14, '009', '2015-05-10 11:23:53', '1900-01-01 00:00:00', '1900-01-01 00:00:00'),
(15, '010', '2015-05-10 11:24:01', '1900-01-01 00:00:00', '1900-01-01 00:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `tutorial`
--

CREATE TABLE IF NOT EXISTS `tutorial` (
  `tutorial_id` int(10) NOT NULL AUTO_INCREMENT,
  `tutorial_userid` varchar(255) NOT NULL,
  `tutorial_datetime` datetime NOT NULL,
  `tutorial_step_name` varchar(255) NOT NULL,
  `tutorial_travel_time_minutes` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tutorial_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Дамп данных таблицы `tutorial`
--

INSERT INTO `tutorial` (`tutorial_id`, `tutorial_userid`, `tutorial_datetime`, `tutorial_step_name`, `tutorial_travel_time_minutes`) VALUES
(1, '001', '2015-05-07 19:41:50', 'Этап1', 1),
(2, '001', '2015-05-07 19:41:55', 'Этап2', 1),
(3, '001', '2015-05-07 19:42:01', 'Этап3', 4),
(4, '001', '2015-05-07 19:42:07', 'Этап4', 3),
(5, '001', '2015-05-13 19:42:12', 'Этап5', 2),
(6, '002', '2015-05-13 19:45:41', 'Этап1', 2),
(7, '002', '2015-05-13 19:45:46', 'Этап2', 1),
(8, '002', '2015-05-13 19:45:51', 'Этап3', 1),
(9, '002', '2015-05-13 19:46:05', 'Этап4', 5),
(10, '002', '2015-05-13 19:46:13', 'Этап5', 2),
(11, '003', '2015-05-07 19:48:38', 'Этап1', 3),
(12, '003', '2015-05-07 19:48:44', 'Этап2', 2),
(13, '003', '2015-05-07 19:48:49', 'Этап3', 1),
(14, '003', '2015-05-07 19:48:57', 'Этап4', 4),
(15, '003', '2015-05-07 19:49:02', 'Этап5', 3),
(16, '001', '2015-05-07 19:42:01', 'Этап3', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `users_id` int(7) NOT NULL AUTO_INCREMENT,
  `users_userid` varchar(255) NOT NULL,
  `users_name` varchar(255) NOT NULL,
  `users_location` varchar(255) NOT NULL,
  PRIMARY KEY (`users_id`),
  UNIQUE KEY `users_uid` (`users_userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`users_id`, `users_userid`, `users_name`, `users_location`) VALUES
(1, '001', 'user1', 'VK'),
(2, '002', 'user2', 'VK'),
(3, '003', 'user3', 'OK'),
(4, '004', 'user4', 'FB'),
(5, '005', 'user5', 'VK'),
(6, '006', 'user6', 'VK'),
(7, '007', 'user7', 'VK'),
(8, '008', 'user8', 'VK'),
(9, '009', 'user9', 'VK'),
(10, '010', 'user10', 'OK');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
