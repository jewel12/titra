Titra.controllers :translations do
  post :new do
    redirect url(:headlines, :index) unless logged_in?
    tr_params = params["title_translation"]
    @translation = TitleTranslation.new( :title => tr_params["title"] )
    @translation.headline_id = tr_params["headline_id"].to_i
    @translation.translator = current_account
    @translation.save!
    warn @translation.translator
    redirect url(:headlines, :index)
  end
end
