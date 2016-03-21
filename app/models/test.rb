class Test < ActiveRecord::Base
  require 'digest/sha1'

  has_one :apk, dependent: :destroy
  validates :user_name, :ip, presence: true
  after_initialize :init

  def init
    self.done ||= false
    self.token ||= Digest::SHA1.hexdigest "#{self.user_name}_#{Time.now.to_i}"
  end
end
