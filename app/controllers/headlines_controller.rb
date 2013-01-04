Titra.controllers :headlines do
  get :index, :map => '/' do
    @headlines_with_best_translation = Headline.get_with_best_translation
    render 'headlines/index'
  end

  get :old, :map => '/old' do
    @headlines = Headline.all
    render 'headlines/old_index'
  end

  get :show, :with => :id do
    @headline = Headline.find(params[:id].to_i)
    @translations = @headline.translations
    render 'headlines/show'
  end

  get :new do
    redirect url(:login) unless logged_in?
    @url = params["url"]
    @title = params["title"]
    render 'headlines/new'
  end

  post :create do
    redirect url(:login) unless logged_in?

    @headline = current_account.translate_headline(params[:headline], params[:translation])

    if @headline.valid?
      redirect url_for(:headlines, :index)
    else
      redirect url_for(:headlines, :new)
    end
  end
end
