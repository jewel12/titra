class TitleTranslation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :account
end
