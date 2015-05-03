class IndeedResult < ActiveRecord::Base
  belongs_to :search

  validates :score, presence: true
  validates :job_total_1, presence: true
  validates :job_total_2, presence: true
  validates :job_listing_1, presence: true
  validates :job_listing_2, presence: true
  validates :job_raw_1, presence: true
  validates :job_raw_2, presence: true
end
