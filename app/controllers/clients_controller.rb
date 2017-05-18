class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.paginate(page: params[:page], :per_page => 5).order('created_at DESC')
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    
    respond_to do |format|
      if @client.save
        if current_user.receptionist?
          notify_administrators("Ha creado al cliente: " + @client.clientName + " "+ @client.clientLastName)
        end
        notify_client(@client,"Se han ingresado sus datos en el sistema de El Patio.")
        format.html { redirect_to @client, notice: 'El cliente ha sido creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'El cliente ha sido actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    if !current_user.admin?
        redirect_to :back, alert: 'No tiene permisos para realizar esta operación'
    else
      if !@client.disabled
        @client.disabled = true
        message = 'El cliente ha sido deshabilitado satisfactoriamente.'
      else
        @client.disabled = false
        message = 'El cliente ha sido habilitado satisfactoriamente.'
      end
      @client.save
      respond_to do |format|
        format.html { redirect_to clients_url, notice: message }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:clientRut, :clientName, :clientLastName, :clientEmail, :clientCellPhone, :clientAddress)
    end

    # Función que notifica a los administrares si el usuarios fue creado por recepcionista
    # * *Args*    :
    #   - +message+ -> Es el mensaje que se desea que reciban los administradores
    def notify_administrators(message)
      admins = User.where(:roles_id => 1).all
      admins.each do |admin|
        NotificationMailer.notification_email(admin,current_user,message).deliver
      end
    end

    # Función que notifica al cliente la creación de su registro
    # * *Args*    :
    #   - +message+ -> Es el mensaje que se desea que reciban los administradores
    def notify_client(client,message)
        NotificationMailer.client_notification_email(client,message).deliver
    end 
end
