class Admin::ItemsController < ApplicationController
  def edit
    render file: 'errors/not_found', status: 404 if current_user.nil?
    render file: 'errors/not_found', status: 404 unless current_admin? || current_user == @merchant
    @item = Item.find_by(slug: params[:slug])
    @form_url = edit_admin_item_path(@item)
  end

  def update
    @item = Item.find_by(slug: params[:slug])
    @item.update(item_params)
      flash[:success] = "Item updated"
      redirect_to item_path(@item)
  end

  private

  def item_params
    params.require(:item).permit(:slug)
  end

  def require_admin
    redirect_to root_path unless current_admin?
  end
end
