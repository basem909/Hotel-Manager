class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations
  has_many :rooms, through: :reservations

  # Set the default role
  before_validation :set_default_role

  validates :role, presence: true, inclusion: { in: %w[admin user] }
  def admin?
    is?('admin')
  end

  private

  ROLES = %w[admin user].freeze
  def is?(requested_role)
    role == requested_role.to_s
  end

  def set_default_role
    self.role ||= 'user'
  end
end
