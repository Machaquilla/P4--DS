class AddUsuarioToTexts < ActiveRecord::Migration[7.1]
  def change
    add_column :texts, :usuario, :string
  end
end
