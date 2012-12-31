class TitleTranslation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :account

  validates :headline, :presence => true
  validates :title, :presence => true, :space => true
end
