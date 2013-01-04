Titra.controllers :headlines do
  get :index, :map => '/' do
    @headlines_with_best_translation = Headline.latest_order.get_with_best_translation
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

    @headline = session.delete(:headline)
    @translation = session.delete(:translation)

    param_initializer = lambda { |sym|
      return params[sym] if params[sym]
      return @headline.send(sym) if @headline
      return ''
    }
    @title, @url = [:title, :url].map(&param_initializer)

    render 'headlines/new'
  end

  post :create do
    redirect url(:login) unless logged_in?

    @headline, @translation = current_account.translate_headline(params[:headline], params[:translation])

    if @headline.valid? && @translation.valid?
      redirect url_for(:headlines, :index)
    else
      session[:headline] = @headline
      session[:translation] = @translation
      redirection_url = url_for(:headlines, :new)
      redirection_url += "?from_profile=true" if params["from_profile"]
      redirect redirection_url
    end
  end
end
