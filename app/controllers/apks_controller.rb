class ApksController < ApplicationController
  def index
    @apks = Apk.all
  end

  def new
    @apk = Apk.new
  end

  def create
    @apk = Apk.new(apk_params)
    if @apk.save
      redirect_to apks_path, notice: "#{File.basename(@apk.file.path)} has been uploaded."
    else
      render 'new'
    end
  end

  def destroy
    @apk = Apk.find(params[:id])
    @apk.destroy
    redirect_to apks_path, notice: "#{File.basename(@apk.file.path)} has been deleted."
  end

  private
  def apk_params
    params.require(:apk).permit(:file)
  end
end
