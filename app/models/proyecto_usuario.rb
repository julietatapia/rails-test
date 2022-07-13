class ProyectoUsuario < ApplicationRecord
  belongs_to :proyecto
  belongs_to :usuario
end
