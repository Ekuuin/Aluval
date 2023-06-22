-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-06-2023 a las 02:10:18
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `aluval`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `cat_id` int(11) NOT NULL,
  `cat_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`cat_id`, `cat_name`) VALUES
(3, 'Cristales'),
(1, 'Perfiles');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_pedido`
--

CREATE TABLE `detalles_pedido` (
  `dp_id` int(11) NOT NULL,
  `dp_proy_id` int(11) NOT NULL,
  `dp_prod_id` int(11) DEFAULT NULL,
  `dp_tipo` tinyint(4) NOT NULL,
  `dp_perfil` int(11) NOT NULL,
  `dp_mosq` tinyint(1) NOT NULL,
  `dp_cantidad` int(11) NOT NULL,
  `dp_ancho` decimal(4,2) DEFAULT NULL,
  `dp_altura` decimal(4,2) DEFAULT NULL,
  `dp_costo` decimal(8,2) NOT NULL,
  `dp_comentarios` varchar(300) NOT NULL,
  `dp_extra` decimal(6,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalles_pedido`
--

INSERT INTO `detalles_pedido` (`dp_id`, `dp_proy_id`, `dp_prod_id`, `dp_tipo`, `dp_perfil`, `dp_mosq`, `dp_cantidad`, `dp_ancho`, `dp_altura`, `dp_costo`, `dp_comentarios`, `dp_extra`) VALUES
(6, 19, 14, 2, 17, 0, 2, 1.60, 1.20, 9200.00, 'MAMPARA DE BAÑO,ALUMINIO GRIS NATURAL', 0.00),
(7, 19, 14, 2, 17, 0, 2, 0.77, 1.28, 5599.26, 'PUERTAS ENTRADA A BAÑOS,ALUMINIO GRIS NATURAL', 0.00),
(8, 20, 14, 2, 18, 0, 2, 1.65, 1.20, 9409.50, 'MAMPARAS DE BAÑO,ALUMINIO GRIS NATURAL', 0.00),
(9, 20, 14, 2, 18, 0, 2, 0.78, 1.28, 5622.44, 'PUERTAS ENTRADA BAÑO,ALUMINIO GRIS NATURAL', 0.00),
(10, 21, 13, 0, 21, 0, 2, 1.90, 1.19, 24784.90, 'ventana corrediza,mitad fija,vidrio tipo espejo', 0.00),
(11, 21, 13, 0, 21, 0, 1, 1.95, 2.08, 18027.10, 'ventana corrediza,mitad fija,vidrio tipo espejo', 0.00),
(12, 21, 13, 0, 21, 0, 2, 1.32, 0.32, 10692.64, 'ventana corrediza,mitad fija,vidrio tipo espejo', 0.00),
(13, 21, 13, 0, 21, 0, 1, 1.80, 1.20, 12054.00, 'ventana corrediza,mitad fija,vidrio tipo espejo', 0.00),
(14, 21, 15, 3, 21, 0, 1, 0.96, 2.26, 11954.48, 'puerta tapada duela,chapa residencial o de acero inoxidable', 0.00),
(15, 22, 11, 1, 22, 0, 2, 2.80, 1.90, 15008.00, 'fijo Europeo con doble división y cristal claro de 6mm y otra parte con pelicula esmerilada', 0.00),
(16, 22, 11, 1, 22, 0, 2, 1.80, 1.90, 10598.00, 'fijo Europeo con doble division,cristal claro de 6mm', 0.00),
(17, 23, 12, 0, 17, 0, 5, 1.09, 1.55, 24507.44, '', 0.00),
(18, 23, 12, 0, 17, 0, 2, 0.78, 1.23, 6963.18, '', 0.00),
(19, 23, 12, 0, 17, 0, 1, 0.30, 0.40, 1020.00, '', 0.00),
(20, 23, 12, 0, 20, 0, 1, 1.20, 2.20, 8226.00, '', 0.00),
(21, 24, 13, 0, 25, 0, 1, 2.37, 1.14, 16841.19, 'Ventana corrediza linea española 4600,mosquitero corredizo,uñeros serie 4600,cristal sol lite 6mm, aluminio color negro', 0.00),
(22, 24, 13, 0, 25, 0, 1, 1.60, 1.14, 13340.00, 'Ventana corrediza linea española 4600,mosquitero corredizo,uñeros serie 4600,cristal sol lite 6mm, aluminio color negro', 0.00),
(23, 24, 13, 0, 25, 0, 1, 2.03, 1.14, 15295.21, 'Ventana corrediza linea española 4600,mosquitero corredizo,uñeros serie 4600,cristal sol lite 6mm, aluminio color negro', 0.00),
(24, 24, 13, 0, 25, 0, 1, 1.64, 1.16, 13662.72, 'Ventana corrediza linea española 4600,mosquitero corredizo,uñeros serie 4600,cristal sol lite 6mm, aluminio color negro', 0.00),
(25, 24, 13, 3, 25, 0, 2, 0.28, 1.15, 5353.40, 'Ventanas abatibles de proyección,Linea española 4600 para proyección en aluminio negro,mosquiteros fijos internos,cristal sol lite 6mm, brazo largo de', 0.00),
(26, 24, 13, 3, 25, 0, 3, 0.36, 1.14, 8586.36, 'Ventanas abatibles de proyección,Linea española 4600 para proyección en aluminio negro,mosquiteros fijos internos,cristal sol lite 6mm, brazo largo de', 0.00),
(27, 24, 13, 3, 25, 0, 1, 1.10, 0.29, 2334.95, 'Ventanas abatibles de proyección,Linea española 4600 para proyección en aluminio negro,mosquiteros fijos internos,cristal sol lite 6mm, brazo largo de', 0.00),
(29, 26, 13, 0, 20, 0, 1, 2.00, 1.20, 9102.00, 'ventana corrediza a 3 hojas aluminio negro nacional 3pulgadas,2 partes corredizas y una fija,mosquitero corredizo', 2200.00),
(30, 26, 13, 0, 20, 0, 1, 2.69, 2.29, 16400.06, 'cancel 2 hojas en aluminio negro nacional 3pulgadas,una hoja fija y una corrediza', 2916.00),
(31, 27, 26, 3, 20, 0, 2, 0.50, 1.60, 7170.00, 'Ventana Proyección Linea Española en negro, parte superior de proyección y parte inferior fijo, vidrio tintex plus de 6mm', 0.00),
(32, 27, 26, 3, 20, 0, 2, 0.50, 1.20, 5670.00, 'Ventana Proyección Linea Española en negro, parte superior de proyección y parte inferior fijo, vidrio tintex plus de 6mm', 0.00),
(33, 27, 26, 0, 29, 0, 3, 1.00, 0.40, 5385.00, 'Ventana corrediza de 2 pulgadas en aluminio negro, mosquitero fijo, mitad fija y mitad corrediza,vidrio tintex plus', 0.00),
(34, 27, 26, 0, 20, 0, 1, 1.98, 2.08, 11537.46, 'Cancel corredizo de 3 pulgadas, aluminio negro, mosquitero corredizo,vidrio tintex plus de 6mm, mitad corrediza y mitad fija', 0.00),
(35, 27, 28, 0, 20, 0, 1, 1.98, 2.08, 18538.74, 'Cancel corredizo de 3 pulgadas, aluminio negro, mosquitero corredizo,vidrio tintex plus templado de 6mm, mitad corrediza y mitad fija', 0.00),
(36, 27, 26, 0, 29, 0, 1, 0.90, 1.20, 3954.00, 'ventana corrediza de 2 pulgadas en color negro, mitad fija y mitad corrediza con vidrio tintex plus', 0.00),
(37, 27, 26, 1, 29, 0, 2, 0.90, 1.10, 4385.00, 'ventana fija de 2 pulgadas en color negro, con vidrio tintex plus', 0.00),
(38, 27, 26, 1, 29, 0, 1, 0.90, 1.20, 3846.00, 'ventana fija de 2 pulgadas en color negro, con vidrio tintex plus', 1500.00),
(39, 27, 27, 1, 22, 0, 1, 1.14, 2.39, 12598.30, 'Fijo de vidrio tintex plus templado de 10mm sostenido con herrajes de acero inoxidable', 500.00),
(40, 28, 28, 0, 33, 0, 1, 0.55, 1.10, 4787.75, 'ventana corrediza en Linea Nacional de 3 pulgadas,mitad fija y mitad corrediza.Aluminio negro con cristal templado de 6mm,mosquitero corredizo', 0.00),
(41, 28, 28, 3, 33, 0, 1, 0.76, 2.04, 8917.24, 'Ventana en dos secciones, parte inferior fija y parte superior abatible tipo proyección.Aluminio negro con cristal templado de 6mm y mosquitero fijo', 0.00),
(42, 28, 28, 0, 33, 0, 1, 1.40, 1.03, 8243.80, 'ventana corrediza en Linea Nacional de 3 pulgadas ,mitad fija y mitad corrediza.Aluminio negro con cristal templado de 6mm,mosquitero corredizo', 0.00),
(43, 29, 28, 0, 25, 0, 1, 1.10, 0.55, 8635.25, 'ventana corrediza en Linea Española 4600 en aluminio negro,2 piezas corredizas con cristal templado de 6mm,mosquitero corredizo', 300.00),
(44, 29, 28, 0, 25, 0, 1, 0.76, 2.04, 18117.44, 'ventana corrediza en Linea Española 4600 en aluminio negro,2 piezas corredizas con cristal templado de 6mm,mosquitero corredizo', 300.00),
(45, 29, 28, 3, 25, 0, 1, 1.40, 1.03, 8078.70, 'ventana en Linea española en aluminio negro, parte inferior fija y parte superior tipo proyección. cristal templado de 6mm y mosquitero fijo', 300.00),
(46, 30, 35, 2, 34, 0, 1, 0.90, 2.00, 3879.50, 'suministro y colocación de Puerta en acabado color blanco, tablero aluminio blanco.<br>incluye perfiles, herrajes, chapa marca philips modelo 3065,elementos de fijación, mano de obra y herramienta necesaria para su correcta ejecución.', 950.00),
(47, 30, 16, 0, 34, 0, 1, 0.65, 0.50, 1601.00, 'suministro y colocación ventana corrediza compuesta de 2 módulos, uno fijo o otro corredizo, incluye cristal claro esmerilado de 6mm de espesor. Incluye herrajes, elementos de fijación, mano de obra y herramienta necesaria para su correcta ejecución. ', 0.00),
(48, 31, 16, 0, 34, 0, 1, 0.65, 0.50, 1853.34, 'Suministro y colocación de ventana corrediza compuesta de 2 módulos,  uno fijo y uno corredizo, incluye cristal claro esmerilado de 6mm de espesor. Incluye herrajes, elementos de fijación, mano de obra y herramienta necesaria para su correcta ejecución. ', 252.34),
(49, 31, 35, 2, 34, 0, 1, 0.90, 2.00, 3879.50, 'Suministro y colocación de  Puerta en aluminio acabado color blanco, incluye chapa marca Philips modelo 3065. También incluye herrajes, elementos de fijación, mano de obra y herramienta necesaria para su correcta ejecución.', 950.00),
(50, 32, 16, 0, 34, 0, 20, 0.65, 0.50, 35020.00, 'Suministro y colocación de ventana de aluminio color blanco compuesta de 2 módulos, uno fijo y uno corredizo, incluye cristal esmerilado de 6mm de espesor. También incluye herrajes, elementos de fijación, mano de obra herramienta necesaria para su correcta ejecución.', 150.00),
(51, 32, 35, 2, 34, 0, 20, 0.90, 2.00, 75590.00, 'Suministro y colocación de Puerta de aluminio color blanco, incluye chapa marca Philips modelo 3065. También incluye herrajes, elementos de fijación, mano de obra herramienta necesaria para su correcta ejecución.', 850.00),
(52, 33, 11, 0, 18, 0, 2, 2.40, 1.10, 13966.00, 'Cancel aluminio Natural en linea 2\", marca cuprum o similar en calidad, costo y garantía, con cristal claro de 6mm. Incluye: suministro, colocación, diseño de película en franjas horizontales, elementos de fijación, sellado, felpa, presentación, ajustes, repizon, materiales, mano de obra, equipo, he', 1599.00),
(53, 34, 11, 3, 37, 0, 2, 1.80, 2.00, 39000.00, 'PUERTA ESTILO FRANCESA, DOS HOJAS ABATIBLES EN ALUMINIO MADERA CEREZO, DISEÑO CUADROS CON CRISTAL, MITAD DUELA DE ALUMINIO DOBLE VISTA, FIJO SUPERIOR EN ARCO DISEÑO CUADROS', 7565.00),
(54, 34, 11, 3, 37, 0, 5, 1.51, 2.00, 71991.25, 'VENTANAS ABATIBLES EN ALUMINIO MADERA CEREZO, DISEÑO A CUADROS CON CRISTAL CLARO Y FIJO SUPERIOR EN ARCO', 3500.00),
(55, 34, 11, 0, 36, 0, 1, 1.52, 1.20, 9699.60, 'VENTANA CORREDIZA EN ALUMINIO COLOR MADERA,DISEÑO A CUADROS CON CRISTAL CLARO Y MOSQUITERO CORREDIZO, FIJO SUPERIOR EN ARCO', 2980.00),
(56, 34, 11, 0, 36, 0, 1, 1.53, 2.00, 13503.65, 'VENTANA CORREDIZA EN ALUMINIO COLOR MADERA,DISEÑO A CUADROS CON CRISTAL CLARO Y MOSQUITERO CORREDIZO, FIJO SUPERIOR EN ARCO', 4000.00),
(57, 34, 11, 0, 36, 0, 1, 1.79, 1.65, 12562.08, 'VENTANA CORREDIZA EN ALUMINIO COLOR MADERA,DISEÑO A CUADROS CON CRISTAL CLARO Y MOSQUITERO CORREDIZO, FIJO SUPERIOR EN ARCO', 3500.00),
(58, 34, 11, 0, 36, 0, 1, 0.99, 0.77, 6030.68, 'VENTANA CORREDIZA EN ALUMINIO COLOR MADERA,DISEÑO A CUADROS CON CRISTAL CLARO Y MOSQUITERO CORREDIZO, FIJO SUPERIOR EN ARCO', 2000.00),
(59, 34, 16, 0, 36, 0, 1, 0.90, 0.80, 5416.50, 'VENTANA CORREDIZA EN ALUMINIO COLOR MADERA,DISEÑO A CUADROS CON CRISTAL SATINADO OSCURO Y MOSQUITERO CORREDIZO', 1250.00),
(60, 34, 11, 0, 36, 0, 1, 1.20, 1.20, 7136.00, 'VENTANA CORREDIZA EN ALUMINIO COLOR MADERA,DISEÑO A CUADROS CON CRISTAL CLARO Y MOSQUITERO CORREDIZO', 1250.00),
(61, 34, 16, 2, 36, 0, 3, 1.00, 2.30, 22626.00, 'PUERTA PARA BAÑO,LINEA ECONOMICA EN COLOR MADERA,DISEÑO A CUADROS CON CRISTAL SATINOVO OSCURO Y MITAD DUELA DOBLE VISTA', 1900.00),
(62, 35, 12, 0, 25, 0, 1, 2.25, 2.24, 19363.80, 'VENTANA CORREDIZA A DOS HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(63, 35, 12, 3, 25, 0, 1, 1.27, 0.95, 4380.43, 'VENTANA CORREDIZA A DOS HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(64, 35, 12, 0, 25, 0, 1, 1.96, 1.18, 12001.48, 'VENTANA CORREDIZA A DOS HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(65, 35, 12, 1, 22, 0, 1, 1.02, 2.29, 4384.03, 'VENTANA MITAD FIJA,MITAD TIPO PROYECCION CON OPERADOR MANUAL. EN ALUMINIO COLOR NEGRO DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO FIJO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(66, 35, 16, 0, 25, 0, 1, 1.41, 0.74, 7911.97, 'VENTANA CORREDIZA A DOS HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(67, 35, 12, 0, 25, 0, 1, 1.20, 0.85, 7524.00, 'VENTANA CORREDIZA A DOS HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(68, 35, 12, 0, 25, 0, 2, 1.78, 2.30, 35063.80, 'VENTANA CORREDIZA A 4 HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(69, 35, 12, 0, 25, 0, 2, 1.46, 1.80, 26823.60, 'VENTANA CORREDIZA A 4 HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(70, 35, 12, 0, 25, 0, 1, 1.93, 2.44, 19022.62, 'VENTANA CORREDIZA A DOS HOJAS EN ALUMINIO COLOR NEGRO, DE LINEA EUROPEA 4600, TAMBIEN INCLUYE MOSUITERO CORREDIZO. INCLUYE SUMINISTROS PARA SU CORRECTA COLOCACION Y  FUNCIONALIDAD', 0.00),
(71, 35, 23, 1, 22, 0, 1, 0.70, 1.30, 3731.00, 'DOMO, MARCO ALUMINIO COLOR NEGRO Y CUBIERTA CRISTAL TEMPLADO 6MM. INCLUYE SUMINISTROS PARA COLOCACION Y CORRECTA FUNCIONALIDAD', 0.00),
(72, 36, 11, 0, 38, 0, 2, 2.30, 0.70, 12593.00, 'ventana corrediza a 4 hojas, 2 fijas y 2 corredizas al centro. vidrio claro de 6mm de espesor, incluye herrajes y material para su correcta instalación.', 1200.00),
(73, 36, 16, 0, 38, 0, 2, 3.00, 1.50, 25980.00, 'ventana corrediza a 4 hojas, 2 fijas y 2 corredizas al centro. vidrio claro de 6mm de espesor, incluye herrajes y material para su correcta instalación.', 1500.00),
(74, 36, 11, 0, 38, 0, 2, 2.00, 1.50, 18720.00, 'ventana corrediza a 4 hojas, 2 fijas y 2 corredizas al centro. vidrio claro de 6mm de espesor, incluye herrajes y material para su correcta instalación.', 1500.00),
(75, 36, 11, 0, 38, 0, 1, 4.00, 1.50, 13670.00, 'ventana corrediza a 4 hojas, 2 fijas y 2 corredizas al centro. vidrio claro de 6mm de espesor, incluye herrajes y material para su correcta instalación.', 1700.00),
(76, 39, 11, 1, 17, 0, 1, 1.00, 1.00, 1660.00, 'Chambilla', 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `pro_id` int(11) NOT NULL,
  `pro_name` varchar(50) NOT NULL,
  `pro_category` int(11) NOT NULL,
  `pro_brand` varchar(50) DEFAULT NULL,
  `pro_cost` decimal(10,2) DEFAULT NULL,
  `pro_unit` enum('m2','m','Pieza') DEFAULT NULL,
  `jambaC` decimal(6,2) DEFAULT NULL,
  `mosquiteroC` decimal(6,2) DEFAULT NULL,
  `rielC` decimal(6,2) DEFAULT NULL,
  `adaptadorC` decimal(6,2) DEFAULT NULL,
  `traslapeC` decimal(6,2) DEFAULT NULL,
  `zocloC` decimal(6,2) DEFAULT NULL,
  `bolsaF` decimal(6,2) DEFAULT NULL,
  `escalonadoF` decimal(6,2) DEFAULT NULL,
  `junquilloF` decimal(6,2) DEFAULT NULL,
  `marcoPE` decimal(6,2) DEFAULT NULL,
  `cercoPE` decimal(6,2) DEFAULT NULL,
  `zocloPE` decimal(6,2) DEFAULT NULL,
  `tubularPEsp` decimal(6,2) DEFAULT NULL,
  `hojaPEsp` decimal(6,2) DEFAULT NULL,
  `zocloPEsp` decimal(6,2) DEFAULT NULL,
  `junquilloPEsp` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`pro_id`, `pro_name`, `pro_category`, `pro_brand`, `pro_cost`, `pro_unit`, `jambaC`, `mosquiteroC`, `rielC`, `adaptadorC`, `traslapeC`, `zocloC`, `bolsaF`, `escalonadoF`, `junquilloF`, `marcoPE`, `cercoPE`, `zocloPE`, `tubularPEsp`, `hojaPEsp`, `zocloPEsp`, `junquilloPEsp`) VALUES
(11, 'vidrio claro 6mm ', 3, 'ALUVAL', 750.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(12, 'VIDRIO FILTRASOL 6MM', 3, 'ALUVAL', 850.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(13, 'SOL LITE 6MM', 3, 'ALUVAL', 1050.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(14, 'DUELA SENCILLA', 3, 'ALUVAL', 1300.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(15, 'DUELA DOBLE VISTA', 3, 'ALUVAL', 2800.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(16, 'VIDRIO SATINOVO 6MM', 3, 'ALUVAL', 1100.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(17, 'ALUMINIO BLANCO 2\"', 1, 'ALUVAL', 0.00, 'm', 260.00, 165.00, 150.00, 65.00, 155.00, 230.00, 200.00, 190.00, 65.00, 135.00, 225.00, 320.00, 350.00, 540.00, 600.00, 85.00),
(18, 'ALUMINIO GRIS NATURAL 2\"', 1, 'ALUVAL', 0.00, 'm', 250.00, 155.00, 150.00, 65.00, 155.00, 220.00, 190.00, 190.00, 65.00, 135.00, 220.00, 320.00, 350.00, 530.00, 600.00, 85.00),
(19, 'acrilico ', 3, 'ALUVAL', 1100.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(20, 'aluminio 3\" B.N.G/PROYECCION', 1, 'ALUVAL', 0.00, 'm', 330.00, 160.00, 200.00, 65.00, 250.00, 300.00, 300.00, 300.00, 90.00, 260.00, 230.00, 230.00, 300.00, 350.00, 350.00, 85.00),
(21, 'Perfil Europe Tono Madera', 1, 'AluVal', 0.00, 'm', 650.00, 460.00, 650.00, 50.00, 460.00, 460.00, 350.00, 350.00, 90.00, 250.00, 360.00, 395.00, 360.00, 550.00, 650.00, 90.00),
(22, 'fijos europeos', 1, 'AluVal', 0.00, 'm', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 350.00, 300.00, 90.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(23, 'vidrio templado 6mm claro', 3, 'Aluval', 2500.00, '', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(24, 'templado 4mm sin diseño', 3, 'ALUVAL', 1800.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(25, 'serie española 4600', 1, 'Aluval', 0.00, 'm', 650.00, 650.00, 650.00, 100.00, 680.00, 650.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 500.00, 350.00, 350.00, 85.00),
(26, 'tintex plus (verde)', 3, 'Aluval', 1150.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(27, 'tintex templado 10mm', 3, 'Aluval', 3500.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(28, 'tintex templado 6mm', 3, 'Aluval', 2850.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(29, 'Aluminio Negro 2\"', 1, 'Aluvall', 0.00, 'm', 255.00, 165.00, 150.00, 80.00, 160.00, 195.00, 250.00, 220.00, 60.00, 140.00, 265.00, 290.00, 260.00, 550.00, 600.00, 90.00),
(30, 'insulado 6+6', 3, 'Aluval', 4800.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(31, 'insulado cuadricula interna', 3, 'Aluval', 7000.00, 'm2', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(32, 'corrediza española doble vidrio', 1, 'Aluval', 0.00, '', 850.00, 720.00, 850.00, 100.00, 780.00, 720.00, 540.00, 540.00, 90.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(33, 'Aluminio 3 N.B.G/Proyeccion L.E.', 1, 'Aluval', 0.00, '', 335.00, 170.00, 210.00, 75.00, 265.00, 320.00, 255.00, 255.00, 90.00, 130.00, 255.00, 320.00, 255.00, 530.00, 630.00, 95.00),
(34, 'Aluminio Blanco', 1, 'Aluval', 0.00, 'm', 260.00, 165.00, 155.00, 75.00, 170.00, 250.00, 200.00, 175.00, 75.00, 185.00, 265.00, 335.00, 0.00, 0.00, 0.00, 0.00),
(35, 'duela sencilla blanco', 3, 'Aluval', 200.00, 'm', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
(36, 'Aluminio Tono Madera', 1, 'Aluval', 0.00, 'm', 400.00, 200.00, 235.00, 120.00, 275.00, 375.00, 385.00, 390.00, 100.00, 200.00, 270.00, 375.00, 270.00, 550.00, 570.00, 120.00),
(37, 'D.P. ALUMINIO MADERA', 1, 'aLUVAL', 0.00, 'm2', 400.00, 200.00, 235.00, 110.00, 275.00, 375.00, 380.00, 390.00, 110.00, 250.00, 500.00, 650.00, 275.00, 1100.00, 650.00, 250.00),
(38, 'Aluminio ventanas 4 hojas', 1, 'Aluval', 0.00, 'm', 250.00, 165.00, 200.00, 80.00, 500.00, 200.00, 300.00, 300.00, 85.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyectos`
--

CREATE TABLE `proyectos` (
  `proy_id` int(11) NOT NULL,
  `proy_fecha` date NOT NULL,
  `proy_cliente` varchar(100) NOT NULL,
  `proy_domicilio` varchar(100) NOT NULL,
  `proy_total` decimal(8,2) NOT NULL,
  `proy_estado` enum('CANCELADO','PENDIENTE','ACTIVO','FINALIZADO') NOT NULL DEFAULT 'PENDIENTE'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proyectos`
--

INSERT INTO `proyectos` (`proy_id`, `proy_fecha`, `proy_cliente`, `proy_domicilio`, `proy_total`, `proy_estado`) VALUES
(19, '2022-09-13', 'PAUL SOLORIO', 'USAE PENJAMO', 18501.14, 'FINALIZADO'),
(20, '2022-09-13', 'PAUL SOLORIO', 'USAE PENJAMO', 18504.25, 'FINALIZADO'),
(21, '2022-09-23', 'Luis Ventanas Europeas', 'desconocido', 89915.22, 'FINALIZADO'),
(22, '2022-09-23', 'Wilhen', 'agroquimicos', 38402.96, 'FINALIZADO'),
(23, '2022-10-01', 'romeral', 'rome', 47231.28, 'PENDIENTE'),
(24, '2022-10-27', 'JUAN ', 'Potreros', 89320.00, 'FINALIZADO'),
(26, '2022-12-03', 'Juan', 'Potreros', 29582.39, 'PENDIENTE'),
(27, '2023-01-16', 'Ing Misael Espinoza', 'Saturno', 84778.02, 'PENDIENTE'),
(28, '2023-01-17', 'Paty Nacional', 'E.Carranza', 25460.60, 'PENDIENTE'),
(29, '2023-01-17', 'Paty L.Española', 'E.Carranza 53', 40404.41, 'PENDIENTE'),
(30, '2023-01-30', 'Presidencia', 'comunidaes', 6357.38, 'PENDIENTE'),
(31, '2023-01-30', 'Urbanizadora AJO S.A. deC.V.', 'Baños Comunidades', 6650.09, 'PENDIENTE'),
(32, '2023-02-10', 'Urbanizadora AJO S.A. de C.V.', 'comunidades', 128307.60, 'ACTIVO'),
(33, '2023-02-17', 'Candy', 'whats', 16200.56, 'PENDIENTE'),
(34, '2023-05-15', 'HUGO CERVANTES', 'FRACC', 218040.27, 'PENDIENTE'),
(35, '2023-05-15', 'ROBERTO GARCIA', 'LLANTAS Y SERV. PENJAMO', 162639.81, 'PENDIENTE'),
(36, '2023-06-12', 'Ign. Missael', 'escuelas', 82317.08, 'PENDIENTE'),
(39, '2023-06-21', 'Raul', 'Cazador 29', 1925.60, 'PENDIENTE');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`cat_id`),
  ADD UNIQUE KEY `cat_name` (`cat_name`);

--
-- Indices de la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD PRIMARY KEY (`dp_id`),
  ADD KEY `pd_prod_id` (`dp_prod_id`),
  ADD KEY `pd_ord_id` (`dp_proy_id`),
  ADD KEY `detalles_pedido_ibfk_3` (`dp_perfil`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`pro_id`),
  ADD UNIQUE KEY `pro_name_category` (`pro_name`,`pro_category`) USING BTREE,
  ADD KEY `pro_category` (`pro_category`);

--
-- Indices de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  ADD PRIMARY KEY (`proy_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  MODIFY `dp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `pro_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `proyectos`
--
ALTER TABLE `proyectos`
  MODIFY `proy_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalles_pedido`
--
ALTER TABLE `detalles_pedido`
  ADD CONSTRAINT `detalles_pedido_ibfk_1` FOREIGN KEY (`dp_prod_id`) REFERENCES `productos` (`pro_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_pedido_ibfk_2` FOREIGN KEY (`dp_proy_id`) REFERENCES `proyectos` (`proy_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalles_pedido_ibfk_3` FOREIGN KEY (`dp_perfil`) REFERENCES `productos` (`pro_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `pro_category` FOREIGN KEY (`pro_category`) REFERENCES `categoria` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
