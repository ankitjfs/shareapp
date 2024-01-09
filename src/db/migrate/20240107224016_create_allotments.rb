class CreateAllotments < ActiveRecord::Migration[7.1]
  def change
    create_table :allotments do |t|
      t.integer :resource_id
      t.integer :user_id
      t.integer :status, default:0

      t.timestamps
    end
  end
end
