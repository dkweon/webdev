class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :todo_items, dependent: :destroy
  has_secure_password
end
