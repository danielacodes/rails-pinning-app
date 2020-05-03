class Pin < ActiveRecord::Base
  validates_presence_of :title, :url, :slug, :text, :category_id
  validates_uniqueness_of :slug
  belongs_to :category
  belongs_to :user, optional: true
  has_one_attached :image
  validate :correct_image_type

  private 
  def correct_image_type
    if image.attached? && !image.content_type.in?(%w(image/jpeg image/png))
      errors.add(:image, 'must be a JPEG or PNG')
    elsif image.attached? == false
      errors.add(:image, 'is required')
    end
  end

end