require 'digest/md5'

class User < ActiveRecord::Base
  validates_presence_of :username, :password

  has_many :games

  before_create :encrypt_password

  def encrypt_password
    self.password = User.encrypt(password)
  end

  def self.encrypt(password)
    Digest::MD5.hexdigest(password)
  end

  def self.lookup(username, password)
    find_by_username_and_password(username.to_s, encrypt(password.to_s))
  end
end
