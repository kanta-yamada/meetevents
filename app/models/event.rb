class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :place, presence: true, length: { maximum: 50 }
  validates :time, presence: true, length: { maximum: 50 }
end
