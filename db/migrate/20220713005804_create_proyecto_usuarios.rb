class CreateProyectoUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :proyecto_usuarios do |t|
      t.references :proyecto, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
