class Result < ActiveRecord::Base
  belongs_to :search
  validates :search_id, presence: true, uniqueness: true
end
