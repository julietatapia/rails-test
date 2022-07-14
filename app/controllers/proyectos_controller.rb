class ProyectosController < ApplicationController

#creacion nuevo proyecto
#{"proyecto" => {"nombre" => "el nombre", "fecha_inicio" => "dd/mm/aaaa", "fecha_fin" => "dd/mm/aaaa", "usuarios" => [3,4,1], "tecnologia" => [2,3,1]}}
#{}

def create
  puts "---------CREATE----------"
  puts proyecto_params
  puts "-------------------------"

  no_existe = false
  if !proyecto_params["id"].nil?
    #Busco el proyecto
    if Proyecto.where(id: proyecto_params["id"]).empty?
      #No existe el proyecto
      no_existe = true      
    else
      #Obtengo el proyecto 
      proyecto = Proyecto.where(id: proyecto_params["id"]).first
    end
  else
    #Creo un nuevo proyecto
    proyecto = Proyecto.new
  end
  if no_existe
    render json: { status: :unprocessable_entity, message: "No existe proyecto" }
  else
    proyecto.nombre = proyecto_params["nombre"]
    proyecto.fecha_inicio = proyecto_params["fecha_inicio"]
    proyecto.fecha_fin = proyecto_params["fecha_fin"]

    usuarios = eval(proyecto_params["usuarios"])

    tecnologia = eval(proyecto_params["tecnologia"])


    respuesta_proyecto = "exito"
    respuesta_usuario = "exito"
    respuesta_tecnologia = "exito"

    ActiveRecord::Base.transaction do

      begin
        proyecto.save!

        proyecto.usuarios.delete_all

        proyecto.tecnologia.delete_all

        usuarios.each do |u|
          proyecto_usuario = ProyectoUsuario.new
          proyecto_usuario.proyecto_id = proyecto.id
          proyecto_usuario.usuario_id = u
          
          begin 
            proyecto_usuario.save!
          rescue
            respuesta_usuario = 'error'
          end
        end

        tecnologia.each do |t|
          proyecto_tecnologia = ProyectoTecnologia.new
          proyecto_tecnologia.proyecto_id = proyecto.id
          proyecto_tecnologia.tecnologia_id = t

          begin 
            proyecto_tecnologia.save!
          rescue
            respuesta_tecnologia = 'error'
          end
        end

      rescue
        respuesta_proyecto = "error"
      end

      raise ActiveRecord::Rollback if respuesta_proyecto != "exito" || respuesta_usuario != "exito" || respuesta_tecnologia != "exito" 
    end

    if respuesta_proyecto == "exito" && respuesta_usuario == "exito" && respuesta_tecnologia == "exito" 
      render json: { status: "Exito",  message: "Proyecto actualizado" }
    elsif respuesta_proyecto != "exito"
      render json: { status: :unprocessable_entity, message: "Error en datos del proyecto" }
    elsif respuesta_usuario != "exito"
      render json: { status: :unprocessable_entity, message: "Error de usuarios" }
    else
      render json: { status: :unprocessable_entity, message: "Error de tecnologias" }
    end
  end
end

def listar_proyectos
  puts "------------- listado_proyectos"
  puts params.inspect
  puts "-------------------------------"

  proyectos = Array.new

  if params["filtro"] == ""
    @proyectos = Proyecto.all
  elsif params["filtro"].split(":").first == "usuario"
    proy_usu = ProyectoUsuario.where("usuario_id = #{params["filtro"].split(":").last}")
    @proyectos = Array.new
    proy_usu.each do |pu|
      @proyectos << Proyecto.find(pu.proyecto_id)
    end
  elsif params["filtro"].split(':').first == "tecnologia"
    proy_tec = ProyectoTecnologia.where("tecnologia_id = #{params['filtro'].split(':').last}")
    @proyectos = Array.new
    proy_tec.each do |pt|
      @proyectos << Proyecto.find(pt.proyecto_id)
    end
  else
    @proyectos = []
  end
  @proyectos.each do |p|
    proyectos << {"nombre" => p.nombre, "fecha_inicio" => p.fecha_inicio, "fecha_fin" => p.fecha_fin} 
  end
   
  render json: { status: "Exito",  message: proyectos.to_s }
end

def recuperar_proyecto
  puts "------------- recuperar_proyecto"
  puts params.inspect
  puts "-------------------------------"

  proyectos = Proyecto.where(id: params["id"])
  if proyectos.empty?
    @proyecto = nil
    mensaje ="{}"
  else
    @proyecto = proyectos.first
    mensaje = "{proyecto: #{@proyecto.to_json}, usuarios: #{@proyecto.usuarios.to_json}, tecnologia: #{@proyecto.tecnologia.to_json}"
  end 

  render json: { status: 'Exito',  message: mensaje }

end


  private

    def proyecto_params
      params.require(:proyecto).permit(:id, :nombre, :fecha_inicio, :fecha_fin, :usuarios, :tecnologia)
    end

end