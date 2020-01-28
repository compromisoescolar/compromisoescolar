<?php

    require_once "dist/conf/require_conf.php";

    session_start();

    if (!isset($_SESSION['user'])) {
        header("location: login.php");
        exit();
    }

    $conn = connectDB_demos();

    $cursos_basica = array();
    $cursos_media = array();

    $usuario_stmt = $conn->prepare('SELECT * FROM ce_usuarios where nombre_usu = :username');
    $usuario_stmt->execute(array('username' => $_SESSION['user']));

    $usuario = $usuario_stmt->fetch();

    $role = $conn->query("SELECT ce_roles.* from ce_roles join ce_rol_user cru on ce_roles.id_rol = cru.id_roles_fk where cru.id_usuario_fk = {$usuario['id_usu']} AND id_rol = 2")->fetch();

    if (!$role) {
        header("location: index.php");
        exit();
    }

    $establecimiento_id = $usuario['fk_establecimiento'];

    $establecimiento_stmt = $conn->prepare("SELECT * FROM ce_establecimiento WHERE id_ce_establecimiento = :id");
    $establecimiento_stmt->execute(array('id' => $establecimiento_id));
    $establecimiento = $establecimiento_stmt->fetch();

    $cursos_stmt = $conn->prepare("SELECT ce_curso_nombre as nombre,
           COUNT(id_ce_participantes)                                as participantes,
           SUM(ce_p1 + ce_p2 + ce_p3 + ce_p4 + ce_p5 + ce_p6 + ce_p7 + ce_p8 + ce_p9 + ce_p10 +
               ce_p11 + ce_p12 + ce_p13 + ce_p14 + ce_p15 + ce_p16 + ce_p17 + ce_p18 + ce_p19 + ce_p20 +
               ce_p21 + ce_p22 + ce_p23 + ce_p24 + ce_p25 + ce_p26 + ce_p27 + ce_p28 + ce_p29) /
           COUNT(ce_participantes.id_ce_participantes)               AS CE,
           SUM(ce_p30 +
               ce_p31 +
               ce_p32 +
               ce_p33 +
               ce_p34 +
               ce_p35 +
               ce_p36 +
               ce_p37 +
               ce_p38 +
               ce_p39 +
               ce_p40 +
               ce_p41 +
               ce_p42 +
               ce_p43 +
               ce_p44 +
               ce_p45 +
               ce_p46 +
               ce_p47) / COUNT(ce_participantes.id_ce_participantes) AS FC,
           ce_participantes.ce_fk_nivel as nivel
    FROM ce_encuesta_resultado
           JOIN ce_participantes ON ce_participantes_token_fk = ce_participanes_token
           JOIN ce_curso ON ce_curso_id_ce_curso = id_ce_curso
    WHERE ce_estado_encuesta = 1
      AND ce_establecimiento_id_ce_establecimiento = :id    
    GROUP BY ce_curso.ce_curso_nombre");

    try {

        $cursos_stmt->execute(array('id' => $establecimiento_id));

        while ($cursos_result = $cursos_stmt->fetch()) {
            $curso = array(
                'name' => $cursos_result['nombre'],
                'x' => (float) $cursos_result['FC'],
                'y' => (float) $cursos_result['CE'],
                'participantes' => (int) $cursos_result['participantes']
            );

            if ($cursos_result['nivel'] == 1) {
                //$curso['color'] = 'rgb(206, 225, 255)';
                $curso['color'] = 'rgb(95, 55, 188)';
                array_push($cursos_basica, $curso);
            } else {
                if ($cursos_result['nivel'] == 2) {
                    $curso['color'] = 'rgb(95, 55, 188)';

                    array_push($cursos_media, $curso);
                }
            }
        }

        $totalParticipantesBasica = array_reduce($cursos_basica, function ($accum, $item) {
            return $accum + $item['participantes'];
        }, 0);

        $totalParticipantesMedia = array_reduce($cursos_media, function ($accum, $item) {
            return $accum + $item['participantes'];
        }, 0);

        if($totalParticipantesBasica == 0){
            $hidden_basica = "hidden";
        }else{
            $hidden_basica = "";
        }
        if($totalParticipantesMedia == 0){
            $hidden_media = "hidden";
        }else{
            $hidden_media = "";
        }
    } catch (Exception $e) {
       echo $e;
    }

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Reportes Compromiso Escolar</title>
    <!-- Tell the browser to be responsive to screen width -->
    <?php require "dist/css/css.php"; ?>
    <script src="../assets/js/jquery-1.10.2.js"></script>
    <script src="../assets/js/mresize.min.js"></script>
    
    <style type="text/css">

        .main-sidebar {
            background: #f4af1f;
        }

        .header {
            background: #f27611;
        }

        .sidebar {
            width: 220px;
            float: right;
        }

        .user-panel {
            background: #f27611;
        }

        .content-header {
            background: #f4af1f;
        }


        .panel {
            width:  100%;
            margin: 0;
            padding: 0;
        }

        .panel-body {
            width:  100%;
            padding: 15px;
            margin-top: 0;

        }

        .cursor_dimensiones{
            text-decoration: none;
        }

        div.label-alerta-media.hvr.hvr-grow {
            text-decoration: none;
        }

        .skin-blue .sidebar-menu .treeview-menu > li.active > a, .skin-blue .sidebar-menu .treeview-menu > li > a:hover {
            color: #ffffff;
            background-color: #f2761185;
        }

        .skin-blue .sidebar-menu > li > .treeview-menu {
            margin: 0 1px;
            background: #f27611;
        }

        .skin-blue .sidebar-menu > li > a {
            border-left-color: white;
        }

        .skin-blue .sidebar-menu .treeview-menu > li > a {
            color: #ffffff85;
        }

        .skin-blue .sidebar-menu > li:hover > a, .skin-blue .sidebar-menu > li.active > a, .skin-blue .sidebar-menu > li.menu-open > a {
            color: #ffffff;
            background: #f4af1f;
        }

        .skin-blue .sidebar-menu > li:hover > a, .skin-blue .sidebar-menu > li.active > a, .skin-blue .sidebar-menu > li.treeview > a {
            color: #ffffff;
            background: #f4af1f;
        }

        .tit-menu {
            float: left;
            text-align: left;
            color: white;
        }

        .skin-blue .wrapper, .skin-blue .main-sidebar, .skin-blue .left-side {
            background-color: #f4af1f;
        }

        .nav-pills > li.active > a, .nav-pills > li.active > a:hover, .nav-pills > li.active > a:focus {
            font-size: 18px;
            font-weight: 400;
            color: black;
            background-color: #e6e6e6;
            border-bottom-color: #e6e6e68c;
        }

        .nav-pills > li > a {
            font-size: 18px;
            border-radius: 0;
            border-top: 3px solid transparent;
            color: white;
            background-color: #cfd0d1;
        }

        /* pestañas superiores */
        .nav-pills > li.pest_li.active > a {
            font-size: 18px;
            border-radius: 0;
            border-top: 3px solid transparent;
            color: white;
            background-color: #cfd0d1; /* gris claro */
        }

        .nav-pills > li.pest_li > a {
            font-size: 18px;
            border-radius: 0;
            border-top: 0.5px solid white;
            border-left: 0.5px solid white;
            border-right: 0.5px solid white;
            color: white;
            background-color: #f4af1f; /* zapallo */
        }

        .nav-pills > li.pest_li:focus > a {
            background-color: #f4af1f7d; /* zapallo */
        }

        .id_recur_edu {
            margin-top: 175px;
            margin-left: 20px;
            padding-top: 1px;
            padding-left: 10px;
            width: 195px;
            height: 300px;
            background-image: url("../assets/img/recursos-educativos.png");
            background-repeat: no-repeat;
            background-size:100% auto;
            text-shadow: 0.5px 0.5px 0.5px black;
            color: white;
            border-radius: 10px;
        }

        .id_recur_edu:hover {
            cursor:pointer;
            cursor: hand;
            opacity: 0.9;
        }

        .id_recur_edu:active {
            cursor:pointer;
            cursor: hand;
            opacity: 0.7;
        }

        #img_btn_salir:hover {
            cursor:pointer;
            cursor: hand;
            opacity: 0.9;
        }

        #img_btn_salir:active {
            cursor:pointer;
            cursor: hand;
            opacity: 0.7;
        }

        .btn_cuadrado:hover { 
            cursor: pointer;
            opacity: 0.7;
        }

        .btn_cuadrado:active { 
            cursor: pointer;
            opacity: 0.4;
        }

        .btn_side:hover {
            cursor:pointer; 
            cursor: hand;
            opacity: 0.9;
        }

        .btn_side:active { 
            cursor:pointer; 
            cursor: hand;
            opacity: 0.7;
        }

        html {
            padding: 0;
            margin: 0;
        }

        body {
            padding: 0;
            margin: 0;
        }

        @media (max-width: 1299px) {
            .main-sidebar {
                -webkit-transform: translate(-230px, 0);
                -ms-transform: translate(-230px, 0);
                -o-transform: translate(-230px, 0);
                transform: translate(-230px, 0);
            }
        }

        @media (min-width: 1300px) {
            .sidebar-collapse .main-sidebar {
                -webkit-transform: translate(-230px, 0);
                -ms-transform: translate(-230px, 0);
                -o-transform: translate(-230px, 0);
                transform: translate(-230px, 0);
            }
        }

        @media (max-width: 1299px) {
            .sidebar-open .main-sidebar {
                -webkit-transform: translate(0, 0);
                -ms-transform: translate(0, 0);
                -o-transform: translate(0, 0);
                transform: translate(0, 0);
            }
        }

        @media (max-width: 1299px) {
            .main-sidebar {
                -webkit-transform: translate(-230px, 0);
                -ms-transform: translate(-230px, 0);
                -o-transform: translate(-230px, 0);
                transform: translate(-230px, 0);
                margin-left: 0;
            }
        }

        @media (max-width: 1300px) {
            .content-wrapper, .main-footer {
                margin-left: 0;
            }
        }
    </style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
    <div id="linea-superior" style="background: #40c2d4; padding-left: 100px; ">
        <table width="100%" height="100%" >
            <tr width="100%">
                <td align="left" width="50%">
                    <div style="display: flex; align-items: baseline; background: #40c2d4;">
                        <img style="height: 78px; width: 750px;"  src="../assets/img/C2_Resultados.png">
                        <div style="margin-top: 30px; margin-left: 195px; font-size: 20px; position: absolute; color: white;">
                            Módulo de Resultados
                        </div>
                    </div>
                </td>
                <td align="right" width="50%">
                    <table width="100%">
                        <tr width="100%">
                            <td align="right" width="50%">
                                <h3 style="color: white;"><?php echo $_SESSION["profesor_nombres"];?></h3>

                            </td>
                            <td align="right" width="50%">
                                <button id="btn_cerrar_session" style="text-decoration: none; background: transparent; width: 100%; height: 100%;  background-repeat: no-repeat; border-radius: 35px; border: none; cursor:pointer; overflow: hidden; outline:none; background-position: center;">
                                    <img id="img_btn_salir" style="width: 128px; height: 48px; " src="../assets/img/salir-2.png">
                                </button>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div class="contenido row justify-content-center align-items-center">
        <div class="card_c" style="padding-right: 200px; padding-left: 200px; padding-top: 10px; padding-bottom: 10px; background: #e6e6e6;">
            <div class="wrapper card_c" id="subir_head" style="border: 1.5px solid #A5A1A0; border-radius: 10px;">
                <aside class="main-sidebar">
                    <div style="position: absolute; top: 0px; left: 16px; color: white; padding-bottom: 0;">
                        <h4><?php echo $_SESSION["tipo_nombre"]; ?></h4>
                    </div>
                    <section class="sidebar">
                        <div class="user-panel">
                            <div class="pull-left image">
                                <br>
                            </div>
                            <div class="pull-left info" style="left: 0;">
                                <p>
                                    Menú De Navegación
                                </p>
                            </div>
                        </div>
                        <ul class="sidebar-menu" data-widget="tree">
                            <li class="active treeview" >
                                <a href="#" id="id_estab">
                                    <i class="fa fa-th"></i>
                                    <span>Establecimiento</span>
                                    <span class="pull-right-container">
                                        <i class="fa fa-angle-left pull-right"></i>
                                    </span>
                                </a>
                                <ul class="treeview-menu" >
                                    <li class="active" style="padding: 5px;">
                                        <a id='select_estudiante' href='#'>
                                            <i class='fa fa-pie-chart' aria-hidden='true'></i>
                                            Reportes
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </section>
                    <div align="left" class="id_recur_edu">

                    </div>
                </aside>
                <div class="content-wrapper">
                    <section class="content-header" style="background: #f4af1f; padding-bottom: 20px;">
                        <a style="width: 60px; height: 60px; border: 0; color: white; background: #f4af1f; padding: 0; padding-right: 10px; font-size: 30px;" class="openbtn btn_side">☰</a> 
                        <h1 class="text-center">
                            <?php echo $establecimiento['ce_establecimiento_nombre'] ?>
                        </h1>
                    </section>
                    <section class="content">
                        <div class="row">
                            <?php tarjeta_de_presentacion_establecimiento($establecimiento_id); ?>
                        </div>
                        <div class="row">
                            <div class="col-xs-12" hidden>
                                <div class="badge_compromiso_escolar" data-toggle="collapse" data-target="#demo">
                                    Bajo compromiso escolar (-) y Factores contextuales limitantes (-). <span> Ver descripción</span>
                                </div>
                                <div id="demo" class="collapse">
                                    <p class="text-justify">
                                        Estudiantes que presentan una débil participación e interés en las actividades académicas. En general, no consideran que el aprendizaje sea significativo para su presente y futuro, al tiempo que no se sienten parte de una comunidad escolar. No hay una disposición para invertir destrezas cognitivas dentro del aprendizaje y dominio de nuevas habilidades de gran complejidad. EI no tener un compromiso escolar desarrollado es un factor de riesgo de la deserción escolar, para graduarse con altos niveles de conductas de riesgo y un bajo rendimiento académico. El compromiso escolar es altamente permeable por factores contextuales. En este caso se aprecia que el débil compromiso escolar se vincula a un bajo involucramiento de la familia del estudiante en su proceso de aprendizaje junto con un clima escolar deteriorado (relación con profesores y pares) Io que termina desmotivando al estudiante. Un clima escolar deteriorado se puede observar en malas relaciones entre estudiante y profesores, entre los mismos estudiantes, y en un ambiente donde se han deteriorado los lazos de respeto y confianza.
                                    </p>
                                </div>
                            </div>

                            <div class="col-xs-12" style="margin-bottom: 10px;">
                                <button id="id_btn_pdf" style="margin-top:2.3%;" class="btn btn-primary pull-right" disabled>
                                    <span id="id_reporte_cargado" hidden>
                                        Descargar Reporte 
                                        <i class="fa fa-download" aria-hidden="true"></i>
                                    </span> 
                                    <span id="id_cargando_reporte">
                                        Cargando Reporte
                                        <i class="fa fa-spinner fa-spin fa-fw"></i>
                                    </span>
                                </button>

                            </div>
                            <div class="col-xs-12">
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <h4>Gráfico de Dispersión</h4>
                                    </div>
                                    <div class="panel-body">
                                        <div>
                                            <span>
                                                <p style="font-size: 20px; text-align: center">Reporte Establecimiento <i class="fa fa-question-circle" style="color:#2d6693; font-size: 20px" aria-hidden="true" onclick="definicion_cuadrantes()"></i></p>
                                            </span>
                                        </div>
                                        <div id="id_graficos_b">
                                            <div id="dispersion-establecimiento-basica" style="min-width: 310px; height: 500px; margin: 0 auto" <?php echo $hidden_basica; ?> >
                                            </div>
                                        </div>
                                        <div id="id_graficos_m">
                                            <div id="dispersion-establecimiento-media" style="min-width: 310px; height: 500px; margin: 0 auto" <?php echo $hidden_media; ?> >
                                            </div>
                                        </div>
                                        
                                        <div id="id_error" class="alert alert-danger text-center" hidden>
                                            No hay Estudiantes encuestados en el Establecimiento
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <footer class="page-footer pt-4" style="margin-bottom: 0px; background: white; padding-top: 40px; padding-bottom: 0px; bottom: 0; height: 200px;">
            <div class="container" style="margin-bottom: 20px;">
               <table cellpadding="10">
                    <tr>
                        <td align="left" valign="center">
                            <div style="display: flex; align-items: baseline;">
                                <img style="margin-right: 5px;" width="44" src="../assets/img/mineduc.png">
                                <img style="margin-right: 5px;" width="120" src="../assets/img/fondef.png">
                                <img style="margin-right: 5px;" width="110" src="../assets/img/corfo.png">
                                <img style="margin-right: 5px; padding-top: 5px;" width="60" src="../assets/img/ufro.png">
                                <img style="margin-right: 5px; padding-bottom: 4px;" width="100" src="../assets/img/autonoma.png">
                                <img style="margin-right: 5px; padding-bottom: 4px;" width="160" src="../assets/img/fund_telefonica.png">
                            </div>
                        </td>
                        <td width="33%" align="center" valign="center" >
                            <p style="font-size: small; text-align: justify; font: condensed 100% sans-serif; color: #212529;"> 
                                Estas encuestas forman parte del Proyecto FONDEF ID14I10078-ID14I20078 Medición del compromiso del niño, niña y adolescente con sus estudios para la promoción de trayectorias educativas exitosas.
                            </p>
                        </td>
                    </tr>
               </table>
            </div>
        </footer>
