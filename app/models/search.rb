class Search < ActiveRecord::Base

  belongs_to :user

  validates :job1, presence: true
  validates :job2, presence: true
  validates :city, presence: true
end
