class Image < ApplicationRecord
  belongs_to :item
  mount_uploader :url, ImagesUploader
end
