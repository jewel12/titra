class Translation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :translator

  validates :headline_id, :presence => true, :uniqueness => { :scope => :translator_id }
  validates :title, :presence => true, :space => true
  validates :summary, :space => true

  def self.initialize_with_translator(params, translator)
    translation = Translation.new(params)
    translation.translator = translator
    return translation
  end

  def self.create_or_update(params)
    t = where(:headline_id => params[:headline].id,
              :translator_id => params[:translator].id).first_or_create
    return t.update_attributes(params)
  end
end
