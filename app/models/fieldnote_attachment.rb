class FieldnoteAttachment < ActiveRecord::Base
  attr_accessible :file, :file_cache, :file_url, :content_type

  validates_presence_of  :file

  belongs_to  :fieldnote

  mount_uploader :file, FileUploader

  searchable :auto_index => true, :auto_remove => true do
    time    :created_at
  end

  def is_image?
    %w[jpg jpeg png].include?(file.file.extension) ? true : false
  end

  def thumb_or_icon_url
    if is_image?
      file.thumb.url
    else
      extension = file.file.extension
      "/images/icons/#{extension}.jpeg"
    end
  end

end
