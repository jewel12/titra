class Headline < ActiveRecord::Base
  has_many :title_translations

  validates_uniqueness_of :url
end
