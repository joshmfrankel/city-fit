class Search < ActiveRecord::Base

  belongs_to :user
  has_many :results, dependent: :destroy

  validates :job1, presence: true
  validates :job2, presence: true
  validates :location, presence: true
  validates :user_id, presence: true
end
