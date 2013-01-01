Titra.controllers :translations do
  post :new do
    redirect url(:headlines, :index) unless logged_in?

    tr_params = params["title_translation"]
    tr_params[:translator] = current_account
    tr_params[:headline] = Headline.find(tr_params[:headline_id])
    # @translation = TitleTranslation.create_with_translator(current_account, tr_params)

    @translation = TitleTranslation.create_or_update(tr_params)

    redirect url(:headlines, :index)
  end
end
