class Proyecto < ApplicationRecord
	has_many :proyecto_usuarios
	has_many :proyecto_tecnologia

	validates :nombre, presence: true	
	validates :fecha_inicio, presence: true
	validates :fecha_fin, presence: true	
end