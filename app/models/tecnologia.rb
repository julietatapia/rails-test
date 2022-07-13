class Tecnologia < ApplicationRecord
	has_many :proyecto_tecnologia

	validates :nombre, presence: true	
end
