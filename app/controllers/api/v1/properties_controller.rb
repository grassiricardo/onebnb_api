class Api::V1::PropertiesController < ApplicationController
  before_action :set_api_v1_property, only: [:show, :update, :destroy, :add_to_wishlist, :remove_from_wishlist, :visit_property]
  before_action :authenticate_api_v1_user!, except: [:index, :show, :search, :autocomplete, :featured, :visit_property]
 
  # GET /api/v1/properties.json
  def index
    @api_v1_properties = Property.all
  end
 
  # GET /api/v1/properties/1.json
  def show
  end
 
  # GET /api/v1/autocomplete.json
  def autocomplete
    results = []
    Property.where(status: :active).each do |property|
      results << property.name
      results << property.address.city
      results << property.address.country
    end
    render json: results.uniq, status: 200
  end

  def visit_property
    begin
      byebug
      @api_v1_property.visit_properties.find_or_create_by(user: current_api_v1_user)
      render json: {success: true}
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end
 
  # GET /api/v1/featured.json
  def featured
    properties = []
    begin
      Property.where(priority: true, status: :active).order("RANDOM()").limit(1).each {|p| properties << p}
      Property.where('id != ?',properties.first.id).where(status: :active).order("RANDOM()").limit(1).each {|p| properties << p}
      Property.where(id: VisitProperty.all.order("RANDOM()").limit(10).first.property_id).each {|p| properties << p}
       
      @api_v1_properties = properties
 
      render template: '/api/v1/properties/index', status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end
 
 
  # GET /api/v1/search
  def search
    # Caso o usuário não coloque nenhuma informação pesquisamos por qualquer uma
    search_condition = params[:search] || '*'
    # Caso não esteja sendo selecionado por página, pegamos a primeira
    page = params[:page] || 1
    # Filtra por status, presença de wifi, máquina de lavar e etc
    # Faça você mesmo \o/
    conditions = {status: :active}
 
    # Realizamos a busca do ElasticSearch
    @api_v1_properties = (Property.search search_condition, where: conditions,  page: page, per_page: 18)
    render template: '/api/v1/properties/index', status: 200
  end
 
  # POST /api/v1/properties.json
  def create
    @api_v1_property = Property.new(api_v1_property_params)
 
    if @api_v1_property.save
      render :show, status: :created, location: @api_v1_property
    else
      render json: @api_v1_property.errors, status: :unprocessable_entity
    end
  end
 
  # PATCH/PUT /api/v1/properties/1.json
  def update
    if @api_v1_property.update(api_v1_property_params)
      render :show, status: :ok, location: @api_v1_property
    else
      render json: @api_v1_property.errors, status: :unprocessable_entity
    end
  end
 
  # DELETE /api/v1/properties/1.json
  def destroy
    @api_v1_property.destroy
  end
 
  # POST /api/v1/properties/:id/wishlist.json
  def add_to_wishlist
    begin
      byebug
      @api_v1_property.wishlists.find_or_create_by(user: current_api_v1_user)
      render json: {success: true}
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end
 
  # DELETE /api/v1/properties/:id/wishlist.json
  def remove_from_wishlist
    begin
      @api_v1_property.wishlists.find_by(user: current_api_v1_user).delete
      render json: {success: true}, status: 200
    rescue Exception => errors
      render json: errors, status: :unprocessable_entity
    end
  end
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_property
      @api_v1_property = Property.find(params[:id])
    end
 
    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_property_params
      params.require(:api_v1_property).permit(:title, :description)
    end
end