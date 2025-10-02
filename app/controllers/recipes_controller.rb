class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
  @recipe = Recipe.new(recipe_params)

  if @recipe.save
    redirect_to @recipe, notice: "Recipe was successfully created."
  else
    render :new, status: :unprocessable_entity
  end
end


  def update
  if @recipe.update(recipe_params)
    redirect_to @recipe, notice: "Recipe was successfully updated.", status: :see_other
  else
    render :edit, status: :unprocessable_entity
  end
end


  def destroy
  @recipe.destroy
  redirect_to recipes_path, notice: "Recipe was successfully deleted."
end


  private
    def set_recipe
      @recipe = Recipe.find(params.expect(:id))
    end

    def recipe_params
      params.expect(recipe: [ :title, :cook_time, :difficulty, :instructions ])
    end
end
