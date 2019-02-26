class Task < ApplicationRecord

  validates_presence_of :name

  validates_length_of :name, maximum: 30

  belongs_to :user

  scope :recent, -> {order(created_at: :desc)}

end
