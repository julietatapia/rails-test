class ProyectosController < ApplicationController

#creacion nuevo proyecto
#{"proyecto" => {"nombre" => "el nombre", "fecha_inicio" => "dd/mm/aaaa", "fecha_fin" => "dd/mm/aaaa", "usuarios" => [3,4,1], "tecnologia" => [2,3,1]}}
def create
# @proyecto = Proyecto.new()
  puts "---------CREATE----------"
  puts proyecto_params
  puts "-------------------------"

  proyecto = Proyecto.new
  proyecto.nombre = proyecto_params["nombre"]
  proyecto.fecha_inicio = proyecto_params["fecha_inicio"]
  proyecto.fecha_fin = proyecto_params["fecha_fin"]

  usuarios = eval(proyecto_params["usuarios"])

  tecnologia = eval(proyecto_params["tecnologia"])

  ActiveRecord::Base.transaction do
    if proyecto.save!
      respuesta_proyecto = "exito"
      nuevo_proyecto = Proyecto.last

      respuesta_usuario = ""
      usuarios.each do |u|
        proyecto_usuario = ProyectoUsuario.new
        proyecto_usuario.proyecto_id = nuevo_proyecto.id
        proyecto_usuario.usuario_id = u
        
        if respuesta_usuario != "error"
          respuesta_usuario = proyecto_usuario.save! ? "exito" : "error"
        end

      end

      respuesta_tecnologia = ""
      tecnologia.each do |t|
        proyecto_tecnologia = ProyectoTecnologia.new
        proyecto_tecnologia.proyecto_id = nuevo_proyecto.id
        proyecto_tecnologia.tecnologia_id = t

        if respuesta_tecnologia != "error"
          respuesta_tecnologia = proyecto_tecnologia.save! ? "exito" : "error"      
        end

      end
    else
      respuesta_proyecto = "error"
    end

    raise ActiveRecord::Rollback if respuesta_proyecto = "error" || respuesta_usuario = "error" || respuesta_tecnologia = "error" 
  end

  if respuesta_proyecto = "exito" && respuesta_usuario = "exito" && respuesta_tecnologia = "exito" 
    render json: { status: "Exito",  message: "proyecto dado de alta" }
  elsif respuesta_proyecto = "error"
    render json: { status: :unprocessable_entity, message: "No pudo grabar el proyecto" }
  elsif respuesta_usuario = "error"
    render json: { status: :unprocessable_entity, message: "Error de usuarios" }
  else
    render json: { status: :unprocessable_entity, message: "Error de tecnologias" }
  end

end

def listado_obras
  puts "------VIENDO LOS PARAMETROS ------------ -------"
  puts params.inspect
  puts "------VIENDO LOS PARAMETROS ARRIBA ------------ -------"
  if params["token"] == "clave"
    @obras = Obra.all
    obras = Array.new
    @obras.each do |obra|
      obras << obra.nombre
    end
    render json: { status: 'Exito',  message: obras.to_s }
  else
    render json: { status: :unprocessable_entity, message: "Conection error" }
  end
end



  private

    def proyecto_params
      params.require(:proyecto).permit(:nombre, :fecha_inicio, :fecha_fin, :usuarios, :tecnologia)
    end

end