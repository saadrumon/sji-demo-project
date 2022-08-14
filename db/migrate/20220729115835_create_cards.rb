class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.integer :card_type
      t.string :card_holder_name
      t.string :card_number
      t.date :expiration_date
      t.references :user, null: false, foreign_key: true
      t.boolean :is_default, default: false

      t.timestamps
    end
  end
end
