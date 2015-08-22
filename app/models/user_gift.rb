class UserGift < ActiveRecord::Base
  belongs_to :user
  belongs_to :gift

  validate :users_must_less_than_amount, on: :create

  def users_must_less_than_amount

    if self.class.where(gift_id: self.gift_id).count > self.gift.amount
      errors.add "人数超过了"
    end

  end

end
