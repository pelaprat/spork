class Fieldnote < ActiveRecord::Base
  attr_accessible :user_id, :observations, :reflection, :visited_on, :fieldnote_attachments_attributes

  validates_presence_of  :user
  validates_presence_of  :observations
  validates_presence_of  :visited_on

  belongs_to  :user
  has_many    :fieldnote_attachments

  accepts_nested_attributes_for :fieldnote_attachments, :allow_destroy => true

  searchable :auto_index => true, :auto_remove => true do

    integer :id
    integer :user_id, :references => User

    string  :user_name do
      user.fullname
    end

    text    :observations
    text    :reflection

    time    :visited_on
    time    :created_at
  end

end
