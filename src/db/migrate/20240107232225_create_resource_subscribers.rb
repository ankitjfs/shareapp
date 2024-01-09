class CreateResourceSubscribers < ActiveRecord::Migration[7.1]
  def change
    create_table :resource_subscribers do |t|
      t.integer :resource_id
      t.integer :user_id
      t.integer :status, default:0

      t.timestamps
    end
  end
end
