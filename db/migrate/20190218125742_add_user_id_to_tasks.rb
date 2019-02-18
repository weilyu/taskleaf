class AddUserIdToTasks < ActiveRecord::Migration[5.2]

  def up
    # will delete all the data from task table
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end

end
