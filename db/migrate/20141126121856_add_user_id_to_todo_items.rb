class AddUserIdToTodoItems < ActiveRecord::Migration
  def change
    change_table :todo_items do |t|
      t.integer :user_id
    end
  end
end

#a new column in the todo_items => user_id
