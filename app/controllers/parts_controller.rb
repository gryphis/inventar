class PartsController < ApplicationController
  before_filter :find_part, only: [:show,:edit,:update,:destroy]

  def index
    @parts = Part.all
  end
  def new
    @part = Part.new
  end
  def create
    if params[:commit] == "Cancel"
      return redirect_to parts_path, notice: "Creation cancelled."
    end      
    @part = Part.new(params[:part])
    if @part.save
      redirect_to @part, notice: "Part has been created."
    else
      flash[:alert] = "Part has not been created."
      render action: "new"
    end
  end
  def show
  end
  def edit
  end
  def update
    if params[:commit] == "Cancel"
      flash[:notice] = "Update cancelled."
      return redirect_to @part
    end      
    old_part = Part.new.reload(@part[:id])
    @part.attributes = params[:part]
    if old_part.as_json == @part.as_json
      flash[:notice] = "No update requested."
      redirect_to @part
    elsif @part.update_attributes(params[:part])
      flash[:notice] = "Part has been updated."
      redirect_to @part
    else
      flash[:alert] = "Part has not been updated."
      render action: "edit"
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
