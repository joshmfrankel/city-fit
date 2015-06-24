class Meetup < ActiveRecord::Base
  belongs_to :search

  validates :score, presence: true, numericality: true
  validates :name, presence: true
  validates :total_members, presence: true, numericality: { only_integer: true }
  validates :total_meetups, presence: true, numericality: { only_integer: true }
end
