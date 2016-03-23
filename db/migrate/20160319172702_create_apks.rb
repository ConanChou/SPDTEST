class CreateApks < ActiveRecord::Migration
  def change
    create_table :apks do |t|
      t.string :file
      t.integer :test_id
      t.timestamps
    end
  end
end
