require "yaml"
class Account < ActiveRecord::Base
  has_many :title_translations

  [:name, :uid, :provider].each do |param|
    validates param, :presence => true, :space => true
  end

  def self.create_with_omniauth(auth)
    create! do |account|
      account.name = auth["info"].nickname
      account.provider = auth["provider"]
      account.uid = auth["uid"]
    end
  end
end
