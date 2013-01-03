Titra.controllers :auth do

  get :auth, :map => '/auth/:provider/callback' do
    auth = request.env["omniauth.auth"]
    account = Translator.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
      Translator.create_with_omniauth(auth)
    set_current_account(account)
    redirect "http://" + request.env["HTTP_HOST"] + url_for(:headlines, :index)
  end

end
