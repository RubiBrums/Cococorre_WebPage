-- Se crea la base de datos --
CREATE DATABASE cococorre_db;
USE cococorre_db;

-- Se crea la tabla primaria "entidad" --
CREATE TABLE `Entidad` (
  `id` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_escenario` integer NOT NULL,
  `id_personaje` integer NOT NULL,
  `id_item` integer NOT NULL
);

-- Se crean las tablas con claves foráneas --
CREATE TABLE `Personajes` (
  `id_personaje` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) UNIQUE NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `src_imgPersonaje` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `Items` (
  `id_item` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) UNIQUE NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `src_imgItem` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `Escenarios` (
  `id_escenario` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) UNIQUE NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `src_imgEscenario` varchar(255) UNIQUE NOT NULL
);

-- Se asocian las claves foráneas con la tabla entidad, con sus respectivas restricciones --
ALTER TABLE `Entidad` ADD CONSTRAINT `fk_Escenarios_id_escenario_Entidad` FOREIGN KEY (`id_escenario`) REFERENCES `Escenarios` (`id_escenario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Entidad` ADD CONSTRAINT `fk_Personajes_id_personaje_Entidad` FOREIGN KEY (`id_personaje`) REFERENCES `Personajes` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Entidad` ADD CONSTRAINT `fk_Items_id_item_Entidad` FOREIGN KEY (`id_item`) REFERENCES `Items` (`id_item`) ON DELETE NO ACTION ON UPDATE NO ACTION;


-- Se insertan datos de los escenarios, personajes e items en las tablas -- 
ALTER TABLE `Escenarios`;
INSERT INTO Escenarios (id_escenario, nombre, descripcion, src_imgEscenario)
VALUES
(1,'Granja Campo Lindo','La granja de Maggie, una bella granja donde los animales son comercializados.','frontend/assets/img/escenario_GranjaCL.png'),
(2,'Carretera Challán-Terolin','Una bella carretera llena de baches y peligros. Helen recorre estos caminos en busca del camión que secuestró a Gallardo.','frontend/assets/frontendassets/img/escenario_carreteraCT.png'),
(3,'Túnel','Un oscuro túnel con diversos peligros y una muy mala iluminación.','frontend/assets/img/escenario_tunel.png'),
(4,'Carretera Terolin-Parronal','Una carretera sucia, llena de estorbos y basura, la lluvia se siente ácida.','frontend/assets/img/escenario_carreteraTP.png'),
(5,'Fábrica Happy Animals','La ilustre fábrica "Cruelty Free" de la reconocida empresaria Bossy, llena de robots que experimentan en animales sin considerar si estos sufren en el proceso.','frontend/assets/img/escenario_fabricaHA.png'),
(6,'Matadero','Una vez los animales de la fábrica Happy Animals son descartados, estos son enviados al matadero del Carnicero. Huele a químicos, muerte, sangre y huesos.','frontend/assets/img/escenario_matadero.png'),
(7,'Parada de camioneros','Al anochecer, los camioneros se reunen en esta parada para comenzar las peleas clandestinas de gallos. Está lleno de tierra, sangre, vómito, vidrios rotos y cerveza.','frontend/assets/img/escenario_paradaCamiones.png'),
(8,'Granja Verdemar','Una hermosa granja perteneciente a Rosita, es el paraíso de los animales de granja. Lleno de flores hermosas y un hermoso arroyo.','frontend/assets/img/escenario_granjaVM.png'),
(9,'Camino de tierra','Un camino lleno de polvo y baches por el cual Helen debe cruzar para llegar a la carretera Challán-Terolin.','frontend/assets/img/escenario_caminotierra.png'),
(10,'Retorno','Tras derrotar al carnicero, Helen y Gallardo correrán a través del retorno para regresar a su granja, sin embargo, se equivocan de camino, debido a que no saben leer. Así es como llega con Gallardo a la granja Verdemar.','frontend/assets/img/escenario_retorno.png');

ALTER TABLE `Personajes`;
INSERT INTO Personajes (id_personaje, nombre, descripcion, tipo, src_imgPersonaje)
VALUES
(1,'Helen','Helen es una valiente gallina que debe rescatar a su esposo Gallardo de las manos de un matadero. No se acobarda ante nada, le gusta mucho el maíz, y usar pañuelos.','Protagonista','frontend/assets/img/full_helen.png'),
(2,'Gallardo','Gallardo es el esposo de Helen, un gallo amable que cuidaba de todos en la granja, sin embargo, fue secuestrado por unos camioneros para llevarlo a un matadero. Le gustan las ramas y siempre busca nidos para Helen.','NPC','frontend/assets/img/full_gallardo.png'),
(3,'Charlie','Conejo charlatán que vende basura a buen precio, es un comerciante ambulante que se encontrará en el camino de Helen en diversas ocasiones. Le gusta rebuscar entre los escombros de la carretera, y ama su sombrero.','NPC','frontend/assets/img/full_charlie.png'),
(4,'Rana Radio','Rana Radio es una rana que vive en la granja y se la pasa junto a una radio que está en un granero, comunica sus mensajes a través de la radio. Le gusta observar al resto, y le brinda ayuda a Helen para cumplir su misión.','NPC','frontend/assets/img/full_ranaRadio.png'),
(5,'Gladiolo','Gladiolo es un gallo de pelea que, al igual que el resto, ha sido obligado a sufrir a costa del entretenimiento de los camioneros. Ayudará a Helen para que los libre de las peleas clandestinas.','NPC','frontend/assets/img/full_gladiolo.png'),
(6,'Rosita','Un alma amable que ama a los animales y les protege todo lo posible, dueña de una granja con animales rescatados, siempre acepta a nuevos integrantes.','NPC','frontend/assets/img/full_rosita.png'),
(7,'Jurel','Jurel es una gata que vive con Rosita, muy cariñosa, protege a los animales de su granja, y está siempre pendiente de que nadie les moleste. Le encantan las latas de jurel.','NPC','frontend/assets/img/full_jurel.png'),
(8,'Teodoro','Un toro bravo que acaba de llegar al matadero. No está para juegos, debe escapar para regresar con su familia. Ofrecerá su ayuda a Helen si le libera de su prisión de metal.','NPC','frontend/assets/img/full_teodoro.png'),
(9,'Daisy','Una valiente pata que ha perdido a sus patitos a manos de unos galgos. La vida le ha enseñado a ser precavida y a valerse por sí misma. Le ha enseñado a Helen a pelear.','NPC','frontend/assets/img/full_daisy.png'),
(10,'Granjera Maggie','Una granjera muy interesada por el dinero, no le tiene ningún cariño a sus animales, pues estos son solo números. Maggie ha vendido a una buena cantidad de animales de su granja, y entre ellos estaba Gallardo. Su más grande amor es el dinero.','Boss','frontend/assets/img/full_granjeraMaggie.png'),
(11,'Trucker','Este camionero es iracundo, siempre tiene un aspecto cansado y fuma como chimenea, es muy apático y ve a los demás seres vivos como objetos. Se irrita fácilmente. Le gustan las peleas clandestinas de gallos.','Boss','frontend/assets/img/full_trucker.png'),
(12,'Bossy','Es una empresaria muy importante y dueña de la fábrica "Happy Animals", siempre trae su teléfono a mano,  mantiene su temple en calma, hasta que las cosas dejan de salir como ella quiere. Un pisotón de esos tacones y estás fuera.','Boss','frontend/assets/img/full_bossy.png'),
(13,'Carnicero','Un ser vil que no duda en destruir las vidas de animales; él solo ve números, números que solo se suman a la cantidad exorbitante de vidas que ha arrebatado.','Boss','frontend/assets/img/full_carnicero.png'),
(14,'Minion obrero','Los minions obreros se encargan de todo el trabajo bruto de la elaboración de productos "cruelty free". Son toscos y siguen todas las órdenes de sus superiores sin cuestionarse.','Enemigo','frontend/assets/img/full_minionObrero.png'),
(15,'Minion oficinista','Los minions oficinistas se encargan de administrar la fábrica en sus cubículos, si se acerca una amenaza lanzan los artículos que están portando y llaman a los minions obreros para protegerlos.','Enemigo','frontend/assets/img/full_minionOficinista.png'),
(16,'Minion carnicero','Robot o monstruo? No lo sabemos, pero no dudará en atacar al animal que se le cruce por delante, mucho menos a una gallina.','Enemigo','frontend/assets/img/full_minionCarnicero.png'),
(17,'Gallos de pelea','Los jóvenes gallos están tan cegados por sobrevivir que ya no les importa matarse entre sí. Han tenido una vida muy difícil, a veces sueñan con vivir en un hermoso campo lleno de flores... Sueños lejanos...','Enemigo','frontend/assets/img/full_gallosPelea.png'),
(18,'Dui','Un viejo perro que no permite que los animales de la granja de Maggie escapen, tiene problemas con Helen y Daisy, debido a que siempre están intentando huir y romper cosas. Es un perro cansado, una vida de perros.','Enemigo','frontend/assets/img/full_dui.png');


ALTER TABLE `Items`;
INSERT INTO Items (id_item, nombre, descripcion, tipo, src_imgItem)
VALUES
(1,'Maíz','Recurso utilizado por los animales para comercio interespecie.','economia','frontend/assets/img/item_maiz.png'),
(2,'Gusano saludable','Un rosado y delicioso gusano con propiedades curativas. Recupera +1 HP para Helen.','hp','frontend/assets/img/item_gusanoSaludable.png'),
(3,'Gusano escurridizo','Un escurridizo y picante gusano que aumenta la velocidad de Helen por 4 segundos.','efecto','frontend/assets/img/item_gusanoEscurridizo.png'),
(4,'Gusano musculoso','Un gigante y musculoso gusano que aumenta la fuerza de Helen por 4 segundos.','efecto','frontend/assets/img/item_gusanoMusculoso.png'),
(5,'Gusano legendario','Un reluciente y poderoso gusano con propiedades curativas y además potenciadoras. Añade un corazón adicional a la vida de Helen y recupera toda su salud.','hp','frontend/assets/img/item_gusanoLegendario.png'),
(6,'Pañoleta','Una linda pañoleta que Helen encontró en el gallinero, al parecer era de Maggie.','accesorio','frontend/assets/img/item_panoleta.png'),
(7,'Lentes de sol','Al derrotar a Bossy podrás robarle uno de sus lentes de sol, y así tener un gran estilo.','accesorio','frontend/assets/img/item_lentesSol.png'),
(8,'Sombrero de bruja','Sombrero temático para las épocas de Halloween.','accesorio','frontend/assets/img/item_halloween.png'),
(9,'Sombrero navideño','Sombrero temático para las épocas de Navidad.','accesorio','frontend/assets/img/item_navidad.png'),
(10,'Boina de ilustradora','Una boina robada de una ilustradora que luchaba contra robots, es bastante cómoda e inspira creatividad.','accesorio','frontend/assets/img/item_comunidad.png'),
(11,'Sombrero de paja','Al derrotar a la granjera Maggie podrás robarle su sombrero, es bueno para protegerse del sol.','accesorio','frontend/assets/img/item_sombreroPaja.png'),
(12,'Sombrero de arroz','Charlie te regalará su sombrero al salvarle la vida de la fábrica Happy Animals, como su mayor muestra de agradecimiento.','accesorio','frontend/assets/img/item_sombreroArroz.png'),
(13,'Cofia','Al derrotar al Carnicero podrás quitarle su cofia de carnicería. Huele a muerte.','accesorio','frontend/assets/img/item_cofia.png'),
(14,'Gorra de camionero','Al derrotar a Trucker, podrás robarle su gorra. Huele a aceite de motor y cigarros.','accesorio','frontend/assets/img/item_gorraCamionero.png'),
(15,'Rana Radio portátil','Una vez hayas completado por primera vez el juego, Rana Radio te pedirá acompañarte para conocer el mundo. Irá pegada en la cabeza de Helen.','accesorio','frontend/assets/img/item_ranaRadioPortatil.png'),
(16,'Espuelas oxidadas','Unas viejas y oxidadas espuelas encontradas en la basura por Charlie, se las ha vendido a Helen por 15 granos de maíz. El riesgo de contraer tétanos para el enemigo no es muy alto, pero nunca nulo.','arma','frontend/assets/img/item_espuelaOxidada.png'),
(17,'Espuelas ornamentales','Unas elegantes y doradas espuelas encontradas en la parada de camiones por Charlie, se las ha vendido a Helen por 35 granos de maíz. El brillo que desprenden puede cegar a sus enemigos.','arma','frontend/assets/img/item_espuelaOrnamental.png'),
(18,'Espuelas de cobre','Unas pulidas y endebles espuelas encontradas en la basura por Charlie, se las ha vendido a Helen por 20 granos de maíz. No tiene muchas utilidades, pero daña más a los enemigos que las espuelas oxidadas.','arma','frontend/assets/img/item_espuelaCobre.png'),
(19,'Espuelas de acero','Unas resistentes y fuertes espuelas de acero inoxidable que Gladiolo le ha regalado a Helen antes de entrar al matadero. Son tan filosas que pueden cortar metal.','arma','frontend/assets/img/item_espuelaAcero.png'),
(20,'Mazorca','Una gran mazorca con una considerable cantidad de maíz. ¡Con una de estas te harás rico!','economia','frontend/assets/img/item_mazorca.png');
