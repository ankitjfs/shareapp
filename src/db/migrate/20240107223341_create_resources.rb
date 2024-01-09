class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.integer :company_id
      t.integer :status, default:0

      t.timestamps
    end
  end
end
