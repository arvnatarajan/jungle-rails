class Admin::CategoriesController < ApplicationController
  before_filter :authenticate

  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to [:admin, :categories], notice: 'Catgory deleted!'
  end

  private
    def category_params
      params.require(:category).permit(
        :name
      )
    end

  protected

  def authenticate
    puts 'aidhsdjf'
    authenticate_or_request_with_http_basic do |username, password|
      puts username
      puts password
      username == "jungle" && password == "book"
    end
  end

end
