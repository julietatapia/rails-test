class CreateTecnologia < ActiveRecord::Migration[7.0]
  def change
    create_table :tecnologia do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
