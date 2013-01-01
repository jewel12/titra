Titra.controllers :translations do
  post :new do
    redirect url(:headlines, :index) unless logged_in?

    tr_params = params["title_translation"]
    @translation = TitleTranslation.create_with_translator(current_account, tr_params)

    redirect url(:headlines, :index)
  end
end
