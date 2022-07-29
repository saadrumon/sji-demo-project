class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.integer :card_type
      t.string :card_holder_name
      t.string :card_number
      t.date :expiration_date

      t.timestamps
    end
  end
end
