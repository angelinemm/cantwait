class AddIndexToEventsForeignKey < ActiveRecord::Migration
  def change
  	add_index :events, :user_id
  end
end
