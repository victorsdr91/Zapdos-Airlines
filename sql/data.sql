-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.6.26-log - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.3.0.4994
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
-- Volcando datos para la tabla db_airlines.airports: ~2 rows (aproximadamente)
DELETE FROM `airports`;
/*!40000 ALTER TABLE `airports` DISABLE KEYS */;
INSERT INTO `airports` (`id`, `iata`, `name`, `city`, `country`, `pais`) VALUES
	(1, 'MAD', 'Barajas', 'Madrid', 'Spain', 'España\r\n'),
	(2, 'DUB', 'Dublin', 'Dublin', 'Ireland', 'Irlanda'),
	(3, 'PAR', 'Paris', 'Paris', 'France', 'Francia');
/*!40000 ALTER TABLE `airports` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.babypassenger: ~2 rows (aproximadamente)
DELETE FROM `babypassenger`;
/*!40000 ALTER TABLE `babypassenger` DISABLE KEYS */;
INSERT INTO `babypassenger` (`id`, `idPassenger`, `name`, `surName`, `nif`, `birthdate`, `country`, `state`) VALUES
	(1, 52, 'Alejandra', 'Sánchez del Río', '74565232S', '2014-11-15', 'ES', 'Castilla-La Mancha'),
	(2, 54, 'Alejandra', 'Sánchez del Río', '74565232S', '2016-02-17', 'AF', 'Castilla-La Mancha');
/*!40000 ALTER TABLE `babypassenger` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.babypassenger_backup: ~0 rows (aproximadamente)
DELETE FROM `babypassenger_backup`;
/*!40000 ALTER TABLE `babypassenger_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `babypassenger_backup` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.bookedservices: ~79 rows (aproximadamente)
DELETE FROM `bookedservices`;
/*!40000 ALTER TABLE `bookedservices` DISABLE KEYS */;
INSERT INTO `bookedservices` (`id`, `idFo`, `idService`) VALUES
	(70, 47, 1),
	(71, 47, 4),
	(72, 48, 1),
	(73, 48, 2),
	(74, 49, 1),
	(75, 49, 5),
	(76, 49, 2),
	(77, 51, 1),
	(78, 51, 5),
	(79, 52, 1),
	(80, 55, 1),
	(81, 55, 5),
	(82, 56, 1),
	(83, 57, 1),
	(84, 58, 1),
	(85, 59, 1),
	(86, 59, 2),
	(87, 60, 1),
	(88, 60, 2),
	(89, 60, 5),
	(90, 60, 4),
	(91, 61, 1),
	(92, 61, 4),
	(93, 61, 5),
	(94, 61, 7),
	(95, 62, 1),
	(96, 62, 4),
	(97, 62, 5),
	(98, 62, 2),
	(99, 62, 7),
	(100, 63, 1),
	(101, 66, 2),
	(102, 67, 6),
	(103, 67, 1),
	(104, 67, 5),
	(105, 67, 2),
	(106, 68, 6),
	(107, 68, 1),
	(108, 68, 5),
	(109, 68, 2),
	(110, 69, 1),
	(111, 69, 4),
	(112, 69, 2),
	(113, 70, 1),
	(114, 70, 2),
	(115, 70, 4),
	(116, 71, 6),
	(117, 71, 1),
	(118, 71, 7),
	(119, 72, 6),
	(120, 72, 2),
	(121, 72, 1),
	(122, 72, 4),
	(123, 73, 4),
	(124, 73, 1),
	(125, 73, 5),
	(126, 74, 1),
	(127, 74, 2),
	(128, 74, 3),
	(129, 74, 7),
	(130, 75, 1),
	(131, 75, 4),
	(132, 75, 5),
	(133, 75, 2),
	(134, 76, 1),
	(135, 76, 4),
	(136, 76, 5),
	(137, 76, 7),
	(138, 76, 2),
	(139, 77, 1),
	(140, 77, 2),
	(141, 77, 3),
	(142, 77, 7),
	(143, 77, 5),
	(144, 78, 1),
	(145, 78, 4),
	(146, 78, 2),
	(147, 78, 5),
	(148, 78, 7);
