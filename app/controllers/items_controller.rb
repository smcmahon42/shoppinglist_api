class ItemsController < ApplicationController

  def index
    if !params[:shoppinglist_id].blank?
      @list = Shoppinglist.find(params[:shoppinglist_id])
      @listItems = @list.items
      render :json => [ @listItems ]
    elsif !params[:name].blank?
      @list = Item.search( params[:name] )
      render :json => [ @list ]
    else
      render :json => [ :success => false ]
    end
  end

  def create
    @items = Item.new(items_params)
    if@items.save && !params[:shoppinglist_id].blank?
      @list = Shoppinglist.find(params[:shoppinglist_id])
      @items.shoppinglists << @list 
      render :json => [ @items ]
    else
      render :json => [ :success => false ]
    end
  end

  def show
    if !params[:shoppinglist_id].blank?
      @list = Shoppinglist.find(params[:shoppinglist_id])
      render :json => [ @list.items ]
    else
      render :json => [ :success => false ]
    end
  end

  def update
    @items = Item.find( params[:id] )
    if @items.update_attributes(items_params)
      render :json => [ @items ]
    end
  end

  def destroy
    #delete a specific assoc item for a list
    if !params[:shoppinglist_id].blank?
      @item = Item.find(params[:id])
      @list = Shoppinglist.find(params[:shoppinglist_id])
      @list.items.delete(@item)
      @item.destroy
      render :json => [ @item ]
    else
      render :json => [ :success => false ]
    end
  end

  private

  def items_params
    params.require(:items).permit(:item_name, :quantity)
  end
end
