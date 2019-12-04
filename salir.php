<?php 
	session_start(); 
	$usu_autogestion = $_SESSION['user'];
	$estudiante = $_SESSION['estudiante'];
	if($estudiante != ''){
		header('Location: index2.php'); 
		session_destroy(); 
	} elseif($usu_autogestion != '') {
		header('Location: index2.php');
		array_map('unlink', glob("reportes/dist/img/individual/*.png"));
		array_map('unlink', glob("reportes/dist/img/curso/*.png"));
		session_destroy();  
	} else {
		header('Location: index2.php');
		array_map('unlink', glob("reportes/dist/img/individual/*.png"));
		array_map('unlink', glob("reportes/dist/img/curso/*.png"));
		session_destroy(); 
	}

	
	

