class Users < ActiveRecord::Base

  has_many :todo_items

end
