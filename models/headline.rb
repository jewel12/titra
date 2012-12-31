# -*- coding: utf-8 -*-
class Headline < ActiveRecord::Base
  has_many :title_translations

  validates :url, :uniqueness => true, :format => URI.regexp(%w[http https])
  validates :title, :presence => true, :space => true
end
