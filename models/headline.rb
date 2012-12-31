# -*- coding: utf-8 -*-
class Headline < ActiveRecord::Base
  has_many :title_translations

  validates :url, :uniqueness => true
  validates :title, :presence => true, :space => true
end
