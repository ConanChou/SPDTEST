class TestsController < ApplicationController

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
  end

  def create
    p = test_params
    @test = nil
    if params[:test_id] && params[:test_id] != '0'
      @test = Test.find_by_id(params[:test_id])
      @test.update(p)
    else
      @test = Test.new(p)
    end
    apk = Apk.find_by_id(p[:apk_id] || 0)
    if @test && @test.save
      @test.apk = apk
      respond_to do |format|
        format.html {redirect_to tests_path, notice: "测试已完成，非常感谢！"}
        format.json {render json: {:test_id => @test.id}}
      end
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
