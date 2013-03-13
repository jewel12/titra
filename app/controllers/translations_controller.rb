# -*- coding: utf-8 -*-
Titra.controllers :translations, :conditions => {:protect => true} do
  def self.protect(protected)
    condition do
      @translation = Translation.find(params[:id])
      halt 403, "Not Authorized" unless @translation.translator.id == current_account.id
    end if protected
  end

  get :edit, :with => :id do
    redirect url(:login) unless logged_in?
    render 'translations/edit'
  end

  post :update, :with => :id do
    redirect url(:login) unless logged_in?

    if @translation.update_attributes(params[:translation])
      redirect url_for(:profile, :index)
    else
      render 'translations/edit'
    end
  end

  delete :delete, :with => :id do
    redirect url(:login) unless logged_in?

    if @translation.delete
      redirect url_for(:profile, :index)
    else
      render 'translations/edit'
    end
  end

end
