class Account < ApplicationRecord
  belongs_to :user
  has_many :Transaction, dependent: :destroy
  has_many :Deposit, dependent: :destroy

  def name_with_initial
    "#{account_number}. #{bank_name}"
  end
end
