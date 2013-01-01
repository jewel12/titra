class TitleTranslation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :translator, :class_name => 'Account'

  validates :headline_id, :presence => true, :uniqueness => { :scope => :translator_id }
  validates :title, :presence => true, :space => true

  def self.create_or_update(params)
    t = where(:headline_id => params[:headline].id,
              :translator_id => params[:translator].id).first_or_create
    t.title = params[:title]
    t.save!
  end


  def self.create_with_translator(translator, params)
    create! do |translation|
      translation.title = params[:title]
      translation.headline_id = params[:headline_id]
      translation.translator = translator
    end
  end
end
