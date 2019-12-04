<?php

//librerias 
require_once "../conf/conexion_db.php";
require_once "../conf/funciones_db.php";

$token_estu = filter_input(INPUT_POST, 'txt_contrasena', FILTER_SANITIZE_STRING);
$pais = filter_input(INPUT_POST, 'sel_country', FILTER_SANITIZE_STRING);
$con = connectDB_demos();

//consultamos si se ya a realizado la encuesta
$query = $con->query("SELECT * FROM ce_encuesta_resultado WHERE ce_participantes_token_fk = '$token_estu'");
$resultado = $query->rowCount();
// si no la a realizado 0
if ($resultado == 0) {
    $query = $con->query("SELECT ce_participanes_token,ce_fk_nivel FROM
    ce_participantes
     WHERE ce_participanes_token = '$token_estu';");
    $con = NULL;
    $row = $query->fetch(PDO::FETCH_ASSOC);
    $resultado = $row["ce_participanes_token"];
    $resultado_nivel = $row["ce_fk_nivel"];
    //si lo que trae es null
    if ($resultado == NULL) {
        $datos = array('Estado' => '0');
        header('Content-Type: application/json');
        echo json_encode($datos, JSON_FORCE_OBJECT);
    }
    
    else if($resultado != " "){
        session_start();
        $_SESSION["pais"] = $pais;
        $_SESSION["estudiante"] = $resultado;
        $_SESSION["nivel_estudiante"] =  $resultado_nivel;
        $datos = array('Estado' => '1');
        header('Content-Type: application/json');
        echo json_encode($datos, JSON_FORCE_OBJECT);
    }
} 
else if ($resultado == 1) {
    $datos = array('Estado' => '2');
    header('Content-Type: application/json');
    echo json_encode($datos, JSON_FORCE_OBJECT);
} 

else if ($resultado >= 1) {
    $datos = array('Estado' => '3');
    header('Content-Type: application/json');
    echo json_encode($datos, JSON_FORCE_OBJECT);
}
?>