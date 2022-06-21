class ArticlesController < ApplicationController
  attr_accessor :test

  def initialize
    @test = 'SAMPLLEEEE-----asdf--sdf-a-d-sd-f-asd--sdf-'
  end

  def index
    HardJob.perform_async('Sample of Job starting', 5)
    @articles = Article.all
    @article = Article.find(4)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    puts('hits')
    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end