<?php

define('DB_SERVER', 'localhost');
define('DB_USER', 'carlos');
define('DB_PASS', 'secret');
define('DB_NAME', 'compromiso_escolar');
define('DB_PORT', '3306');

function connectDB() {
    return Conexion();
}

function connectDB_demos() {
    return Conexion();
}

function Conexion() {
    $lista = array(
        '127.0.0.1',
        '::1'
    );

    try {
        if(in_array($_SERVER['REMOTE_ADDR'], $lista)){
            $conn = new PDO(

                "mysql:host=localhost; dbname=compromiso_escolar;charset=UTF8", 
                "root",//"carlos", //root
                "1234"//"secret"
            );      
            $conn->setAttribute(
                PDO :: ATTR_ERRMODE, 
                PDO :: ERRMODE_EXCEPTION
            );
            return $conn;
        } else {
            $conn = new PDO(
                "mysql:host=167.71.191.60; dbname=compromiso_escolar;charset=UTF8",
                "root",
                "92mbx6#p^wq@hac^"
            ); 
            $conn->setAttribute(
                PDO :: ATTR_ERRMODE, 
                PDO :: ERRMODE_EXCEPTION
            );
            return $conn;
        }
    } catch (Exception $e) {
        exit ("Excepción capturada: ".$e->getMessage());
    }
}