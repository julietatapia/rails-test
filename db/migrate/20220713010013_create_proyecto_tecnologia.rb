class CreateProyectoTecnologia < ActiveRecord::Migration[7.0]
  def change
    create_table :proyecto_tecnologia do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.references :tecnologia, null: false, foreign_key: true

      t.timestamps
    end
  end
end
