-- Se crea la base de datos --
CREATE DATABASE cococorre;
USE cococorre;

-- Se crea la tabla primaria "entidad" --
CREATE TABLE `Entidad` (
  `id` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `id_escenario` integer NOT NULL,
  `id_personaje` integer NOT NULL,
  `id_item` integer NOT NULL
);

-- Anular la restricción de que los id de los escenarios, personajes e items no puedan ser nulos, ya que no todos tienen la misma cantidad de datos --
ALTER TABLE `Entidad`
MODIFY `id_escenario` integer NULL,
MODIFY `id_personaje` integer NULL,
MODIFY `id_item` integer NULL;

-- Se crean las tablas con claves foráneas --
CREATE TABLE `Personajes` (
  `id_personaje` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) UNIQUE NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `src_imgPersonaje` varchar(255) UNIQUE NOT NULL,
  `src_thumbnail` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `Items` (
  `id_item` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) UNIQUE NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `src_imgItem` varchar(255) UNIQUE NOT NULL,
  `src_thumbnail` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `Escenarios` (
  `id_escenario` integer UNIQUE PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) UNIQUE NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `src_imgEscenario` varchar(255) UNIQUE NOT NULL,
  `src_thumbnail` varchar(255) UNIQUE NOT NULL
);

-- Se asocian las claves foráneas con la tabla entidad, con sus respectivas restricciones --
ALTER TABLE `Entidad` ADD CONSTRAINT `fk_Escenarios_id_escenario_Entidad` FOREIGN KEY (`id_escenario`) REFERENCES `Escenarios` (`id_escenario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Entidad` ADD CONSTRAINT `fk_Personajes_id_personaje_Entidad` FOREIGN KEY (`id_personaje`) REFERENCES `Personajes` (`id_personaje`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `Entidad` ADD CONSTRAINT `fk_Items_id_item_Entidad` FOREIGN KEY (`id_item`) REFERENCES `Items` (`id_item`) ON DELETE NO ACTION ON UPDATE NO ACTION;


-- Se insertan datos de los escenarios, personajes e items en las tablas -- 
ALTER TABLE `Escenarios`;
INSERT INTO Escenarios (id_escenario, nombre, descripcion, src_imgEscenario, src_thumbnail)
VALUES
(1,'Granja Campo Lindo','La granja de Maggie, una bella granja donde los animales son comercializados.','escenario_granjacl.png','thumbnail_granjacl.png'),
(2,'Carretera Challán-Terolin','Una bella carretera llena de baches y peligros. Helen recorre estos caminos en busca del camión que secuestró a Gallardo.','escenario_carreteract.png','thumbnail_carreteract.png'),
(3,'Túnel','Un oscuro túnel con diversos peligros y una muy mala iluminación.','escenario_tunel.png','thumbnail_tunel.png'),
(4,'Carretera Terolin-Parronal','Una carretera sucia, llena de estorbos y basura, la lluvia se siente ácida.','escenario_carreteratp.png','thumbnail_carreteratp.png'),
(5,'Fábrica Happy Animals','La ilustre fábrica "Cruelty Free" de la reconocida empresaria Bossy, llena de robots que experimentan en animales sin considerar si estos sufren en el proceso.','escenario_fabricaha.png','thumbnail_fabricaha.png'),
(6,'Matadero','Una vez los animales de la fábrica Happy Animals son descartados, estos son enviados al matadero del Carnicero. Huele a químicos, muerte, sangre y huesos.','escenario_matadero.png','thumbnail_matadero.png'),
(7,'Parada de camioneros','Al anochecer, los camioneros se reunen en esta parada para comenzar las peleas clandestinas de gallos. Está lleno de tierra, sangre, vómito, vidrios rotos y cerveza.','escenario_paradacamiones.png','thumbnail_paradacamiones.png'),
(8,'Granja Verdemar','Una hermosa granja perteneciente a Rosita, es el paraíso de los animales de granja. Lleno de flores hermosas y un hermoso arroyo.','escenario_granjavm.png','thumbnail_granjavm.png'),
(9,'Camino de tierra','Un camino lleno de polvo y baches por el cual Helen debe cruzar para llegar a la carretera Challán-Terolin.','escenario_caminotierra.png','thumbnail_caminotierra.png'),
(10,'Retorno','Tras derrotar al carnicero, Helen y Gallardo correrán a través del retorno para regresar a su granja, sin embargo, se equivocan de camino, debido a que no saben leer. Así es como llega con Gallardo a la granja Verdemar.','escenario_retorno.png','thumbnail_retorno.png');

ALTER TABLE `Personajes`;
INSERT INTO Personajes (id_personaje, nombre, descripcion, tipo, src_imgPersonaje, src_thumbnail)
VALUES
(1,'Helen','Helen es una valiente gallina que debe rescatar a su esposo Gallardo de las manos de un matadero. No se acobarda ante nada, le gusta mucho el maíz, y usar pañuelos.','Protagonista','full_helen.png','thumbnail_helen.png'),
(2,'Gallardo','Gallardo es el esposo de Helen, un gallo amable que cuidaba de todos en la granja, sin embargo, fue secuestrado por unos camioneros para llevarlo a un matadero. Le gustan las ramas y siempre busca nidos para Helen.','NPC','full_gallardo.png','thumbnail_gallardo.png'),
(3,'Charlie','Conejo charlatán que vende basura a buen precio, es un comerciante ambulante que se encontrará en el camino de Helen en diversas ocasiones. Le gusta rebuscar entre los escombros de la carretera, y ama su sombrero.','NPC','full_charlie.png','thumbnail_charlie.png'),
(4,'Rana Radio','Rana Radio es una rana que vive en la granja y se la pasa junto a una radio que está en un granero, comunica sus mensajes a través de la radio. Le gusta observar al resto, y le brinda ayuda a Helen para cumplir su misión.','NPC','full_ranaradio.png','thumbnail_ranaradio.png'),
(5,'Gladiolo','Gladiolo es un gallo de pelea que, al igual que el resto, ha sido obligado a sufrir a costa del entretenimiento de los camioneros. Ayudará a Helen para que los libre de las peleas clandestinas.','NPC','full_gladiolo.png','thumbnail_gladiolo.png'),
(6,'Rosita','Un alma amable que ama a los animales y les protege todo lo posible, dueña de una granja con animales rescatados, siempre acepta a nuevos integrantes.','NPC','full_rosita.png','thumbnail_rosita.png'),
(7,'Jurel','Jurel es una gata que vive con Rosita, muy cariñosa, protege a los animales de su granja, y está siempre pendiente de que nadie les moleste. Le encantan las latas de jurel.','NPC','full_jurel.png','thumbnail_jurel.png'),
(8,'Teodoro','Un toro bravo que acaba de llegar al matadero. No está para juegos, debe escapar para regresar con su familia. Ofrecerá su ayuda a Helen si le libera de su prisión de metal.','NPC','full_teodoro.png','thumbnail_teodoro.png'),
(9,'Daisy','Una valiente pata que ha perdido a sus patitos a manos de unos galgos. La vida le ha enseñado a ser precavida y a valerse por sí misma. Le ha enseñado a Helen a pelear.','NPC','full_daisy.png','thumbnail_daisy.png'),
(10,'Granjera Maggie','Una granjera muy interesada por el dinero, no le tiene ningún cariño a sus animales, pues estos son solo números. Maggie ha vendido a una buena cantidad de animales de su granja, y entre ellos estaba Gallardo. Su más grande amor es el dinero.','Boss','full_granjeramaggie.png','thumbnail_granjeramaggie.png'),
(11,'Trucker','Este camionero es iracundo, siempre tiene un aspecto cansado y fuma como chimenea, es muy apático y ve a los demás seres vivos como objetos. Se irrita fácilmente. Le gustan las peleas clandestinas de gallos.','Boss','full_trucker.png','thumbnail_trucker.png'),
(12,'Bossy','Es una empresaria muy importante y dueña de la fábrica "Happy Animals", siempre trae su teléfono a mano,  mantiene su temple en calma, hasta que las cosas dejan de salir como ella quiere. Un pisotón de esos tacones y estás fuera.','Boss','full_bossy.png','thumbnail_bossy.png'),
(13,'Carnicero','Un ser vil que no duda en destruir las vidas de animales; él solo ve números, números que solo se suman a la cantidad exorbitante de vidas que ha arrebatado.','Boss','full_carnicero.png','thumbnail_carnicero.png'),
(14,'Minion obrero','Los minions obreros se encargan de todo el trabajo bruto de la elaboración de productos "cruelty free". Son toscos y siguen todas las órdenes de sus superiores sin cuestionarse.','Enemigo','full_minionobrero.png','thumbnail_minionobrero.png'),
(15,'Minion oficinista','Los minions oficinistas se encargan de administrar la fábrica en sus cubículos, si se acerca una amenaza lanzan los artículos que están portando y llaman a los minions obreros para protegerlos.','Enemigo','full_minionoficinista.png','thumbnail_minionoficinista.png'),
(16,'Minion carnicero','Robot o monstruo? No lo sabemos, pero no dudará en atacar al animal que se le cruce por delante, mucho menos a una gallina.','Enemigo','frontend/assets/img/full_minionCarnicero.png','thumbnail_minioncarnicero.png'),
(17,'Gallos de pelea','Los jóvenes gallos están tan cegados por sobrevivir que ya no les importa matarse entre sí. Han tenido una vida muy difícil, a veces sueñan con vivir en un hermoso campo lleno de flores... Sueños lejanos...','Enemigo','full_gallospelea.png','thumbnail_gallospelea.png'),
(18,'Dui','Un viejo perro que no permite que los animales de la granja de Maggie escapen, tiene problemas con Helen y Daisy, debido a que siempre están intentando huir y romper cosas. Es un perro cansado, una vida de perros.','Enemigo','full_dui.png','thumbnail_dui.png');


ALTER TABLE `Items`;
INSERT INTO Items (id_item, nombre, descripcion, tipo, src_imgItem, src_thumbnail)
VALUES
(1,'Maíz','Recurso utilizado por los animales para comercio interespecie.','economia','item_maiz.png','thumbnail_maiz.png'),
(2,'Gusano saludable','Un rosado y delicioso gusano con propiedades curativas. Recupera +1 HP para Helen.','hp','item_gusanosaludable.png','thumbnail_gusanosaludable.png'),
(3,'Gusano escurridizo','Un escurridizo y picante gusano que aumenta la velocidad de Helen por 4 segundos.','efecto','item_gusanoescurridizo.png','thumbnail_gusanoescurridizo.png'),
(4,'Gusano musculoso','Un gigante y musculoso gusano que aumenta la fuerza de Helen por 4 segundos.','efecto','item_gusanomusculoso.png','thumbnail_gusanomusculoso.png'),
(5,'Gusano legendario','Un reluciente y poderoso gusano con propiedades curativas y además potenciadoras. Añade un corazón adicional a la vida de Helen y recupera toda su salud.','hp','item_gusanolegendario.png','thumbnail_gusanolegendario.png'),
(6,'Pañoleta','Una linda pañoleta que Helen encontró en el gallinero, al parecer era de Maggie.','accesorio','item_panoleta.png','thumbnail_panoleta.png'),
(7,'Lentes de sol','Al derrotar a Bossy podrás robarle uno de sus lentes de sol, y así tener un gran estilo.','accesorio','item_lentessol.png','thumbnail_lentessol.png'),
(8,'Sombrero de bruja','Sombrero temático para las épocas de Halloween.','accesorio','item_halloween.png','thumbnail_halloween.png'),
(9,'Sombrero navideño','Sombrero temático para las épocas de Navidad.','accesorio','item_navidad.png','thumbnail_navidad.png'),
(10,'Boina de ilustradora','Una boina robada de una ilustradora que luchaba contra robots, es bastante cómoda e inspira creatividad.','accesorio','item_comunidad.png','thumbnail_comunidad.png'),
(11,'Sombrero de paja','Al derrotar a la granjera Maggie podrás robarle su sombrero, es bueno para protegerse del sol.','accesorio','item_sombreropaja.png','thumbnail_sombreropaja.png'),
(12,'Sombrero de arroz','Charlie te regalará su sombrero al salvarle la vida de la fábrica Happy Animals, como su mayor muestra de agradecimiento.','accesorio','item_sombreroarroz.png','thumbnail_sombreroarroz.png'),
(13,'Cofia','Al derrotar al Carnicero podrás quitarle su cofia de carnicería. Huele a muerte.','accesorio','item_cofia.png','thumbnail_cofia.png'),
(14,'Gorra de camionero','Al derrotar a Trucker, podrás robarle su gorra. Huele a aceite de motor y cigarros.','accesorio','item_gorracamionero.png','thumbnail_gorracamionero.png'),
(15,'Rana Radio portátil','Una vez hayas completado por primera vez el juego, Rana Radio te pedirá acompañarte para conocer el mundo. Irá pegada en la cabeza de Helen.','accesorio','item_ranaradioportatil.png','thumbnail_ranaradioportatil.png'),
(16,'Espuelas oxidadas','Unas viejas y oxidadas espuelas encontradas en la basura por Charlie, se las ha vendido a Helen por 15 granos de maíz. El riesgo de contraer tétanos para el enemigo no es muy alto, pero nunca nulo.','arma','item_espuelaoxidada.png','thumbnail_espuelaoxidada.png'),
(17,'Espuelas ornamentales','Unas elegantes y doradas espuelas encontradas en la parada de camiones por Charlie, se las ha vendido a Helen por 35 granos de maíz. El brillo que desprenden puede cegar a sus enemigos.','arma','item_espuelaornamental.png','thumbnail_espuelaornamental.png'),
(18,'Espuelas de cobre','Unas pulidas y endebles espuelas encontradas en la basura por Charlie, se las ha vendido a Helen por 20 granos de maíz. No tiene muchas utilidades, pero daña más a los enemigos que las espuelas oxidadas.','arma','item_espuelacobre.png','thumbnail_espuelacobre.png'),
(19,'Espuelas de acero','Unas resistentes y fuertes espuelas de acero inoxidable que Gladiolo le ha regalado a Helen antes de entrar al matadero. Son tan filosas que pueden cortar metal.','arma','item_espuelaacero.png','thumbnail_espuelaacero.png'),
(20,'Mazorca','Una gran mazorca con una considerable cantidad de maíz. ¡Con una de estas te harás rico!','economia','item_mazorca.png','thumbnail_mazorca.png');

-- Se insertan datos de las entidades con los id de los escenarios, personajes e items en la tabla -- 
ALTER TABLE `Entidad`;
INSERT INTO Entidad (id, id_escenario, id_personaje, id_item)
VALUES
(1,1,1,1),
(2,2,2,2),
(3,3,3,3),
(4,4,4,4),
(5,5,5,5),
(6,6,6,6),
(7,7,7,7),
(8,8,8,8),
(9,9,9,9),
(10,10,10,10),
(11,null,11,11),
(12,null,12,12),
(13,null,13,13),
(14,null,14,14),
(15,null,15,15),
(16,null,16,16),
(17,null,17,17),
(18,null,18,18),
(19,null,null,19),
(20,null,null,20);
