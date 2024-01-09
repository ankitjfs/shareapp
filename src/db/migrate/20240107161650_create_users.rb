class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :work_email
      t.string :company_id
      t.integer :status, default:0
      t.string :password_digest

      t.timestamps
    end
  end
end
