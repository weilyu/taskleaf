class Task < ApplicationRecord

  validates_presence_of :name

  validates_length_of :name, maximum: 30

  validate :validate_name_not_including_comma

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
