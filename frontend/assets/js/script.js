document.addEventListener("DOMContentLoaded", async () => {
  const contenedor = document.getElementById("contenedorCartas");
  const detalleImg = document.getElementById("detalleImg");
  const detalleNombre = document.getElementById("detalleNombre");
  const detalleDesc = document.getElementById("detalleDesc");

  // --- Normaliza la ruta base ---
  const normalizarRuta = (ruta) => {
    if (!ruta) return "assets/img/placeholder.png";

    let limpia = ruta.replace(/frontendassetsimg/gi, "assets/img/");

    if (!/^(assets\/img\/|\/assets\/img\/)/i.test(limpia)) {
      const nombre = limpia.split("/").pop();
      limpia = "assets/img/" + nombre;
    }
    limpia = limpia.replace(/\/{2,}/g, "/");
    return limpia;
  };

  // --- Busca el thumbnail correcto ---
  const elegirThumbnail = async (imgCompleta) => {
    const carpeta = imgCompleta.split("/").slice(0, -1).join("/") || "assets/img";
    const archivo = imgCompleta.split("/").pop();

    const candidatos = [];

    if (archivo.startsWith("full_")) {
      candidatos.push(`${carpeta}/thumbnail_${archivo.substring(5)}`);
      candidatos.push(`${carpeta}/thumbnail_${archivo}`);
    }
    candidatos.push(`${carpeta}/thumbnail_${archivo}`);
    candidatos.push(`${carpeta}/thumbnail_${archivo.toLowerCase()}`);
    const archivoLowerNoCaps = archivo.replace(/([A-Z])/g, (m) => m.toLowerCase());
    candidatos.push(`${carpeta}/thumbnail_${archivoLowerNoCaps}`);

    if (/gallos/i.test(archivo)) {
      const alt = archivo.toLowerCase().replace("gallospelea", "gallosdepelea");
      candidatos.push(`${carpeta}/thumbnail_${alt}`);
    }

    candidatos.push(imgCompleta);

    for (const ruta of candidatos) {
      try {
        const resp = await fetch(ruta, { method: "HEAD" });
        if (resp.ok) return ruta;
      } catch (e) {}
    }
    return "assets/img/placeholder.png";
  };

  // --- Carga los datos desde el backend ---
  async function cargarDatos(tipo = "") {
    try {
      const url = tipo ? `/api/entidades?tipo=${encodeURIComponent(tipo)}` : "/api/entidades";
      const res = await fetch(url);
      const data = await res.json();

      contenedor.innerHTML = "";

      if (!data || data.length === 0) {
        contenedor.innerHTML = `<p class="text-center text-light">No se encontraron resultados.</p>`;
        return;
      }

      for (const ent of data) {
        const nombre = ent.nombre || "Sin nombre";
        const desc = ent.descripcion || "Sin descripción";
        const tipoEntidad = ent.fuente || "desconocido";
        const subtipo = ent.subtipo || "";

        const rawImg = ent.src || "assets/img/placeholder.png";
        const imgCompletaBase = normalizarRuta(rawImg);
        const imgCompleta = `${imgCompletaBase}?v=${Date.now()}`; // ← fuerza recarga de la full

        const imgThumbnailBase = await elegirThumbnail(imgCompletaBase);
        const imgThumbnail = `${imgThumbnailBase}?v=${Date.now()}`; // ← fuerza recarga del thumbnail

        const card = document.createElement("div");
        card.className = "col-12 col-sm-6 col-md-4 col-lg-3";

        card.innerHTML = `
          <div class="card h-100 bg-secondary text-dark text-center">
            <img src="${imgThumbnail}" class="card-img-top img-fluid" alt="${nombre}" 
                 onerror="this.src='assets/img/placeholder.png'">
            <div class="card-body">
              <h5 class="card-title" style="font-weight: bold;">${nombre}</h5>
              <button class="btn btn-sm btn-outline-light btn-detalle">Ver más</button>
            </div>
          </div>
        `;

        const btnDetalle = card.querySelector(".btn-detalle");
        btnDetalle.addEventListener("click", async () => {
          try {
            const r = await fetch(imgCompletaBase, { method: "HEAD" });
            detalleImg.src = r.ok ? imgCompleta : "assets/img/placeholder.png";
          } catch {
            detalleImg.src = "assets/img/placeholder.png";
          }
          detalleNombre.textContent = nombre;
          detalleDesc.textContent = desc;
        });

        contenedor.appendChild(card);
      }
    } catch (err) {
      console.error("Error al cargar datos:", err);
      contenedor.innerHTML = `<p class="text-danger text-center">No se pueden mostrar los datos.</p>`;
    }
  }

  // --- Carga inicial ---
  await cargarDatos();

  // --- Filtros ---
  document.querySelectorAll(".filtro").forEach(link => {
    link.addEventListener("click", async e => {
      e.preventDefault();
      const tipo = link.dataset.tipo || "";
      await cargarDatos(tipo);

      document.querySelectorAll(".nav-link, .dropdown-item").forEach(el => el.classList.remove("active"));
      link.classList.add("active");
    });
  });
});
