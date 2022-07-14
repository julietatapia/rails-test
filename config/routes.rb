Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'crear_proyecto', to: 'proyectos#create'

  get 'listar_proyectos', to: 'proyectos#listar_proyectos'

  get 'recuperar_proyecto', to: 'proyectos#recuperar_proyecto'

end
