class AddUrlDescriptionPictureToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :url, :text, limit:512
  	add_column :events, :details, :text
  	add_column :events, :picture, :text, limit:512
  end
end