/*!40000 ALTER TABLE `bookedservices` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.bookedservices_backup: ~0 rows (aproximadamente)
DELETE FROM `bookedservices_backup`;
/*!40000 ALTER TABLE `bookedservices_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookedservices_backup` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.bookings: ~10 rows (aproximadamente)
DELETE FROM `bookings`;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` (`id`, `bookingCode`, `bookingDate`, `idUser`) VALUES
	(34, 'TAGLTH2D', '2016-02-19', 2),
	(35, '1442UOBF', '2016-02-19', 2),
	(36, '5FVI6RG8', '2016-02-19', 2),
	(38, '6YY14AFW', '2016-02-22', 4),
	(39, '5YJEMJJ7', '2016-02-23', 2),
	(40, 'C74XJL25', '2016-02-23', 2),
	(41, '3GY8QGW7', '2016-02-23', 2),
	(42, 'U620QRH9', '2016-02-23', 2),
	(43, 'LA6BCURT', '2016-02-24', 2),
	(44, 'X4IIBQIB', '2016-02-24', 2);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.bookings_backup: ~0 rows (aproximadamente)
DELETE FROM `bookings_backup`;
/*!40000 ALTER TABLE `bookings_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings_backup` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.companydata: ~0 rows (aproximadamente)
DELETE FROM `companydata`;
/*!40000 ALTER TABLE `companydata` DISABLE KEYS */;
/*!40000 ALTER TABLE `companydata` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.connections: ~5 rows (aproximadamente)
DELETE FROM `connections`;
/*!40000 ALTER TABLE `connections` DISABLE KEYS */;
INSERT INTO `connections` (`id`, `originAirport`, `originTerminal`, `destinationAirport`, `destinationTerminal`) VALUES
	(1, 1, 1, 2, 3),
	(2, 1, 2, 2, 4),
	(3, 2, 4, 1, 1),
	(4, 2, 3, 1, 2),
	(5, 1, 1, 3, 5);
/*!40000 ALTER TABLE `connections` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.departuretimes: ~2 rows (aproximadamente)
DELETE FROM `departuretimes`;
/*!40000 ALTER TABLE `departuretimes` DISABLE KEYS */;
INSERT INTO `departuretimes` (`id`, `DepartureTime`) VALUES
	(1, '09:00:00'),
	(2, '12:30:00');
/*!40000 ALTER TABLE `departuretimes` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.flightoccupation: ~32 rows (aproximadamente)
DELETE FROM `flightoccupation`;
/*!40000 ALTER TABLE `flightoccupation` DISABLE KEYS */;
INSERT INTO `flightoccupation` (`id`, `idBook`, `idFlight`, `idPassenger`, `type`, `factured`, `seat`) VALUES
	(47, 34, 2, 40, 'D', b'1', '1'),
	(48, 34, 2, 41, 'D', b'1', '5'),
	(49, 35, 1, 42, 'D', b'1', '2'),
	(50, 35, 6, 42, 'B', b'1', '1'),
	(51, 35, 1, 43, 'D', b'1', '6'),
	(52, 35, 6, 43, 'B', b'1', '8'),
	(53, 35, 1, 44, 'D', b'1', '1'),
	(54, 35, 6, 44, 'B', b'1', '2'),
	(55, 36, 5, 45, 'D', b'1', '1'),
	(56, 36, 6, 45, 'B', b'1', '6'),
	(57, 36, 5, 46, 'D', b'1', '5'),
	(58, 36, 6, 46, 'B', b'1', '5'),
	(59, 38, 3, 47, 'D', b'0', '8'),
	(60, 38, 6, 47, 'B', b'0', '3'),
	(61, 38, 3, 48, 'D', b'0', '4'),
	(62, 38, 6, 48, 'B', b'0', '4'),
	(63, 39, 2, 49, 'D', b'1', '3'),
	(64, 40, 6, 50, 'D', b'1', '7'),
	(65, 41, 4, 51, 'D', b'1', '1'),
	(66, 41, 1, 51, 'B', b'1', '3'),
	(67, 42, 1, 52, 'D', b'1', '5'),
	(68, 42, 2, 52, 'B', b'1', '2'),
	(69, 42, 1, 53, 'D', b'1', '7'),
	(70, 42, 2, 53, 'B', b'1', '6'),
	(71, 43, 1, 54, 'D', b'1', '8'),
	(72, 43, 2, 54, 'B', b'1', '7'),
	(73, 43, 1, 55, 'D', b'1', '4'),
	(74, 43, 2, 55, 'B', b'1', '4'),
	(75, 44, 5, 56, 'D', b'1', '2'),
	(76, 44, 4, 56, 'B', b'1', '5'),
	(77, 44, 5, 57, 'D', b'1', '6'),
	(78, 44, 4, 57, 'B', b'1', '6');
