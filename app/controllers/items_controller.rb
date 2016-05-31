class ItemsController < ApplicationController
  def index
    @items = Item.all

    respond_to do |format|
      format.html { @items  }
      format.json { render json: @items }
    end
  end

  def show
    @item = Item.find_by(id: params[:id])

    respond_to do |format|
      format.html { @item }
      format.json { render json: @item }
      format.json { render xml: @item }
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to items_path, notice: "The item was created."
    else
      flash.now[:notice] = "The item was not created."
      render :new
    end
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(item_params)
      redirect_to item_path(@item), notice: "The item was updated."
    else
      flash.now[:notice] = "The item was not updated."
      render :edit
    end
  end

  def destroy
    Item.destroy(params[:id])

    redirect_to items_path, notice: "The item was deleted."
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image_url)
  end
end
