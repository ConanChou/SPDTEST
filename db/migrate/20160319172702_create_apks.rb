class CreateApks < ActiveRecord::Migration
  def change
    create_table :apks do |t|
      t.string :file
      t.timestamps
    end
  end
end
