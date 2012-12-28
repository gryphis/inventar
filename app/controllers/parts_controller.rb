class PartsController < ApplicationController
  def index
  end
  def new
    @part = Part.new
  end
  def create
    @part = Part.new(params[:part])
    if @part.save
      # flash[:notice:] = "Part has been created."
      redirect_to @part, :notice => "Part has been created."
    else
      # nothing yet
      # redirect_to ?, :alert => "Part has not been created."
    end
  end
  def show
    @part = Part.find(params[:id])
  end
end
