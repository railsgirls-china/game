class User < ActiveRecord::Base

  has_many :user_gifts
  has_many :gifts, through: :user_gifts

end
