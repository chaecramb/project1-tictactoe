class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :games

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end


  #mount_uploader :user_avatar, UserAvatarUploader
end
