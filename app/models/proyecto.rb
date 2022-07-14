class Proyecto < ApplicationRecord
	has_many :proyecto_usuarios
	has_many :proyecto_tecnologia

	has_many :usuarios, through: :proyecto_usuarios
	has_many :tecnologia, through: :proyecto_tecnologia

	validates :nombre, presence: true	
	validates :fecha_inicio, presence: true
	validates :fecha_fin, presence: true	
end