console.log("app.js cargado correctamente");

// ===============================
// REGISTRAR ANIMALES
// ===============================
const formAnimal = document.getElementById("formAnimal");
const tablaAnimales = document.getElementById("tablaAnimales");

if (formAnimal) {
    formAnimal.addEventListener("submit", (e) => {
        e.preventDefault();

        const raza = document.getElementById("raza").value;
        const sexo = document.getElementById("sexo").value;
        const fecha = document.getElementById("fecha").value;
        const peso = document.getElementById("peso").value;
        const estado = document.getElementById("estado").value;
        const rfid = document.getElementById("rfid").value;

        let fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${raza}</td>
            <td>${sexo}</td>
            <td>${fecha}</td>
            <td>${peso}</td>
            <td>${estado}</td>
            <td>${rfid}</td>
        `;

        tablaAnimales.appendChild(fila);
        formAnimal.reset();
    });
}



// ===============================
// REGISTRAR ALIMENTACIÓN
// ===============================
const formAlimentacion = document.getElementById("formAlimentacion");
const tablaAlimentacion = document.getElementById("tablaAlimentacion");

if (formAlimentacion) {
    formAlimentacion.addEventListener("submit", (e) => {
        e.preventDefault();

        const alimento = document.getElementById("alimento").value;
        const cantidad = document.getElementById("cantidad").value;
        const fechaAli = document.getElementById("fechaAli").value;

        let fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${alimento}</td>
            <td>${cantidad}</td>
            <td>${fechaAli}</td>
        `;

        tablaAlimentacion.appendChild(fila);
        formAlimentacion.reset();
    });
}



// ===============================
// REGISTRAR VACUNACIONES
// ===============================
const formVacunas = document.getElementById("formVacunas");
const tablaVacunas = document.getElementById("tablaVacunas");

if (formVacunas) {
    formVacunas.addEventListener("submit", (e) => {
        e.preventDefault();

        const vacuna = document.getElementById("vacuna").value;
        const fechaVac = document.getElementById("fechaVac").value;
        const proxima = document.getElementById("proxima").value;

        let fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${vacuna}</td>
            <td>${fechaVac}</td>
            <td>${proxima}</td>
        `;

        tablaVacunas.appendChild(fila);
        formVacunas.reset();
    });
}



// ===============================
// REGISTRAR PRODUCCIÓN
// ===============================
const formProduccion = document.getElementById("formProduccion");
const tablaProduccion = document.getElementById("tablaProduccion");

if (formProduccion) {
    formProduccion.addEventListener("submit", (e) => {
        e.preventDefault();

        const tipoProd = document.getElementById("tipoProd").value;
        const cantidadProd = document.getElementById("cantidadProd").value;
        const fechaProd = document.getElementById("fechaProd").value;

        let fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${tipoProd}</td>
            <td>${cantidadProd}</td>
            <td>${fechaProd}</td>
        `;

        tablaProduccion.appendChild(fila);
        formProduccion.reset();
    });
}



// ===============================
// REGISTRAR INVENTARIO
// ===============================
const formInventario = document.getElementById("formInventario");
const tablaInventario = document.getElementById("tablaInventario");

if (formInventario) {
    formInventario.addEventListener("submit", (e) => {
        e.preventDefault();

        const item = document.getElementById("item").value;
        const cantidadInv = document.getElementById("cantidadInv").value;
        const tipoInv = document.getElementById("tipoInv").value;

        let fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${item}</td>
            <td>${cantidadInv}</td>
            <td>${tipoInv}</td>
        `;

        tablaInventario.appendChild(fila);
        formInventario.reset();
    });
}



// ===============================
// REGISTRAR VENTAS
// ===============================
const formVentas = document.getElementById("formVentas");
const tablaVentas = document.getElementById("tablaVentas");

if (formVentas) {
    formVentas.addEventListener("submit", (e) => {
        e.preventDefault();

        const cliente = document.getElementById("cliente").value;
        const cantidadVen = document.getElementById("cantidadVen").value;
        const precio = document.getElementById("precio").value;
        const fechaVen = document.getElementById("fechaVen").value;

        let total = cantidadVen * precio;

        let fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${cliente}</td>
            <td>${cantidadVen}</td>
            <td>${precio}</td>
            <td>${total}</td>
            <td>${fechaVen}</td>
        `;

        tablaVentas.appendChild(fila);
        formVentas.reset();
    });
}



// ===============================
// REGISTRAR REPRODUCCIÓN
// ===============================
const formReproduccion = document.getElementById("formReproduccion");
const tablaReproduccion = document.getElementById("tablaReproduccion");

if (formReproduccion) {
    formReproduccion.addEventListener("submit", (e) => {
        e.preventDefault();

        const evento = document.getElementById("evento").value;
        const fechaRep = document.getElementById("fechaRep").value;
        const resultado = document.getElementById("resultado").value;

        let fila = document.createElement("tr");
        fila.innerHTML = `
            <td>${evento}</td>
            <td>${fechaRep}</td>
            <td>${resultado}</td>
        `;

        tablaReproduccion.appendChild(fila);
        formReproduccion.reset();
    });
}

