Titra.controllers do

  get :login do
    redirect url_for(:profile, :index) if logged_in?
    render 'login'
  end

  get :logout do
    set_current_account(nil)
    redirect url_for(:headlines, :index)
  end

end
