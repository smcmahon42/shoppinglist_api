class ShoppinglistsController < ApplicationController

  def index
    @lists = Shoppinglist.where( :group_id => params[:group_id] )
    render :json => [ @lists ]
  end

  def create
    @list = Shoppinglist.new(list_params)
    if @list.save
      render :json => [ @list ]
    end
  end

  def show
    @list = Shoppinglist.find(params[:id])
    render :json => [ @list ]
  end

  def update
    @list = Shoppinglist.find(params[:id])
    if @list.update_attributes(list_params)
      render :json => [ @list ]
    end
  end

  def destroy    
    #delete a specific list and all items
    @list = Shoppinglist.find(params[:id])
    @items = @list.items
    if !@items.empty? 
      @list.items.count.times do |num|
        @list.items[num].delete
      end
      @list.items.delete(@items)
    end
    @list.destroy
    render :json => [ @list ]
  end

  private 

  def list_params
     params.require(:shoppinglist).permit(:group_id, :list_name)
  end

end