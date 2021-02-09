class CreateProfileUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_users do |t|
      t.string :address
      t.string :gender
      t.date :birthdate
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
