class Translation < ActiveRecord::Base
  belongs_to :headline
  belongs_to :translator

  validates :headline_id, :presence => true, :uniqueness => { :scope => :translator_id }
  validates :title, :presence => true, :space => true

  def self.create_or_update(params)
    t = where(:headline_id => params[:headline].id,
              :translator_id => params[:translator].id).first_or_create
    t.update_attributes(params)
    return t
  end
end
