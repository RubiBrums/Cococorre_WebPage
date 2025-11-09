// backend/server.js
import express from "express";
import mysql from "mysql2";
import cors from "cors";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
app.use(cors());
app.use(express.json());

// Middleware para permitir imagenes con ?v=123 eliminando los parametros de consulta
app.use((req, res, next) => {
  if (req.url.includes("?")) {
    req.url = req.url.split("?")[0];
  }
  next();
});

//Servir correctamente los archivos estaticos del frontend 
app.use(express.static(path.join(__dirname, "../frontend")));

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "cococorre"
});

db.connect(err => {
  if (err) {
    console.error("Error al conectar a MySQL:", err);
    throw err;
  }
  console.log("Conectado a MySQL correctamente");
});

app.get("/api/entidades", (req, res) => {
  const filtro = (req.query.tipo || "").toLowerCase().trim();

  const query = `
    SELECT
      e.id AS id_entidad,
      p.id_personaje, p.nombre    AS personaje_nombre, p.tipo    AS personaje_tipo, p.descripcion AS personaje_descripcion, p.src_imgPersonaje,
      i.id_item,      i.nombre    AS item_nombre,      i.tipo    AS item_tipo,      i.descripcion AS item_descripcion,      i.src_imgItem,
      esc.id_escenario, esc.nombre AS escenario_nombre, esc.descripcion AS escenario_descripcion, esc.src_imgEscenario
    FROM entidad e
    LEFT JOIN personajes p ON e.id_personaje = p.id_personaje
    LEFT JOIN items i ON e.id_item = i.id_item
    LEFT JOIN escenarios esc ON e.id_escenario = esc.id_escenario
    ORDER BY e.id ASC
  `;

  db.query(query, (err, rows) => {
    if (err) {
      console.error("Error al ejecutar consulta:", err);
      res.status(500).json({ error: "Error al obtener entidades" });
      return;
    }

    const expanded = [];
    for (const r of rows) {
      if (r.id_personaje) {
        expanded.push({
          id_entidad: `${r.id_entidad}_p${r.id_personaje}`,
          fuente: "personaje",
          nombre: r.personaje_nombre,
          descripcion: r.personaje_descripcion,
          subtipo: r.personaje_tipo,
          src: r.src_imgPersonaje
        });
      }
      if (r.id_item) {
        expanded.push({
          id_entidad: `${r.id_entidad}_i${r.id_item}`,
          fuente: "item",
          nombre: r.item_nombre,
          descripcion: r.item_descripcion,
          subtipo: r.item_tipo,
          src: r.src_imgItem
        });
      }
      if (r.id_escenario) {
        expanded.push({
          id_entidad: `${r.id_entidad}_e${r.id_escenario}`,
          fuente: "escenario",
          nombre: r.escenario_nombre,
          descripcion: r.escenario_descripcion,
          subtipo: null,
          src: r.src_imgEscenario
        });
      }
    }

    if (!filtro) {
      res.json(expanded);
      return;
    }

    const filtroLower = filtro.toLowerCase();

    const resultadoFiltrado = expanded.filter(item => {
      if (filtroLower === "personaje" || filtroLower === "personajes") return item.fuente === "personaje";
      if (filtroLower === "item" || filtroLower === "items") return item.fuente === "item";
      if (filtroLower === "escenario" || filtroLower === "escenarios") return item.fuente === "escenario";

      if (["protagonista", "npc", "enemigo", "boss"].includes(filtroLower)) {
        return item.fuente === "personaje" && item.subtipo && item.subtipo.toLowerCase() === filtroLower;
      }

      if (["economia", "hp", "efecto", "efectos", "accesorio", "accesorios", "arma", "armas"].includes(filtroLower)) {
        return item.fuente === "item" && item.subtipo && item.subtipo.toLowerCase().startsWith(filtroLower.replace(/s$/, ""));
      }

      return false;
    });

    res.json(resultadoFiltrado);
  });
});

app.get(/.*/, (req, res) => {
  res.sendFile(path.join(__dirname, "../frontend/index.html"));
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Servidor corriendo en http://localhost:${PORT}`));
