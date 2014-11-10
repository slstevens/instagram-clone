class Photo < ActiveRecord::Base

	has_many :comments, dependent: :destroy
	has_many :likes
	belongs_to :user

	has_many :liked_users, through: :likes, source: :user

	validates :title, length: {minimum: 3}

	has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
