class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all.paginate(:page => params[:page], :per_page => 10)
      if params[:search]
        @profiles = Profile.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      else
        @profiles = Profile.all.paginate(:page => params[:page], :per_page => 10)
      end
      authorize @profiles
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    authorize Profile
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    authorize @profile
  end

  # GET /profiles/1/edit
  def edit
    authorize Profile
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    authorize @profile
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'El perfil se creo correctamente.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        authorize @profile
        format.html { redirect_to @profile, notice: 'El perfil se actualizo correctamente.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    authorize @profile
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'El perfil se elimino correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:nombre, :descripcion)
    end
end
