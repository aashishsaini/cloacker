class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.string :type
      t.datetime :time

      t.timestamps
    end
  end
end
