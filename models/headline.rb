# -*- coding: utf-8 -*-
class Headline < ActiveRecord::Base
  has_many :translations

  validates :url, :uniqueness => true, :format => URI.regexp(%w[http https])
  validates :title, :presence => true, :space => true

  scope :latest_order, order('updated_at desc')

  # Todo: 現在は登録順で最も新しいものを取得しているが、実際はスコア等で並び替えが行われる
  def self.get_with_best_translation
    all.map { |headline|
      translation = headline.translations.first
      translation.blank? ? nil : [headline, translation]
    }.compact
  end

  def self.first_or_initialize_by_url(params)
    headline = Headline.where(:url => params[:url]).first_or_initialize
    headline.title = params[:title]
    return headline
  end
end
