class Test < ActiveRecord::Base
  has_one :apk, dependent: :destroy
  validates :uid, :ip, :isp, :has_gfw, presence: true
end
