<?php
class Persona {
    private $id;
    private $nombre;
    private $apellido;
    private $fechaNacimiento;
    private $edad;
    private $email;
    private $telefono;
    private $genero;

    public function __construct($id, $nombre, $apellido, $fechaNacimiento, $email, $telefono, $genero) {
        $this->id = $id;
        $this->nombre = $nombre;
        $this->apellido = $apellido;
        $this->fechaNacimiento = $fechaNacimiento;
        $this->email = $email;
        $this->telefono = $telefono;
        $this->genero = $genero;
        $this->calcularEdad();
    }

    private function calcularEdad() {
        $fechaNacimiento = new DateTime($this->fechaNacimiento);
        $hoy = new DateTime();
        $this->edad = $hoy->diff($fechaNacimiento)->y;
    }

    public function getId() { return $this->id;}
    public function getNombreCompleto() { return $this->nombre . ' ' . $this->apellido; }
    public function getEdad() { return $this->edad; }
    public function getGenero() { return $this->genero; }

    public function realizarAccion($accion) {
        return $this->getNombreCompleto() . " está " {$accion} ".";
    }
}
?>