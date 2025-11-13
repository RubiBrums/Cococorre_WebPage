document.addEventListener("DOMContentLoaded", async () => {
  const contenedor = document.getElementById("contenedorCartas");
  const detalleImg = document.getElementById("detalleImg");
  const detalleNombre = document.getElementById("detalleNombre");
  const detalleDesc = document.getElementById("detalleDesc");

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
        const nombre = ent.nombre || "Sin nombre.";
        const desc = ent.descripcion || "Sin descripción.";

        // Buscar nombres en la base de datos
        const imgThumbnail = `/assets/img/${ent.thumbnail || "placeholder.png"}`;
        const imgCompleta = `/assets/img/${ent.src || "placeholder.png"}`;

        const card = document.createElement("div");
        card.className = "col-12 col-sm-6 col-md-4 col-lg-3";

        card.innerHTML = `
          <div class="card h-100 text-center">
            <img src="${imgThumbnail}" class="card-img-top img-fluid" alt="${nombre}"
                onerror="this.src='/assets/img/placeholder.png'">
            <div class="card-body">
              <h5 class="card-title" style="font-weight: bold; color: black;">${nombre}</h5>
              <button class="btn btn-sm btn-dark btn-detalle">Ver más</button>
            </div>
          </div>
        `;

        const btnDetalle = card.querySelector(".btn-detalle");
        btnDetalle.addEventListener("click", async () => {
          try {
            const r = await fetch(imgCompleta, { method: "HEAD" });
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

  // Carga inicial
  await cargarDatos();

  // Filtros
  document.querySelectorAll(".filtro").forEach((link) => {
    link.addEventListener("click", async (e) => {
      e.preventDefault();
      const tipo = link.dataset.tipo || "";
      await cargarDatos(tipo);

      document.querySelectorAll(".nav-link, .dropdown-item").forEach((el) =>
        el.classList.remove("active")
      );
      link.classList.add("active");
    });
  });
});
