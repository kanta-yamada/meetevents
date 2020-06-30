class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 25 }
    validates :email, presence: true, length: { maximum: 100 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false } 
    has_secure_password
    
    has_many :events
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :meets
    has_many :joinings, through: :meets, source: :event
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end
    
    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end
    
    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def feed_events
        Event.where(user_id: self.following_ids + [self.id])
    end
    
    def interest(event)
        self.meets.find_or_create_by(event_id: event.id)
    end
    
    def uninterest(event)
        meets = self.meets.find_by(event_id: event.id)
        meets.destroy if meets
    end
    
    def interesting?(event)
        self.joinings.include?(event)
    end
end