/*!40000 ALTER TABLE `flightoccupation` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.flightoccupation_backup: ~0 rows (aproximadamente)
DELETE FROM `flightoccupation_backup`;
/*!40000 ALTER TABLE `flightoccupation_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `flightoccupation_backup` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.flights: ~6 rows (aproximadamente)
DELETE FROM `flights`;
/*!40000 ALTER TABLE `flights` DISABLE KEYS */;
INSERT INTO `flights` (`id`, `idConnection`, `flightCode`, `departureDate`, `idTime`, `duration`, `airplane`, `price`, `nPlacement`) VALUES
	(1, 1, 'ZA 1111', '2016-03-12', 1, '02:30:00', 'ZA41526 R', 45.3, 8),
	(2, 3, 'ZA 2110', '2016-03-20', 1, '02:30:00', 'ZA41526 R', 65.25, 8),
	(3, 2, 'ZA 1221', '2016-03-12', 2, '02:30:00', 'ZA41524 S', 41.4, 8),
	(4, 4, 'ZA 2220', '2016-03-20', 2, '02:30:00', 'ZA41524 S', 70.25, 8),
	(5, 1, 'ZA 1111', '2016-03-11', 1, '02:23:00', 'ZA41214 C', 39.4, 8),
	(6, 3, 'ZA 2110', '2016-03-18', 1, '02:30:00', 'ZA41214 C', 58.7, 8);
