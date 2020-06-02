<?php 
session_start();
require_once '../conf/conexion_db.php';
require_once '../conf/funciones_db.php';
?>
  <div class="modal fade" id="modal_actualizar_curso">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">          
        <div class="modal-header">
          <h4 class="modal-title">Editar Curso</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>      
      
        <div class="modal-body">
         <form id="formulario_update_curso">
         <div class="row">
          <div class="col-md-6">
          <label>Docente:</label>
            <?php lista_docente_establecimiento_update($_SESSION["identificador_estable"]);?>
              <input type="text" name="id_curso_update" id="id_curso_update" class="invisible"/>
          </div>          
          <div class="col-md-6">
          <label>Curso:</label>
          <input type="text" name="nombre_curso_update" id="nombre_curso_update" class="form-control"/>
          </div>
          <div class="col-md-6">
             <label>Nivel Curso:</label>
             <?php niveles_compromiso_escolar_update($_SESSION["identificador_estable"]);?>
          </div>      
          <?php
			if($_SESSION["pais"] == 1) {
				echo '<div class="col-md-6" id="tipo_encuesta_update"><label>Tipo Encuesta:</label>';
				lista_tipo_encuesta_update(); 			
				echo '</div>';
				
			}?>
         </div>
        </div>       
       
        <div class="modal-footer">
        <input type="submit" id="actualizando_curso" class="btn btn-primary" value="Actualizar" />
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        </div>
        </form>
      </div>
    </div>
  </div>

  <script>
            $(document).ready(function(){

              $('#niveles_ce_update').on('change', function(){
                if($('#niveles_ce_update').val() == 2) {
                  if($('#tipo_encuesta_update').length > 0) {
                    $('#tipo_encuesta_update').hide();
                    $('#id_tipo_encuesta_update').val(1);
                  }
                } else {
                  if($('#tipo_encuesta_update').length > 0) {
                    $('#tipo_encuesta_update').show();
                  }
                }
              });
            });

      $("#actualizando_curso").click(function(){
        var formData = new FormData(document.getElementById("formulario_update_curso"));
                    formData.append("dato", "curso_update");                       
                                        
                    $.ajax({
                        url: "php/gest_administrador.php",
                        type: "post",
                        dataType: "html",
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                 
                 success: function(response){
                     console.log(response);
                    $("#tabla_soste").load("php/tabla_sostenedor.php");
                    $("#tabla_prof").load("php/tabla_docente.php");
                    $("#tabla_cur").load("php/tabla_curso.php");
                  
                   var respuesta = (JSON.parse(response));
                   if(respuesta.estado === "1"){
                       alertify.success("<div class='text-white text-center'>Datos Actualizados</>");                      
                          
                   }
                   else if(respuesta.estado === "0"){                                              
                    alertify.success("<div class='text-white text-center'>Datos no actualizados</>");     
                   
                   }
                   else if(respuesta.estado === "2"){
                    
                      
                   
                   }
                  
        
                 }
                    })
      })
     
  </script>