class BookAttachment < ApplicationRecord
   mount_uploader :photo, BookPhotoUploader
   belongs_to :book
end
