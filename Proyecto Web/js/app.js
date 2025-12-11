document.addEventListener("DOMContentLoaded", () => {

    // BOTÓN DE MENÚ (ya no oculta nada)
    const menuBtn = document.querySelector("#menuBtn");
    if (menuBtn) {
        menuBtn.addEventListener("click", () => {
            console.log("El menú es fijo y no se oculta.");
        });
    }

    // LOGIN
    const loginForm = document.querySelector("#loginForm");
    if (loginForm) {
        loginForm.addEventListener("submit", (e) => {
            e.preventDefault();
            window.location.href = "dashboard.html";
        });
    }

    // CREAR CUENTA
    const createAccountForm = document.querySelector("#createAccountForm");
    if (createAccountForm) {
        createAccountForm.addEventListener("submit", (e) => {
            e.preventDefault();
            alert("Cuenta creada correctamente");
            window.location.href = "login.html";
        });
    }
});
