class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  enum role: {
    user: 'user',
    admin: 'admin'
  }

  has_many :groups, dependent: :destroy
  has_many :campaigns, dependent: :destroy

  # has_many :group_users
  # has_many :clients, through: :group_users

  def admin?
    role == "admin"
  end
end
