class TitleTranslation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :translator, :class_name => 'Account'

  validates :headline_id, :presence => true, :uniqueness => { :scope => :translator_id }
  validates :title, :presence => true, :space => true

  def self.create_with_translator(translator, params)
    create! do |translation|
      translation.title = params[:title]
      translation.headline_id = params[:headline_id]
      translation.translator = translator
    end
  end
end
