const juego = document.getElementById("juego");
const player = document.getElementById("player");
const scoreDisplay = document.getElementById("score");
const fallosDisplay = document.getElementById("fallos");
const vidasDisplay = document.getElementById("vidas");
const gameoverScreen = document.getElementById("gameover");
const vidasHUD = document.getElementById("vidasHUD");

let score = 0;
let fallos = 0;
let vidas = 3;
let velocidad = 2;
let playerX = 410;
let jugando = true;

let teclaIzq = false;
let teclaDer = false;

// =========================
//  SONIDOS
// =========================
const audioCtx = new (window.AudioContext || window.webkitAudioContext)();

function sonarFrecuencia(freq, duration) {
    const osc = audioCtx.createOscillator();
    const gain = audioCtx.createGain();

    osc.frequency.value = freq;
    osc.type = "sine";
    gain.gain.value = 0.1;

    osc.connect(gain);
    gain.connect(audioCtx.destination);

    osc.start();
    osc.stop(audioCtx.currentTime + duration);
}

function sonidoAtrapado() { sonarFrecuencia(800, 0.1); }
function sonidoFallado() { sonarFrecuencia(200, 0.2); }
function sonidoGameOver() { sonarFrecuencia(100, 0.6); }

// =========================
//  VIDAS CON CORAZONES
// =========================
function dibujarVidas() {
    vidasHUD.innerHTML = "";
    for (let i = 0; i < vidas; i++) {
        const c = document.createElement("div");
        c.classList.add("corazon");
        vidasHUD.appendChild(c);
    }
}
dibujarVidas();

// =========================
//  MOVIMIENTO
// =========================
document.addEventListener("keydown", (e) => {
    if (e.key === "ArrowLeft") teclaIzq = true;
    if (e.key === "ArrowRight") teclaDer = true;
});

document.addEventListener("keyup", (e) => {
    if (e.key === "ArrowLeft") teclaIzq = false;
    if (e.key === "ArrowRight") teclaDer = false;
});

setInterval(() => {
    if (!jugando) return;

    if (teclaIzq && playerX > 0) playerX -= 6;
    if (teclaDer && playerX < 820) playerX += 6;

    player.style.left = playerX + "px";
}, 10);

// =========================
//  CREAR ESTRELLAS
// =========================
function crearEstrella() {
    if (!jugando) return;

    const estrella = document.createElement("div");
    estrella.classList.add("estrella");
    estrella.style.left = Math.floor(Math.random() * 840) + "px";
    juego.appendChild(estrella);

    let pos = -70;

    const caer = setInterval(() => {
        if (!jugando) {
            estrella.remove();
            clearInterval(caer);
            return;
        }

        pos += velocidad;
        estrella.style.top = pos + "px";

        const estrellaX = parseInt(estrella.style.left);

        // ATRAPADA
        if (pos > 350 && pos < 430 && Math.abs(estrellaX - playerX) < 60) {
            score++;
            scoreDisplay.innerHTML = score;
            sonidoAtrapado();
            estrella.remove();
            clearInterval(caer);

            if (score % 10 === 0 && velocidad < 15) velocidad += 1;
            return;
        }

        // FALLADA
        if (pos > 480) {
            fallos++;
            fallosDisplay.innerHTML = fallos;
            sonidoFallado();
            estrella.remove();
            clearInterval(caer);
            perderVida();
        }

    }, 20);
}

setInterval(crearEstrella, 1000);

// =========================
//  VIDAS
// =========================
function perderVida() {
    vidas--;
    vidasDisplay.innerHTML = vidas;
    dibujarVidas();

    if (vidas <= 0) finalizarJuego();
}

// =========================
//  GAME OVER
// =========================
function finalizarJuego() {
    jugando = false;
    gameoverScreen.style.display = "flex";
    sonidoGameOver();
}

// =========================
//  REINICIAR
// =========================
document.getElementById("btnReiniciar").onclick = () => {
    score = 0;
    fallos = 0;
    vidas = 3;
    velocidad = 2;
    jugando = true;

    scoreDisplay.innerHTML = score;
    fallosDisplay.innerHTML = fallos;
    vidasDisplay.innerHTML = vidas;

    dibujarVidas();

    gameoverScreen.style.display = "none";
};
