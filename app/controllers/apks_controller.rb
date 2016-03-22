class ApksController < ApplicationController
  def index
    @apks = Apk.all
  end

  def new
    @apk = Apk.new
    @test = Test.new
    @first_apk ||= Apk.all.first
  end

  def create
    @apk = Apk.new(apk_params)
    if @apk.save
      respond_to do |format|
        format.html {redirect_to new_apk_path(:apk => @apk.id), notice: "#{File.basename(@apk.file.path)} has been uploaded."}
        format.json {render json: {:apk => @apk.id}}
      end
    else
      render 'new'
    end
  end

  def destroy
    @apk = Apk.find(params[:id])
    @first_apk ||= Apk.all.first
    if @first_apk && @first_apk != @apk
      @apk.destroy
      redirect_to apks_path, notice: "#{File.basename(@apk.file.path)} has been deleted."
    else
      redirect_to apks_path, notice: "The 1st file cannot be deleted."
    end
  end

  private
  def apk_params
    params.require(:apk).permit(:file)
  end
end
