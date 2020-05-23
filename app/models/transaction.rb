class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates :operation, presence: true
  validates :value, presence: true
  validates :account_whither, presence: true

  # def account_whither
  #   if self.account.account_number == self.account_whither
  #     errors.add(:base, "Not accounts cannot be the same")
  #   end 
  # end 

end
