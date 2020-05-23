class TransactionsService

  def initialize(transaction)
    @transaction = transaction
  end

  def execute
    verify_account
    
  
    private

  def verify_account
    p @transaction
    abort("sdfsffffffppp")
  
  end

end