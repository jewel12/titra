Titra.controllers :profile do

  get :index do
    @translator = current_account
    @headline_translation_pairs = @translator.latest_order_translations.map{ |t| [t.headline, t] }
    render 'profile'
  end

  get :withdraw do
    current_account.withdraw
    redirect url_for(:headlines, :index)
  end

end
