class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [ :index, :show ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
    @project = Project.friendly.find(params[:id])
    @project.increment!(:clicks_count) unless user_signed_in?
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

# PATCH/PUT /projects/1 or /projects/1.json
def update
  new_images = params[:project][:images]

  respond_to do |format|
    if @project.update(project_params.except(:images))
      @project.images.attach(new_images) if new_images.present?

      format.html { redirect_to project_url(@project), notice: "Project berhasil diperbarui!" }
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end
end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to projects_path, notice: "Project was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

def delete_image
  @project = Project.find(params[:id])

  @image = @project.images.find_by(id: params[:image_id])

  if @image
    @image.purge
    redirect_to edit_project_path(@project), notice: "Gambar berhasil dihapus."
  else
    redirect_to edit_project_path(@project), alert: "Gambar tidak ditemukan."
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, :github_url, images: [])
    end
end
