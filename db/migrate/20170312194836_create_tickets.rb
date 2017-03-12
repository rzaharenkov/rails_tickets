class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :status, default: 0
      t.integer :reporter_id
      t.integer :assignee_id

      t.timestamps
    end
  end
end
