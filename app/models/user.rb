# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :quotes, dependent: :destroy

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email,
                      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  scope :normal, lambda {
    includes(:roles).references('roles').where('roles.name = ?', 'normal')
  }
  scope :admin, lambda {
    includes(:roles).references('roles').where('roles.name = ?', 'admin')
  }

  def full_name
    if first_name.present? && middle_name.present? && last_name.present?
      "#{first_name} #{middle_name} #{last_name}"
    elsif first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      first_name.to_s
    end
  end
end
