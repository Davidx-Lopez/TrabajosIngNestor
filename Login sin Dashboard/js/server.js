const express = require("express");
const nodemailer = require("nodemailer");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// CAMBIA ESTO por tu Gmail
const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: "tucorreo@gmail.com",
        pass: "tu_clave_de_aplicacion"
    }
});

// Solicitud de recuperación
app.post("/forgot-password", async (req, res) => {
    const { email } = req.body;

    const recoveryLink = `http://localhost:3000/reset-password/${email}`;

    await transporter.sendMail({
        from: "Sistema Ganadero",
        to: email,
        subject: "Recuperación de contraseña",
        html: `
            <h2>Recuperación de contraseña</h2>
            <p>Haz clic en el siguiente enlace para crear una nueva contraseña:</p>
            <a href="${recoveryLink}">Restablecer contraseña</a>
        `
    });

    res.json({ message: "Se ha enviado un enlace a tu correo." });
});

// Página para cambiar la contraseña
app.post("/reset-password", (req, res) => {
    const { email, password } = req.body;

    console.log(`Nueva contraseña de ${email}: ${password}`);

    res.json({ message: "Contraseña actualizada correctamente" });
});

app.listen(3000, () => console.log("Servidor corriendo en http://localhost:3000"));
