class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :first, :last, :email, :password, :password_confirmation, :is_admin

  validates_presence_of   :first
  validates_presence_of   :last
  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_presence_of   :password, :on => :create

  has_many  :fieldnotes

  searchable :auto_index => true, :auto_remove => true do
      string  :first
      string  :last
      string  :email

      text    :fullname
      time    :created_at
  end

  public

  def fullname
    first.to_s + ' ' + last.to_s
  end
end
