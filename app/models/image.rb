class Image < ActiveRecord::Base
  belongs_to :comment
  before_save :update_image_attributes
  mount_uploader :filename, ImageUploader
  
  private

  def update_image_attributes
    if filename.present?
      self.content_type = filename.file.content_type
      self.size = filename.file.size
      self.width, self.height = `identify -format "%wx%h" #{filename.file.path}`.split(/x/)
      # if you also need to store the original filename:
      # self.original_filename = image.file.filename
    end
  end
end

