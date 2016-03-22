class CreateTests < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.integer :apk_id
      t.string :uid
      t.string :isp
      t.string :ip
      t.string :has_gfw
      t.float :download_time
      t.float :upload_time

      t.timestamps
    end
  end
end
