class TestsController < ApplicationController

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to tests_path, notice: "#{@test.user_name}'s invitation has been generated."
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
    redirect_to tests_path, notice: "#{@test.user_name}'s invitation has been deleted."
  end

  private
  def test_params
    params.require(:test).permit(:user_name).merge(:ip => request.remote_ip)
  end
end
