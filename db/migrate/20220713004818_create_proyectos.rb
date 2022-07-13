class CreateProyectos < ActiveRecord::Migration[7.0]
  def change
    create_table :proyectos do |t|
      t.string :nombre
      t.date :fecha_inicio
      t.date :fecha_fin

      t.timestamps
    end
  end
end
