class Headline < ActiveRecord::Base
  has_many :title_translations

  validates :url, :uniqueness => true
  validates :title, :presence => true
end
