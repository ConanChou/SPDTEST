class Apk < ActiveRecord::Base
  belongs_to :test
  mount_uploader :file, ApkUploader
end
