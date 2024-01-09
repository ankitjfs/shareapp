class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :city
      t.string :country
      t.string :email_domain
      t.integer :status, default:0

      t.timestamps
    end
  end
end
