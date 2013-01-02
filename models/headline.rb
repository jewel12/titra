# -*- coding: utf-8 -*-
class Headline < ActiveRecord::Base
  has_many :title_translations

  validates :url, :uniqueness => true, :format => URI.regexp(%w[http https])
  validates :title, :presence => true, :space => true

  # Todo: 現在は登録順で最も新しいものを取得しているが、実際はスコア等で並び替えが行われる
  def self.get_with_best_translation
    all.map { |headline|
      translation = headline.title_translations.first
      translation.blank? ? nil : [headline, translation]
    }.compact
  end

  def self.create_with_title_translation(params)
    warn Headline.all

    headline = Headline.where(:url => params[:url], :title => params[:title]).first_or_create

    tr_params = {
      :headline => headline,
      :translator => params[:account],
      :title => params[:translation]
    }
    TitleTranslation.create_or_update(tr_params)

    return headline
  end

end
