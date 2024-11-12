class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    ingredient_ids = recipe_params[:ingredient_ids]
    ingredients = Ingredient.where(id: ingredient_ids.reject(&:blank?))

    @recipe.ingredients << ingredients
    
    if @recipe.save
      redirect_to recipes_path
    else
      render :new, :status, :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipes_path
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

  def import
    Recipe.import(params[:file])
    redirect_to recipes_path
  end

  private 
  def recipe_params
    params.require(:recipe).permit(:name, :description, :instruction, :catagory_id, ingredient_ids: [])
  end
end
