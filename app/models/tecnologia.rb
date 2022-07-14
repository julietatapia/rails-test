class Tecnologia < ApplicationRecord
	has_many :proyecto_tecnologia
	has_many :proyectos, through: :proyecto_tecnologia

	validates :nombre, presence: true	
end
