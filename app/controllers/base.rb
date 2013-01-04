Titra.controllers do

  get :login do
    render 'login'
  end

  get :logout do
    set_current_account(nil)
    redirect url_for(:headlines, :index)
  end

  get :profile do
    @translator = current_account
    @headline_translation_pairs = @translator.latest_order_translations.map{ |t| [t.headline, t] }
    render 'profile'
  end

end
