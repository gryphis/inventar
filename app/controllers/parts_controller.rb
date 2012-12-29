class PartsController < ApplicationController
  def index
    @parts = Part.all
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
      flash[:alert] = "Part has not been created."
      render :action => "new"
    end
  end
  def show
    @part = Part.find(params[:id])
  end
  def edit
    @part = Part.find(params[:id])
  end
  def update
    @part = Part.find(params[:id])
    if @part.update_attributes(params[:part])
      flash[:notice] = "Part has been updated."
      redirect_to @part
    else
      flash[:alert] = "Part has not been updated."
      render :action => "edit"
    end
  end

end
