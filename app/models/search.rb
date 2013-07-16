class Search < ActiveRecord::Base
  validates_presence_of :user
  validates_presence_of :name

  belongs_to            :user

  def sanitize_terms
    @terms.strip!
  end

  def exists_terms?
    (@terms.is_a? String) && (not @terms.blank?) ? true : false
  end

end
