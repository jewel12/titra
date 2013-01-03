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
    @translations = @headline.title_translations
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

    params[:account] = current_account

    Headline.create_with_title_translation(params)

    redirect url_for(:headlines, :index)
  end
end
