class CreateEvents < ActiveRecord::Migration
  def change
  	drop_table :events
    create_table :events do |t|
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
