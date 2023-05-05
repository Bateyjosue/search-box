class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    # @searches = Search.group(:query).count
    @searches = Search.group(:query).count.transform_keys(&:to_s).sort_by { |_query, count| -count }.to_h
    @top_searches = @searches.first(5).to_h
    if params[:query].present?
      @articles = Article.where("title LIKE ?", "%#{params[:query]}%")
      @search = Search.all
      if @articles  or @search
        @articles.each do |article|
          search(@search, params[:query])
        end
      else
        Search.create(user: current_user, article: article, query: params[:query])
      end
    else
      @articles = Article.all
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    # @article = Article.find(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
    def search(arr, query)
      arr.collect do |search|
        if(search.query.downcase.include?query.downcase or query.downcase.include?search.query.downcase)
          search.update(query: query)
        else
          Search.create(query: query, user: search.user, article: search.article)
        end
      end
    end
end
