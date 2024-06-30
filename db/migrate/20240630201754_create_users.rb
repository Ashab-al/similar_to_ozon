class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :last_name
      t.string :phone
      t.string :email
      t.integer :age
      t.string :role
      t.string :address

      t.timestamps
    end
  end
end
