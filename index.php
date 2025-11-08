<?php

require_once 'persona.php';
session_start();

//Aca se inicializa la lista de personas en la sesion
if (!isset($_SESSION['personas'])) {
    $_SESSION['personas'] = ();
}

// Para registrar una nueva persona
if (isset($_POST['registrar'])) {
    $id = uniqid();
    $persona = new Persona(
        $id,
        $_POST['nombre'],
        $_POST['apellido'],
        $_POST['FechaNacimiento'],
        $_POST['email'],
        $_POST['telefono'],
        $_POST['genero']
    );
    $_SESSION['personas'][$id] = $persona;
}

// Para eliminar una persona
if (isset($_POST['eliminar'])) {
    $idEliminar = $_GET['idEliminar'];
    unset($_SESSION['personas'][$idEliminar]);
}

// Para ejecutar la accion
$resultado = '';
if (isset($_POST['accion']) && isset($_POST['persona_id'])) {
    $personaId = $_POST['persona_id'];
    $accion = $_POST['accion'];

    if (isset($_SESSION['personas'][$personaId])) {
        $persona = $_SESSION['personas'][$personaId];
        $resultado = $persona->realizarAccion($accion);
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión de Personas</title>
    <link rel="stylesheet" href="estilos.css">
</head>
<body>
    <div class="container">
    <h2>Sistema de Gestión de Personas</h2>
    <form method="post" class="formulario">
        <input type="text" name="nombre" placeholder="Nombre" required>
        <input type="text" name="apellido" placeholder="Apellido" required>
        <input type="date" name="FechaNacimiento" required>
        <input type="email" name="email" placeholder="Correo electronico" required> 
        <input type="text" name="telefono" placeholder="Teléfono" required>
        <select name="genero" required>
            <option value="" disabled selected>Género</option>
            <option value="masculino">Masculino</option>
            <option value="femenino">Femenino</option>
            <option value="otro">Otro</option>
        </select>
        <button type="submit" name="registrar">Registrar Persona</button>
    </form>
</div>

<?php
if (!empty($_SESION['personas'])) { ?>
    <div class="lista-personas">
        <h2>Personas Registradas</h2>
        <table>
            <tr>
                <th>Nombre</th>
                <th>Edad</th>
                <th>Genero</th>
                <th>Accion</th>
                <th>Eliminar</th>
            </tr>
            <?php foreach ($_SESSION['personas'] as $persona) { ?>
                <tr>
                    <td><?php htmlspecialchars($persona->getNombreCompleto()); ?></td>
                    <td><?php htmlspecialchars($persona->getEdad()); ?></td>
                    <td><?php htmlspecialchars($persona->getGenero()); ?></td>
                    <td>
                        <form method="post" class="accion-form">
                            <input type="hidden" name="persona_id" value="<?= $persona->getId(); ?>">
                            <select name="accion" required>
                                <option value="">Seleccionar</option>
                                <option value="comiendo">Comer</option>
                                <option value="caminando">Caminar</option>
                                <option value="hablando">Hablar</option>
                                <option value="durmiendo">Dormir</option>
                                <option value="estudiando">Estudiar</option>
                            </select>
                            <button type="submit">Ejecutar</button>
                        </form>
                </tr>
                <td><a class="eliminar" href="?eliminar=<?= $persona->getId(); ?>">Borrar</a></td>
            <?php } ?>
        </table>
    </div>
<?php } ?>

<?php if ($resultado) { ?>
    <div class="resultado">
        <h3>Resultado:</h3>
        <p><?= htmlspecialchars($resultado); ?></p>
    </div>
<?php } ?>
</div>
</body>
</html> 