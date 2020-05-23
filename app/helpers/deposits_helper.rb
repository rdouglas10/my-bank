module DepositsHelper

  def validateDeposit(deposit)
    if deposit
      account = Account.find_by(account_number:deposit.account_number)
      if deposit.value
        if account
          account.balance = account.balance + deposit.value
          account.save() 

          @deposit.account_id = account.id
          @create = "success"
        else
          @create = "fail"
          @msg = "This account not exist..."
        end 
      else
        @create = "fail"
        @msg = "Enter the value..."
      end
    end
  end

end