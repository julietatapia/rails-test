class Usuario < ApplicationRecord
	has_many :proyecto_usuarios
  has_many :proyectos, through: :proyecto_usuarios

	validates :nombre, presence: true	
end
