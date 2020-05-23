class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :show, :edit, :create, :update, :destroy, :statement]
  skip_before_action :verify_authenticity_token, :only => :statement
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all().where("user":current_user.id, "active":1)
    # @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts/statement
  def statement
    if params[:date_stt] && params[:date_end] != ""
      start_date = params[:date_stt].to_date.beginning_of_day
      end_date = params[:date_end].to_date.end_of_day
      @records = Transaction.where(:created_at => start_date..end_date, user_id:current_user, )

      @account = Account.select(:id).where(user_id:current_user)
      @querys = Deposit.where(:created_at => start_date..end_date, account_id:@account)
    else
      @records = nil
      @querys = nil
    end
  end 

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
   
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    # @account.destroy
    @account.active = 0
    @account.save()
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:user_id, :account_number, :balance, :bank_name, :agency_number, :type_account)
    end
end
