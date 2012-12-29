class PartsController < ApplicationController
  before_filter :find_part, :only => [:show,:edit,:update,:destroy]

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
  end
  def edit
  end
  def update
    if @part.update_attributes(params[:part])
      flash[:notice] = "Part has been updated."
      redirect_to @part
    else
      flash[:alert] = "Part has not been updated."
      render :action => "edit"
    end
  end
  def destroy
    @part.destroy
    flash[:notice] = "Part has been deleted."
    redirect_to parts_path
  end

private
  def find_part
    @part = Part.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The part you were looking for could not be found."
    redirect_to parts_path
  end

end
