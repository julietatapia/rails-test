class Usuario < ApplicationRecord
	has_many :proyecto_usuarios

	validates :nombre, presence: true	
end
