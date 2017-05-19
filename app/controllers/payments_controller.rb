class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update_verified, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.paginate(page: params[:page], :per_page => 20).order('created_at DESC')
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    @clients = Client.all
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    if current_user.admin?
      @payment.verified = true
    end
    respond_to do |format|
      if @payment.save
        format.html { redirect_to payments_url, notice: 'El abono ha sido creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update_verified
    if current_user.admin? && !@payment.verified
      @payment.verified = true
      message = 'El abono ha sido aprobado satisfactoriamente.' 
    else
      message = 'El abono no ha podido ser aprobado.' 
    end
    respond_to do |format|
      if @payment.save
        format.html { redirect_to :back, notice: message}
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    if current_user.admin?
      @payment.destroy
      message = 'El abono ha sido cancelado satisfactoriamente.' 
    else
      message = 'No tiene los permisos para realizar esta acción.' 
    end
    respond_to do |format|
      format.html { redirect_to payments_url, notice: message }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      if(!params[:id].nil?)
        @payment = Payment.find(params[:id])
      else
        @payment = Payment.find(params[:payment_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
        params.require(:payment).permit(:description, :amount, :pay_date, :verified, :client_id)
    end
end
