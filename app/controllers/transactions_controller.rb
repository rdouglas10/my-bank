class TransactionsController < ApplicationController
  include TransactionsHelper
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :show, :edit, :create, :update, :destroy, :cash, :withdraw]

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end
  
  # GET /accounts/cash
  def cash
    @transaction = Transaction.new
  end

# POST /withdraw
  def withdraw
    @transaction = Transaction.new(transaction_params)
    @create = validateWithdraw(@transaction)
    respond_to do |format|
      if @create == "success"
        if @transaction.save()
          format.html { redirect_to accounts_path, notice: 'Transaction was successfully created.' }
          format.json { render :new, status: :created, location: @transaction }
        else
          format.html { render :new }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to transactions_cash_path, alert: @msg }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    
    @transaction = Transaction.new(transaction_params)
    @create = validateTransfer(@transaction)
    respond_to do |format|
      if @create == 'success'
        if @transaction.save()
          format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
          format.json { render :show, status: :created, location: @transaction }
        else
          format.html { render :new }
          format.json { render json: @transaction.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to '/transactions/new', alert: @msg }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:user_id, :account_id, :operation, :value, :account_whither)
    end
end
