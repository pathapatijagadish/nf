class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end
 
  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    1.times do
      @question = @project.questions.build
    end
  end

  # GET /projects/1/edit
  def edit
    #redirect_to root_path
    #project = Project.find(params[:id])
    #html  = render_to_string
    #kit   = IMGKit.new(html)
    #img   = kit.to_img(:png)
    #file  = Tempfile.new(["template_#{project.id}", 'png'], 'tmp',
    #:encoding => 'ascii-8bit')
    #file.write(img)
    #file.flush
    #project.avatar = file
    #project.save
    #file.unlink
    #@question = Question.find_by_project_id(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    #render :text=>params and return false
    respond_to do |format|
      if @project.save
        kit = IMGKit.new(render_to_string(:partial => 'form', :layout => false,:locals => {:project => @project})) #it takes html and any options for wkhtmltoimage
        kit.stylesheets << '/home/intel-ithub/Desktop/ROR/nf/app/assets/stylesheets/ImgKit.css' #its apply the give css to the converted image 
        t = kit.to_img(:png) # convert image to specific format
        #render :text =>t and return false
        #render :text=>t abd return false
        file_path = '/home/intel-ithub/Desktop/ROR/nf/app/assets/images/' + @project.id.to_s+ ".png" #storing path of converted file
        file = kit.to_file(file_path)
        format.html { redirect_to root_path, notice: 'Flyer was successfully updated.' }
        format.json { render :new, status: :ok, locatioFlyern: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json

  def update
    respond_to do |format|
      if @project.update(project_params)
        kit = IMGKit.new(render_to_string(:partial => 'form', :layout => false,:locals => {:project => @project}))
        kit.stylesheets << '/home/intel-ithub/Desktop/ROR/nf/app/assets/stylesheets/ImgKit.css'
        t = kit.to_img(:png) 
        file_path = '/home/intel-ithub/Desktop/ROR/nf/app/assets/images/' + @project.id.to_s+ ".png"
        file = kit.to_file(file_path)
        format.html { redirect_to root_path, notice: 'Flyer was successfully updated.' }
        format.json { render :show, status: :ok, locatioFlyern: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroyFlyer
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Flyer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name,:description, questions_attributes: [:id,:project_id,:subject,:content,:_destroy, :avatar])
      #params.require(:project).permit(:name, questions_attributes: [:id,:project_id,:subject,:content, :_destroy])
    end

end
