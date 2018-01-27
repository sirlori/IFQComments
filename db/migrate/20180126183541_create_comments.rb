class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :comment
      t.string :username
      t.string :userbadge
      t.string :when

      t.timestamps
    end
  end
end
