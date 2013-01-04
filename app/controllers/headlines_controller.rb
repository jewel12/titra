Titra.controllers :headlines do
  get :index, :map => '/' do
    @headlines = Headline.latest_order.page(params[:page] || 1).per(30)
    @headlines_with_best_translation = @headlines.get_with_best_translation
    render 'headlines/index'
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
