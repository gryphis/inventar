class PartDescsController < ApplicationController
  before_filter :find_part_desc, only: [:show,:edit,:update,:destroy]

  def index
    @part_descs = PartDesc.all
  end
  def new
    @part_descs = PartDesc.new
  end
  def create
    if params[:commit] == "Cancel"
      return redirect_to part_descs_path, notice: "Creation cancelled."
    end      
    @part_desc = PartDesc.new(params[:part_desc])
    if @part_desc.save
      redirect_to @part_desc, notice: "Part Description has been created."
    else
      flash[:alert] = "Part Description has not been created."
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
      return redirect_to @part_desc
    end      
    old_part_desc = PartDesc.new.reload(@part_desc[:id])
    @part_desc.attributes = params[:part_desc]
    if old_part_desc.as_json == @part_desc.as_json
      flash[:notice] = "No update requested."
      redirect_to @part_desc
    elsif @part_desc.update_attributes(params[:part_desc])
      flash[:notice] = "Part Description has been updated."
      redirect_to @part_desc
    else
      flash[:alert] = "Part Description has not been updated."
      render action: "edit"
    end
  end
  def destroy
    @part_desc.destroy
    flash[:notice] = "Part Description has been deleted."
    redirect_to part_descs_path
  end

private
  def find_part_desc
    @part_desc = PartDesc.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The part description you were looking for could not be found."
    redirect_to part_descs_path
  end

end
