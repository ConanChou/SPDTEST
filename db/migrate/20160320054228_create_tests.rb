class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :user_name
      t.integer :apk_id
      t.string :ip
      t.string :token
      t.boolean :done

      t.timestamps
    end
  end
end
