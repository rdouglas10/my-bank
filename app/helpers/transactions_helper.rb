module TransactionsHelper

  # Check if the account informed exist in database
  def accountExistDb(accountNumber)
    account_number = Account.find_by(account_number:accountNumber)
  end
   

  # Action to calculate the rates to be applied
  def calculeRates(valueMoney)
    if valueMoney
      require "time"
      require "date"

      week = [ "Monday", "Tuesday", "Wednesday", "Thursday", "Friday" ]
      time = Time.now
      day = Date.today.strftime("%A")
      current_hour = time.hour
    
      if week.include?(day) && current_hour >= 9 && current_hour < 18
        rate = 5
      else
        rate = 7
      end

      if valueMoney <= 1000
        new_rate = rate
      else
        new_rate = rate + 10
      end
    end
  end


  # Action to update values of accounts credits and debits
  def updateAccounts(accountOrigin, accountWhither, valueTransf)
    # calculates the rate of the reported value
    rate_value = calculeRates(valueTransf) 
  
    # checks if the source account has money and if the value is greater than requested  
    if @transaction.account.balance > (valueTransf + rate_value)
        # subtracts the value and rate
        new_balance = @transaction.account.balance - (valueTransf + rate_value)
        # updating field balance of table accounts (credit e debit)
        account_debit = Account.find_by(account_number:accountOrigin)
        account_debit.balance = new_balance
        if account_debit.save()
          account_credit = Account.find_by(account_number:accountWhither)
          account_credit.balance = account_credit.balance + valueTransf
          account_credit.save()
          # value of final rate
          final_rate = rate_value
        end
     end
  end


# Service action to validate the infomations about cash transfer
  def validateTransfer(transaction)
    if transaction
      # Verify if the accounts are differents
      if (transaction.account.account_number != transaction.account_whither)
        if transaction.account_whither && transaction.value
          if accountExistDb(transaction.account_whither)
            convenience_value = updateAccounts(transaction.account.account_number, transaction.account_whither, transaction.value)
            if convenience_value  
              transaction.rate = convenience_value
              @result = 'success'
              # @msg = "congratulations it`s all ok!"
            else
              @result = 'fail'
              @msg = "insufficient balance for this transaction"
            end
          else 
            @result = 'fail'
            @msg = "The field account whither no exist..."
          end
        else
          @result = 'fail'
          @msg = "Enter the two fields: account whither and value "
        end
      else
        @result = 'fail'
        @msg = "accounts cannot be the same"
      end   
    end
  end



  # Service action to validate the infomations about cash withdrawal
  def validateWithdraw(transaction)
    query_account = Account.find_by(id:transaction.account_id)
    if query_account
      if transaction.value
        if query_account.balance > transaction.value
          query_account.balance = query_account.balance - transaction.value
          query_account.save()
          @response = "success"
        else
          @msg = "The requested balance is insufficient"
        end
      else
        @msg = "Enter field value..."
      end
    end
  end 


  # Service to validate the deposit opperation
  def validateDeposit(transaction)
    if transaction.account_whither != ""
      query_account = Account.find_by(account_number:transaction.account_whither)
      p query_account
      p transaction.account_whither
      
      if query_account != nil
        if transaction.value
          query_account.balance = query_account.balance + transaction.value
          query_account.save()
          @response = "success" 
        else
          @msg = "Enter field value..."
        end
      else
        @msg = "The account informed to deposit not exist."
      end
    else
      @msg = "Enter field account whither..."
    end
  end
end
