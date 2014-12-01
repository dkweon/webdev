class TodoItem < ActiveRecord::Base
  belongs_to :user
  validates :name, uniqueness:true
end

#you type user -> under user there are todo list
# user (amazon id) -> my! shopping cart loaded
