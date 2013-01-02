class TitleTranslation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :account

  validates :headline_id, :presence => true, :uniqueness => { :scope => :account_id }
  validates :title, :presence => true, :space => true

  def self.create_or_update(params)
    t = where(:headline_id => params[:headline].id,
              :account_id => params[:account].id).first_or_create
    t.title = params[:title]
    t.save!
    return t
  end


  def self.create_with_translator(translator, params)
    create! do |translation|
      translation.title = params[:title]
      translation.headline_id = params[:account_id]
      translation.translator = translator
    end
  end
end
