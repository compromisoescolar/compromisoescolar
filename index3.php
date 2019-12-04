<?php 
    require 'conf/conexion_db.php';
    require 'conf/funciones.php';
    require 'conf/funciones_db.php';

?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Compromiso Escolar</title>
        <?php include "assets/css/css.php"; ?>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="assets/css/estilo_inicio.css">
        <script src="assets/js/jquery-1.10.2.js"></script>
        </head>
        <?php
        echo select_token_pdf_copia(67,284,151);
        
        ?>
    </body>
</html>