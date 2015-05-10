class Search < ActiveRecord::Base

  belongs_to :user
  has_one :indeed_result, dependent: :destroy

  validates :job1, presence: true
  validates :job2, presence: true
  validates :location, presence: true
  validates :user_id, presence: true
  validates :job_scale, presence: true, :numericality => { :greater_than_or_equal_to => -50, :less_than_or_equal_to => 50 }
end
