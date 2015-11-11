class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :set_default_role
  has_and_belongs_to_many :games

  scope :all_except, ->(user) { where.not(id: user) }

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

  def self.search(term)
    User.where("name ILIKE (?)", "%#{term}%").to_a 
  end

  private
  def set_default_role
    self.role ||= 'player'
    self.save
  end

  mount_uploader :user_avatar, UserAvatarUploader
end
