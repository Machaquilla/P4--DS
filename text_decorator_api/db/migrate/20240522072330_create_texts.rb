class CreateTexts < ActiveRecord::Migration[7.1]
  def change
    create_table :texts do |t|
      t.text :content
      t.boolean :bold
      t.boolean :italic
      t.boolean :underline

      t.timestamps
    end
    def change
      add_reference :texts, :user, null: false, foreign_key: true
    end
  end
end
