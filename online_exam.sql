-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Сен 21 2019 г., 17:28
-- Версия сервера: 10.1.37-MariaDB
-- Версия PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `online_exam`
--

-- --------------------------------------------------------

--
-- Структура таблицы `department`
--

CREATE TABLE `department` (
  `department_id` int(11) NOT NULL,
  `department_code` varchar(255) NOT NULL,
  `department_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `department`
--

INSERT INTO `department` (`department_id`, `department_code`, `department_name`) VALUES
(1, 'D1', 'Upper-Intermediate'),
(2, 'D2', 'Advanced');

-- --------------------------------------------------------

--
-- Структура таблицы `exams`
--

CREATE TABLE `exams` (
  `exam_id` int(11) NOT NULL,
  `exam_name` longtext NOT NULL,
  `exam_from` date NOT NULL,
  `exam_to` date NOT NULL,
  `passing_score` int(11) NOT NULL,
  `exam_date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `exam_created_by` int(11) NOT NULL,
  `exam_modified_by` int(11) NOT NULL,
  `exam_time_limit` int(11) NOT NULL,
  `isdeleted` int(11) DEFAULT '0',
  `passing_grade` int(11) NOT NULL,
  `department_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `exams`
--

INSERT INTO `exams` (`exam_id`, `exam_name`, `exam_from`, `exam_to`, `passing_score`, `exam_date_created`, `exam_created_by`, `exam_modified_by`, `exam_time_limit`, `isdeleted`, `passing_grade`, `department_id`) VALUES
(36, 'Grammar Quiz 2', '2019-04-01', '2019-04-09', 3, '2019-04-10 09:09:00', 79, 0, 120, 0, 100, 2),
(34, 'Superstitions ', '2019-04-01', '2019-04-09', 3, '2019-04-10 08:52:29', 79, 1, 300, 0, 75, 2),
(35, 'Grammar Quiz 1', '2019-04-01', '2019-04-09', 5, '2019-04-10 09:01:09', 79, 0, 300, 0, 75, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `exams_answers`
--

CREATE TABLE `exams_answers` (
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_name` longtext NOT NULL,
  `answer_flag` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `exams_answers`
--

INSERT INTO `exams_answers` (`answer_id`, `question_id`, `answer_name`, `answer_flag`) VALUES
(333, 151, 'gender', 0),
(332, 151, ' case', 1),
(331, 151, 'number', 0),
(330, 150, 'adjectives', 0),
(329, 150, 'adverbs', 0),
(328, 150, 'nouns', 1),
(327, 148, 'calligraphic form', 0),
(326, 148, 'word agreement', 1),
(325, 148, ' word indexation', 0),
(324, 147, ' You are looking good', 1),
(323, 147, ' Your looking good', 0),
(322, 146, 'a plural verb ', 1),
(321, 146, 'a singular verb ', 0),
(320, 145, ' an object', 0),
(319, 145, 'a verb', 1),
(318, 144, 'Verb-Object-Subject', 0),
(317, 144, ' Subject-Verb-Object', 1),
(316, 143, 'a capital letter ', 1),
(315, 143, 'a large letter ', 0),
(314, 142, 'in', 0),
(313, 142, 'before', 0),
(312, 142, 'after', 0),
(311, 142, 'as', 1),
(310, 141, 'on', 1),
(309, 141, 'with', 0),
(308, 141, 'in', 0),
(307, 141, 'by', 0),
(306, 140, 'by', 0),
(305, 140, 'from', 0),
(304, 140, 'with', 0),
(303, 140, 'against', 1),
(302, 139, ' after a noun', 0),
(300, 138, ' a plural verb', 1),
(301, 139, ' before a noun ', 1),
(296, 136, ' an object', 0),
(299, 138, ' a singular verb ', 0),
(294, 135, ' Verb-Object-Subject', 0),
(295, 136, 'a verb', 1),
(293, 135, 'Subject-Verb-Object ', 1),
(292, 134, ' a capital letter', 1),
(291, 134, 'a large letter', 0),
(289, 132, 'plural', 1),
(288, 132, 'singular ', 0),
(287, 131, ' a fact-adjective ', 0),
(286, 131, 'an opinion-adjective', 1),
(285, 130, ' after a noun', 0),
(284, 130, 'before a noun', 1),
(283, 129, 'a plural verb', 0),
(282, 129, 'a singular verb ', 1),
(281, 128, ' a plural verb', 1),
(280, 128, 'a singular verb', 0),
(279, 127, 'an object', 0),
(278, 127, 'a verb ', 1),
(277, 126, 'Verb-Object-Subject', 0),
(276, 126, ' Subject-Verb-Object ', 1),
(275, 125, 'a capital letter', 1),
(274, 125, 'a large letter', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `exams_question`
--

CREATE TABLE `exams_question` (
  `question_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `question_name` longtext NOT NULL,
  `question_code` varchar(255) NOT NULL,
  `question_type` int(11) DEFAULT '0',
  `question_date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `question_date_modified` datetime NOT NULL,
  `question_modified_by` int(11) NOT NULL,
  `question_created_by` int(11) NOT NULL,
  `essay_points` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `exams_question`
--

INSERT INTO `exams_question` (`question_id`, `exam_id`, `question_name`, `question_code`, `question_type`, `question_date_created`, `question_date_modified`, `question_modified_by`, `question_created_by`, `essay_points`) VALUES
(151, 36, ' Possessive is a value of the grammatical category called', '', 0, '2019-04-10 09:15:05', '0000-00-00 00:00:00', 0, 79, 0),
(150, 36, ' Only _____ can be affected by the grammatical category known as \"number\".', '', 0, '2019-04-10 09:14:19', '0000-00-00 00:00:00', 0, 79, 0),
(148, 36, ' Grammatical category is related to', '', 0, '2019-04-10 09:12:44', '0000-00-00 00:00:00', 0, 79, 0),
(146, 35, ' A plural subject needs', '', 0, '2019-04-10 09:06:11', '0000-00-00 00:00:00', 0, 79, 0),
(147, 35, ' Which is correct?', '', 0, '2019-04-10 09:07:02', '0000-00-00 00:00:00', 0, 79, 0),
(145, 35, ' Every sentence must have a subject and', '', 0, '2019-04-10 09:05:42', '0000-00-00 00:00:00', 0, 79, 0),
(144, 35, ' The order of a basic positive sentence is', '', 0, '2019-04-10 09:05:09', '0000-00-00 00:00:00', 0, 79, 0),
(143, 35, ' The first letter of the first word in a sentence should be', '', 0, '2019-04-10 09:04:17', '0000-00-00 00:00:00', 0, 79, 0),
(142, 34, 'Giving knives or things that cut ______ a wedding present is considered bad luck.', '', 0, '2019-04-10 08:58:11', '0000-00-00 00:00:00', 0, 79, 0),
(140, 34, ' A necklake of amber beads protects ______ cold.', '', 0, '2019-04-10 08:55:19', '0000-00-00 00:00:00', 0, 79, 0),
(141, 34, ' Get out of the bed ______ the same side that you get in to avoid bad luck', '', 0, '2019-04-10 08:56:44', '0000-00-00 00:00:00', 0, 79, 0),
(139, 33, '  Adjectives usually come', '', 0, '2019-04-08 16:00:33', '0000-00-00 00:00:00', 0, 1, 0),
(138, 33, ' When two singular subjects are connected by or, use', '', 0, '2019-04-08 16:00:09', '0000-00-00 00:00:00', 0, 1, 0),
(136, 33, 'Every sentence must have a subject and', '', 0, '2019-04-08 15:33:27', '0000-00-00 00:00:00', 0, 1, 0),
(135, 33, ' The order of a basic positive sentence is', '', 0, '2019-04-08 15:33:04', '0000-00-00 00:00:00', 0, 1, 0),
(134, 33, ' The first letter of the first word in a sentence should be', '', 0, '2019-04-08 15:32:33', '0000-00-00 00:00:00', 0, 1, 0),
(133, 32, ' Which is correct?', '', 0, '2019-04-08 14:47:56', '0000-00-00 00:00:00', 0, 1, 0),
(132, 32, ' In British English, a collective noun is usually treated as', '', 0, '2019-04-08 14:47:43', '0000-00-00 00:00:00', 0, 1, 0),
(131, 32, ' If an opinion-adjective and a fact-adjective are used before a noun, which comes first?', '', 0, '2019-04-08 14:47:35', '0000-00-00 00:00:00', 0, 1, 0),
(130, 32, ' Adjectives usually come', '', 0, '2019-04-08 14:47:18', '0000-00-00 00:00:00', 0, 1, 0),
(129, 32, ' When two singular subjects are connected by or, use', '', 0, '2019-04-08 14:47:11', '0000-00-00 00:00:00', 0, 1, 0),
(128, 32, ' A plural subject needs', '', 0, '2019-04-08 14:47:04', '0000-00-00 00:00:00', 0, 1, 0),
(127, 32, ' Every sentence must have a subject and', '', 0, '2019-04-08 14:46:55', '0000-00-00 00:00:00', 0, 1, 0),
(126, 32, ' The order of a basic positive sentence is', '', 0, '2019-04-08 14:46:43', '0000-00-00 00:00:00', 0, 1, 0),
(125, 32, ' The first letter of the first word in a sentence should be', '', 0, '2019-04-08 14:46:33', '0000-00-00 00:00:00', 0, 1, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `transaction_date` date NOT NULL,
  `transaction_code` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `time_consumed` int(11) NOT NULL,
  `check_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `transaction_dtl`
--

CREATE TABLE `transaction_dtl` (
  `transaction_dtl_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `transaction_answer_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL,
  `essay` longtext,
  `transaction_code` varchar(255) NOT NULL,
  `transaction_question_type` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `israted` int(11) NOT NULL,
  `checked_by` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_fname` varchar(256) NOT NULL,
  `user_lname` varchar(256) NOT NULL,
  `department_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL DEFAULT '4',
  `user_enabled` int(11) DEFAULT '0',
  `user_createdby` int(11) NOT NULL,
  `user_createdon` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_modifiedby` int(11) DEFAULT NULL,
  `user_modifiedon` datetime DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_password` varchar(256) NOT NULL,
  `exam_checker` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `user_fname`, `user_lname`, `department_id`, `role_id`, `user_enabled`, `user_createdby`, `user_createdon`, `user_modifiedby`, `user_modifiedon`, `user_name`, `user_password`, `exam_checker`) VALUES
(75, 'Student Name', 'Student LastName', 2, 4, 1, 1, '2019-09-04 05:23:36', NULL, NULL, 'student_test', 'b538c6fd231ef0fbf7f09fe393663cf8', 0),
(84, 'Embergenov', 'Nursultan', 2, 4, 0, 0, '2019-09-04 05:40:16', NULL, NULL, 'nursultan', 'b538c6fd231ef0fbf7f09fe393663cf8', 0),
(83, 'Yernar', 'Yergaziev', 2, 4, 0, 0, '2019-09-01 13:57:02', NULL, NULL, 'yernar', 'b538c6fd231ef0fbf7f09fe393663cf8', 0),
(81, 'Alimkhan', 'Akimzhan', 2, 1, 1, 0, '2019-09-04 05:20:50', NULL, '2019-09-04 00:00:00', 'admin', '21232f297a57a5a743894a0e4a801fc3', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `user_roles`
--

CREATE TABLE `user_roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `user_roles`
--

INSERT INTO `user_roles` (`role_id`, `role_name`) VALUES
(1, 'Admin'),
(2, 'Moderator'),
(4, 'Student'),
(3, 'Teacher');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`department_id`);

--
-- Индексы таблицы `exams`
--
ALTER TABLE `exams`
  ADD PRIMARY KEY (`exam_id`);

--
-- Индексы таблицы `exams_answers`
--
ALTER TABLE `exams_answers`
  ADD PRIMARY KEY (`answer_id`);

--
-- Индексы таблицы `exams_question`
--
ALTER TABLE `exams_question`
  ADD PRIMARY KEY (`question_id`);

--
-- Индексы таблицы `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Индексы таблицы `transaction_dtl`
--
ALTER TABLE `transaction_dtl`
  ADD PRIMARY KEY (`transaction_dtl_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Индексы таблицы `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `department`
--
ALTER TABLE `department`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `exams`
--
ALTER TABLE `exams`
  MODIFY `exam_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT для таблицы `exams_answers`
--
ALTER TABLE `exams_answers`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=334;

--
-- AUTO_INCREMENT для таблицы `exams_question`
--
ALTER TABLE `exams_question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT для таблицы `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT для таблицы `transaction_dtl`
--
ALTER TABLE `transaction_dtl`
  MODIFY `transaction_dtl_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=982;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT для таблицы `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
