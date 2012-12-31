class Account < ActiveRecord::Base
  has_many :title_translation

  [:name, :uid, :provider].each do |param|
    validates param, :presence => true, :space => true
  end
end
