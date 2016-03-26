class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy  

  validates :username, uniqueness: { case_sensitive: false }, presence: true
  
  validate :avatar_image_size

  mount_uploader :avatar, AvatarUploader

  private

    def avatar_image_size
      if avatar.size > 5.megabytes
      	errors.add(:avatar, "should be less than 5MB")
      end
    end
end
