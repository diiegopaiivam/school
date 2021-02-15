class CreateProfileStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_statistics do |t|
      t.references :profile, null: false, foreign_key: true
      t.integer :right_question, default: 0 #iniviando com um valor padrão de 0
      t.integer :wrong_question, default: 0 #iniciando com um valor padrão de 0

      t.timestamps
    end
  end
end
