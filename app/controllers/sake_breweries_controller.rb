class SakeBreweriesController < ApplicationController
  def show
    @sake_brewery = SakeBrewery.find(params[:id])
    @posts = Post.where(sake_brewery_id: @sake_brewery.id).page(params[:page]).per(3)
  end

  def edit
    @sake_brewery = SakeBrewery.find(params[:id])
  end

  def update
    @sake_brewery = SakeBrewery.find(params[:id])
    if @sake_brewery.update(sake_brewery_params)
      redirect_to sake_brewery_path(@sake_brewery)
    else
      render 'edit'
    end
  end

  private

  def sake_brewery_params
    params.require(:sake_brewery).permit(:brewery_name, :brewery_prefecture, :brewery_address)
  end
end