<div id="id_ingre_cod" class="modal fade">
            <div class="card" id="form-encuesta" style="">
                <div class="card-body">
                    <div class="modal-header"  style="text-align: center; line-height: 7px; border: 0; margin: 0; padding: 0;">
                        <h5 style="" class="modal-title">Formulario de acceso</h5>
                        <button id="btn_cerrar_modal" type="button" class="close" >&times;</button>
                    </div>
                    <div style="text-align: center; line-height: 7px;">
                        <hr style="background: #fc455c;">
                    </div>
                    <form id="form_admin">
                        <br>
                        <div style="text-align: center; margin-bottom: 4px;">
                            <i class="fa fa-user" style="color: #fc455c;" aria-hidden="true"></i> &nbsp; Administracion
                        </div>
                        <br>
                        <div class="form-group has-feedback">
                            <?php echo usuario_administrador(); ?>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="text" name="usuario" id="usuario" class="form-control" placeholder="usuario" required />
                            
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" id="contrasena" name="contrasena" class="form-control"  autocomplete="password" placeholder="contraseña" required />
                           
                        </div>
                        <button style="border-radius: 2px; background-color: #fc455c; font-family: ‘Source Sans Pro’, sans-serif; font-size: 12px; font-weight: 900; min-width:120px; height:30px; width: 100%; margin-top: 15px; border-radius: 5px; color: white; box-shadow: rgba(0, 0, 0, 0.22) 1px 1px 1px 1px; border: 1.5px solid #fc455c;" name="login-button" id="ingresar_admin" type="submit" class="icon-submit btn-limon-validar">
                            <span id="inicia_rep">
                                Ingresar
                            </span>
                            <div id="spinner"></div>
                        </button>  
                    </form>
                </div>
            </div>
        </div>
        
