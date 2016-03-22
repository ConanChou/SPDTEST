class TestsController < ApplicationController

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
  end

  def create
    p = test_params
    @test = Test.new(p)
    apk = Apk.find(p[:apk_id])
    if @test.save
      @test.apk = apk
      redirect_to tests_path, notice: "#{@test.uid}'s invitation has been generated."
    else
      render 'new'
    end
  end

  def finish
  end

  def take_test
    @test = Test.where(params[:i])
  end

  def destroy
    @test = Test.find(params[:id])
    @test.destroy
    redirect_to tests_path, notice: "#{@test.uid}'s invitation has been deleted."
  end

  private
  def test_params
    params.require(:test).permit(:uid, :isp, :has_gfw, :download_time, :upload_time, :apk_id).merge(:ip => request.remote_ip)
  end
end
