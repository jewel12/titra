class TitleTranslation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :translator, :class_name => 'Account'

  validates :headline, :presence => true
  validates :title, :presence => true, :space => true
end