/*!40000 ALTER TABLE `flights` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.flights_backup: ~0 rows (aproximadamente)
DELETE FROM `flights_backup`;
/*!40000 ALTER TABLE `flights_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `flights_backup` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.passengers: ~18 rows (aproximadamente)
DELETE FROM `passengers`;
/*!40000 ALTER TABLE `passengers` DISABLE KEYS */;
INSERT INTO `passengers` (`id`, `NIF`, `Birthdate`, `Name`, `Surname`, `country`, `type`, `state`) VALUES
	(40, '47445556Y', '2002-02-12', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(41, '452215654X', '2002-02-14', 'Jose', 'Sanchez Diaz', 'AU', 'adult', 'Bagdad'),
	(42, '47445556Y', '2002-02-12', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(43, '452215654X', '2002-02-12', 'Jose', 'Sanchez Diaz', 'AF', 'adult', 'Bagdad'),
	(44, '4581125S', '2002-02-08', 'Pablo', 'Sanchez Pene', 'AF', 'adult', 'Minasotta'),
	(45, '47445556Y', '1991-12-30', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(46, '452215654X', '2002-02-12', 'Jose', 'Sanchez Diaz', 'AF', 'adult', 'Bagdad'),
	(47, '47445556Y', '1991-12-30', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(48, '452215654X', '2002-02-12', 'Jose', 'Sanchez Diaz', 'AF', 'adult', 'Bagdad'),
	(49, '47445556Y', '2002-02-13', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(50, '47445556Y', '2002-02-12', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(51, '47445556Y', '1991-12-30', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(52, '47445556Y', '1991-12-30', 'Victor', 'Sanchez del Rio', 'ES', 'adult', 'Castilla-La Mancha'),
	(53, '45215654X', '2002-02-14', 'Jose', 'Sanchez Diaz', 'AF', 'child', 'Bagdad'),
	(54, '47445556Y', '1991-12-30', 'Victor', 'Sanchez del Rio', 'AF', 'adult', 'Castilla-La Mancha'),
	(55, '452215654X', '2002-02-12', 'Jose', 'Sanchez Diaz', 'AF', 'child', 'Bagdad'),
	(56, '47445556Y', '2002-02-12', 'Victor', 'Sanchez del Rio', 'AQ', 'adult', 'Castilla-La Mancha'),
	(57, '452215654X', '2002-02-14', 'Jose', 'Sanchez Diaz', 'BS', 'adult', 'Bagdad');
/*!40000 ALTER TABLE `passengers` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.passengers_backup: ~0 rows (aproximadamente)
DELETE FROM `passengers_backup`;
/*!40000 ALTER TABLE `passengers_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `passengers_backup` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.payments: ~10 rows (aproximadamente)
DELETE FROM `payments`;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` (`id`, `idBooking`, `Price`, `creditCard`, `creditHolder`, `creditYear`, `creditMonth`) VALUES
	(9, 34, 205.5, '4123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(10, 35, 381.99999999999994, '4123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(11, 36, 236.2, '4123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(12, 38, 481.2, '5123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(13, 39, 70.25, '4123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(14, 40, 58.7, '5123549156545872', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(15, 41, 130.55, '4123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(16, 42, 481.1, '5123549156545872', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(17, 43, 462.1, '4123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05'),
	(18, 44, 563.3, '4123549156545987', 'VICTOR SANCHEZ DEL RIO', '16', '05');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.payments_backup: ~0 rows (aproximadamente)
DELETE FROM `payments_backup`;
/*!40000 ALTER TABLE `payments_backup` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments_backup` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.services: ~6 rows (aproximadamente)
DELETE FROM `services`;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` (`id`, `code`, `description`, `descripcion`, `price`) VALUES
	(1, 'ES', 'Seat Selection', 'Elección de Asiento', 5),
	(2, 'AVIP', 'Large seat', 'Asiento Grande', 15),
	(3, '1M', 'One suitcase', 'Una maleta', 25),
	(4, '2M', 'Two suitcases', 'Dos maletas', 50),
	(5, 'F', 'Flexibility', 'Flex', 20),
	(6, 'B', 'Baby', 'Bebé', 20),
	(7, 'SEC', 'Flight Secure', 'Seguro de vuelo', 3);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.terminals: ~5 rows (aproximadamente)
DELETE FROM `terminals`;
/*!40000 ALTER TABLE `terminals` DISABLE KEYS */;
INSERT INTO `terminals` (`id`, `idAirport`, `Location`, `number`) VALUES
	(1, 1, 'T', 1),
	(2, 1, 'T', 2),
	(3, 2, 'T', 1),
	(4, 2, 'T', 2),
	(5, 3, 'T', 1);
/*!40000 ALTER TABLE `terminals` ENABLE KEYS */;

-- Volcando datos para la tabla db_airlines.users: ~3 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `email`, `name`, `surName`, `NIF`, `password`, `idLastPayment`) VALUES
	(2, 'victorsdr91@gmail.com', 'Víctor', 'Sánchez del Río', '47445556Y', '$2a$10$e8KzoWSstO6qJdVGokfWX.IXiHTPPupREY6utaQB.n0Az2OA5UUIC', NULL),
	(3, 'trianmarc91@gmail.com', 'Victor', 'Sánchez del Río', '47445556Y', '$2a$10$vCndLRPWJL3DbQEoKxyb4e2YKNvDwCSzdzUWtHXXPjr8B9uWXhYT6', NULL),
	(4, 'trianmarc91@gmail.com', 'Victor', 'Sánchez del Río', '47445556Y', '$2a$10$gIjY6WLEIhAuFx/RIJKaTeznIyGDisWuLhL3UEaMO1.faozxSH5W2', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
