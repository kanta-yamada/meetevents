class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :place, presence: true, length: { maximum: 50 }
  validates :time, presence: true, length: { maximum: 50 }
  
  has_many :meets
  has_many :rejoings, through: :meets, source: :user, dependent: :destroy
  
end
