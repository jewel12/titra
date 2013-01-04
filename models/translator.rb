require "yaml"
class Translator < ActiveRecord::Base
  has_many :translations

  [:name, :uid, :provider].each do |param|
    validates param, :presence => true, :space => true
  end

  def translate_headline(headline_params, translation_params)
    h = Headline.where(:url => headline_params[:url]).first_or_create
    h.update_attributes(headline_params)

    t = Translation.where(:headline_id => h.id, :translator_id => self.id).first_or_create
    t.update_attributes(translation_params)

    h.save

    return h
  end

  def self.create_with_omniauth(auth)
    create! do |account|
      account.name = auth["info"].nickname
      account.provider = auth["provider"]
      account.uid = auth["uid"]
    end
  end
end