<?php require "dist/js/js.php"; ?>


<script>
    sesion();
    var url_base = window.location;
    var flag_menu = 1;
    var flag_boton = 1;
    var flag_sbar = 1;
    var fewSeconds = 5;
    var des_flag = false;

    function login_admin() {
                url_base_2 = url_base.protocol + "//" + url_base.host;
                dir = url_base_2 + "/php/valida_login.php";
                $('#ingresar_admin').on("click", function() {
                    const user = document.getElementById("usuario").value;
                    const pass = document.getElementById("contrasena").value;
                    if (user == "") {
                        alertify.notify("Debes ingresar el usuario");
                        document.getElementById("usuario").focus();
                        return false;
                    } else if (pass == "") {
                        alertify.notify("Debes ingresar la contraseña");
                        document.getElementById("contrasena").focus();
                        return false;
                    } else {
                        cadena = "usuario=" + $('#usuario').val() +
                            "&contrasena=" + $('#contrasena').val() +
                            "&tipo_usuario=" + $('#tipo_usuario').val() +
                            "&privilegios=" + "1";
                        $.ajax({
                            type: "POST",
                            url: dir,
                            data: cadena,
                            cache: false,
                            statusCode: {
                                404: function() {
                                    alertify.alert("Alerta", "Pagina no Encontrada");
                                    document.getElementById("ingresar_admin").disabled = false;
                                    document.getElementById("spinner").innerHTML = '';
                                    document.getElementById("inicia_rep").innerHTML = 'Ingresar';

                                },
                                502: function() {
                                    alertify.alert("alerta", "Ha ocurrido un error al conectarse con el servidor");
                                    document.getElementById("ingresar_admin").disabled = false;
                                    document.getElementById("spinner").innerHTML = '';
                                    document.getElementById("inicia_rep").innerHTML = 'Ingresar';
                                }
                            },
                            beforeSend: function() {
                                document.getElementById("ingresar_admin").disabled = true;
                                document.getElementById("inicia_rep").innerHTML = '';
                                document.getElementById("spinner").innerHTML = '</i> <i class="fa fa-spinner fa-2x fa-spin  fa-fw">';
                            },
                            success: function(r) {
                                if (r == 1) {
                                    window.location.replace(
                                        url_base.protocol + "//" + 
                                        url_base.host + "/" + 
                                        "modulos.php"
                                    );
                                } else {
                                    document.getElementById("ingresar_admin").disabled = false;
                                    document.getElementById("spinner").innerHTML = '';
                                    document.getElementById("inicia_rep").innerHTML = 'Ingresar';
                                    alertify.defaults.glossary.title = '<p class="text-center">Notificación<p>';
                                    alertify.alert('Usuario Incorrecto');
                                }
                            }
                        });
                    }
                });
            }

    const defaultOptions = {
        title: {
            text: 'Reporte Establecimiento Básica (<?php echo $totalParticipantesBasica?>)'
        },

        chart: {
            type: 'scatter'
        },
        subtitle: {
            text: ''
        }, credits: {
            enabled: false
        },

        xAxis: {
            title: {
                enabled: true,
                text: 'Factores Contextuales',
                align: 'low',
                style: {
                    fontSize: '14px'
                }
            },
            startOnTick: true,
            endOnTick: true,
            showLastLabel: true,
            plotLines: [{
                value: 45,
                color: 'red',
                width: 1,
                zIndex: 4,
                dashStyle: 'shortdash'
            }],
            min: 1,
            max: 95
        },

        yAxis: {
            title: {
                text: 'Compromiso Escolar',
                align: 'low',
                style: {
                    fontSize: '14px',
                    fontFamily: 'Arial'
                }
            },
            plotLines: [{
                value: 90,
                color: 'red',
                width: 1,
                zIndex: 4,
                dashStyle: 'shortdash'
            }],
            min: 29,
            max: 145
        },

        legend: {
            enabled: false,
        },

        plotOptions: {
            scatter: {
                marker: {
                    radius: 15,
                    states: {
                        hover: {
                            enabled: true,
                            lineColor: 'rgb(100,100,100)'
                        }
                    }
                },
                states: {
                    hover: {
                        marker: {
                            enabled: false
                        }
                    }
                },
                tooltip: {
                    headerFormat: '',
                    pointFormat: '<b>{point.name}</b> <br><div>{point.x} FC, {point.y} CE</div>'
                }
            }
        }
    }

    const labels = function (chart) {
        chart.renderer.label('Alto compromiso escolar y Factores contextuales', window.value - 200, 40)
            .attr({
                fill: 'rgb(206, 225, 255)',
                padding: 1,
                zIndex: 1
            })
            .css({
                color: 'black',
                width: '200px',
                border: '10px'
            })
            .add();
        chart.renderer.label('Alto compromiso escolar y bajos Factores contextuales', 70, 40)
            .attr({
                fill: 'rgb(206, 225, 255)',
                padding: 1,
                r: 1,
                zIndex: 1
            })
            .css({
                color: 'black',
                width: '200px'
            })
            .add();
        chart.renderer.label('Bajo compromiso escolar y bajos Factores contextuales', 70, 390)
            .attr({
                fill: 'rgb(206, 225, 255)',
                padding: 1,
                r: 1,
                zIndex: 1
            })
            .css({
                color: 'black',
                width: '200px'
            })
            .add();
        chart.renderer.label('Bajo compromiso escolar y Altos Factores contextuales', window.value - 200, 390)
            .attr({
                fill: 'rgb(206, 225, 255)',
                padding: 1,
                r: 1,
                zIndex: 1
            })
            .css({
                color: 'black',
                width: '200px'
            })
            .add();
    }

    function dispersionEstablecimientoBasicaInit() {
        window.value = document.getElementById('dispersion-establecimiento-basica').offsetWidth;
        const options = {
            ...defaultOptions,

            title: {
                text: null
            },

            series: [{
                data: <?php echo json_encode($cursos_basica) ?>
            }]
        }

        Highcharts.chart('dispersion-establecimiento-basica', options, labels);
    }

    function dispersionEstablecimientoMediaInit() {
        window.value = document.getElementById('dispersion-establecimiento-media').offsetWidth;
        const options = {
            ...defaultOptions,
            title: {
                text: 'Reporte Establecimiento Media (<?php echo $totalParticipantesMedia?>)'
            },

            series: [{
                data: <?php echo json_encode($cursos_media) ?>
            }]
        }

        Highcharts.chart('dispersion-establecimiento-media', options, labels);
    }

    document.addEventListener('DOMContentLoaded', () => {
        dispersionEstablecimientoBasicaInit()
        dispersionEstablecimientoMediaInit()
    })

    

    $("#id_graficos_p").ready(function () {
        var basica = parseInt("<?php echo $totalParticipantesBasica; ?>");
        var media  = parseInt("<?php echo $totalParticipantesMedia; ?>");

        if (basica == 0 && media == 0) {
            $("#id_error").removeAttr("hidden");
            $("#id_graficos_m").attr("hidden", true);
            $("#id_graficos_b").attr("hidden", true);
        } else if (basica == 0 && media != 0) {
            $("#id_error").attr("hidden", true);
            $("#id_graficos_m").removeAttr("hidden");
            $("#id_graficos_b").attr("hidden", true);

            $(window).resize(function() {
                dispersionEstablecimientoMediaInit();
            });

            $(".sidebar-open").on("mresize",function(){
                dispersionEstablecimientoMediaInit();
            });
        } else if (basica != 0 && media == 0) {
            $("#id_error").attr("hidden", true);
            $("#id_graficos_m").attr("hidden");
            $("#id_graficos_b").removeAttr("hidden", true);

            $(window).resize(function() {
                dispersionEstablecimientoBasicaInit();
            });

            $(".sidebar-open").on("mresize",function(){
                alert("dfs");
                dispersionEstablecimientoBasicaInit();
            });

            $(".btn_side").click(function () {
                dispersionEstablecimientoBasicaInit();
            });
        } else if (basica != 0 && media != 0) {
            $("#id_error").attr("hidden", true);
            $("#id_graficos_m").removeAttr("hidden", true);
            $("#id_graficos_b").removeAttr("hidden", true);

            $(window).resize(function() {
                dispersionEstablecimientoBasicaInit();
            });

           
            $(window).resize(function() {
                dispersionEstablecimientoMediaInit();
            });

        }
    });

   
    
    

    $(document).ready(function () {
        login_admin();
        $("body").css('padding', '0');
        /////////// cerrar modal ///////////////////////
        var modal = document.getElementById("id_ingre_cod");
        var span = document.getElementsByClassName("close")[0];

        $("#select_curso").click(function () {
            $("#estudiantes").hide();
            $("#curso_p").show();
        });

        $("#select_estudiante").click(function () {
            $("#estudiantes").show();
            $("#curso_p").hide();
        });

        $("#bt_manual").click(function () {
            window.open(
                url_base.protocol + "//" + 
                url_base.host + "/" + 
                "documentos/Manual_de_Usuario_Plataforma_Compromiso_Escolar_11-09-2019.pdf", 
                '_blank'
            );
        });

        $("#bt_admin").click(function() {
            $('#id_ingre_cod').modal('toggle');
           
        });

        $("#btn_cerrar_modal").click(function() {
            $('#id_ingre_cod').modal('toggle');
            
        });

        $(".btn_side").click(function () {
            flag_sbar *= -1;
            if (flag_sbar != 1) {
                console.log("holaaa");
                $(".main-sidebar").css({"-webkit-transform":"translate(-230px, 0)"});
                $(".main-sidebar").css({"-ms-transform":"translate(-230px, 0)"});
                $(".main-sidebar").css({"-o-transform":"translate(-230px, 0)"});
                $(".main-sidebar").css({"transform":"translate(-230px, 0)"});
                $(".content-wrapper, .main-footer").css("margin-left", "0");

            } else {
                $(".main-sidebar").css({"-webkit-transform":"translate(0, 0)"});
                $(".main-sidebar").css({"-ms-transform":"translate(0, 0)"});
                $(".main-sidebar").css({"-o-transform":"translate(0, 0)"});
                $(".main-sidebar").css({"transform":"translate(0, 0)"});
                $(".content-wrapper, .main-footer").css("margin-left", "230px");
            }
            setTimeout(function() {
                dispersionEstablecimientoBasicaInit();
                dispersionEstablecimientoMediaInit();
            }, 
            300
            );
            
        });

        $("#id_estab").click(function () {
            flag_menu *= -1;
            if (flag_menu != 1) {
                $(".skin-blue .sidebar-menu > li:hover > a, .skin-blue .sidebar-menu > li.active > a, .skin-blue .sidebar-menu > li.treeview > a").css("background", "#f27611");
            } else {
                $(".skin-blue .sidebar-menu > li:hover > a, .skin-blue .sidebar-menu > li.active > a, .skin-blue .sidebar-menu > li.treeview > a").css("background", "#f4af1f");
            }
        });

        $(".id_recur_edu").click(function () {
            window.location.replace(
                url_base.protocol + "//" +
                url_base.host + "/" +
                "recursos_edu.php"
            );
        });

        $("#img_btn_salir").click(function () {
            window.location.replace(
                url_base.protocol + "//" +
                url_base.host + "/" +
                "salir.php"
            );
        });
    });

    $("#dispersion-establecimiento-basica").ready(function () {
        flag_boton *= -1
        setTimeout(function() {
            $("#id_btn_pdf").removeAttr("disabled");
            $("#id_cargando_reporte").hide();
            $("#id_reporte_cargado").show();
        }, 
            5000
        );

        $("#id_btn_pdf").click(function () {
            window.open(
                url_base.protocol + "//" +
                url_base.host + "/" +
                "reportes/colegio_reporte_pdf.php",
                '_blank'
            );
        });
    });
</script>
<style type="text/css">
    .modal-title {
        margin-bottom: 0;
        display: flex;
        text-align: center;
        position: absolute;
        left: 28%;
    }

    .card {
        width: 400px; 
        height: 360px;
        min-height: 350px;
        position: absolute;
        left: 50%;
        top: 30%;
        transform: translate(-50%, -50%);
        -webkit-transform: translate(-50%, -50%);
        border-radius: 15px;
        background: white;
    }
    body {
        padding: 0;
    }

    .card-body {
        padding-top: 15px;
        border-radius: 15px;
        -webkit-box-flex: 1;
        -ms-flex: 1 1 auto;
        flex: 1 1 auto;
        padding: 1.25rem;
        background-color: white;
    }

  .small-box > .inner {
    padding: 10px;
    overflow: hidden;
    outline: auto;
    max-height: 100px;
  }

    .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
                font-weight: 900;
            }

        hr {
            border-top: 2px dashed #fc455c;
        }
</style>
</body>
</html>
