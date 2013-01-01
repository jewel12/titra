Titra.controllers :headlines do
  get :index, :map => '/' do
    @headlines = Headline.all
    render 'headlines/index'
  end

  get :show, :with => :id do
    @headline = Headline.find(params[:id].to_i)
    @translations = @headline.title_translations
    render 'headlines/show'
  end

  post :new do
    @headline = Headline.new(params["headline"])
    @headline.save!
    redirect url(:headlines, :index)
  end
end
