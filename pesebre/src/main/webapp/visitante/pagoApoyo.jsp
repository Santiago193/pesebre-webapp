<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, javax.servlet.http.*, com.pesebre.datos.*" session="true"%>

<%
response.setCharacterEncoding("UTF-8");

// Obtener carrito
List<Map<String,Object>> carrito = (List<Map<String,Object>>) session.getAttribute("carrito_apoyo");
if (carrito == null) carrito = new ArrayList<>();

double total = 0;
for (Map<String,Object> ap : carrito)
    total += (Double) ap.get("monto");

// Acción
String accion = request.getParameter("accion");
String mensaje = "";

// ================================================
//  PROCESAR PAGO  → GUARDAR EN tb_apoyos
// ================================================
if ("procesar".equals(accion)) {

    // Ya NO validamos usuario — siempre se permite pagar
    Conexion cn = new Conexion();

    for (Map<String,Object> ap : carrito) {

        int idGal = (Integer) ap.get("id_galeria");
        double monto = (Double) ap.get("monto");

        String sql =
            "INSERT INTO tb_apoyos(id_galeria, monto) " +
            "VALUES (" + idGal + ", " + monto + ")";

        cn.Ejecutar(sql);
    }

    carrito.clear();
    session.setAttribute("carrito_apoyo", carrito);

    mensaje = "Pago realizado con éxito. ¡Gracias por apoyar los pesebres UPS! 🎄";
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Pago de Apoyo</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css2/pagoApoyo.css">

</head>

<body class="bg-dark text-white">

<div class="container d-flex justify-content-center mt-5">
    <div class="card-pago">

        <!-- TOTAL -->
        <div class="bloque-dark mb-4">
            <span class="badge bg-primary">Tu apoyo</span>
            <h2 class="mt-2">Total: $<%= String.format("%.2f", total) %></h2>
        </div>

        <% if (!mensaje.isEmpty()) { %>

        <!-- MENSAJE DE ÉXITO -->
        <div class="alert alert-success text-center"><%= mensaje %></div>
        <a href="apoya.jsp" class="btn btn-primary w-100">Volver</a>

        <% } else { %>

        <!-- MÉTODOS -->
        <div class="metodos">
            <div class="method-item">VISA</div>
            <div class="method-item">Mastercard</div>
            <div class="method-item">Diners</div>
            <div class="method-item">Discover</div>
            <div class="method-item">PayPhone</div>
        </div>

        <!-- TARJETA REAL -->
        <div class="tarjeta-real" id="card">
            <div class="tarjeta-chip"></div>

            <div class="tarjeta-num" id="t-numero">#### #### #### ####</div>

            <div class="tarjeta-info">
                <span id="t-nombre">NOMBRE APELLIDO</span>
                <span><span id="t-mes">MM</span>/<span id="t-anio">AA</span></span>
            </div>

            <span id="t-logo-text" style="position:absolute; bottom:15px; right:20px; font-size:1.1rem; font-weight:bold;"></span>
        </div>

        <h4 class="text-center mt-3 mb-3">Datos del pago</h4>

        <form method="post">
            <input type="hidden" name="accion" value="procesar">

            <div class="mb-3">
                <label class="form-label">Nombre del titular</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Número de tarjeta</label>
                <input type="text" name="tarjeta" maxlength="19" class="form-control"
                       placeholder="#### #### #### ####" required>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <label class="form-label">MM</label>
                    <input type="number" name="mes" min="1" max="12" class="form-control" required>
                </div>
                <div class="col">
                    <label class="form-label">AA</label>
                    <input type="number" name="anio" max="99" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">CVV</label>
                <input type="number" name="cvv" maxlength="3" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Realizar Pago</button>
        </form>

        <% } %>

    </div>
</div>

<!-- ========================================= -->
<!--  SCRIPT DE TARJETA COMPLETO Y VALIDACIONES -->
<!-- ========================================= -->
<script>
// NOMBRE
document.querySelector("input[name='nombre']").addEventListener("input", e => {
    document.getElementById("t-nombre").textContent =
        e.target.value.trim() === "" ? "NOMBRE APELLIDO" : e.target.value.toUpperCase();
});

// TARJETA + DETECCIÓN
const numeroInput = document.querySelector("input[name='tarjeta']");
const logoText = document.getElementById("t-logo-text");

numeroInput.addEventListener("input", e => {
    let val = e.target.value.replace(/\D/g, "");
    val = val.replace(/(.{4})/g, "$1 ").trim();
    e.target.value = val;

    document.getElementById("t-numero").textContent = val || "#### #### #### ####";

    detectarTarjeta(val.replace(/\s/g,""));
});

function detectarTarjeta(num){
    logoText.textContent = "Desconocida";

    if (num.startsWith("4")) logoText.textContent = "VISA";
    else if (/^5[1-5]/.test(num)) logoText.textContent = "MASTERCARD";
    else if (num.startsWith("36") || num.startsWith("38")) logoText.textContent = "Diners";
    else if (num.startsWith("60")) logoText.textContent = "Discover";
    else if (/^(23|24|25)/.test(num)) logoText.textContent = "PayPhone";
}

// MES
document.querySelector("input[name='mes']").addEventListener("input", e => {
    let v = e.target.value;
    if (v.length > 2) v = v.slice(0,2);
    document.getElementById("t-mes").textContent = v.padStart(2,"0");
});

// AÑO
const anioInput = document.querySelector("input[name='anio']");
anioInput.addEventListener("input", e => {
    let v = e.target.value.replace(/\D/g,"");
    if (v.length > 2) v = v.slice(0,2);
    e.target.value = v;

    document.getElementById("t-anio").textContent = v || "AA";

    if (v.length < 2) {
        anioInput.setCustomValidity("Debe ingresar 2 dígitos.");
        return;
    }

    const now = new Date().getFullYear();
    const yearUser = parseInt("20" + v);

    if (yearUser < now)
        anioInput.setCustomValidity("La tarjeta está expirada.");
    else
        anioInput.setCustomValidity("");
});

// CVV
document.querySelector("input[name='cvv']").addEventListener("input", e => {
    let v = e.target.value.replace(/\D/g,"");
    if (v.length > 3) v = v.slice(0,3);
    e.target.value = v;
});

// EFECTO 3D
const card = document.getElementById("card");
card.addEventListener("mousemove", e => {
    const rect = card.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;
    card.style.transform = `rotateX(${-(y - rect.height/2)/15}deg) rotateY(${(x - rect.width/2)/15}deg)`;
});
card.addEventListener("mouseleave", () => {
    card.style.transform = "rotateX(0deg) rotateY(0deg)";
});
</script>

</body>
</html>
