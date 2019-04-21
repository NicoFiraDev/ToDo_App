class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :body
      t.boolean :completed, default: false
      t.string :urgency
      t.integer :list_id

      t.timestamps
    end
  end
end
