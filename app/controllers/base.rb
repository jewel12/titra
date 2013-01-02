Titra.controllers do

  get :login do
    render 'login'
  end

  get :logout do
    set_current_account(nil)
    redirect url_for(:headlines, :index)
  end

  get :profile do
    render 'profile'
  end

end
