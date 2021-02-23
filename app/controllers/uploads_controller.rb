class UploadsController < ApplicationController
  require 'base64'
  before_action :authorize_request, except: :create
  before_action :set_upload, only: [:show, :destroy]

  # GET /uploads
  def index
    @uploads = Upload.all

    render json: @uploads
  end

  # GET /uploads/1
  def show
    if upload_exists?(params[:id])
      send_file @upload.uri
      `open #{@upload.uri}`
    else
      render :error
    end
  end

  # POST /uploads
  def create
    
    file_name = params[:file]

    #uUpload.create!(upload_params)
    uri = "#{Rails.root}/uploads/#{file_name}"
   
    @upload = Upload.new(upload_params)
    
    if @upload.save
      render json: @upload, status: :created, location: @upload
    else
      render json: @upload.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /uploads/1
  #def update
    #

  # DELETE /uploads/1
  def destroy
    if upload_exists?(params[:id])
      @upload.destroy
    else
      render :error
    end
  end

  private
    # checks if current upload exists by its id
    def upload_exists?(id)                  #:doc:
      Upload.exists?(id: id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def upload_params
      params.permit(:file, :user_id)
    end
end
