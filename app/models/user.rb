class User < ApplicationRecord
  has_secure_password

  has_many :tasks

  validates_presence_of :name, :email
  validates_uniqueness_of :email
end
