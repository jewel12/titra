Titra.controllers :auth do

  get :auth, :map => '/auth/:provider/callback' do
    set_current_account(nil)
    auth = request.env["omniauth.auth"]
    account = Translator.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
      Translator.create_with_omniauth(auth)
    set_current_account(account)
    redirect "http://" + request.env["HTTP_HOST"] + url(:profile)
  end

end
