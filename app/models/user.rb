class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :normal, -> { includes(:roles).references('roles').where('roles.name = ?', 'normal') }
  scope :admin, -> { includes(:roles).references('roles').where('roles.name = ?', 'admin') }

  def full_name
    if first_name.present? and middle_name.present? and  last_name.present?
      "#{first_name} #{middle_name} #{last_name}"
    elsif first_name.present? and last_name.present?
      "#{first_name} #{last_name}"
    else
      "#{first_name}"
    end
  end
end
