class Network::SignatureCollectionsController < ApplicationController
  before_action :only_admin, except: [:index, :show]
  before_action :set_network_signature_collection, only: [:show, :edit, :update, :destroy]

  # GET /network/signature_collections
  # GET /network/signature_collections.json
  def index
    @query, @location, @distance = params[:query], params[:location], params[:distance]

    @network_signature_collections = Network::SignatureCollection.where(:event_date_start.gte =>  DateTime.now)

    @network_signature_collections = @network_signature_collections.or(location_zip_s: /#{@query}/i) if @query
    @network_signature_collections = @network_signature_collections.or(location_name: /#{@query}/i) if @query
    @network_signature_collections = @network_signature_collections.or(location_address: /#{@query}/i) if @query

    distance_from_location
  end

  def distance_from_location
    return unless @location && @distance
    location_coordinates = Geocoder.coordinates(@location)
    return unless location_coordinates # only filter when coordinates found
    @network_signature_collections = @network_signature_collections.geo_near(location_coordinates.reverse).max_distance(@distance.to_f/111)
  end

  # GET /network/signature_collections/1
  # GET /network/signature_collections/1.json
  def show
  end

  # GET /network/signature_collections/new
  def new
    @network_signature_collection = Network::SignatureCollection.new
  end

  # GET /network/signature_collections/1/edit
  def edit
  end

  # POST /network/signature_collections
  # POST /network/signature_collections.json
  def create
    @network_signature_collection = Network::SignatureCollection.new(network_signature_collection_params)

    respond_to do |format|
      if @network_signature_collection.save
        format.html { redirect_to @network_signature_collection, notice: 'Signature collection was successfully created.' }
        format.json { render :show, status: :created, location: @network_signature_collection }
      else
        format.html { render :new }
        format.json { render json: @network_signature_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network/signature_collections/1
  # PATCH/PUT /network/signature_collections/1.json
  def update
    respond_to do |format|
      if @network_signature_collection.update(network_signature_collection_params)
        format.html { redirect_to @network_signature_collection, notice: 'Signature collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @network_signature_collection }
      else
        format.html { render :edit }
        format.json { render json: @network_signature_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /network/signature_collections/1
  # DELETE /network/signature_collections/1.json
  def destroy
    @network_signature_collection.destroy
    respond_to do |format|
      format.html { redirect_to network_signature_collections_url, notice: 'Signature collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network_signature_collection
      @network_signature_collection = Network::SignatureCollection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_signature_collection_params
      params.require(:network_signature_collection).permit(:location_name, :location_zip, :location_address, :event_date_start, :event_date_end)
    end
end
