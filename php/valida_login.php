<?php
session_start();
include_once '../conf/funciones_db.php';
include_once '../conf/conexion_db.php';

$usuario =  $_POST["usuario"]; 
$contrasena = $_POST["contrasena"]; 
$tipo_usuario = $_POST["tipo_usuario"];

$privilegios = $_POST["privilegios"];


$resultado = select_user($usuario ,$contrasena,$tipo_usuario);

if( $resultado["usuario"] == $usuario && $resultado["contrasena"] == $contrasena && $resultado["tipo"] == $tipo_usuario){
         
    $_SESSION['user'] = $usuario; 
    
    $_SESSION['tipo_usuario']= $tipo_usuario;

    $_SESSION["tipo_nombre"] = $resultado["rol"];  

    $_SESSION["identificador_estable"] = $resultado["id_estable"];

    $_SESSION['privilegios']= $privilegios;

    echo 1;
}
else {
    echo 0;
}

